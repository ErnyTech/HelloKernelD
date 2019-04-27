enum VGA_BUFFER = 0xb8000
enum VGA_WIDTH = 80;
enum VGA_HEIGHT = 25;

void main() {
        clearScreen();
        print("Hello D Kernel, LONGMODE!!!");
}

void clearScreen() {
        ubyte* videoMemory = cast(ubyte*) VGA_BUFFER;
        foreach(idx; 0 .. VGA_WIDTH * VGA_HEIGHT) {
                videoMemory[idx * 2] = ' ';
                videoMemory[idx * 2 + 1] = 0b111;
        }

}

void print(string msg) {
        ubyte* videoMemory = cast(ubyte*) VGA_BUFFER;
        foreach(char str; msg) {
                *videoMemory = str;
                videoMemory += 2;
        }
}
 
