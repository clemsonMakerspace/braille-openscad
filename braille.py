from subprocess import Popen
import time

def strProc(string):
	retStr = "[["
	for char in string:
		retStr+= (char.lower() if char != ' ' else '_')
		retStr+= ','
	retStr+="]]"

	return retStr

if __name__ == "__main__":
	ioStr = input("String goes here")

	Popen(["openscad"], shell=True)
