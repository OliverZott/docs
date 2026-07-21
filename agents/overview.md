# AI stack

## Models (LLMs)

**Definition:**  
LLMs sind die „Gehirne“ – reine Modelle, die Text erzeugen, aber selbst keine Dateien lesen, Befehle ausführen oder Projekte analysieren.

**Typische Beispiele:**

- **Qwen / Qwen2.5 / Qwen3‑Coder** – sehr starke Open‑Source‑Coder‑Modelle, laufen gut lokal und sind für Code ideal.
- **LLaMA** – Meta‑Modelle, gute Generalisten für Sprache und Code.
- **Mistral / Codestral** – starke europäische Modelle, u. a. auf Code optimiert.
- **Hermes** – von Nous Research, oft als feingetunte Varianten für Chat/Code.  

**Wichtig:**  
Ein LLM:

- **generiert nur Text**  
- hat **keine Tools**, keine Autonomie  
- kann **nicht selbst Dateien lesen/schreiben** oder Befehle ausführen  

---

## Agents

**Definition:**  
Agents sind Programme/Workflows, die ein LLM benutzen und zusätzlich Tools, Dateizugriff, Terminal, Browser usw. haben.  
Sie sind „Gehirn + Körper + Werkzeuge“.

**Typische Beispiele (wie in deiner Ollama‑Liste):**

- **Cline** – autonomer Coding‑Agent mit paralleler Ausführung, arbeitet gegen dein lokales Modell (z. B. Qwen‑Coder).
- **Claude Code (lokal)** – Open‑Source‑Agent, der so arbeitet wie Claude Code, aber deine lokalen Modelle nutzt, nicht die echte Claude‑API.  
- **Codex App / Codex (lokal)** – Open‑Source‑Agenten, die den OpenAI‑Codex‑Workflow nachbauen, aber mit lokalen Modellen laufen.  
- **OpenCode, OpenClaw, Pi, Qwen Code, Hermes Agent, Hermes Desktop** – verschiedene Agenten für Coding oder „Personal AI“ mit Tools, Dateizugriff, Sub‑Agents usw.

**Wichtig:**

- Diese Agenten sind **keine LLMs**, sondern **Programme, die LLMs benutzen**.  
- Die „Claude Code“/„Codex“‑Namen sind **Workflows/Branding**, nicht die echten Cloud‑Produkte von Anthropic/OpenAI.  
- Sie laufen **lokal** und sprechen mit deinem **Ollama‑Server** oder einem anderen LLM‑Runtime.

---

## Ollama

**Rolle im Stack:**  
Ollama ist dein **LLM‑Runtime** – es lädt, verwaltet und serviert Modelle lokal über eine HTTP‑API (`http://localhost:11434`).

**Funktionen:**

- Modelle **downloaden** (`ollama pull qwen2.5-coder:14b` etc.)  
- Modelle **ausführen** (`ollama run ...`)  
- Eine **OpenAI‑kompatible API** bereitstellen, die Agents/IDE‑Extensions nutzen können (Cline, Continue, VS Code‑Plugins).

**Was Ollama NICHT macht:**

- Kein Training, kein Fine‑Tuning  
- Keine Agent‑Logik – dafür sind Cline, Claude Code, Codex etc. zuständig  

---

## Unsloth

**Rolle im Stack:**  
Unsloth ist ein **Training/Fine‑Tuning‑Toolkit** für LLMs – es verändert Modelle, statt sie nur auszuführen.

**Funktionen (typisch):**

- **QLoRA/LoRA‑Fine‑Tuning** von bestehenden Modellen auf deinen Daten  
- Optimierte Nutzung von GPU‑VRAM  
- Export von feingetunten Modellen (z. B. nach Hugging Face / GGUF), die du anschließend wieder in **Ollama** oder andere Runtimes einbinden kannst  

**Was Unsloth NICHT macht:**

- Kein Chat‑Client, kein Agent, kein Runtime  
- Es startet keine Modelle für dich – es **trainiert** sie, damit du sie später z. B. mit Ollama laufen lässt

**Kurz:**  

- **Ollama = Modelle benutzen**  
- **Unsloth = Modelle trainieren/verbessern**

---

## Beziehung zwischen Models, Agents, Ollama und Unsloth

- **LLMs (Qwen, LLaMA, Mistral, Hermes …)**  
  → werden von **Ollama** ausgeführt  
  → werden von **Agents** benutzt (Cline, Claude Code, Codex …)

