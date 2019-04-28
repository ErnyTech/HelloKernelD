extern(C) void main() {
        clearScreen();
        print("Hello D");
}

void clearScreen() {
        ubyte* videoMemory = cast(ubyte*) 0xb8000;
        foreach(idx; 0 .. 80*25) {
                videoMemory[idx * 2] = ' ';
                videoMemory[idx * 2 + 1] = 0b111;
        }

}

void print(string msg) {
        ubyte* videoMemory = cast(ubyte*) 0xb8000;
        foreach(char c; msg) {
                *videoMemory = c;
                videoMemory += 2;
        }
}
