# ()Multi-language Runner Script (PowerShell)

A simple PowerShell utility that allows you to run JavaScript, Python, and C files with a single command based on file extension.
This project is a fun / experimental tool built mainly for learning and quick development experiments.

## Features

- Auto-detects file type by extension
- Supports:
  - JavaScript (`.js`) via **Bun**
  - Python (`.py`) via **python / py**
  - C (`.c`) via **gcc**
- Auto-compilation for C files
- Temporary executable cleanup after execution
- Optional dependency installer prompt (Bun)
- Pass-through of extra command-line arguments

## Usage

```powershell
.\run.ps1 script.js
.\run.ps1 script.py arg1 arg2
.\run.ps1 program.c
