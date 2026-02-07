# Screenshots per SEO

Questa cartella deve contenere gli screenshot delle funzionalita per i rich snippets di Google.

## Screenshot richiesti

| File | Dimensioni consigliate | Descrizione |
|------|------------------------|-------------|
| `smart-todo.png` | 1200x630 | Dashboard Smart Todo con Kanban board |
| `eisenhower.png` | 1200x630 | Matrice Eisenhower con task nei quadranti |
| `estimation-room.png` | 1200x630 | Sessione Planning Poker con carte |
| `agile-process.png` | 1200x630 | Sprint board con backlog e burndown |
| `retrospective.png` | 1200x630 | Board retrospettiva con colonne |

## Linee guida

- Formato: PNG (preferito) o WebP
- Dimensioni: 1200x630px (ratio 1.91:1 per Open Graph)
- Contenuto: Mostrare la UI in uso con dati di esempio
- Tema: Preferire dark mode per coerenza con brand
- Qualita: Alta risoluzione, no blur

## Utilizzo

Gli screenshot sono referenziati in:
- `index.html` (JSON-LD principale)
- Pagine statiche delle feature (`smart-todo.html`, etc.)
- Open Graph meta tags

## Nota

Finche gli screenshot non sono disponibili, i rich snippets useranno `og-image.png` come fallback.
