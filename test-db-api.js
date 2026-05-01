// test-db-api.js — Supabase REST API test (no password needed)
const PROJECT_URL = 'https://zmtudgbebtnoiysebeli.supabase.co'
const ANON_KEY = 'sb_publishable_U22LM59-HGzGBp0xk8Ouxg_CGngfga8'

async function test() {
  console.log('🔗 Connecting to Supabase...')
  try {
    const res = await fetch(`${PROJECT_URL}/rest/v1/messages?select=content&limit=3`, {
      headers: {
        'apikey': ANON_KEY,
        'Authorization': 'Bearer ' + ANON_KEY
      }
    })
    if (!res.ok) throw new Error('HTTP ' + res.status)
    const data = await res.json()
    console.log('✅ Connected! Messages:')
    data.forEach((m, i) => console.log(`  ${i+1}. ${m.content}`))
  } catch (err) {
    console.error('❌ Error:', err.message)
  }
}
test()
