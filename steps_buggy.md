# Save as buggy_sum.s

# Assemble with GNU assembler
as --32 buggy_sum.s -o buggy_sum.o

# Link with 32-bit linker
ld -m elf_i386 -o buggy_sum buggy_sum.o

# Run the program
./buggy_sum
