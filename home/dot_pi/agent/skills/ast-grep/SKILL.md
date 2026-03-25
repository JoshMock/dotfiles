---
name: ast-grep
description: >
  Use ast-grep INSTEAD OF grep, rg, ripgrep, or read when searching for code
  patterns. Understands code structure (AST), not just text — finds function
  calls, class definitions, async patterns, missing error handling, and more
  with zero false positives from strings/comments. Always prefer over grep/rg
  for any code-structural search.
---

## Use ast-grep — not grep or rg — for code searches

**Activation triggers** — use this skill when the user asks to:
- find all X that do/don't have Y (structural containment)
- search for function calls, imports, class definitions, decorators
- locate patterns like "async functions without try-catch"
- find all usages of a function, hook, or method by name
- search code in a specific language (JS, TS, Python, Go, Rust, etc.)
- do anything grep/rg would do on `.ts`, `.js`, `.py`, `.go`, `.rs` files

**Do not use grep or rg for these.** ast-grep is structure-aware and never
matches function names inside string literals or comments.

---

## Decision: ast-grep run vs scan

| Situation | Command |
|---|---|
| Simple single-node pattern | `ast-grep run --pattern '...' --lang <lang>` |
| Relational rule (has/inside/follows) | `ast-grep scan --inline-rules '...'` |
| Reusable or complex multi-rule | `ast-grep scan --rule my_rule.yml` |

---

## Quick-reference: common searches by pattern type

### 1. Find all calls to a function

```bash
# Any call to console.log
ast-grep run --pattern 'console.log($$$)' --lang javascript .

# Any call to useState (React)
ast-grep run --pattern 'useState($$$)' --lang tsx .

# Any call to fetchUser with any args
ast-grep run --pattern 'fetchUser($$$)' --lang typescript src/
```

### 2. Find all definitions of a kind

```bash
# All async functions (JS/TS)
ast-grep run --pattern 'async function $NAME($$$) { $$$ }' --lang javascript .

# All class definitions (Python)
ast-grep run --pattern 'class $NAME:' --lang python .

# All arrow functions assigned to a variable
ast-grep run --pattern 'const $NAME = ($$$) => { $$$ }' --lang javascript .

# All exported functions (TypeScript)
ast-grep run --pattern 'export function $NAME($$$) { $$$ }' --lang typescript src/
```

### 3. Find structural relationships (has / inside)

```bash
# async functions that contain await
ast-grep scan --inline-rules "id: async-with-await
language: javascript
rule:
  all:
    - kind: function_declaration
    - has:
        pattern: await \$EXPR
        stopBy: end" .

# console.log calls inside class methods
ast-grep scan --inline-rules "id: log-in-method
language: javascript
rule:
  pattern: console.log(\$\$\$)
  inside:
    kind: method_definition
    stopBy: end" .
```

### 4. Find missing patterns (not)

```bash
# async functions WITHOUT try-catch (missing error handling)
ast-grep scan --inline-rules "id: async-no-trycatch
language: javascript
rule:
  all:
    - kind: function_declaration
    - has:
        pattern: await \$EXPR
        stopBy: end
    - not:
        has:
          kind: try_statement
          stopBy: end" .

# useEffect calls that don't return a cleanup function
ast-grep scan --inline-rules "id: effect-no-cleanup
language: tsx
rule:
  all:
    - pattern: useEffect(\$CB, \$DEPS)
    - not:
        has:
          pattern: return \$CLEANUP
          stopBy: end" .
```

### 5. Find imports / require

```bash
# All ES imports from a specific module
ast-grep run --pattern 'import $WHAT from "react"' --lang typescript .

# All require() calls
ast-grep run --pattern 'require($MODULE)' --lang javascript .

# Default imports from lodash
ast-grep run --pattern 'import $NAME from "lodash"' --lang javascript .
```

### 6. Python patterns

