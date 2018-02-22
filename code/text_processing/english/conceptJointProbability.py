#This script calculates the join probability P(O,w) for
# P(O, w) = P(O|w)/P(w) = frames for which O is in focus and w is uttered/total frames
# Input The file contains the frame tag with commentaries when concept happens
#

##############################################################################
import sys

def main() :
    if len(sys.argv) == 1:
        fileName = raw_input("File name of the concept :\n")
        if not fileName :
            fileName = "concept1"
        numFrames = raw_input("Total number of commentaries :\n")
        if not numFrames :
            numFrames = 14 #for coaxing video only
        wordFile1 = raw_input("File containing the words :\n")
        if not wordFile1 :
            wordFile1 = 'gram1' #file containing all words with frequency
        action = raw_input("Action :\n")
        if not action :
            action = 'coax'
    elif len(sys.argv) < 5 :
        print "============================================="
        print "Enter all the 4 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "fileName numFrames wordFile actionName"
        print "Use '_' character for using default value"
        print "============================================="
        return
    else :
        if sys.argv[1] == '_' :
            fileName = 'concept1'
        else :
            fileName = sys.argv[1]
        if sys.argv[2] == '_' :
            numFrames = 14
        else :
            numFrames = float(sys.argv[2])
        if sys.argv[3] == '_' :
            wordFile1 = 'gram1'
        else :
            wordFile1 = sys.argv[3]
            
        if sys.argv[4] == '_' :
            action = 'coax'
        else :
            action = sys.argv[4]
            
    numFrames = 598.0*numFrames
    filePath = fileName +  "/"
    fileName = fileName + '.txt'
    action = action + '/'
    wordFile = 'grams/'+ action + wordFile1 + '.txt'
    
    
    wfile = open(wordFile).readlines()
    cFilePath = filePath + action + fileName
    f = open(cFilePath, "r")
    lines = f.readlines()
    jp = []
    #print "total lines : " + str(len(lines))
    
    for wordLine in wfile :
        wordLine = wordLine.decode('utf-8')
        wordLine = wordLine.replace(u'\ufeff', "")
        wordLine = wordLine.split(" ")
        wordLine.pop()
        wordLine.pop()
        wordLine = ' '.join(wordLine) #get the k-gram seperated
        length = 0.0
        for line in lines :
            line = line.decode('utf-8')
            line = line.split('\t\t')
            #print len(line)
            if (len(line) > 2) and line[2] != '\n':
                if wordFile1 == 'gram1' :
                    words = line[2].split()
                elif wordFile1 == 'gram2' :
                    words = line[2].split()
                    i = 0
                    while(i < len(words) -1) :
                        words[i] = ' '.join([words[i], words[i+1]])
                        i = i + 1
                        
                elif wordFile1 == 'gram3' :
                    words = line[2].split()
                    i = 0
                    while(i < len(words) - 2) :
                        words[i] = ' '.join([words[i], words[i+1], words[i+2]])
                        i = i + 1
                elif wordFile1 == 'gram4' :
                    words = line[2].split()
                    i = 0
                    while(i < len(words) - 3) :
                        words[i] = ' '.join([words[i], words[i+1], words[i+2], words[i+3]])
                        i = i + 1
                    
                if wordLine in words :
                    length = length + float(line[1])  - float(line[0]) + 1

        frac = length/numFrames
        jp.append((frac, wordLine))

    jp1 = sorted(jp, reverse=True)
    numWords = len(jp)
    
    outFile = open(filePath + action + wordFile1 +'jointProb.txt', "w")
    outFile1 = open(filePath + action + wordFile1 +'jointProbSorted.txt', "w")
    
    if outFile == None or outFile1 == None :
        print "unable to open the file\n"
        return

    i = 0
    while(i < numWords) :
        outFile.write((jp[i][1] + " " + str(jp[i][0]) + "\n").encode('utf-8'))
        outFile1.write((jp1[i][1] + " " + str(jp1[i][0]) + "\n").encode('utf-8'))
        i = i + 1
        
    outFile.close()
    outFile1.close()
    print 'Written to file : ' + filePath + action + wordFile1 +'jointProb.txt'
    print 'Written to file : ' + filePath + action + wordFile1 +'jointProbSorted.txt'
if __name__ == "__main__" :
    main()
