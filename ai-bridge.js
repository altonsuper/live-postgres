// ai-bridge.js — Local AI ↔ Supabase Bridge
// Run with: node ai-bridge.js "your prompt here"

import { createClient } from '@supabase/supabase-js'
import { stdin as input, stdout as output } from 'process'
import { createInterface } from 'readline/promises'

// 🔐 Use service_role key ONLY for trusted local scripts (NEVER expose to browser)
const supabase = createClient(
  'https://zmtudgbebtnoiysebeli.supabase.co',
  'YOUR_SERVICE_ROLE_KEY_HERE' // Get from Supabase: Settings → API → service_role
)

const rl = createInterface({ input, output })

// 🧠 AI Prompt Handler (replace with your local Qwen call)
async function runAIQuery(prompt) {
  console.log(`🤖 AI Prompt: ${prompt}`)
  
  // Example: Let AI "decide" what to do (simple rule-based for now)
  if (prompt.toLowerCase().includes('messages')) {
    const { data } = await supabase
      .from('messages')
      .select('content, user_email, created_at')
      .order('created_at', { ascending: false })
      .limit(10)
    return `📬 Last 10 messages:\n${data.map(m => `- [${m.user_email}] ${m.content}`).join('\n')}`
  }
  
  if (prompt.toLowerCase().includes('users')) {
    const { count } = await supabase.from('auth.users').select('*', { count: 'exact', head: true })
    return `👥 Total users: ${count}`
  }
  
  if (prompt.toLowerCase().includes('upload')) {
    const { data } = await supabase.storage.from('uploads').list('public', { limit: 5 })
    return `📁 Recent uploads:\n${data.map(f => `- ${f.name}`).join('\n')}`
  }
  
  return "❓ I don't know how to handle that query yet. Add a rule in ai-bridge.js"
}

// 🖥️ CLI Interface
const prompt = process.argv[2] || await rl.question('🤖 Ask your AI: ')
const result = await runAIQuery(prompt)
console.log('\n✅ Response:\n', result)
rl.close()