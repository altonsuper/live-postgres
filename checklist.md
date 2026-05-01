# 🚀 Production Checklist - Live SaaS

## ✅ Done
- [x] Auth: Email + Google + GitHub
- [x] Database: PostgreSQL + Realtime + RLS
- [x] Storage: File upload + CDN
- [x] Deployment: Git → Vercel → Global CDN
- [x] AI Bridge: Local Qwen + Supabase + Fallback
- [x] Security: .gitignore blocks secrets, anon key safe
- [x] CLI: .\help.bat for one-click workflows

## 🔒 Before Launch
- [ ] Test Google login end-to-end (incognito)
- [ ] Verify RLS: Users can't see each other's data
- [ ] Add rate limiting (Supabase Edge Function)
- [ ] Set up custom domain (optional, $10/mo)

## 📈 Growth Ready
- [ ] Add `/pricing` page + Stripe links
- [ ] Add email notifications (Resend + Edge Function)
- [ ] Add analytics (PostHog/Plausible)
- [ ] Upgrade Supabase to Pro when hitting 80% limits

## 🔄 Forever Workflow
1. Edit code locally
2. .\push.bat
3. Ctrl+Shift+R on live site
4. Done.