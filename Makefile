CPP      := g++
BUILDDIR := build

.PHONY: all

all: $(BUILDDIR)/udtc.o

$(BUILDDIR)/udtc.o:
	@mkdir -p $(BUILDDIR)
	$(CPP) -I/usr/include/udt -ludt -c udtc.cpp -o $(BUILDDIR)/udtc.o -Wall
