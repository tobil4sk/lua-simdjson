SRC = src/hxluasimdjson.cpp src/simdjson.cpp
INCLUDE = -I$(LUA_INCDIR)
LIBS = -lpthread
FLAGS = -std=c++11 -Wall $(LIBFLAG) $(CFLAGS)

ifdef LUA_LIBDIR
FLAGS += $(LUA_LIBDIR)/$(LUALIB)
endif

ifeq ($(OS),Windows_NT)
	LIBEXT = dll
else
	UNAME := $(shell uname -s)
	ifeq ($(findstring MINGW,$(UNAME)),MINGW)
		LIBEXT = dll
	else ifeq ($(findstring CYGWIN,$(UNAME)),CYGWIN)
		LIBEXT = dll
	else
		LIBEXT = so
	endif
endif

TARGET = hxsimdjson.$(LIBEXT)

all: $(TARGET)

$(TARGET):
	$(CXX) $(SRC) $(FLAGS) $(INCLUDE) $(LIBS) -o $@

clean:
	rm *.$(LIBEXT)

install: $(TARGET)
	cp $(TARGET) $(INST_LIBDIR)
