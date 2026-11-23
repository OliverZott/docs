# RAG & How Agents Actually Work

## Short version

- **The LLM is the only "intelligent" part.** It does one thing: it takes text in and produces text out. It can't search, read files or run anything, and it remembers nothing between calls.
- **The agent is ordinary code** (TypeScript, Python, …), a simple loop with no AI in it. It calls the LLM, does whatever the LLM asks for (search, read a file, run a command), and sends the result back.
- **RAG** (Retrieval-Augmented Generation) means **looking up relevant information first and putting it into the prompt**, so the LLM answers from real data instead of only from what it memorized during training.

The agent has no intelligence of its own. All decisions come from the LLM; the agent just carries them out.

---

## 1. What RAG is and what it's for

An LLM only knows what was in its training data:

- **It's out of date.** It knows nothing after its training cutoff.
- **It's never seen your data.** It doesn't know your internal docs, tickets, wikis, contracts or code.
- **It makes things up.** When it doesn't know, it may give a confident wrong answer.

RAG fixes this **without retraining the model** (retraining would be fine-tuning, e.g. with Unsloth, see [ai-stack.md](ai-stack.md)). You find the right facts and paste them into the prompt at the moment you ask the question.

Typical uses:

- Chatbots over company docs ("How do I request VPN access?")
- Customer support over manuals or a knowledge base
- Search over legal or medical documents, with answers that cite their sources
- Coding assistants that look up the relevant parts of a large codebase

### Why not just send the question straight to the LLM?

Because the index is **not of your question, it's of your documents**. The thing the LLM is missing is the *content of your documents*, not the question.

Example: your company has **10,000 internal documents** (wikis, manuals, tickets), roughly 50 million tokens of text. You ask: *"How do I request VPN access?"*

| Option | What happens | Problem |
| :--- | :--- | :--- |
| **A: Just send the question to the LLM** | The LLM answers from its training data | It has **never seen your company's docs**. It doesn't know your process, so it guesses or gives a generic answer |
| **B: Send the question + all 10,000 documents** | The LLM reads everything and answers | 50M tokens is **50× more than the largest context window** (1M). Even if it fit, every question would cost about $50–400 |
| **C: RAG** | Search finds the **5 relevant pages** out of 10,000, and only those go to the LLM with the question | ~3,000 tokens, a fraction of a cent, and the answer is based on *your* docs |

The question's vector is only the **search query**. It answers *"which of my 10,000 documents is this question about?"*

**Library analogy:** you (the question) walk into a library (your documents). The expert (the LLM) is brilliant but has never read these particular books. The index (vector DB) tells you which 5 pages matter, and you hand the expert those 5 pages instead of the whole library.

If your documents are small enough, **option B is perfectly fine**: that's "long context instead of RAG" in [section 5](#5-rag-vs-long-context-vs-agentic-search). RAG only pays off once the collection is too big or too expensive to send every time.

---

## 2. How classic RAG works

There are two phases.

### Phase A: Indexing (done once, ahead of time; plain code plus a small embedding model)

