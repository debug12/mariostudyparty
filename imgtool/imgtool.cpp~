#include <SFML/Graphics.hpp>
#include <SFML/Audio.hpp>
#include <fstream>
#include <iostream>

using namespace std;

int main(int argc, char *argv[]) {
	if (argc != 2) {
		cout << "Invalid arguments.";
		return -1;
	}


	//open up file containing image filenames
	ifstream imgfile;
	imgfile.open(argv[1]);
	if (!imgfile) {
		cout << "File '" << argv[1] << "' does not exist.";
		return -1;
	}

	//open up file to write image data to
	ofstream out;
	out.open("img_sd_data", fstream::trunc | fstream::out | fstream::binary);
	ofstream names;
	names.open("../imgnames.e", fstream::trunc | fstream::out);

	int i = 0;
	int num = 0;

	while (true) {
		string filename;
		imgfile >> filename;
		if (imgfile.eof()) break;

		string ext = filename.substr(filename.length() - 3, 3);
		filename = filename.substr(0, filename.length() - 4);
		if (ext == "bmp")
			names << "img." << filename << "\t\t\t" << ".data\t" << num << '\n';
		else
			names << "snd." << filename << "\t\t\t" << ".data\t" << num << '\n';
		num++;
		if (ext == "bmp") {
			sf::Image img;
			if (!img.loadFromFile(filename + "." + ext)) {
				cout << "File '" << filename << "' does not exist.";
				return -1;		
			}
		
			short val = 1024;
			out.write((char*)&val, 2);
			val = img.getSize().x;
			out.write((char*)&val, 2);
			val = img.getSize().y;
			out.write((char*)&val, 2);

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
		} else {

			sf::SoundBuffer sound;
			if (!sound.loadFromFile(filename + "." + ext)) {
				cout << "File '" << filename << "' does not exist.";
				return -1;
			}
			
			short val = 1025;
			out.write((char*)&val, 2);
			val = (sound.getSampleCount() / 2) % 10000;
			out.write((char*)&val, 2);
			val = (sound.getSampleCount() / 2) / 10000;
			out.write((char*)&val, 2);

			const short *buffer = sound.getSamples();
			for (int j = 0; j < sound.getSampleCount(); j += 2) {
				val = buffer[j];
				out.write((char*)&val, 2);
			}
			
		}
	}

	short val = 0;
	for (int j = i; j < 2048 * 2048; j++)
		out.write((char*)&val, 2);

	out.close();
	imgfile.close();
	names.close();
}
