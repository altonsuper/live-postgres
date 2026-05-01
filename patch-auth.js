// patch-auth.js — Production OAuth Redirect Patcher
// Run via: node patch-auth.js
// Purpose: Replaces window.location.origin with hardcoded production URL

const fs = require('fs');
const path = require('path');

// Configuration
const CONFIG = {
  filePath: path.join(__dirname, 'index.html'),
  backupPath: path.join(__dirname, 'index.html.bak'),
  productionUrl: 'https://project-4rhm6.vercel.app',
  patterns: [
    // Match: redirectTo: window.location.origin
    /redirectTo:\s*window\.location\.origin/g,
    // Match: redirectTo: window['location']['origin'] (edge case)
    /redirectTo:\s*window\[['"]location['"]\]\[['"]origin['"]\]/g,
    // Match: redirectTo: `${window.location.origin}` (template literal)
    /redirectTo:\s*`\$\{window\.location\.origin\}`/g
  ]
};

function main() {
  console.log('🔐 OAuth Redirect Patcher v1.0');
  console.log('===============================');
  
  // Check file exists
  if (!fs.existsSync(CONFIG.filePath)) {
    console.error(`❌ File not found: ${CONFIG.filePath}`);
    process.exit(1);
  }
  
  // Read file
  let content = fs.readFileSync(CONFIG.filePath, 'utf8');
  let originalContent = content;
  let changesMade = 0;
  
  // Apply each pattern
  for (const pattern of CONFIG.patterns) {
    if (pattern.test(content)) {
      content = content.replace(pattern, `redirectTo: '${CONFIG.productionUrl}'`);
      changesMade++;
      console.log(`✅ Pattern matched: ${pattern}`);
    }
  }
  
  // Save if changed
  if (changesMade > 0) {
    // Create backup first
    fs.writeFileSync(CONFIG.backupPath, originalContent, 'utf8');
    console.log(`💾 Backup saved: ${CONFIG.backupPath}`);
    
    // Write patched file
    fs.writeFileSync(CONFIG.filePath, content, 'utf8');
    console.log(`✅ Patched ${changesMade} occurrence(s)`);
    console.log(`🎯 Production URL: ${CONFIG.productionUrl}`);
    console.log('🚀 Ready to deploy: run .\\push.bat');
  } else {
    console.log('ℹ️  No matches found (already patched or different format)');
    console.log('🔍 Search index.html for: redirectTo');
  }
}

// Run
main();