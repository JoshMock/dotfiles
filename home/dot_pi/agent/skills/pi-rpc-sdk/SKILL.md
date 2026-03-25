---
name: pi-rpc-sdk
description: Pi headless RPC JSONL over stdin/stdout, strict LF framing, --mode json event streaming, and Node SDK alternatives (AgentSession). Use when integrating pi --mode rpc, pi --mode json, writing a client that speaks the protocol, reading JSON event streams, or choosing RPC vs in-process SDK. Use for "pi rpc client", "JSONL framing", "readline rpc", "--mode json", "json events", "embed pi without subprocess", "createAgentSession", "AgentSessionRuntime", "ModelRegistry", "embed pi", "SDK factory", even if the user only pasted JSON lines.
compatibility: stdio JSONL client or TypeScript SDK embedding; read pi-mono/packages/coding-agent/docs/rpc.md for framing and AgentSession guidance.
---

# Pi RPC and SDK integration

## Grounding

1. `pi-mono/packages/coding-agent/docs/rpc.md` — **Framing** section (LF-only record delimiter; `readline` incompatibility with U+2028/U+2029).
2. `pi-mono/packages/coding-agent/docs/sdk.md` — programmatic session patterns plus `createAgentSession`, `AgentSession`, `createAgentSessionRuntime`, `ModelRegistry.create()`, `AuthStorage.create()`, and `SessionManager.inMemory()`.
3. `pi-mono/packages/coding-agent/docs/json.md` — `--mode json` event stream: session header, `agent_*`/`turn_*`/`message_*`/`tool_execution_*` events, `jq` filtering examples.
4. `pi-mono/packages/coding-agent/src/modes/rpc/rpc-client.ts` — reference TypeScript client mentioned from `rpc.md` intro when applicable.
5. `pi-mono/packages/coding-agent/src/core/agent-session.ts` — API surface for in-process embedding (per `rpc.md` note to TypeScript users).

## Invariants

- Framing rules are normative text in `pi-mono/packages/coding-agent/docs/rpc.md`; quote or paraphrase strictly from that file when advising client implementers.
- Skill commands and prompt templates are expanded for RPC prompts per `rpc.md` **Input expansion** bullet under `prompt` command.
- `--mode json` is read-only observation (stdout events); `--mode rpc` is bidirectional control (stdin commands + stdout responses). Different use cases, same framing caveats for U+2028/U+2029.
- For TypeScript/Node embedding, `createAgentSession()` is the primary factory; it requires `sessionManager`, `authStorage`, and `modelRegistry`. For advanced multi-session hosting, use `createAgentSessionRuntime()` which returns `AgentSessionRuntime` with lower-level access to `agent`, `sessionManager`, `settingsManager`, `modelRegistry`, `extensions`, `bashExecutor`, `resourceLoader` — `pi-mono/packages/coding-agent/docs/sdk.md`.

## Workflows

- **Choose integration**: If user is on Node/TS, point to `rpc.md` recommendation to prefer `AgentSession` vs subprocess; cite the file’s opening **Note for Node.js/TypeScript users**.
- **Debug framing**: Re-read **Framing** section; do not suggest generic line readers as compliant.
- **JSON event stream**: For read-only observation of agent activity, point to `json.md` (`--mode json`); for bidirectional control, point to `rpc.md` (`--mode rpc`).
- **In-process embedding**: For TypeScript/Node users who don't need subprocess isolation, prefer `createAgentSession()` over `--mode rpc`. Import from `@mariozechner/pi-coding-agent`. See `pi-mono/packages/coding-agent/docs/sdk.md` and `pi-mono/packages/coding-agent/examples/sdk/`.

## Anti-patterns

- Do not describe delimiter behavior contradicting `rpc.md` (only `\n` as record delimiter; optional `\r` strip on input).
