CC = gcc
CFLAGS = -Iinclude -Wall -Wextra -g
SRC_DIR = src
SRC = $(SRC_DIR)/window_system.c \
      $(SRC_DIR)/window.c \
      $(SRC_DIR)/message_queue.c \
      $(SRC_DIR)/window_class.c \
      $(SRC_DIR)/gdi.c \
      $(SRC_DIR)/main.c

OBJ = $(SRC:.c=.o)
EXEC = window_system

.PHONY: all clean

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJ) $(EXEC)