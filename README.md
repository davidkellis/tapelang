# Tapelang

Tapelang is a derivative of [Brainfuck](https://esolangs.org/wiki/Brainfuck) that changes four things: the language name, the input character command, the output character command, and adds a comment command.

Differences from Brainfuck:
1. The name isn't "Brainfuck".

   It isn't uncommon to find people lamenting the name "Brainfuck". The most common reasons seem to be that people either find the name off-putting, or because they're referencing it in an article or essay and they're concerned about the word "fuck" appearing anywhere in their writing.

   To alleviate this problem, the name Tapelang was chosen, because https://esolangs.org/wiki/Brainfuck describes Brainfuck as a language that conceptually operates on a tape.
2. The command to input a character and store it in the cell at the pointer was changed from `,` to the lower-case letter `i`.
3. The command to output the character represented in the cell at the pointer was changed from `.` to the lower-case letter `o`.
4. Brainfuck doesn't have a distinct facility for commenting out code. Brainfuck will ignore characters outside of the set of command characters, but there is no way to ignore command characters. Tapelang adds the `#` command to denote that all command characters following the `#` must be ignored, until a newline is encountered; once a newline is encountered, Tapelang will interpret the remaining command characters.


## Overview

Tapelang implements a simplified Turing machine consisting of a memory tape divided into discrete cells, a reader/writer head capable of reading or writing to a cell on the tape, an input stream (STDIN), an output stream (STDOUT), and the following nine commands:

1. `>` moves the reader/writer head one cell to the right
2. `<` moves the reader/writer head one cell to the left
3. `+` increments the memory cell at which the reader/writer head points
4. `-` decrements the memory cell at which the reader/writer head points
5. `i` reads an ASCII character from STDIN and stores it, represented as an integer, in the memory cell at which the reader/writer head points
6. `o` interprets the integer in the memory cell at which the reader/writer head points as an ASCII character, and writes the ASCII character to STDOUT
7. `[` jumps to the command immediately following the matching `]` if the cell at which the reader/writer head points is zero, or jumps to the command immediately following the `[` if the cell at which the reader/writer head points is non-zero.
8. `]` jumps back the matching `[` and re-evaluates the `[` command.
9. `#` ignores itself and all subsequent command characters, until a newline is encountered; once a newline is encountered, the remaining command characters will be interpreted. Alternatively, the [header comment](https://esolangs.org/wiki/Brainfuck_algorithms#Header_comment) technique may be used to comment out code in Tapelang, though using the comment command, `#`, is more robust.


## Translation from Brainfuck

Any valid Brainfuck program may be translated to Tapelang by replacing all occurrences of `,` with `i`, and replacing all occurrences of `.` with `o`.

The file `translate.rb` is a program that will automatically translate a Brainfuck program into Tapelang. The program reads from STDIN and writes the translated program to STDOUT. If any errors occur during translation, then the program writes the errors to STDERR and exits with an exit code of 1.

The `translate.rb` program may be used like this:
```
ruby translate.rb examples/helloworld.bf > helloworld.tape
```
```
cat examples/helloworld.bf | ruby translate.rb > helloworld.tape
```


## Sample Interpreter

The file `tapelang.rb` is the reference implementation of a Tapelang interpreter. To use the interpreter to run a Tapelang program, install Ruby 2.0+, and then run the following command:
```
ruby tapelang.rb <tapelang source file>
```

The interpreter can execute either Tapelang (i.e. file names that end with a `.tape` extension) or Brainfuck (i.e. file names that end with a `.b` or `.bf` extension) programs. Programs may either be supplied in the form of a file, by specifying the filename as the first argument to the `tapelang.rb` script, or the argument may be omitted and Tapelang source may be supplied via STDIN, either interactively in a terminal session, or piped in via another tool.


## Example Programs

Several of the example programs in the `examples` directory are copied verbatim from http://www.hevanet.com/cristofd/brainfuck/, so all the credit for those Brainfuck implementations go to Daniel B Cristofani.


## Example Usages

Note: The `$ ` is my bash prompt.

```
$ ruby tapelang.rb examples/helloworld.tape
Hello World!
```

```
$ cat examples/helloworld.tape | ruby tapelang.rb
Hello World!
```

```
# implicitly translate and then run a Brainfuck program
$ ruby tapelang.rb examples/helloworld.bf
Hello World!
```

```
# explicitly translate and then run a Brainfuck program
$ ruby translate.rb examples/helloworld.bf | ruby tapelang.rb
Hello World!
```

```
$ echo "`cat examples/echochar3x.bf`\!a" | ruby tapelang.rb examples/brainfuck_interpreter.bf
aaa
```

```
$ ruby tapelang.rb examples/brainfuck_interpreter.bf
,...!a
aaa
```

```
$ ./tapelang.rb examples/benchmark.bf
ZYXWVUTSRQPONMLKJIHGFEDCBA
```