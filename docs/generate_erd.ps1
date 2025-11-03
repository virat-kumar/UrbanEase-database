# UrbanEase Database ERD Generator
# PowerShell script to generate visual ERD diagrams from Mermaid file
# Author: UrbanEase Team
# Date: November 2025

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  UrbanEase ERD Diagram Generator" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if we're in the correct directory
if (-not (Test-Path "docs/erd_diagram.mmd")) {
    Write-Host "ERROR: Please run this script from the project root directory!" -ForegroundColor Red
    Write-Host "Current directory: $(Get-Location)" -ForegroundColor Yellow
    exit 1
}

# Check if Node.js is installed
Write-Host "Checking Node.js installation..." -ForegroundColor Yellow
$nodeVersion = node --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Node.js is not installed!" -ForegroundColor Red
    Write-Host "Please install Node.js from: https://nodejs.org/" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ Node.js found: $nodeVersion" -ForegroundColor Green
Write-Host ""

# Check if Mermaid CLI is installed
Write-Host "Checking Mermaid CLI..." -ForegroundColor Yellow
$mmdcVersion = mmdc --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Mermaid CLI not found. Installing..." -ForegroundColor Yellow
    Write-Host ""
    npm install -g @mermaid-js/mermaid-cli
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to install Mermaid CLI!" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ Mermaid CLI installed successfully!" -ForegroundColor Green
} else {
    Write-Host "✓ Mermaid CLI found: $mmdcVersion" -ForegroundColor Green
}
Write-Host ""

# Generate diagrams
Write-Host "Generating ERD diagrams..." -ForegroundColor Cyan
Write-Host ""

# Generate PNG
Write-Host "1. Generating PNG diagram..." -ForegroundColor Yellow
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.png -b transparent
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✓ PNG generated: docs/erd_diagram.png" -ForegroundColor Green
} else {
    Write-Host "   ✗ Failed to generate PNG" -ForegroundColor Red
}

# Generate SVG
Write-Host "2. Generating SVG diagram..." -ForegroundColor Yellow
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.svg -b transparent
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✓ SVG generated: docs/erd_diagram.svg" -ForegroundColor Green
} else {
    Write-Host "   ✗ Failed to generate SVG" -ForegroundColor Red
}

# Generate PDF
Write-Host "3. Generating PDF diagram..." -ForegroundColor Yellow
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.pdf
if ($LASTEXITCODE -eq 0) {
    Write-Host "   ✓ PDF generated: docs/erd_diagram.pdf" -ForegroundColor Green
} else {
    Write-Host "   ✗ Failed to generate PDF" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Generation Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Generated files in docs/ directory:" -ForegroundColor Yellow
Get-ChildItem docs/erd_diagram.* | ForEach-Object {
    $size = [math]::Round($_.Length / 1KB, 2)
    Write-Host "  - $($_.Name) ($size KB)" -ForegroundColor White
}
Write-Host ""
Write-Host "You can now:" -ForegroundColor Cyan
Write-Host "  • View PNG/SVG in any image viewer" -ForegroundColor White
Write-Host "  • Include in presentations or documentation" -ForegroundColor White
Write-Host "  • Print the PDF version" -ForegroundColor White
Write-Host ""

