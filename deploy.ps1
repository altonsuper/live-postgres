# deploy.ps1 — One-click Git + Vercel deploy
# Usage: Double-click deploy.bat OR run: .\deploy.ps1

$ErrorActionPreference = "Stop"
Write-Host "🚀 Starting deploy..." -ForegroundColor Cyan

# 1. Check prerequisites
if (!(Get-Command git -ErrorAction SilentlyContinue)) { 
    Write-Host "❌ Git not found. Install: https://git-scm.com" -ForegroundColor Red; exit 1 
}
if (!(Get-Command node -ErrorAction SilentlyContinue)) { 
    Write-Host "❌ Node.js not found. Install: https://nodejs.org" -ForegroundColor Red; exit 1 
}

# 2. Auto-commit changes
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
git add .
$changes = git status --porcelain
if ($changes) {
    git commit -m "deploy: $timestamp"
    Write-Host "✅ Committed: $timestamp" -ForegroundColor Green
} else {
    Write-Host "⚠️ No changes to commit" -ForegroundColor Yellow
}

# 3. Ensure branch is 'main'
git branch -M main 2>$null

# 4. Push to GitHub
Write-Host "📤 Pushing to GitHub..." -ForegroundColor Cyan
git push -u origin main
if ($LASTEXITCODE -ne 0) { 
    Write-Host "❌ Push failed. Check GitHub token/permissions." -ForegroundColor Red; exit 1 
}

# 5. Trigger Vercel deploy (optional — auto-deploy usually handles this)
# Uncomment below if you want manual trigger:
# Write-Host "🔁 Triggering Vercel deploy..." -ForegroundColor Cyan
# npx vercel --prod --token $env:VERCEL_TOKEN 2>$null

# 6. Done
$vercelUrl = "https://project-4rhm6.vercel.app"
Write-Host "`n✅ DEPLOY COMPLETE" -ForegroundColor Green
Write-Host "🌐 Live URL: $vercelUrl" -ForegroundColor Cyan
Write-Host "🔗 GitHub: https://github.com/altonsuper/live-postgres" -ForegroundColor Cyan
Write-Host "💡 Tip: Edit index.html → run this script → live in ~15s" -ForegroundColor Gray

# Open live URL in browser (optional)
# Start-Process $vercelUrl