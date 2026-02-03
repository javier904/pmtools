/**
 * Jira Task Suite
 * A specific, independent module for Jira Operations.
 * 
 * Implements:
 * - Verify Login
 * - Add Comment
 * - Log Work
 * - Verify Work
 * - Update Ticket Status
 * - Assign Parent
 * - Add/Remove Label
 * - Assign User
 * - Create Ticket
 */

import * as functions from 'firebase-functions';
import axios from 'axios';

// Interface for common request data
interface JiraRequestData {
    domain: string;
    email: string;
    apiToken: string;
    [key: string]: any;
}

/**
 * Helper to construct the base URL and headers
 */
const getJiraConfig = (data: JiraRequestData) => {
    let { domain, email, apiToken } = data;

    if (!domain || !email || !apiToken) {
        throw new functions.https.HttpsError('invalid-argument', 'Missing Jira credentials (domain, email, apiToken)');
    }

    // Normalize domain
    if (domain.startsWith('https://')) domain = domain.replace('https://', '');
    if (domain.startsWith('http://')) domain = domain.replace('http://', '');
    if (domain.endsWith('/')) domain = domain.slice(0, -1);

    const baseUrl = `https://${domain}/rest/api/3`;
    const auth = Buffer.from(`${email}:${apiToken}`).toString('base64');

    return {
        baseUrl,
        headers: {
            'Authorization': `Basic ${auth}`,
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }
    };
};

/**
 * Helper to handle Axios errors
 */
const handleJiraError = (error: any, context: string) => {
    console.error(`Jira ${context} Error:`, error);
    if (axios.isAxiosError(error)) {
        const status = error.response?.status || 500;
        const message = error.response?.data ? JSON.stringify(error.response.data) : error.message;

        if (status === 401) {
            return new functions.https.HttpsError('unauthenticated', 'Invalid Jira credentials.');
        } else if (status === 403) {
            return new functions.https.HttpsError('permission-denied', 'You do not have permission to perform this action.');
        } else if (status === 404) {
            return new functions.https.HttpsError('not-found', 'Jira resource not found.');
        }

        return new functions.https.HttpsError('unknown', `Jira API Error (${status}): ${message}`);
    }
    return new functions.https.HttpsError('internal', `Internal Error: ${error.message}`);
};

// ==========================================
// 0. Ping (Debug)
// ==========================================
export const jiraPing = functions.https.onCall(async (data, context) => {
    return { message: 'Pong', timestamp: Date.now() };
});

// ==========================================
// 1. Verify Login (and get user info)
// ==========================================
export const verifyJiraLogin = functions.https.onCall(async (data: JiraRequestData, context) => {
    console.log('verifyJiraLogin called');
    try {
        if (!data) {
            console.error('Missing data object');
            throw new functions.https.HttpsError('invalid-argument', 'Missing data');
        }

        // Log keys only for security
        console.log('Data keys:', Object.keys(data));
        const { domain, email } = data;
        console.log(`Attempting login for ${email} at ${domain}`);

        const { baseUrl, headers } = getJiraConfig(data);
        console.log(`Base URL: ${baseUrl}`);

        const response = await axios.get(`${baseUrl}/myself`, { headers });
        console.log('Jira response status:', response.status);

        return response.data;
    } catch (error: any) {
        console.error('verifyJiraLogin Caught Error:', error);
        if (axios.isAxiosError(error)) {
            console.error('Axios Error Details:', {
                status: error.response?.status,
                statusText: error.response?.statusText,
                data: error.response?.data
            });
        }
        throw handleJiraError(error, 'Verify Login');
    }
});

// ==========================================
// 2. Add Comment
// ==========================================
export const jiraAddComment = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { issueKey, body } = data;
    if (!issueKey || !body) throw new functions.https.HttpsError('invalid-argument', 'Missing issueKey or body');

    try {
        const { baseUrl, headers } = getJiraConfig(data);

        // ADF (Atlassian Document Format) simplified
        const adfBody = {
            body: {
                version: 1,
                type: 'doc',
                content: [{
                    type: 'paragraph',
                    content: [{
                        type: 'text',
                        text: body
                    }]
                }]
            }
        };

        const response = await axios.post(`${baseUrl}/issue/${issueKey}/comment`, adfBody, { headers });
        return response.data;
    } catch (error) {
        throw handleJiraError(error, 'Add Comment');
    }
});

