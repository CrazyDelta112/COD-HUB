# Script to find and move unused assets
$projectRoot = "c:\Users\farcr\Downloads\Codhub 1.8"
$unusedFolder = "$projectRoot\unused-assets"

# Create unused assets folder
if (-not (Test-Path $unusedFolder)) {
    New-Item -ItemType Directory -Path $unusedFolder | Out-Null
    New-Item -ItemType Directory -Path "$unusedFolder\img" | Out-Null
    New-Item -ItemType Directory -Path "$unusedFolder\Images" | Out-Null
    New-Item -ItemType Directory -Path "$unusedFolder\Sounds" | Out-Null
}

# Get all HTML files
$htmlFiles = Get-ChildItem -Path $projectRoot -Filter "*.html" -Recurse | Where-Object { $_.FullName -notlike "*unused-assets*" -and $_.FullName -notlike "*.git*" -and $_.FullName -notlike "*node_modules*" }

# Get all CSS and JS files
$cssFiles = Get-ChildItem -Path $projectRoot -Filter "*.css" -Recurse | Where-Object { $_.FullName -notlike "*unused-assets*" -and $_.FullName -notlike "*.git*" -and $_.FullName -notlike "*node_modules*" }
$jsFiles = Get-ChildItem -Path $projectRoot -Filter "*.js" -Recurse | Where-Object { $_.FullName -notlike "*unused-assets*" -and $_.FullName -notlike "*.git*" -and $_.FullName -notlike "*node_modules*" }

# Combine all files to search
$allFilesToSearch = $htmlFiles + $cssFiles + $jsFiles

# Read all content
$allContent = $allFilesToSearch | ForEach-Object { Get-Content $_.FullName -Raw }
$combinedContent = $allContent -join "`n"

Write-Host "Analyzing assets..." -ForegroundColor Cyan

# Check img folder
$imgFiles = Get-ChildItem -Path "$projectRoot\img" -File
$unusedImgCount = 0
Write-Host "`nChecking img folder ($($imgFiles.Count) files)..." -ForegroundColor Yellow

foreach ($file in $imgFiles) {
    $fileName = $file.Name
    # Check if file is referenced anywhere
    if ($combinedContent -notmatch [regex]::Escape($fileName)) {
        Write-Host "  UNUSED: $fileName" -ForegroundColor Red
        Move-Item -Path $file.FullName -Destination "$unusedFolder\img\$fileName" -Force
        $unusedImgCount++
    }
}

# Check Images folder
$imageFiles = Get-ChildItem -Path "$projectRoot\Images" -File
$unusedImagesCount = 0
Write-Host "`nChecking Images folder ($($imageFiles.Count) files)..." -ForegroundColor Yellow

foreach ($file in $imageFiles) {
    $fileName = $file.Name
    if ($combinedContent -notmatch [regex]::Escape($fileName)) {
        Write-Host "  UNUSED: $fileName" -ForegroundColor Red
        Move-Item -Path $file.FullName -Destination "$unusedFolder\Images\$fileName" -Force
        $unusedImagesCount++
    }
}

# Check Sounds folder if it exists
if (Test-Path "$projectRoot\Sounds") {
    $soundFiles = Get-ChildItem -Path "$projectRoot\Sounds" -File
    $unusedSoundsCount = 0
    Write-Host "`nChecking Sounds folder ($($soundFiles.Count) files)..." -ForegroundColor Yellow
    
    foreach ($file in $soundFiles) {
        $fileName = $file.Name
        if ($combinedContent -notmatch [regex]::Escape($fileName)) {
            Write-Host "  UNUSED: $fileName" -ForegroundColor Red
            Move-Item -Path $file.FullName -Destination "$unusedFolder\Sounds\$fileName" -Force
            $unusedSoundsCount++
        }
    }
} else {
    $unusedSoundsCount = 0
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "SUMMARY" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "Unused files moved to: $unusedFolder" -ForegroundColor Cyan
Write-Host "  - img folder: $unusedImgCount/$($imgFiles.Count) files moved" -ForegroundColor Yellow
Write-Host "  - Images folder: $unusedImagesCount/$($imageFiles.Count) files moved" -ForegroundColor Yellow
if (Test-Path "$projectRoot\Sounds") {
    Write-Host "  - Sounds folder: $unusedSoundsCount/$($soundFiles.Count) files moved" -ForegroundColor Yellow
}
Write-Host "  - Total: $($unusedImgCount + $unusedImagesCount + $unusedSoundsCount) unused files" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
