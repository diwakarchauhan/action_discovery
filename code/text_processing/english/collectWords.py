#this script takes input as a directory name and combines
#contents of all the files in the directory into a single file
#words.txt
###############################################################
#               Author : Diwakar Chauhan
###############################################################
import os, sys

def main() :
    if len(sys.argv) == 1 : 
        dirName = raw_input('Action : \n')
        if not dirName :
            dirName = 'coax'
        
        dirPath = raw_input('Directory name : \n')
        if not dirPath :
            dirPath = 'commentaries'
        fName = raw_input('fileName to for output : \n')
        if not fName :
            fName = 'all'
    elif len(sys.argv)  < 4 :
        print "============================================="
        print "Enter all the 3 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "action commentaryDiary outfileName"
        print "Use '_' character for using default value"
        print "============================================="

    else :
        if sys.argv[1] == '_' :
            dirName = 'coax'
        else :
            dirName  = sys.argv[1]
        if sys.argv[2] == '_' :
            dirPath = 'commentaries'
        else :
            dirPath = sys.argv[2]
        if sys.argv[3] == '_' :
            fName = 'all'
        else :
            fName = sys.argv[3]
            
    dirName = dirName + '/'
    dirPath = dirPath + '/' + dirName
    fName = fName + '.txt'
    fp = open(dirPath + fName, "w")
    if (fp == None) :
        return
    
    print "Writing to file :" + dirPath + fName
    names = ['words.txt', 'all.txt', 'filteredWords.txt', 'wordFreq.txt']
    for root, dirs, files in os.walk(dirPath) :
        for name in files :
            if name not in names and '~' not in name:
                fileName = dirPath + name
                f = open(fileName, "r")
                print "reading from file" + fileName
                lines = f.readlines()
                for word in lines :
                    word = word.decode('utf-8')
                    if word != '\n' :
                        #print word
                        fp.write(word.encode('utf-8'))
                f.close()
    fp.close()
    print "Written to file " + dirPath + fName
if __name__ == "__main__" :
    main()