// ==========================================
// 3. Log Work (Add Worklog)
// ==========================================
export const jiraLogWork = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { issueKey, timeSpentSeconds, comment, started } = data;
    if (!issueKey || !timeSpentSeconds) throw new functions.https.HttpsError('invalid-argument', 'Missing issueKey or timeSpentSeconds');

    try {
        const { baseUrl, headers } = getJiraConfig(data);

        const payload: any = {
            timeSpentSeconds: timeSpentSeconds
        };

        if (started) {
            payload.started = started; // ISO 8601 String
        }

        if (comment) {
            payload.comment = {
                version: 1,
                type: 'doc',
                content: [{
                    type: 'paragraph',
                    content: [{
                        type: 'text',
                        text: comment
                    }]
                }]
            };
        }

        const response = await axios.post(`${baseUrl}/issue/${issueKey}/worklog`, payload, { headers });
        return response.data;
    } catch (error) {
        throw handleJiraError(error, 'Log Work');
    }
});


// ==========================================
// 4. Verify Work (Get Worklogs)
// ==========================================
export const jiraGetWorklogs = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { issueKey } = data;
    if (!issueKey) throw new functions.https.HttpsError('invalid-argument', 'Missing issueKey');

    try {
        const { baseUrl, headers } = getJiraConfig(data);
        const response = await axios.get(`${baseUrl}/issue/${issueKey}/worklog`, { headers });
        return response.data;
    } catch (error) {
        throw handleJiraError(error, 'Get Worklogs');
    }
});

// ==========================================
// 5. Update Ticket Status (Transition)
// ==========================================
export const jiraUpdateStatus = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { issueKey, transitionId } = data;
    if (!issueKey || !transitionId) throw new functions.https.HttpsError('invalid-argument', 'Missing issueKey or transitionId');

    try {
        const { baseUrl, headers } = getJiraConfig(data);

        const payload = {
            transition: {
                id: transitionId
            }
        };

        const response = await axios.post(`${baseUrl}/issue/${issueKey}/transitions`, payload, { headers });
        return { success: true, status: response.status }; // 204 No Content usually
    } catch (error) {
        throw handleJiraError(error, 'Update Status');
    }
});

// ==========================================
// 6. Assign Parent
// ==========================================
export const jiraAssignParent = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { issueKey, parentKey } = data;
    if (!issueKey) throw new functions.https.HttpsError('invalid-argument', 'Missing issueKey'); // parentKey can be null to remove? usually explicit

    try {
        const { baseUrl, headers } = getJiraConfig(data);

        // Using Generic Edit API
        const payload = {
            fields: {
                parent: parentKey ? { key: parentKey } : null
            }
        };

        const response = await axios.put(`${baseUrl}/issue/${issueKey}`, payload, { headers });
        return { success: true, status: response.status };
    } catch (error) {
        throw handleJiraError(error, 'Assign Parent');
    }
});

// ==========================================
// 7. General Field Update (Change State/Fields)
// ==========================================
export const jiraUpdateIssue = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { issueKey, fields } = data;
    if (!issueKey || !fields) throw new functions.https.HttpsError('invalid-argument', 'Missing issueKey or fields');

    try {
        const { baseUrl, headers } = getJiraConfig(data);

        const payload = {
            fields: fields
        };

        const response = await axios.put(`${baseUrl}/issue/${issueKey}`, payload, { headers });
        return { success: true, status: response.status };
    } catch (error) {
        throw handleJiraError(error, 'Update Issue');
    }
});

// ==========================================
// 8. Add/Remove Label
// ==========================================
export const jiraManageLabels = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { issueKey, addLabels, removeLabels } = data;
    if (!issueKey) throw new functions.https.HttpsError('invalid-argument', 'Missing issueKey');
    // addLabels: string[], removeLabels: string[]

    try {
        const { baseUrl, headers } = getJiraConfig(data);

        const updateOperation: any = {};

        if (addLabels && Array.isArray(addLabels) && addLabels.length > 0) {
            updateOperation.labels = addLabels.map(l => ({ add: l }));
        }

        if (removeLabels && Array.isArray(removeLabels) && removeLabels.length > 0) {
            // If labels key exists, concat, otherwise create
            const existing = updateOperation.labels || [];
            updateOperation.labels = existing.concat(removeLabels.map(l => ({ remove: l })));
        }

        if (Object.keys(updateOperation).length === 0) {
            return { success: true, message: 'No label changes requested' };
        }

        const payload = {
            update: updateOperation
        };

        const response = await axios.put(`${baseUrl}/issue/${issueKey}`, payload, { headers });
        return { success: true, status: response.status };

    } catch (error) {
        throw handleJiraError(error, 'Manage Labels');
    }
});

