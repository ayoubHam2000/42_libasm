nasm -f elf64 hello.asm -o hello.o     # Assemble
ld hello.o -o hello                    # Link
./hello                                # Run


