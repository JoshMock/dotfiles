---
name: code-conventions
description: Code style, comment conventions, and formatting rules for all code changes. Covers whitespace, comment style, JavaScript/TypeScript idioms (nullish coalescing, single-line ifs, nullish checks, interface extraction), and unit test nesting. Use when writing, reviewing, or refactoring code.
---

# Code Conventions

Load and follow these rules whenever writing, reviewing, or refactoring code.

## Comments

- Avoid adding too many comments:
    - GOOD: explaining a complex, hard-to-read section of code
    - BAD: explaining every step
    - BAD: explaining a couple lines of code that is self-evident
    - BAD: explaining why a test is asserting something that is already stated in the test description
    - BAD: being redundant
- Code comments are usually phrases, not complete sentences. Thus, they typically start lowercase aside from proper nouns, and do not end in a period unless they're multiple sentences. If an existing comment does not follow the lowercase/sentence rules, do not update it unless you are making other text changes to it.

## General Style

- No trailing whitespace.
- Empty lines should just be a newline character, not followed by any whitespace.
- Ensure files always end with a Unix-style newline.

## JavaScript/TypeScript

- Always prefer using `??` for nullish coalescing rather than `||`
- If a condition is short and its corresponding block is a single line, compact to a single line:
  ```javascript
  // bad
  if (!test) {
    return []
  }

  // good
  if (!test) return []
  ```
- When checking if a value is null or undefined in a condition, use a more precise nullish check rather than a truthy check:
  ```javascript
  // bad
  if (!handler)

  // good
  if (handler == null)
  ```
- If a type is an object or otherwise not a primitive type, define it in a separate line:
  ```typescript
  // bad
  function foo(): { one: string[], two: number }

  // good
  interface FooVal {
    one: string[]
    two: number
  }

  function foo(): FooVal
  ```

## Unit Test Organization

- If the test framework supports nesting (e.g. `describe`/`it`), group all tests for a single class or function under a common parent
- No duplicate tests, whether from reorganization or testing the same thing twice
