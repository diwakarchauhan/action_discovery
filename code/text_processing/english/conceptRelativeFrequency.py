#this script calculates the relative frequency measure for
#for the words of the concepts

######################################################################
#                       Author : Diwakar Chauhan
######################################################################
import sys, collections

def main(conceptName, gramFileName, action) :
    conceptPath = conceptName + '/'
    conceptFileName = conceptName + '.txt'
    gramFilePath = 'grams/' + action + gramFileName + '.txt'
    gramFile = open(gramFilePath).readlines()
    conceptFilePath = conceptPath + action + conceptFileName
    conceptFile = open(conceptFilePath).readlines()

    completeWords = []
    for line in conceptFile :
        line = line.decode('utf-8')
        line = line.split('\t\t')
        words = []
        if (len(line) > 2) and line[2] != '\n' :
            if gramFileName == 'gram1' :
                words = line[2].split()
            elif gramFileName == 'gram2' :
                words = line[2].split()
                i = 0
                while(i < len(words) -1) :
                    words[i] = ' '.join([words[i], words[i+1]])
                    i = i + 1
                    
            elif gramFileName == 'gram3' :
                words = line[2].split()
                i = 0
                while(i < len(words) - 2) :
                    words[i] = ' '.join([words[i], words[i+1], words[i+2]])
                    i = i + 1
            elif gramFileName == 'gram4' :
                words = line[2].split()
                i = 0
                while(i < len(words) - 3) :
                    words[i] = ' '.join([words[i], words[i+1], words[i+2], words[i+3]])
                    i = i + 1
        if words :
            completeWords = completeWords + words
    wordsCounter = collections.Counter(completeWords)
    #now for each line in gramfile, calculate the RF     
    rf = []
    for gramLine in gramFile :
        gramLine = gramLine.decode('utf-8')
        gramLine = gramLine.replace(u'\ufeff', '')
        gramLine = gramLine.split()
        fraq = float(gramLine.pop())
        freq = float(gramLine.pop())
        gramLine = ' '.join(gramLine) # get the k-grams seperated
        if gramLine in wordsCounter.keys() :
            rf.append((float(wordsCounter[gramLine])/freq,gramLine))
        else :
            rf.append((0.0, gramLine))
    rf1 = sorted(rf, reverse=True)
    outFilePath = conceptPath + action + gramFileName + 'relativeFrequency.txt'
    outFilePath1 = conceptPath + action + gramFileName + 'relativeFrequenctSorted.txt'
    outFile = open(outFilePath, 'w')
    outFile1 = open(outFilePath, 'w')
    i = 0
    while(i < len(rf)) :
        outFile.write((rf[i][1] + ' ' + str(rf[i][0]) + '\n').encode('utf-8'))
        outFile1.write((rf1[i][1] + ' ' + str(rf1[i][0]) + '\n').encode('utf-8'))
        i = i + 1
    outFile.close()
    outFile1.close()
    print "Written to file : " + outFilePath
    print "Written to file : " + outFilePath1
    return

if __name__ == "__main__" :
    if len(sys.argv) == 1:
        fileName = raw_input("File name of the concept :\n")
        if not fileName :
            fileName = "concept1"
        numFrames = raw_input("Total number of frames(of all videos) :\n")
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
            
    #filePath = fileName +  "/"
    #fileName = fileName + '.txt'
    action = action + '/'
    numFrames = numFrames * 598.0
    main(fileName, wordFile1, action)
