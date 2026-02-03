# Retrospective Advanced Features

## Overview

The retrospective tab in Agile Tools has been restructured into 4 sub-tabs: **Active**, **History**, **Action Items**, and **Lessons Learned**. This architecture follows Scrum Guide best practices for continuous improvement and aligns with the PMBOK Lessons Learned Register framework for organizational knowledge management.

The goal is to transform retrospectives from isolated events into a continuous improvement engine, where action items are tracked across retros, lessons are catalogued and shared across projects, and sentiment trends provide visibility into team health over time.

---

## Architecture

### Tab Structure

```
Tab Retro
├── Active           - Current retro in progress or create new
├── History          - Completed retros grouped by sprint + trend chart
├── Action Items     - Cross-retro action items tracker with filters
└── Lessons Learned  - PMBOK-style register with cross-project import
```

### Files Created

The following 13 new files were created to implement the advanced retrospective features:

| # | File Path | Purpose |
|---|-----------|---------|
| 1 | `lib/widgets/retrospective/retro_tab_sections_widget.dart` | Main container widget that hosts the 4 sub-tabs (Active, History, Action Items, Lessons Learned) using a `TabBar` + `TabBarView` layout |
| 2 | `lib/widgets/retrospective/retro_active_section_widget.dart` | Displays the current active or draft retrospective with board access, or shows a create button when no active retro exists |
| 3 | `lib/widgets/retrospective/retro_history_section_widget.dart` | Lists completed retrospectives grouped by sprint name, with a trend chart at the top and expandable cards for each sprint |
| 4 | `lib/widgets/retrospective/retro_summary_dialog.dart` | Read-only summary dialog for viewing a completed retrospective, including all cards, action items, sentiment, and metadata |
| 5 | `lib/widgets/retrospective/action_items_tracker_widget.dart` | Cross-retro action items aggregator with summary counters, status/assignee/retro filters, inline status changes, and overdue highlighting |
| 6 | `lib/widgets/retrospective/carry_forward_dialog.dart` | Dialog that appears when creating a new retro, showing uncompleted action items from previous retros for selective carry-forward |
| 7 | `lib/widgets/retrospective/lessons_learned_section_widget.dart` | Lessons Learned list view with category, type, and resolved/unresolved filters, plus add/edit/delete/import capabilities |
| 8 | `lib/widgets/retrospective/lesson_learned_dialog.dart` | Create and edit form dialog for a lesson learned entry, including title, description, root cause, recommendation, tags, recurring flag, and resolved status |
| 9 | `lib/widgets/retrospective/cross_project_import_dialog.dart` | Dialog for importing lessons learned from other projects owned by the current user, with project selection and lesson browsing |
| 10 | `lib/widgets/retrospective/retro_trend_chart_widget.dart` | fl_chart `LineChart` widget showing sentiment average and action item completion rate trends over completed retrospectives |
| 11 | `lib/models/lesson_learned_model.dart` | Data model for Lessons Learned with 7 categories, 3 types, metadata fields, cross-project import references, and serialization |
| 12 | `lib/services/lessons_learned_service.dart` | Firestore CRUD service for the `lessons_learned` subcollection under each agile project document |

### Files Modified

| File Path | Changes |
|-----------|---------|
| `lib/models/retrospective_model.dart` | Added `ActionItemStatus` enum (`open`, `inProgress`, `completed`, `deferred`) with backward compatibility for the existing `isCompleted` boolean field |
| `lib/screens/agile_project_detail_screen.dart` | Replaced the monolithic `_buildRetroTab()` method with the new `RetroTabSectionsWidget`, passing project context and callbacks |
| `lib/services/agile_firestore_service.dart` | Added `getOwnedProjects()` method to query projects where the current user is the owner, used by the cross-project import feature |
| `lib/widgets/retrospective/retro_methodology_guide.dart` | Expanded with three new sections: Lessons Learned Framework, Action Items Best Practices, and Continuous Improvement Cycle |

---

## Features

### 1. Active Tab

The Active tab serves as the primary workspace for the current retrospective session.

