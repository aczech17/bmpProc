image:	main.o	proceed.o
	g++ main.o proceed.o -o image
main.o:	main.cpp
	g++ -c main.cpp
proceed.o:	proceed.asm
	nasm -f elf64 proceed.asm -o proceed.o
