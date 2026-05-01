// smoke-test.js — Quick live site verification
const SITE = 'https://project-4rhm6.vercel.app';
async function test() {
  console.log(`🔍 Testing ${SITE}...`);
  const res = await fetch(SITE);
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  const html = await res.text();
  const checks = [
    { name: 'Auth buttons', pass: html.includes('Google') && html.includes('GitHub') },
    { name: 'Supabase SDK', pass: html.includes('supabase-js') },
    { name: 'Production redirect', pass: html.includes('project-4rhm6.vercel.app') },
    { name: 'Dashboard link', pass: html.includes('dashboard.html') }
  ];
  console.log('\n✅ Results:');
  checks.forEach(c => console.log(`  ${c.pass ? '✅' : '❌'} ${c.name}`));
  const allPass = checks.every(c => c.pass);
  console.log(`\n${allPass ? '🎉 All checks passed!' : '⚠️  Review manually'}`);
}
test().catch(err => console.error('💥 Error:', err.message));