```bash
# All class methods (Python)
ast-grep run --pattern 'def $NAME(self, $$$):' --lang python .

# All decorator usages
ast-grep run --pattern '@$DECORATOR' --lang python .

# try blocks without except for a specific exception type
ast-grep scan --inline-rules "id: bare-except
language: python
rule:
  kind: try_statement
  not:
    has:
      pattern: except $TYPE
      stopBy: end" .
```

### 7. Go patterns

```bash
# All error checks
ast-grep run --pattern 'if err != nil { $$$ }' --lang go .

# Functions returning an error
ast-grep run --pattern 'func $NAME($$$) ($$$, error) { $$$ }' --lang go .
```

---

## General workflow

### Step 1: Start with `run` (pattern search)

Try a simple pattern first — it's faster to write and good for most searches:

```bash
ast-grep run --pattern 'PATTERN' --lang LANG PATH
```

Use `$VAR` for a single node, `$$$` for zero-or-more nodes.

### Step 2: Escalate to `scan` for relational logic

If you need "X that contains Y" or "X without Y", write a YAML rule inline:

```bash
ast-grep scan --inline-rules "id: my-rule
language: javascript
rule:
  all:
    - kind: ...
    - has:
        pattern: ...
        stopBy: end" PATH
```

**Always add `stopBy: end`** to `has`/`inside` relational rules — without it,
the search stops at the first non-matching sibling, missing most matches.

### Step 3: Debug with --debug-query

When a pattern doesn't match, inspect the AST to find the correct node `kind`:

```bash
# See real AST node kinds for a snippet
ast-grep run --pattern 'async function example() { await fetch(); }' \
  --lang javascript --debug-query=ast

# See how ast-grep parses your pattern
ast-grep run --pattern 'async function $NAME($$$) { $$$ }' \
  --lang javascript --debug-query=pattern
```

---

## Metavariable reference

| Syntax | Matches |
|---|---|
| `$NAME` | exactly one AST node |
| `$$$` | zero or more nodes (variadic) |
| `$$$ARGS` | named variadic (use in multiple positions) |
| `$_` | any single node (anonymous) |

---

## Rule building blocks (YAML)

```yaml
# Atomic
rule:
  pattern: console.log($ARG)   # text pattern
  kind: function_declaration    # node type
  regex: "^handle"              # regex on node text

# Relational
rule:
  has:        # direct or indirect child
    pattern: await $X
    stopBy: end
  inside:     # any ancestor matches
    kind: class_declaration
    stopBy: end
  follows:    # preceding sibling
    pattern: const $X = ...
  precedes:   # following sibling
    pattern: return $X

# Composite
rule:
  all:          # AND
    - kind: ...
    - has: ...
  any:          # OR
    - pattern: ...
    - kind: ...
  not:          # negate
    has: ...
```

---

## Integrated examples (realistic tasks)

### "Find all React hooks used in this component file"

```bash
ast-grep run --pattern 'use$HOOK($$$)' --lang tsx src/components/UserProfile.tsx
```

### "Find all places we call db.query without awaiting it"

```bash
ast-grep scan --inline-rules "id: unawaited-query
language: typescript
rule:
  pattern: db.query(\$\$\$)
  not:
    inside:
      pattern: await \$X
      stopBy: end" src/
```

### "Find every file that imports from '../utils' (refactor audit)"

```bash
ast-grep run --pattern 'import $WHAT from "../utils"' --lang typescript src/
```

### "Find all Python functions longer than trivial that lack a docstring"

```bash
ast-grep scan --inline-rules "id: no-docstring
language: python
rule:
  kind: function_definition
  not:
    has:
      kind: expression_statement
      has:
        kind: string
      stopBy: neighbor" .
```

### "Find all error objects created but not thrown or returned"

```bash
ast-grep scan --inline-rules "id: orphan-error
language: javascript
rule:
  pattern: new Error(\$MSG)
  not:
    inside:
      any:
        - pattern: throw \$X
        - pattern: return \$X
        - pattern: reject(\$X)
      stopBy: end" src/
```

---

## Resources

- `references/rule_reference.md` — full rule syntax docs (load when needed)
- Run `ast-grep --help` for CLI flag reference
