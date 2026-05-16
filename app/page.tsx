import Link from "next/link";
export default function Home() {
  return (
    <main className="min-h-screen flex flex-col items-center justify-center p-6 bg-[#050508] text-[#e6e8ff]">
      <h1 className="text-5xl font-bold bg-gradient-to-r from-[#00f3ff] to-[#7000ff] bg-clip-text text-transparent mb-4">MCALTONZ 2026</h1>
      <p className="text-gray-400 max-w-xl text-center mb-6">AI-powered media workspace. Upload, analyze, and share with 80-model routing.</p>
      <div className="flex gap-4">
        <Link href="/upload" className="px-6 py-3 bg-[#00f3ff] text-black font-semibold rounded-full hover:shadow-[0_0_25px_rgba(0,243,255,0.5)] transition">📤 Upload</Link>
        <Link href="/gallery" className="px-6 py-3 border border-[#00f3ff] text-[#00f3ff] rounded-full hover:bg-[#00f3ff]/10 transition">🖼️ Gallery</Link>
      </div>
    </main>
  );
}
