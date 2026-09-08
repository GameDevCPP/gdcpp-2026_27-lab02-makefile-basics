# :wave: Lab 02 — Makefile Basics

## 🤓 Practical overview and learning outcomes

In lab 01 you typed the compiler command yourself. That stops being reasonable at about three
files. **Make** is a command generator: you describe what depends on what, and it works out the
commands to run — and skips the ones that are not needed.

By the end you will be able to:

* read a Makefile rule and say what it does
* use variables to avoid repeating yourself
* write `all`, `clean` and `run` targets
* explain why `make` sometimes says "nothing to be done"

## 💻 Terms to know

* **target** — the thing being built, written before the colon
* **prerequisite** — what the target depends on, written after the colon
* **recipe** — the indented command lines under a rule. **These must be indented with a real
  TAB, not spaces.** This is the single most common Makefile error, and the message you get
  (`missing separator`) does not tell you that
* **variable** — `CXX := g++`, used later as `$(CXX)`
* **phony target** — a target that is a command rather than a file, like `clean`

## 🔧 Setup

You need a C++ compiler, `make`, `cmake` and Git. Check what you already have:

```
g++ --version
make --version
cmake --version
git --version
```

If any of those say "command not found", install them:

* **Windows** — install [MSYS2](https://www.msys2.org/), then in the MSYS2 UCRT64 terminal run
  `pacman -S mingw-w64-ucrt-x86_64-gcc mingw-w64-ucrt-x86_64-cmake make git`.
  Visual Studio with the "Desktop development with C++" workload also works.
* **macOS** — `xcode-select --install` gets you a compiler, `make` and `git`.
  Then `brew install cmake`.
* **Linux** — `sudo apt install build-essential cmake git` (or your distribution's equivalent).

You only have to do this once, for the whole module.

## 🏗️ Build

```
make
```

That is the whole command. `make` looks for a file called `Makefile` in the current directory,
finds the first target (`all`), and works backwards through the prerequisites.

Run it a second time without changing anything:

```
make
```

It says `make: Nothing to be done for 'all'.` — it compared the timestamp on `hello` against
the timestamp on `src/main.cpp`, saw the binary was newer, and did nothing. That is the entire
point of make.

## ▶️ Run

```
./hello
```

And to throw away what you built:

```
make clean
```

### Task 1 — A `run` target

Add a target that builds *and* runs, so you can type one command instead of two:

```Makefile
run: $(TARGET)
	./$(TARGET)
```

Remember the TAB. Add `run` to the `.PHONY` line, then try `make run`.

### Task 2 — Watch the dependency work

1. Run `make` twice. The second one does nothing.
2. Now `touch src/main.cpp` (this only updates its timestamp) and run `make` again.
3. It rebuilds. Make is comparing timestamps, nothing cleverer than that.

### Task 3 — Two source files

1. Create `src/greeting.cpp` with a function that prints something, and `src/greeting.hpp`
   declaring it. Call it from `main`.
2. Change the Makefile so each `.cpp` becomes a `.o` first, and the `.o` files are linked
   together:

```Makefile
$(TARGET): src/main.o src/greeting.o
	$(CXX) $(CXXFLAGS) -o $(TARGET) src/main.o src/greeting.o

src/main.o: src/main.cpp
	$(CXX) $(CXXFLAGS) -c src/main.cpp -o src/main.o

src/greeting.o: src/greeting.cpp
	$(CXX) $(CXXFLAGS) -c src/greeting.cpp -o src/greeting.o
```

3. Update `clean` to remove the `.o` files too.
4. Build, then touch *only* `src/greeting.cpp` and build again. Only that one file recompiles.
   With two files that saves nothing. With two hundred it is the difference between seconds
   and minutes.

### Task 4 — Break it on purpose

Replace the TAB at the start of one recipe line with four spaces and run `make`. Read the
error. Put the TAB back. You will meet this error again and now you will recognise it.

## 📮 Submission

There is no GitHub Classroom this year. You create your own copy instead:

1. Open **<https://github.com/GameDevCPP/gdcpp-2026_27-lab02-makefile-basics/generate>** — that is the one-click version of the
   **Use this template** button on this page.
2. Name it `gdcpp-2026_27-lab02-makefile-basics-<your-github-username>` so I can tell whose is whose,
   and leave it **public** unless you have been told otherwise.
3. Clone *your* copy, not this one:
   ```
   git clone https://github.com/<your-github-username>/gdcpp-2026_27-lab02-makefile-basics-<your-github-username>.git
   ```
4. Do the tasks, committing as you go:
   ```
   git add -A
   git commit -m "Lab task 1 complete"
   git push
   ```
5. Submit the URL of your repository on the module page.

Commit as you work, not once at the end. The history is part of what I am looking at.

## 📝 Optional next steps

* Open a pull request against your own repository and describe what you changed.
* Add a `NOTES.md` saying what clicked and what is still murky. I read these.

## 📚 Resources

* [Learn Makefiles, with the tastiest examples](https://makefiletutorial.com/)
* [GNU Make manual](https://www.gnu.org/software/make/manual/make.html)
* [CMake tutorial](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)
* [Pro Git book, chapters 1–3](https://git-scm.com/book/en/v2)
