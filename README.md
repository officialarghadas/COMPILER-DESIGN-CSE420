# COMPILER-DESIGN-CSE420

A collection of compiler design lab work and practice implementations for the **CSE420 (Compiler Design)** course.  
This repository contains experiments and assignments built around core compiler construction concepts using **C**, **Lex/Flex**, and **Yacc/Bison**.

## 📚 Topics Covered

This repository is focused on standard compiler design stages, including:

- **Lexical Analysis** (tokenizing source code with Lex/Flex)
- **Syntax Analysis / Parsing** (grammar-based parsing with Yacc/Bison)
- **Grammar & CFG Design**
- **Error Handling in Parsing**
- **Symbol Table / Semantic Structure (if included in labs)**
- **Intermediate steps of front-end compiler construction**

> The exact implementation details vary by lab/task files in this repository.

## 🛠 Tech Stack

Language composition of this repository:

- **C** — 76.6%
- **Yacc** — 15.7%
- **Lex** — 3.7%
- **C++** — 3.6%
- **Shell** — 0.4%

## 📁 Repository Structure (Typical)

You may find files/folders such as:

- `.l` files for Lex/Flex specifications
- `.y` files for Yacc/Bison grammars
- `.c` / `.cpp` source files for driver code, utility functions, and integration
- shell scripts for build/run automation
- lab-wise folders for separate assignments

## ▶️ How to Build and Run

> Depending on the specific lab/task, commands may vary.  
> A common workflow is:

```bash
# Generate lexer
flex lexer.l

# Generate parser
bison -d parser.y

# Compile generated + support C files
gcc lex.yy.c parser.tab.c -o compiler -lfl

# Run
./compiler < input.txt
```

If your environment uses `yacc`/`lex` directly, you can replace `bison`/`flex` commands accordingly.

## ✅ Prerequisites

Install the following tools before running the programs:

- `gcc` (or `g++` when needed)
- `flex` / `lex`
- `bison` / `yacc`
- Unix-like shell (Linux/macOS/WSL/Git Bash recommended)

## 🎯 Course Context

This repository is intended for educational purposes as part of **Compiler Design (CSE420)** coursework, demonstrating hands-on understanding of how compilers process source code from tokens to parse structures.

## 🤝 Contributing

If you are a classmate or collaborator and want to contribute:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a pull request

## ⚠️ Note

These implementations are primarily academic/lab-oriented and may prioritize clarity and coursework objectives over production-level robustness.

## 📄 License

Add a license section here if you plan to make usage terms explicit (e.g., MIT, Apache-2.0, or academic-only use).

## 👤 Author

**Argha Das**  
GitHub: [@officialarghadas](https://github.com/officialarghadas)
