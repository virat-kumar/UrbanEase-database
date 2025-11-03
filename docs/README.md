# UrbanEase ERD Documentation

This directory contains Entity Relationship Diagram (ERD) resources for the UrbanEase e-commerce database.

## 📁 Files

### Source Files
- **`erd_diagram.mmd`** - Mermaid diagram source code (version controlled)
  - Can be edited directly in any text editor
  - Renders automatically on GitHub
  - View/edit online at https://mermaid.live/

### Generator Scripts
- **`generate_erd.ps1`** - PowerShell script for Windows
- **`generate_erd.sh`** - Bash script for Linux/Mac

### Generated Files (not in git)
- **`erd_diagram.png`** - PNG image (transparent background)
- **`erd_diagram.svg`** - SVG scalable vector (transparent background)
- **`erd_diagram.pdf`** - PDF document (for printing)

## 🚀 Quick Start

### Option 1: View on GitHub (No Setup Required)
The Mermaid diagram in the main `README.md` is automatically rendered by GitHub.
Just open the README on GitHub and scroll to the ERD section!

### Option 2: Generate Images Locally

#### Windows (PowerShell):
```powershell
# From project root directory
.\docs\generate_erd.ps1
```

#### Linux/Mac (Bash):
```bash
# From project root directory
chmod +x docs/generate_erd.sh
./docs/generate_erd.sh
```

#### Manual Method (Cross-platform):
```bash
# Install Mermaid CLI (one time)
npm install -g @mermaid-js/mermaid-cli

# Generate diagrams
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.png -b transparent
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.svg -b transparent
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.pdf
```

## 🔧 Requirements

- **Node.js** (v14 or higher) - https://nodejs.org/
- **npm** (comes with Node.js)
- **@mermaid-js/mermaid-cli** (auto-installed by scripts)

## 📝 Editing the ERD

### Method 1: Edit Directly
1. Open `docs/erd_diagram.mmd` in any text editor
2. Make your changes following Mermaid syntax
3. Test at https://mermaid.live/ (paste the code)
4. Save and commit

### Method 2: Online Editor
1. Go to https://mermaid.live/
2. Paste contents of `erd_diagram.mmd`
3. Edit visually or via code
4. Copy back to `erd_diagram.mmd`

## 🎨 Mermaid ERD Syntax

### Cardinality Notation
```
||--o{  One-to-Many (1:N)
||--||  One-to-One (1:1)
}o--o{  Many-to-Many (M:N)
}o--||  Many-to-One (N:1)
```

### Table Definition
```mermaid
TableName {
    DATATYPE column_name PK "Primary Key"
    DATATYPE column_name FK "Foreign Key"
    DATATYPE column_name UK "Unique"
    DATATYPE column_name "Description"
}
```

### Relationship Definition
```mermaid
TableA ||--o{ TableB : "description"
```

## 📚 Resources

- **Mermaid Documentation**: https://mermaid.js.org/
- **Mermaid Live Editor**: https://mermaid.live/
- **Mermaid CLI GitHub**: https://github.com/mermaid-js/mermaid-cli
- **ERD Syntax Guide**: https://mermaid.js.org/syntax/entityRelationshipDiagram.html

## 🎯 Use Cases

### For Presentations
Generate high-quality images:
```bash
# SVG for presentations (scalable, no quality loss)
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.svg -b transparent

# PDF for printing
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.pdf
```

### For Documentation
Include in other documents:
```markdown
![UrbanEase ERD](./docs/erd_diagram.png)
```

### For Collaboration
Share the Mermaid code:
1. Copy `erd_diagram.mmd` contents
2. Share link: https://mermaid.live/edit#<your-diagram>
3. Collaborators can edit and export

## 🔍 Troubleshooting

### "mmdc: command not found"
Install Mermaid CLI globally:
```bash
npm install -g @mermaid-js/mermaid-cli
```

### "node: command not found"
Install Node.js from https://nodejs.org/

### Generation is slow
The first generation may take 30-60 seconds as it installs Puppeteer.
Subsequent generations will be much faster.

### Permission denied (Linux/Mac)
Make the script executable:
```bash
chmod +x docs/generate_erd.sh
```

## 📧 Support

If you encounter issues:
1. Check Node.js is installed: `node --version`
2. Check npm is working: `npm --version`
3. Try running the manual commands above
4. Check Mermaid CLI is installed: `mmdc --version`

---

**Last Updated**: November 2025  
**UrbanEase Database Project**

