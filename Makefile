# A deliberately small Makefile. You will grow it during this lab.

CXX      := g++
CXXFLAGS := -std=c++17 -Wall -Wextra
TARGET   := hello
SRC      := src/main.cpp

# The first target in the file is the default, so a bare `make` builds this.
all: $(TARGET)

$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC)

clean:
	rm -f $(TARGET)

# `all` and `clean` are not real files, so tell make not to look for them.
.PHONY: all clean