// ==========================================
// 9. Assign User
// ==========================================
export const jiraAssignUser = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { issueKey, accountId } = data;
    if (!issueKey || !accountId) throw new functions.https.HttpsError('invalid-argument', 'Missing issueKey or accountId');

    try {
        const { baseUrl, headers } = getJiraConfig(data);

        // New API uses accountId strict
        const payload = {
            accountId: accountId
        };

        const response = await axios.put(`${baseUrl}/issue/${issueKey}/assignee`, payload, { headers });
        return { success: true, status: response.status };
    } catch (error) {
        throw handleJiraError(error, 'Assign User');
    }
});

// ==========================================
// 10. Create Ticket
// ==========================================
export const jiraCreateTicket = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { projectKey, summary, description, issueType, parentKey, priority, extraFields } = data;

    if (!projectKey || !summary || !issueType) {
        throw new functions.https.HttpsError('invalid-argument', 'Missing required fields (projectKey, summary, issueType)');
    }

    try {
        const { baseUrl, headers } = getJiraConfig(data);

        const fields: any = {
            project: { key: projectKey },
            summary: summary,
            issuetype: { name: issueType },
            ...extraFields
        };

        if (description) {
            // Simple ADF for description
            fields.description = {
                version: 1,
                type: 'doc',
                content: [{
                    type: 'paragraph',
                    content: [{
                        type: 'text',
                        text: description
                    }]
                }]
            };
        }

        if (parentKey) {
            fields.parent = { key: parentKey };
        }

        if (priority) {
            fields.priority = { name: priority };
        }

        const payload = { fields };

        const response = await axios.post(`${baseUrl}/issue`, payload, { headers });
        return response.data; // Returns key, id, self
    } catch (error) {
        throw handleJiraError(error, 'Create Ticket');
    }
});

// ==========================================
// 11. Get Issue (Read)
// ==========================================
export const jiraGetIssue = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { issueKey } = data;
    if (!issueKey) throw new functions.https.HttpsError('invalid-argument', 'Missing issueKey');

    try {
        const { baseUrl, headers } = getJiraConfig(data);
        const response = await axios.get(`${baseUrl}/issue/${issueKey}`, { headers });
        return response.data;
    } catch (error) {
        throw handleJiraError(error, 'Get Issue');
    }
});

// ==========================================
// 12. Search Issues (JQL)
// ==========================================
export const jiraSearchIssues = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { jql, startAt, maxResults, fields } = data;
    if (!jql) throw new functions.https.HttpsError('invalid-argument', 'Missing JQL');

    try {
        const { baseUrl, headers } = getJiraConfig(data);

        // Use search/jql endpoint for v3
        const payload = {
            jql,
            startAt: startAt || 0,
            maxResults: maxResults || 50,
            fields: fields || ['summary', 'status', 'issuetype', 'priority', 'assignee', 'description', 'updated', 'created']
        };

        const response = await axios.post(`${baseUrl}/search/jql`, payload, { headers });
        return response.data; // { issues: [], total: number }
    } catch (error) {
        throw handleJiraError(error, 'Search Issues');
    }
});

// ==========================================
// 13. Get Transitions
// ==========================================
export const jiraGetTransitions = functions.https.onCall(async (data: JiraRequestData, context) => {
    const { issueKey } = data;
    if (!issueKey) throw new functions.https.HttpsError('invalid-argument', 'Missing issueKey');

    try {
        const { baseUrl, headers } = getJiraConfig(data);
        const response = await axios.get(`${baseUrl}/issue/${issueKey}/transitions`, { headers });
        return response.data; // { transitions: [] }
    } catch (error) {
        throw handleJiraError(error, 'Get Transitions');
    }
});
