CXX := c++
CXX_FLAGS := -std=c++11 $\
						 -O2 -march=native -pipe $\
						 -Wall -Wextra -Wpedantic $\
						 $(shell pkg-config --cflags webkit2gtk-4.0)
LD_FLAGS := ${CXX_FLAGS} $\
						$(shell pkg-config --libs webkit2gtk-4.0)

OBJECT_FILES := $(patsubst src/%.cpp, $\
								  build/%.o,$\
									$(shell find src -name '*.cpp'))

browser: ${OBJECT_FILES}
	${CXX} $< ${LD_FLAGS} -o $@
	
build/%.o: src/%.cpp
	${CXX} -c $< ${CXX_FLAGS} -o $@