**Behavior:**
- When an active or draft retrospective exists, it displays the retro card with direct board access (click to open the retro board)
- When no active retro exists, it shows a prominent "Create New Retrospective" button
- Creating a new retrospective triggers the **carry-forward dialog**, which presents any uncompleted action items from previous retros for selective inclusion in the new session

**Key interactions:**
- Single tap on the active retro card opens the retrospective board
- The create button initiates the standard retro creation flow with the carry-forward step injected before the board opens

### 2. History Tab

The History tab provides a longitudinal view of all completed retrospectives with trend analysis.

**Trend Chart (top section):**
- Built with `fl_chart` `LineChart` widget
- **Sentiment line**: Plots the average team sentiment score (1-5 scale) for each completed retro over time
- **Completion rate line**: Plots the percentage of action items marked as completed for each retro
- **Trend indicator chip**: Displays a summary chip showing whether the trend is "Improving", "Stable", or "Declining" based on the slope of recent data points

**Completed retros list (below chart):**
- Retrospectives are grouped by sprint name using `ExpansionTile` widgets
- Each retro card displays:
  - Template icon (indicating which retro format was used)
  - Completion date
  - Average sentiment score
  - Action items ratio (completed / total)
- Clicking a card opens the **read-only summary dialog** (`RetroSummaryDialog`), which presents all cards organized by column, action items with their statuses, and session metadata

### 3. Action Items Tab

The Action Items tab aggregates all action items from all retrospectives in the project into a single, filterable tracker.

**Summary counters (top row):**
- Total items count
- Open items count
- In Progress items count
- Completed items count
- Deferred items count
- Overall completion rate percentage

**Filters (3 dropdown controls):**
- **Status filter**: Filter by `open`, `inProgress`, `completed`, or `deferred`
- **Assignee filter**: Filter by assigned team member (dynamically populated from all action items)
- **Source Retro filter**: Filter by the retrospective that originated the action item

**Item interactions:**
- Each action item displays its title, assignee, due date, priority, and current status
- Status can be changed inline via a `PopupMenuButton` dropdown directly on the status chip
- Items past their due date are highlighted in red to indicate overdue status
- Status changes propagate back to the source retrospective's Firestore document, ensuring data consistency

### 4. Lessons Learned Tab

The Lessons Learned tab implements a PMBOK-style Lessons Learned Register as a Firestore subcollection.

**Storage:** `agile_projects/{projectId}/lessons_learned/{lessonId}`

**Categories (7):**
- Process
- Technical
- Team
- Communication
- Tools
- Quality
- Estimation

**Types (3):**
- Strength (what went well)
- Weakness (what needs improvement)
- Recommendation (actionable suggestion)

**Filtering:**
- Filter chips by category (multi-select)
- Dropdown filter by type
- Toggle for resolved vs. unresolved lessons

**CRUD operations:**
- **Add**: Opens the `LessonLearnedDialog` form with all fields
- **Edit**: Long press or edit icon opens the same dialog pre-populated
- **Delete**: Long press triggers a confirmation dialog before deletion

**Cross-project import (owner only):**
- Available only to the project owner
- Opens `CrossProjectImportDialog`
- User selects a source project from their owned projects
- Dialog displays lessons from the selected project
- User selects which lessons to import
- Imported lessons are copied with `importedFromProjectId` and `importedFromProjectName` references preserved

---

## Data Model

### LessonLearnedModel