1. **Split** the documents into chunks (e.g. 300–1000 tokens each).
2. **Embed** each chunk. An **embedding model** turns the text into a vector (a list of numbers) that represents its meaning, so texts with similar meanings get similar vectors.
   - This is a *separate, small model*, not the chat LLM. Example: `nomic-embed-text` in the Continue config in [ai-stack.md](ai-stack.md) (role `embed`). That is exactly what Continue uses to index your codebase for RAG. More in [section 6](#6-embedding-models-and-what-goes-where).
3. **Store** the vectors in a vector database (pgvector, Qdrant, Pinecone, Elasticsearch, …).

### Phase B: Answering (on every question)

1. **Embed the question** with the same embedding model.
2. **Retrieve** the chunks whose vectors are closest to the question's vector (usually the top 5–20). This is pure math (vector distance), no LLM involved. It's often combined with ordinary keyword search ("hybrid search").
3. Optionally **rerank** the chunks with a second small model so the best ones come first.
4. **Build the prompt.** The code pastes the chunks into a template:

   ```text
   Answer using only the context below. Cite the source.
   <context>
   [chunk 1 – vpn-guide.md] ...
   [chunk 2 – it-policy.pdf] ...
   </context>
   Question: How do I request VPN access?
   ```

5. **Generate.** This is the only step where the chat LLM runs: it reads the prompt and writes the answer.

### What the vector DB actually stores (nothing is translated back)

Embedding only works one way: you **can't** turn a vector back into its text. Instead, the vector DB stores **the original text next to each vector**:

| id | vector (used for searching) | text (stored as-is) | source |
| :--- | :--- | :--- | :--- |
| 17 | [0.12, -0.83, 0.44, …] | "To request VPN access, open a ticket in…" | vpn-guide.md |
| 18 | [0.09, 0.51, -0.20, …] | "Remote access requires 2FA…" | it-policy.pdf |
| … | … | … | … |

Per question:

1. **Embedding model:** turns the question into a vector. That's its only job, and it's then finished; it never sees the search results.
2. **Vector DB:** compares that vector with the stored ones and returns the closest **rows**, e.g. ids 17 and 18 *with their stored text*.
3. **Your code (the RAG pipeline or agent):** takes the `text` column of those rows and pastes it into the prompt template.
4. **LLM:** reads that text plus the question and writes the answer.

The vector works like an **index card used to find the right page**. Once you've found it, you hand over the original page, not the index card. The LLM gets the original chunk word for word, which is why it can quote and cite sources accurately.

### How big is a vector DB?

Not huge. Vectors are small:

- One vector = 768 numbers × 4 bytes ≈ **3 KB**
- One chunk of original text ≈ 2–4 KB, about the same size

So a vector DB is roughly **as big as your text, around twice the size with the vectors added**:

| Collection | Chunks | Vector size |
| :--- | :--- | :--- |
| A 500-page manual | ~1,000 | ~3 MB |
| A company wiki (10,000 docs) | ~200,000 | ~600 MB |
| A huge enterprise archive | ~10,000,000 | ~30 GB |

Search stays fast even at that scale, because vector DBs use special indexes (e.g. **HNSW**) that find the nearest vectors **without comparing against every row**, typically in a few milliseconds. Small collections don't even need a dedicated database: Postgres with the `pgvector` extension, or a local file, is enough. Continue, for example, stores its codebase index as a few files on your disk.

---

## 3. Who does what in RAG?

The question it's easy to get confused about: **does the LLM search for its own context?**

**In classic RAG: no.** The LLM is called **once**, at the very end. Everything before that is ordinary code plus the small embedding model:

| Step | Done by | Is it "AI"? |
| :--- | :--- | :--- |
| Split documents into chunks | Your code | No |
| Turn chunks and question into vectors | Embedding model | Yes, but small and specialized; it just maps text to numbers |
| Find the most similar chunks | Vector DB (math) | No |
| Paste chunks + question into the prompt | Your code (string template) | No |
| Read everything and write the answer | **Chat LLM** | **Yes, this is the only reasoning step** |

The LLM never "prepares its own question". By the time it sees anything, the code has already found the context and placed it in the prompt. From the LLM's point of view, it just got a long prompt that happens to contain the right documents.

### Variant: query rewriting (LLM is called twice)

Users ask vague questions ("and what about the other one?"). So some systems call the LLM twice:

1. **LLM call 1:** "Rewrite this question as a good search query" → `"VPN access request procedure"`
2. Code runs the search with that query.
3. **LLM call 2:** "Here is the context, answer the question" → final answer.

So yes, in this case the **same model writes the search query and later writes the answer**. But these are **two separate, independent calls**. The LLM isn't talking to itself: the code sits in between, takes the output of call 1, runs the search, and builds a new prompt for call 2.

### Variant: agentic RAG (the LLM decides when and what to search)

The LLM gets a `search` tool and decides itself whether, what, and how often to search. This is the agent loop from the next section. Coding agents like Claude Code mostly work this way: they don't use a vector database, they call `grep` / file-read tools as needed.

---

## 4. Where does an agent's "intelligence" come from?

**From the LLM only.** The agent is a program with a loop. The trick that makes it work:

> The LLM can't *do* anything, but it can *write a request* for an action. The agent program reads that request, does the action, and shows the LLM the result.

### The agent loop

```text
┌──────────── Agent (normal code, no AI) ────────────┐
│                                                    │
│ 1. Send to the LLM:                                │
│    - system prompt ("You are a coding agent ...")  │
│    - list of available tools (name, description,   │
│      parameters), e.g. read_file, grep, run_bash   │
│    - full conversation so far                      │
│                                                    │
│ 2. LLM answers with EITHER                         │
│    a) a final text answer  → done, show to user    │
│    b) a tool request, e.g.                         │
│       { "tool": "grep", "args": { "pattern": "VPN" } }
│                                                    │
│ 3. Agent executes the tool (real grep, real file   │
│    read, real shell command).                      │
│                                                    │
│ 4. Agent appends the tool result to the            │
│    conversation → go back to 1.                    │
└────────────────────────────────────────────────────┘
```

In code it really is about this simple:

```ts
const messages = [{ role: "user", content: userQuestion }];

while (true) {
  const reply = await llm.call({ system, tools, messages }); // the only "intelligent" step

  if (reply.type === "text") {          // LLM says: I'm done
    console.log(reply.text);
    break;
  }

  // LLM says: please run this tool for me
  const result = await runTool(reply.toolName, reply.toolArgs); // plain code: fs, grep, exec...
  messages.push(reply);                                         // remember what it asked
  messages.push({ role: "tool", content: result });             // and what came back
}
```

### Who decides what?

| Decision | Who makes it |
| :--- | :--- |
| Which file to read, what to search for, which command to run | **LLM** (it writes the tool request) |
| Whether the task is finished | **LLM** (it replies with text instead of a tool call) |
| How to interpret an error and what to try next | **LLM** |
| Actually reading the file / running the command | **Agent** (plain code) |
| Which tools exist at all, permissions ("ask before deleting files") | **Agent** (hard-coded by whoever built it) |
| Keeping the conversation history and sending it each time | **Agent** |
| Limits (max steps, timeouts, cost) | **Agent** |

### Why the LLM seems to "remember" and "plan"

The LLM is **stateless**: every call starts from zero. It seems to follow a plan only because the agent sends it the **entire conversation, including every previous tool call and result, on every call**. Each time, the LLM reads the whole history and decides on the next single step. "Planning" is the LLM writing a plan into its reply, which is then part of the history it reads on the next call.

That's also why the **context window** (see [basics.md](basics.md)) matters so much for agents: the history grows with every tool call.

### How does the LLM know how to make tool requests?

Models like Claude, GPT, Qwen-Coder and Llama are **trained** (fine-tuned) to answer in a special tool-call format when the prompt contains a list of tools. That's why some small local models are poor at agent work: they were never trained well on tool use, so they ignore the tools or produce broken requests.

### Analogy

- **LLM** = a very smart consultant who sits in a closed room with no phone and no computer. It can only read notes slipped under the door and write notes back.
- **Agent** = an assistant outside the door who can't think for themselves but does exactly what the notes say ("open file X", "search for Y"), then slips the results back under the door, along with all the earlier notes, because the consultant forgets everything after each note.

---

## 5. RAG vs. long context vs. agentic search

| Approach | How it works | Good for | Weak spots |
| :--- | :--- | :--- | :--- |
| **Classic RAG** | Code retrieves chunks, LLM answers once | Huge document collections, frequently changing data, per-user access control | Answer is only as good as the retrieval; a missed chunk means a wrong or vague answer |
| **Long context** | Put *everything* into the prompt (1M-token models: Claude, Gemini 4, GPT-6.2, Qwen4-Max) | Small/medium codebases or document sets; no indexing needed | Cost per call (prompt caching helps); doesn't scale to millions of documents |
| **Agentic search** | LLM calls search/grep/read tools in a loop | Codebases, exploratory questions, multi-step research | Slower and more LLM calls; depends on the model being good at tool use |

Most RAG tuning goes into the retrieval part: chunk size, hybrid search, and reranking.

---

## 6. Embedding models and what goes where

### Is an embedding model a small LLM?

It's closely related, but it does a different job:

| | Chat LLM (Claude, GPT, Qwen-Coder, …) | Embedding model (`nomic-embed-text`, …) |
| :--- | :--- | :--- |
| Architecture | Transformer | Transformer (same family) |
| Size | Billions to trillions of parameters | Usually ~100M to a few B (`nomic-embed-text` ≈ 137M, ~270 MB) |
| Output | **Text**, generated word by word | **One vector** (e.g. 768 numbers), in a single pass |
| Can it answer questions? | Yes | No, it can't write text at all |

So it's a small cousin of an LLM, trained for one thing only: placing texts with similar meanings close together as vectors. It's cheap and fast, which is why it runs fine on a laptop.

### Where does it run?

Either works:

- **Locally**, e.g. Ollama + `nomic-embed-text` (as in the Continue config in [ai-stack.md](ai-stack.md)).
- **Through a cloud embedding API**: OpenAI, Google, Voyage AI, Cohere, … (Anthropic doesn't offer its own embedding model and points to Voyage AI.)

The embedding model and the chat LLM are independent. You can run local embeddings with a cloud LLM, or the other way round.

### The vectors are never sent to the LLM

The vectors are **only used for searching**. The LLM always gets **plain text**:

```text
your machine                                       cloud LLM API
────────────                                       ─────────────
question ──► embedding model ──► vector
                                    │
                         vector DB: "which chunks are closest?"
                                    │
              take the TEXT of those chunks ─────────► prompt = chunk text + question
                                                          │
              answer ◄────────────────────────────────── LLM reads text, writes answer
```

An LLM can't read another model's vectors; to it they're meaningless numbers. (LLMs do turn text into vectors internally too, but those are their own internal ones and can't be swapped with an embedding model's.)

### What this means for privacy

| Setup | What leaves your machine |
| :--- | :--- |
| Local embeddings + cloud LLM | Your whole collection stays local during indexing, but **the chunks found for each question are sent to the LLM as plain text** |
| Cloud embeddings + cloud LLM | During indexing, **every document** goes to the embedding provider; per question, the chunks go to the LLM |
| Local embeddings + local LLM (e.g. Ollama + Qwen-Coder) | Nothing |

Running the embeddings locally does **not** keep the relevant content private if the LLM is in the cloud.

---

## 7. Example: how Claude Code works (agentic search instead of RAG)

Claude Code is an agent as described in [section 4](#4-where-does-an-agents-intelligence-come-from). It uses **no embeddings and no vector index**. It uses agentic search:

- **The model** (e.g. Claude Opus 5.5) runs in **Anthropic's cloud**. It makes all the decisions.
- **The agent program** (the Claude Code CLI / VS Code extension) runs **locally on your machine**, along with its tools: `Grep`, `Glob`, `Read`, `Edit`, `Bash`, …
- When the model decides "read `agents/ai-stack.md`", Claude Code reads the file **locally** and sends **the file's text** to the API as part of the conversation. Then the model decides the next step.

Example flow ("Is there an embedding model in my Continue config?"):

```text
Model (cloud)                          Claude Code (your machine)
─────────────                          ──────────────────────────
"run Grep, pattern 'embed'"   ───────► runs grep over the repo locally
                              ◄─────── sends back the matching lines (text)
"Read agents/ai-stack.md"     ───────► reads the file locally
                              ◄─────── sends back the file content (text)
"Yes: nomic-embed-text,
 with role embed"             ───────► shows the answer to you
```

### Claude Code vs. classic RAG

| | Classic RAG | Claude Code (agentic search) |
| :--- | :--- | :--- |
| Preparation | Index everything ahead of time (chunk, embed, store) | None; works on the files as they are right now |
| Who decides what to look up | Code + vector similarity, once per question | The LLM, step by step, as often as needed |
| How it searches | Similarity of meaning (vectors) | Exact text (`grep`), file names (`glob`), reading whole files |
| LLM calls per question | Usually 1 (2 with query rewriting) | Many, one per step |
| Up to date | Only as fresh as the last indexing run | Always current |
| Strong at | Huge collections of prose; finding things phrased differently from the question ("VPN" vs. "remote access") | Code, where exact names, symbols and file structure matter |
| Weak at | Missed chunks give bad answers; index goes stale | Slower and more tokens; finds only what it thinks to search for |
| What reaches the cloud LLM | Only the retrieved chunks | Every file and search result it reads (files it never opens aren't sent) |

Both approaches end the same way: **the cloud LLM only ever sees plain text**, whatever was retrieved or read. Nothing is uploaded ahead of time, but anything the agent reads is sent.
