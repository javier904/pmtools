import json
import sys
import os

def find_l10n_issues(template_path, target_path):
    if not os.path.exists(template_path):
        print(f"Error: Template path {template_path} does not exist.")
        return None
    if not os.path.exists(target_path):
        print(f"Error: Target path {target_path} does not exist.")
        return None

    with open(template_path, 'r', encoding='utf-8') as f:
        template = json.load(f)
    
    with open(target_path, 'r', encoding='utf-8') as f:
        target = json.load(f)
    
    template_keys = set(template.keys())
    target_keys = set(target.keys())
    
    missing_keys = template_keys - target_keys
    # Filter out metadata
    missing_keys = [k for k in missing_keys if not k.startswith('@')]
    
    # Identify keys that are present but likely untranslated (identical to template or English)
    # We'll use a simple heuristic: if it's identical to the template (which is Italian) 
    # OR if it's identical to the English version (if we had it, but we use template as base)
    # Since we are comparing with 'app_it.arb', and many new keys were added in EN/IT first:
    untranslated_keys = []
    for key in target_keys:
        if key.startswith('@'): continue
        if key in template and target[key] == template[key]:
            untranslated_keys.append(key)
            
    # Also check for specific English patterns if target is NOT English
    # But for now, identical to template (IT) is a good indicator of "copied but not translated"
    
    result = {
        "missing": {k: template[k] for k in missing_keys},
        "untranslated": {k: target[k] for k in untranslated_keys}
    }
        
    return result

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 find_missing_l10n.py <template.arb> <target.arb> [output.json]")
        sys.exit(1)
        
    template_path = sys.argv[1]
    target_path = sys.argv[2]
    output_path = sys.argv[3] if len(sys.argv) > 3 else None
    
    issues = find_l10n_issues(template_path, target_path)
    
    if issues:
        if output_path:
            with open(output_path, 'w', encoding='utf-8') as f:
                json.dump(issues, f, indent=2, ensure_ascii=False)
            print(f"Issues written to {output_path}")
        else:
            print(json.dumps(issues, indent=2, ensure_ascii=False))
