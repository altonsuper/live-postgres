// test-db-api.js — Simpler fallback using Supabase REST API
// Run with: node test-db-api.js

const PROJECT_URL = 'https://zmtudgbebtnoiysebeli.supabase.co'
const ANON_KEY = 'sb_publishable_U22LM59-HGzGBp0xk8Ouxg_CGngfga8'

async function test() {
  try {
    console.log('🔗 Connecting via Supabase API...')
    
    // Fetch messages via REST API
    const res = await fetch(`${PROJECT_URL}/rest/v1/messages?select=content&limit=3`, {
      headers: {
        'apikey': ANON_KEY,
        'Authorization': `Bearer ${ANON_KEY}`
      }
    })
    
    if (!res.ok) throw new Error(`HTTP ${res.status}: ${await res.text()}`)
    
    const data = await res.json()
    console.log('✅ Connected! Last 3 messages:')
    data.forEach((m, i) => console.log(`  ${i+1}. ${m.content}`))
    
  } catch (err) {
    console.error('❌ Error:', err.message)
  }
}

test()