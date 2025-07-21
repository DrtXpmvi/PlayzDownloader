# Set console window title
$host.ui.RawUI.WindowTitle = "PlayzDownloader - Git LFS Project Setup"

# Define the repository path
$RepoPath = "C:\Safe_Folder\DrtXpmvi\Programming\Languages\Python\Projects\PlayzDownloader\Github-Repo"

# Change to the repository directory
Set-Location -Path $RepoPath

Write-Host "🔄 Starting Git LFS setup in '$RepoPath'..."

# 1. Ensure Git LFS is installed
git lfs install
Write-Host "✅ Git LFS initialized"

# 2. Write .gitattributes file
$gitattributes = @"
# Track all files recursively
**/* filter=lfs diff=lfs merge=lfs -text

# Exclude Safe_Folder from LFS tracking (at any depth)
Safe_Folder/** !filter !diff !merge !text
**/Safe_Folder/** !filter !diff !merge !text
"@

Set-Content -Path ".gitattributes" -Value $gitattributes -Encoding UTF8
Write-Host "✅ .gitattributes file written"

# 3. Clear Git index without deleting files
git rm --cached -r . | Out-Null
Write-Host "📦 Cleared Git index (kept working directory files)"

# 4. Re-add everything with LFS rules
git add .
Write-Host "📁 Re-added all files for tracking"

# 5. Commit the changes
$commitMessage = "Update Git LFS tracking (excluding Safe_Folder)"
git commit -m $commitMessage
Write-Host "✅ Commit created: $commitMessage"

# 6. Push to GitHub
git push origin main
Write-Host "🚀 Pushed to GitHub (branch: main)"

Write-Host "🎉 Git LFS setup complete!"