- **Agents**  
  → sprechen über eine API mit deinem Runtime (z. B. Ollama)  
  → führen Aktionen aus: Dateien ändern, Befehle ausführen, Projekte analysieren

- **Unsloth**  
  → nimmt ein Basis‑LLM (z. B. Qwen2.5)  
  → feintuned es auf deine Daten  
  → du importierst das neue Modell wieder in **Ollama** und nutzt es mit deinen Agents

---

## Einfacher Start: Ollama lokal mit einem brauchbaren LLM

### 1. Ollama installieren

**Schritte (Windows/macOS/Linux):**

1. **Download** von der offiziellen Ollama‑Seite und Installer ausführen.
2. Terminal öffnen und prüfen:  
   - `ollama --version`  
   - wenn das läuft, ist der Runtime da.

### 2. Ein gutes Coding‑Modell ziehen (Beispiel: Qwen2.5‑Coder)

Für einen typischen Entwickler‑Laptop mit 16–24 GB RAM/VRAM:

1. Im Terminal:  
   - `ollama pull qwen2.5-coder:14b` (oder kleiner: `qwen2.5-coder:7b`)
2. Testen:  
   - `ollama run qwen2.5-coder:14b "Schreibe eine TypeScript-Funktion, die zwei sortierte Arrays merged."`  
   - Wenn die Tokens in brauchbarer Geschwindigkeit kommen, bist du ready.

### 3. Optional: Agent/IDE anbinden (z. B. Cline oder Continue)

1. **VS Code Extension installieren** (Cline oder Continue).
2. In der Config den Provider auf **Ollama** setzen, Base‑URL:  
   - `http://localhost:11434` (oder `http://localhost:11434/v1`, je nach Adapter)  
3. Als Modellnamen `qwen2.5-coder:14b` eintragen.  
4. Jetzt kann der Agent:

   - Dateien lesen/ändern  
   - Befehle ausführen  
   - Refactorings planen  
   – alles lokal, ohne Cloud‑Kosten.

---

## Einfacher Start: Unsloth + Ollama (exemplarisch)

> Das ist „Level 2“ – nur, wenn du wirklich eigene Modelle trainieren willst.

### 1. Unsloth installieren

- Python‑Umgebung einrichten (z. B. `conda` oder `venv`).  
- Unsloth per `pip` installieren (typisch: `pip install unsloth` o. ä., je nach aktueller Doku).

### 2. Basis‑Modell laden (z. B. Qwen2.5)

- Ein Open‑Weight‑Modell von Hugging Face wählen (z. B. `Qwen/Qwen2.5-7B` oder eine Coder‑Variante).  
- In Unsloth als Basis‑Checkpoint laden.

### 3. Fine‑Tuning auf deinen Daten

- Deine Trainingsdaten vorbereiten (z. B. JSONL mit Prompts/Antworten oder Code‑Snippets).  
- In Unsloth ein QLoRA‑Fine‑Tuning laufen lassen (Konfiguration: Batch‑Size, LR, Epochen etc.).  
- Ergebnis: ein feingetunter Modell‑Checkpoint.

### 4. Export und Nutzung in Ollama

- Das feingetunte Modell in ein Format bringen, das Ollama versteht (z. B. GGUF oder ein von der Community bereitgestelltes Ollama‑Modell‑Template).  
- In einem `Modelfile` für Ollama referenzieren und mit `ollama create` ein neues Modell anlegen.
- Danach kannst du dein **eigenes** Modell genauso nutzen wie `qwen2.5-coder:14b` – mit Cline, Continue, Claude‑Code‑Agenten usw.

---

## Minimaler „Day‑1“-Flow für dich

1. **Ollama installieren**  
2. **`qwen2.5-coder:14b` ziehen und testen**  
3. **VS Code + Cline/Continue konfigurieren** auf `http://localhost:11434`  
4. **Ein Projekt öffnen** und den Agent eine kleine Aufgabe erledigen lassen (z. B. „Refactor diese Funktion“, „Schreibe Tests für dieses Modul“).  
5. Erst wenn du mit der Qualität vertraut bist und merkst „ich will, dass das Modell meinen Stil/Daten kennt“, lohnt sich der Schritt zu **Unsloth**.

---

Wenn du magst, kann ich dir als nächsten Schritt eine **konkrete `Modelfile` + Beispiel‑Config für Cline/Continue** bauen, exakt zugeschnitten auf deinen Hardware‑Level und deinen Node/TypeScript‑Workflow.
