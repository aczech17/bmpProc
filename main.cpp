#include <fstream>
#include <iostream>
#include <memory>
#include <string>

extern "C" void proceed
(
	char* pixelArray, 	//RDI
	int width,		//RSI
	int height		//RDX
);

int main(int argc, char **argv)
{
	if(argc < 3)
	{
		std::cerr << "No arguments provided." << std::endl;
		return 1;
	}
	const std::string inputName 	= argv[1];
	const std::string outputName 	= argv[2];
	
	std::ifstream input(inputName, std::fstream::binary);
	if(!input.is_open())
	{
		std::cerr << "Cannot open " << inputName << std::endl;
		return 2;
	}
	
	char header[54];
	input.read(header, 54);
	
	int size 	= *(int*)&header[2];
	int offset 	= *(int*)&header[10];
	int width 	= *(int*)&header[18];
	int height 	= *(int*)&header[22];
	
	auto image = std::make_unique<char[]>(size);
	input.seekg(0, std::fstream::beg); //go to beginning
	input.read(image.get(), size); //raw pointer needed
	
	input.close();
	
	char* pixelArray = image.get() + offset;
	proceed(pixelArray, width, height);
	
	std::ofstream output(outputName, std::fstream::binary);
	if(!output.is_open())
	{
		std::cerr << "Cannot create " << outputName << std::endl;
		return 3;
	}
	output.write(image.get(), size);
	
	output.close();
	return 0;
}
