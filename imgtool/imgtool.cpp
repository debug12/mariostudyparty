#include <SFML/Graphics.hpp>
#include <fstream>
#include <iostream>

using namespace std;

int main(int argc, char *argv[]) {
	sf::Image img;
	if (!img.loadFromFile("test.bmp")) return -1;

	ofstream out;
	out.open("img_sd_data", fstream::trunc | fstream::out | fstream::binary);
	short val = 1024;
	out.write((char*)&val, 2);
	val = img.getSize().x;
	out.write((char*)&val, 2);
	val = img.getSize().y;
	out.write((char*)&val, 2);

	int i = 0;

	for (int y = 0; y < img.getSize().y; y++) {
		for (int x = 0; x < img.getSize().x; x++) {
			sf::Color c = img.getPixel(x, y);
			char r = (c.r / 255.0) * 7.0 + 0.5;
			char g = (c.g / 255.0) * 7.0 + 0.5;
			char b = (c.b / 255.0) * 3.0 + 0.5;
			short col = (r << 5) | (g << 2) | b;
			out.write((char*)&col, 2);
			i++;
		}
	}

	val = 0;
	
	for (int j = i; j < 2048 * 2048; j++) {
		out.write((char*)&val, 2);
	}

	out.close();
}
