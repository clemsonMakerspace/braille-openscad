from subprocess import Popen
import time

def procWhitespace(string):
	retStr = ""
	for char in string:
		retStr+= (char.lower() if char != ' ' else '_')

	return retStr

def strProc(string):
	retStr = "string=[["
	for char in string:
		retStr+= char
		retStr+= ','
	retStr+="]] "

	return retStr

if __name__ == "__main__":
	ioStr = ""
	process = []

	print("A simple CLI to convert strings to braille STLs and SVGs.")
	print("This program does not convert grade 1 to grade 2 braille.")

	while ioStr != '\n' and ioStr.lower() != 'q' and ioStr.lower() != "quit":
		ioStr = input("\nEnter a string to braillify, or q to quit.\n")

		cleanStr = procWhitespace(ioStr)
		argStr = strProc(cleanStr)

		process.append(Popen(["openscad " + "braille.scad " + "-D " + argStr + "-D " + "is3D=false " + "-o " + cleanStr+".svg"], shell=True))
		process.append(Popen(["openscad " + "braille.scad " + "-D " + argStr + "-D " + "is3D=true " + "-o " + cleanStr+".stl"], shell=True))

	for proc in process:
		while proc.poll() == None:
			print("Rendering...")
			time.sleep(1)