```dart
class LessonLearnedModel {
  final String id;
  final String projectId;
  final String? retroId;
  final String? sprintId;
  final String? sprintName;

  // Classification
  final String category;    // "process" | "technical" | "team" | "communication" | "tools" | "quality" | "estimation"
  final String type;         // "strength" | "weakness" | "recommendation"

  // Content
  final String title;
  final String description;
  final String? rootCause;
  final String? recommendation;

  // Traceability
  final List<String> sourceCardIds;
  final List<String> sourceActionItemIds;

  // Metadata
  final List<String> tags;
  final bool isRecurring;
  final int occurrenceCount;
  final bool isResolved;
  final DateTime? resolvedAt;

  // Cross-project import
  final String? importedFromProjectId;
  final String? importedFromProjectName;

  // Audit
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

**Firestore document structure:**

```json
{
  "id": "auto-generated",
  "projectId": "abc123",
  "retroId": "retro456",
  "sprintId": "sprint789",
  "sprintName": "Sprint 12",
  "category": "process",
  "type": "weakness",
  "title": "Sprint planning takes too long",
  "description": "Planning sessions consistently exceed 2 hours...",
  "rootCause": "Stories not refined before planning",
  "recommendation": "Implement mandatory refinement session before planning",
  "sourceCardIds": ["card1", "card2"],
  "sourceActionItemIds": ["action1"],
  "tags": ["planning", "refinement"],
  "isRecurring": true,
  "occurrenceCount": 3,
  "isResolved": false,
  "resolvedAt": null,
  "importedFromProjectId": null,
  "importedFromProjectName": null,
  "createdBy": "user@example.com",
  "createdAt": "2025-01-15T10:30:00Z",
  "updatedAt": "2025-01-20T14:00:00Z"
}
```

### ActionItemStatus

Added to the existing `ActionItem` class within `retrospective_model.dart`:

```dart
enum ActionItemStatus { open, inProgress, completed, deferred }
```

**Backward compatibility:** The enum maintains backward compatibility with the existing `isCompleted` boolean field. When reading legacy data:
- `isCompleted == true` maps to `ActionItemStatus.completed`
- `isCompleted == false` maps to `ActionItemStatus.open`

When writing, the `isCompleted` field is kept in sync with the enum value for any code that still references it.

---

## Firestore Rules

The Lessons Learned subcollection is protected by the same participant-based access control used throughout the Agile Tools project:

```javascript
match /agile_projects/{projectId} {
  // ... existing project rules ...

  match /lessons_learned/{lessonId} {
    allow read, write: if isAuthenticated() &&
      canAccessByParticipantEmails(
        get(/databases/$(database)/documents/agile_projects/$(projectId))
      );
  }
}
```

This ensures that only authenticated users who are participants (or the owner) of the parent agile project can read or write lessons learned entries.

---

## User Flows

### Flow 1: Complete Retro to History

1. The facilitator marks a retrospective as completed (status changes to `completed`)
2. The retro automatically moves from the **Active** tab to the **History** tab
3. The **trend chart** updates with the new data point (sentiment average + completion rate)
4. All action items from the completed retro become visible in the **Action Items** tracker
5. The Active tab now shows the "Create New Retrospective" button

### Flow 2: Carry Forward

1. User clicks "Create New Retrospective" in the Active tab
2. The `CarryForwardDialog` appears, displaying all uncompleted action items from previous retrospectives
3. Items are sorted by priority (critical items first), then by creation date
4. User selects which items to carry forward into the new retro using checkboxes
5. Selected items are copied into the new retrospective's action items list
6. The new retro board opens with the carried-forward items already present
7. Original items in the source retro remain unchanged (they are copied, not moved)

### Flow 3: Cross-Project Import

1. User navigates to the **Lessons Learned** tab
2. User clicks "Import from Other Projects" button (visible only to project owners)
3. The `CrossProjectImportDialog` opens
4. The dialog loads all projects where the current user is the owner (via `getOwnedProjects()`)
5. User selects a source project from the list
6. The dialog displays all lessons learned from the selected project
7. User selects which lessons to import using checkboxes
8. On confirmation, selected lessons are copied to the current project's `lessons_learned` subcollection
9. Each imported lesson preserves the `importedFromProjectId` and `importedFromProjectName` fields for traceability

### Flow 4: Action Item Status Tracking

1. User opens the **Action Items** tab
2. User optionally applies filters (status, assignee, source retro) to narrow the list
3. User identifies an action item to update
4. User taps the status chip on the action item row
5. A `PopupMenuButton` dropdown appears with status options: Open, In Progress, Completed, Deferred
6. User selects the new status
7. The status is updated in the source retrospective's Firestore document
8. Summary counters at the top of the tab update in real-time to reflect the change
9. If the item was overdue and is now completed, the red overdue highlighting is removed

---

## Methodology Guide Integration

The `retro_methodology_guide.dart` file has been expanded with three new sections to support the advanced retrospective features:

### Action Items Best Practices

- Guidance on writing effective action items using SMART criteria (Specific, Measurable, Achievable, Relevant, Time-bound)
- Recommendations for assigning clear ownership to each action item
- Best practices for setting realistic due dates
- Advice on follow-up and accountability during subsequent retros

### Lessons Learned Framework

- Explanation of the 7 category taxonomy (Process, Technical, Team, Communication, Tools, Quality, Estimation)
- Guidance on distinguishing between Strengths, Weaknesses, and Recommendations
- Instructions for conducting root cause analysis
- Best practices for writing reusable lessons that provide value when imported to other projects

### Continuous Improvement Cycle

- How to use the trend chart to identify patterns in team sentiment and action item completion
- When and how to use the carry-forward feature effectively
- Cross-project knowledge sharing through the lessons learned import mechanism
- Recommendations for periodic review of the lessons learned register

---

## Localization

All features are fully localized in 4 languages:

| Language | Code |
|----------|------|
| English  | EN   |
| Italian  | IT   |
| Spanish  | ES   |
| French   | FR   |

Approximately **100 new localization keys** were added, covering:

- Tab labels and section headers
- Filter dropdown labels and placeholder text
- Status labels (open, in progress, completed, deferred)
- Category and type labels for lessons learned
- Dialog titles, button labels, and confirmation messages
- Tooltip hints for all interactive elements
- Methodology guide section headings and body text
- Trend chart labels and indicator text
- Summary counter labels
- Error messages and empty state descriptions

---

## Tooltips

All interactive elements include contextual tooltips to improve discoverability and usability:

| Element | Tooltip Behavior |
|---------|-----------------|
| **Filter dropdowns** | Explain what each filter controls (e.g., "Filter action items by their current status") |
| **Status chips** | Explain the click-to-change interaction (e.g., "Tap to change status") |
| **Priority badges** | Explain priority levels (e.g., "Critical priority - address immediately") |
| **Category chips** | Explain the category meaning (e.g., "Process - related to team workflows and ceremonies") |
| **Type chips** | Explain the type classification (e.g., "Weakness - an area that needs improvement") |
| **Import button** | Explains the cross-project import behavior (e.g., "Import lessons learned from another project you own") |
| **Add button** | Explains what will be created (e.g., "Add a new lesson learned entry") |
| **Chart elements** | Hover tooltips showing exact values at each data point |
| **Form fields** | Helper text explaining the purpose of each field (e.g., "Root cause: identify the underlying reason for this lesson") |
| **Carry forward checkboxes** | Explain the carry-forward mechanism (e.g., "Select to include this item in the new retrospective") |
| **Overdue indicators** | Explain why the item is highlighted (e.g., "This action item is past its due date") |
| **Trend indicator chip** | Explains the calculation basis (e.g., "Based on the last 5 retrospectives") |
| **Create retro button** | Explains the flow including carry-forward (e.g., "Create a new retrospective - you will be able to carry forward pending items") |

---

## Technical Notes

### State Management

The retrospective advanced features follow the same hybrid state management approach used throughout Agile Tools:
- `StatefulWidget` for local UI state within each sub-tab
- Firestore streams for real-time data synchronization
- Callback-based communication between parent and child widgets

### Performance Considerations

- Action items are aggregated client-side from loaded retrospective documents rather than maintaining a separate collection, keeping the data model simple and consistent
- The trend chart recalculates only when the History tab is active and the underlying data changes
- Cross-project import queries are paginated to handle projects with large numbers of lessons
- Filter state is maintained in memory during tab switches to preserve user context

### Error Handling

- All Firestore operations include try-catch blocks with user-friendly error messages
- Network failures during cross-project import show specific guidance
- Empty states are handled with descriptive messages and action suggestions
- Backward compatibility ensures existing retrospective data loads correctly without migration
