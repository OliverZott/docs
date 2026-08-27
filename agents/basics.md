# AI and Agent Basics

e.g. https://ollama.com/library/qwen2.5-coder

- model:qwen2.5-coder:14b
- size:9.0GB
- context: 32K

## Parameters

- **14b** refers to model size, measured in billions of parameters.
- Parameters are the “neurons” of the model.
- More parameters → more intelligence, better reasoning, better coding.

## Size

This is the actual **memory footprint** when loaded, this is how much **VRAM** or RAM the model needs to run.

Rule of thumb:

- Model GB ≈ minimum VRAM required
- If your GPU has 12–16GB VRAM, you can run up to 14B comfortably.
- 32B needs 20GB+ VRAM, usually multi‑GPU or server‑class cards.

## Context

- This is the maximum input length the model can handle at once.
- 32K tokens ≈ ~24,000 words
- You can paste huge files, long codebases, multi‑file projects.
- It does not affect VRAM.
- It affects how much text the model can “see” at once.
