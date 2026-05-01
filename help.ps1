# Save as C:\Ag\db\help.ps1
Write-Host "`n👑 SUPREME MASTER CLI" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host "1. deploy     → .\push.bat + open live site" -ForegroundColor White
Write-Host "2. dashboard  → open /dashboard.html in incognito" -ForegroundColor White  
Write-Host "3. ai-read    → node ai-read.js 'your question'" -ForegroundColor White
Write-Host "4. secure     → validate .gitignore + check for secrets" -ForegroundColor White
Write-Host "5. status     → show Supabase usage + Vercel deploy status" -ForegroundColor White
Write-Host "6. exit       → close this menu" -ForegroundColor White

$choice = Read-Host "`n👤 Select option (1-6)"
switch ($choice) {
  "1" { .\push.bat; Start-Process "https://project-4rhm6.vercel.app?v=$(Get-Random)" }
  "2" { Start-Process "chrome.exe" --args "--incognito", "https://project-4rhm6.vercel.app/dashboard.html" }
  "3" { $q = Read-Host "❓ Ask AI"; node ai-read.js $q }
  "4" { 
    Write-Host "`n🔒 Security Check:" -ForegroundColor Cyan
    if ((Get-Content .gitignore) -contains "config.json") { Write-Host "✅ config.json ignored" -ForegroundColor Green }
    else { Write-Host "❌ Add 'config.json' to .gitignore" -ForegroundColor Red }
    if (Test-Path "config.json") { Write-Host "⚠️  config.json exists locally (good)" -ForegroundColor Yellow }
    else { Write-Host "❌ config.json missing → copy from config.example.json" -ForegroundColor Red }
  }
  "5" { 
    Write-Host "`n📊 Status:" -ForegroundColor Cyan
    Write-Host "• Vercel: https://vercel.com/altonsupers-projects/project-4rhm6" -ForegroundColor White
    Write-Host "• Supabase: https://supabase.com/dashboard/project/zmtudgbebtnoiysebeli" -ForegroundColor White
    Start-Process "https://vercel.com/altonsupers-projects/project-4rhm6"
  }
  "6" { Write-Host "👋 Goodbye."; exit }
  default { Write-Host "❌ Invalid option"; .\help.ps1 }
}