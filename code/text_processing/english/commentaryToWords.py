#this script filters all the words in the commentaries
#of a directory and puts them into another directory
#input :
#	  dirName : containing the commentaries 
# outout : 
#	  words of a commentary in a seperate directory

######################################################
#				  Author : Diwakar Chauhan
######################################################
import sys,os

def main(comDirName, action, wordDirName) :
    comPath = comDirName + action;
    wordPath = wordDirName + action
    names = ['all.txt']
    print comPath
    for root, dirs, files in os.walk(comPath) :
        for name in files :
            if name not in names :
                comFilePath = comPath + name
                wordFilePath = wordPath + name
                f = open(comFilePath).readlines()
                wFile = open(wordFilePath, 'w')
                for line in f :
                    line = line.decode('utf-8').split('\t\t')
                    if len(line) > 2 and line[2] != '\n' :
                        line[2] = line[2].split()
                        for word in line[2] :
                            wFile.write((word + '\n').encode('utf-8'))
                wFile.close()
                print "Written to file " + wordFilePath
                
                
if __name__ == "__main__" :
    if len(sys.argv) == 1 :
        comDirName = raw_input("Directory containing commentaries :\n")
        if not comDirName :
            comDirName = 'commentaries'
        action = raw_input('Action Name : \n')
        if not action :
            action = 'coax'
        wordDirName = raw_input('Word Directory name : \n')
        if not wordDirName :
            wordDirName = 'words'
    elif len(sys.argv) <  4 :
        print "============================================="
        print "Enter all the 3 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "comDirName actionName wordDirName"
        print "Use '_' character for using default value"
        print "============================================="
    else :
        if sys.argv[1] == '_' :
            comDirName = 'commentaries'
        else :
            comDirName = sys.argv[1]
        if sys.argv[2] == '_' :
            action = 'coax'
        else :
            action = sys.argv[2]
        if sys.argv[3] == '_' :
            wordDirName = 'words'
        else :
            wordDirName = sys.argv[3]
        action = action + '/'
        comDirName = comDirName + '/'
        wordDirName = wordDirName + '/'
	main(comDirName, action, wordDirName)
