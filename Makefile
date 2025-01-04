CC=gcc
CFLAGS  += -I. -shared -fPIC -fvisibility=hidden
CFLAGS  += -fPIE -fPIC -pie -fstack-protector-strong -D_FORTIFY_SOURCE=2 -O1 -Wl,-z,noexecstack
CFLAGS  += -Wall
LDFLAGS += -g -ldl -shared
OBJ = src/lznt1_compress.o src/lznt1_decompress.o src/mscomp.o src/xpress_compress.o src/xpress_decompress.o src/xpress_huff_compress.o src/xpress_huff_decompress.o

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

libMSCompression: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) -o libMSCompression.so $(LDFLAGS)
	rm -f src/*.o || true
	true

clean:
	rm -f src/*.o
	rm -f *.so
