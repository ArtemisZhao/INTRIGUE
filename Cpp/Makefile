intrigue: main.o GenEM.o GenEM_mixture.o controller.o BF.o
	g++ -O3 main.o GenEM.o GenEM_mixture.o controller.o BF.o -o intrigue -lgsl -lgslcblas
main.o: main.cc
	g++ -O3 -c main.cc
controller.o: controller.cc controller.h
	g++ -O3 -c controller.cc
BF.o: BF.h BF.cc
	g++ -O3 -c BF.cc
GenEM_mixture.o: GenEM_mixture.h GenEM_mixture.cc
	g++ -O3 -c GenEM_mixture.cc
GenEM.o: GenEM.h GenEM.cc
	g++ -O3 -c GenEM.cc
clean: 
	rm *.o intrigue
