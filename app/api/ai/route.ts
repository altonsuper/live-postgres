import { streamText } from "ai";
import { createOpenAI } from "@ai-sdk/openai";
import { NextRequest } from "next/server";
export async function POST(req: NextRequest) {
  const { model, prompt, system } = await req.json();
  const provider = createOpenAI({ baseURL: "https://dashscope.aliyuncs.com/compatible-mode/v1", apiKey: process.env.MODELSTUDIO_API_KEY! });
  try {
    const result = streamText({ model: provider(model || "qwen-max"), prompt, system: system || "You are MCALTONZ AI.", temperature: 0.7 });
    return result.toDataStreamResponse();
  } catch (e) { return new Response(JSON.stringify({ error: "AI routing failed" }), { status: 500 }); }
}
