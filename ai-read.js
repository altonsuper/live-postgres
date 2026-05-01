// ai-read.js — Production-Ready AI Bridge
const fs = require('fs');
const path = require('path');

const CONFIG = JSON.parse(fs.readFileSync(path.join(__dirname, 'config.json'), 'utf8'));
const { supabase, ollama, app } = CONFIG;
const question = process.argv[2] || app.defaultQuestion;

async function fetchSupabase(endpoint) {
  const url = supabase.url + endpoint;
  const res = await fetch(url, {
    headers: { 'apikey': supabase.anonKey, 'Authorization': `Bearer ${supabase.anonKey}` }
  });
  if (!res.ok) throw new Error(`Supabase HTTP ${res.status}`);
  return await res.json();
}

async function askOllama(prompt) {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), ollama.timeoutMs);
  try {
    const res = await fetch(`${ollama.baseUrl}/api/generate`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        model: ollama.model, prompt, stream: false, options: ollama.options
      }),
      signal: controller.signal
    });
    clearTimeout(timeout);
    const json = await res.json();
    return json.response?.trim() || null;
  } catch { clearTimeout(timeout); return null; }
}

async function run() {
  console.log(`🤖 Q: "${question}"`);
  let dataText = '';
  
  try {
    if (question.includes('message')) {
      const data = await fetchSupabase(supabase.endpoints.messages);
      dataText = data.map(d => `[${d.user_email || 'anon'}] ${d.content}`).join('\n');
    } else if (question.includes('user') || question.includes('count')) {
      const rows = await fetchSupabase(supabase.endpoints.userCount);
      const uniqueEmails = [...new Set(rows.map(r => r.user_email).filter(e => e))];
      dataText = `Unique users: ${uniqueEmails.length}\nEmails: ${uniqueEmails.join(', ') || 'none'}`;
    } else {
      const data = await fetchSupabase(supabase.endpoints.messages);
      dataText = data.map(d => d.content).join('\n');
    }
  } catch (err) { console.error(`❌ DB Error: ${err.message}`); process.exit(1); }
  
  const promptKey = question.includes('count') ? 'count' : question.includes('list') ? 'list' : 'summary';
  const promptTemplate = ollama.prompts[promptKey] || ollama.prompts.summary;
  const prompt = promptTemplate.replace('{data}', dataText);
  
  console.log('🧠 AI thinking...');
  let answer = await askOllama(prompt);
  
  if (answer && ollama.fallback.enabled) {
    console.log(`✅ AI: ${answer}`);
  } else if (ollama.fallback.enabled) {
    console.log(ollama.fallback.template.replace('{data}', dataText));
  } else {
    console.log(`📄 Raw:\n${dataText}`);
  }
}
run().catch(err => { console.error('💥 Crash:', err.message); });