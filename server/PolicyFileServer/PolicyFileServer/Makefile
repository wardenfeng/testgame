SRCCPP=$(wildcard *.cpp)
SRCCC=$(wildcard *.cc)
BIN_SRCS=$(shell grep "int main" -l *.cpp)
DEPS=$(SRCS:.cpp=.d) 
OBJS=$(SRCS:.cpp=.o) 
CPP_LIB_OBJS=$(patsubst %.cpp,%.o,$(SRCCPP)) 
CC_LIB_OBJS = $(patsubst %.cc,%.o,$(SRCCC))

BINS=$(patsubst %.cpp, %, $(BIN_SRCS))
SO_LIB=$(patsubst %,lib%.so,$(LIB_NAME))
STATIC_LIB=$(patsubst %,%.lib,$(LIB_NAME))

CC=g++
CFLAGS= -Wall -D_REENTRANT -D_GNU_SOURCE -fPIC 
BOOST_DIR = /usr/local/include/boost

MYSQL_LIB = $(shell mysql_config --libs)

BOOST_LIB = -L/usr/local/include/boost/stage/lib

GOOGLE_LIB = -L/usr/local/lib
GOOGLE_INC = /usr/local/include

COMP_INC = ../../modules/include
COMP_LIB = -L../../modules/lib
COMP_LIBS=$(shell ls ../../modules/lib)

MEMCACHED_INC = /usr/local/libmemcached/include/libmemcached
MEMCACHED_LIB = -L/usr/local/libmemcached/lib

INC= -I${BOOST_DIR} -I${COMP_INC} -I${GOOGLE_INC}

LIB = $(MYSQL_LIB) $(BOOST_LIB) $(GOOGLE_LIB) $(COMP_LIB) $(MEMCACHED_LIB)


LIBS = -lpthread -lboost_thread -lboost_system 

ifeq ($(debug), 1)
CFLAGS += -g -DDEBUG 
else
CFLAGS += -O2 -DNDEBUG 
endif

all: $(BINS)  

$(BINS): % :%.o $(CC_LIB_OBJS) $(CPP_LIB_OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIB) $(LIBS) 
 
$(SO_LIB): $(LIB_OBJS) 
	$(CC) $(CFLAGS) -shared -o $@ $^ 
$(STATIC_LIB): $(LIB_OBJS) 
	ar -rcs -o $@ $^ 
dist :
	rm -f $(DEPS)

debug: clean
  @make debug=1
clean:
	rm -f $(BINS) $(OBJS) $(DEPS) $(SO_LIB) $(STATIC_LIB) $(CC_LIB_OBJS) $(CPP_LIB_OBJS)

%.d : %.cpp
	$(CC) -MM $(INC)  $< >$@

%.d : %.cc
	$(CC) -MM $(INC)  $< >$@

%.o : %.cpp
	$(CC) $(CFLAGS) $(INC) -c  $< 

%.o : %.cc
	$(CC) $(CFLAGS) $(INC) -c  $< 

-include  $(DEPS)
