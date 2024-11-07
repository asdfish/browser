CXX := c++
CXX_FLAGS := -std=c++11 $\
						 -O2 -march=native -pipe $\
						 -Wall -Wextra -Wpedantic $\
						 $(shell pkg-config --cflags gtk+-3.0) $\
						 $(shell pkg-config --cflags webkit2gtk-4.0)
LD_FLAGS := ${CXX_FLAGS} $\
						$(shell pkg-config --libs gtk+-3.0) $\
						$(shell pkg-config --libs webkit2gtk-4.0)

OBJECT_FILES := $(patsubst src/%.cpp, $\
								  build/%.o,$\
									$(shell find src -name '*.cpp'))

define REMOVE
	$(if $(wildcard $(1)),$\
		$(info Removing $(1)) $\
		$(shell rm -rf $(1)))
endef
define REMOVE_LIST
	$(foreach ITEM,$\
		$(1),$\
		$(call REMOVE,${ITEM}))
endef

all: browser

browser: ${OBJECT_FILES}
	$(info Linking $<)
	@${CXX} $< ${LD_FLAGS} -o $@
	
build/%.o: src/%.cpp
	$(info Compiling $<)
	@${CXX} -c $< ${CXX_FLAGS} -o $@

clean:
	$(call REMOVE_LIST,${OBJECT_FILES})
	$(call REMOVE,browser)

.PHONY: all clean
