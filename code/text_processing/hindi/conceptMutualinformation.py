#This function calculates the mutual information for the given word
#The input to the script is the joint probability values
# and the concept for which the mi is taken
# Mutual information = (joint ptobability)*log((joint probability)/(probability of w))
#

########################################################################
#                   Author : Diwakar Chauhan
########################################################################
import math, sys

def main() :
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
            
    numFrames = float(numFrames) * 598.0
    filePath = fileName + "/"
    fileName = fileName + '.txt'
    action = action + '/'

    numFrames = float(numFrames)
    cFilePath = filePath + action + fileName
    concept = open(cFilePath).readlines()
    
    wordFile = 'grams/' + action + wordFile1 + '.txt' #file containing all words with frequency
    wFile = open(wordFile).readlines()
    
    cFrames = 0.0
    for line in concept :
        line = line.decode('utf-8').split('\t\t')        
        cFrames = cFrames + float(float(line[1]) - float(line[0])) + 1
        
    frac = cFrames/numFrames
    
    jFilePath = filePath + action + wordFile1 +'jointProb.txt'
    jProb = open(jFilePath).readlines()
    
    freq = 0.0
    for line in wFile :
        line = line.decode('utf-8').split()
        freq = freq + float(line[len(line) - 2])
    mInfo = []

    i = 0
    for line in jProb :    
        wFile[i] = wFile[i].split()
        wFreq = float(wFile[i][len(wFile[i]) - 2])
        freqFraq = wFreq/freq
        line = line.decode('utf-8').split()
        jp = float(line.pop())
        line = ' '.join(line)
        if jp == 0 :
            mInfo.append((jp, line))
        else :
            if freqFraq == 0 or frac == 0 :
                mi = 10
            else :
                mi = jp*math.log(jp/(freqFraq*frac), 2)
            mInfo.append((mi, line))
        i = i + 1
        
    mInfo1 = sorted(mInfo, reverse=True)
    numWords = len(mInfo)
    i = 0

    outFile = open(filePath + action + wordFile1 + 'mutualInfo.txt', "w")
    outFile1 = open(filePath + action + wordFile1 + 'mutualInfoSorted.txt', "w")
    
    if not outFile :
        print "unable to open the file\n"
        return
    
    while(i < numWords) :
        outFile.write((mInfo[i][1] + " " + str(mInfo[i][0]) + "\n").encode('utf-8'))
        outFile1.write((mInfo1[i][1] + " " + str(mInfo1[i][0]) + "\n").encode('utf-8'))
        i = i + 1
        
    outFile.close()
    outFile1.close()
    print 'Written to file : ' + filePath +'coax/' + wordFile1 + 'mutualInfoSorted.txt'
    print 'Written to file : ' + filePath +'coax/' + wordFile1 + 'mutualInfo.txt'
                    
if __name__  == "__main__" :
    main()
