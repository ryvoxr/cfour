objects := $(patsubst src%, target%, $(patsubst %.c,%.o,$(wildcard src/*.c)))
headers := $(wildcard src/*.h)

CFLAGS = -Wall -Wextra
LDFLAGS = -L/usr/local/lib -Wl,-rpath,/usr/local/lib -Wl,--enable-new-dtags \
-lSDL2 -lSDL2_image -lSDL2_ttf -lm

cfour : $(objects) $(headers)
	gcc $(objects) $(headers) -o target/cfour  $(LDFLAGS) $(CFLAGS)

target/main.o : src/main.c src/cfour.h
	gcc -c src/main.c -o target/main.o $(CFLAGS)

target/cfour.o : src/cfour.c src/cfour.h
	gcc -c src/cfour.c -o target/cfour.o $(CFLAGS)

target/gui.o : src/gui.c src/cfour.h
	gcc -c src/gui.c $$(sdl2-config --cflags) -o target/gui.o -Wall $(CFLAGS)

target/event.o : src/event.c src/cfour.h
	gcc -c src/event.c $$(sdl2-config --cflags) -o target/event.o $(CFLAGS)

target/bot.o : src/bot.c src/cfour.h
	gcc -c src/bot.c -o target/bot.o $(CFLAGS)

clean :
	rm target/*.o
