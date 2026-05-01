# 🔍 Local Test Checklist (Before Push)

## ✅ Pre-Flight
- [ ] `index.html` has production redirect: `redirectTo: 'https://project-4rhm6.vercel.app'`
- [ ] `dashboard.html` exists and has auth guard
- [ ] `config.json` is in `.gitignore` (secrets safe)
- [ ] `patch-auth.js` exists (for future fixes)

## 🧪 Local Test Steps
1. Run: `.\help.bat` → pick `9` (test-local)
2. Wait for: `Serving HTTP on :: port 8080`
3. Open: http://localhost:8080 in Chrome
4. Test these flows:

### 🔐 Auth Flow
- [ ] Click 🔵 Google → redirects to accounts.google.com
- [ ] Sign in → returns to http://localhost:8080
- [ ] See: `👤 you@gmail.com` (not error)
- [ ] Click 🚪 Logout → returns to login screen

### 📊 Dashboard Flow
- [ ] While logged in, go to: http://localhost:8080/dashboard.html
- [ ] See: Welcome message + stats cards
- [ ] See: Recent activity list (or "No activity yet")
- [ ] Click ← Home → returns to index.html

### 🤖 AI Bridge Flow (Optional)
- [ ] Open new PowerShell → run: `node ai-read.js "summary"`
- [ ] See: Fallback data (or AI answer if fast)
- [ ] No hanging, no errors

## 🚀 Ready to Push?
If ALL boxes above are ✅:
1. Stop local server (Ctrl+C in test window)
2. Run: `.\help.bat` → pick `1` (deploy)
3. Wait for Vercel rebuild (~15s)
4. Open incognito: `https://project-4rhm6.vercel.app?v=FORCE`
5. Hard refresh: Ctrl+Shift+R
6. Test same flows on live URL

## 🆘 If Something Fails Locally
- ❌ Auth redirect wrong → Run `help.bat` → `6` (auth-fix) → retest
- ❌ Dashboard 404 → Check `dashboard.html` exists in folder
- ❌ AI bridge error → Check `config.json` has correct keys
- ❌ Server won't start → Try `npx serve . -p 8080` instead of Python

## 🎯 Golden Rule
> "If it doesn't work on localhost:8080, it won't work on Vercel."
> Test first. Push second. Sleep well.