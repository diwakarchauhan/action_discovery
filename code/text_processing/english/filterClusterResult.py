#This function filter words from the cluster results based on various criteria
#   Some of the criterias :
#               appearance of word in corpus(remove top appearing words)
#               Noun from the concpet analysis

##############################################################################
#                       Author : Diwakar Chauhan
##############################################################################
import sys
numLines = 100
def main(action, wordFilePath, scoreFilePath) :
    wordFile = open(wordFilePath).readlines()
    scoreFile = open(scoreFilePath).readlines()
    i = 0
    wordFile = wordFile[:numLines]
    while(i < len(wordFile)) :
        wordFile[i] = wordFile[i].decode('utf-8').rstrip().split()
        #print wordFile[i]
        #wordFile[i].pop()
        #wordFile[i].pop()
        #print wordFile[i]
        wordFile[i] = ''.join(wordFile[i])
        #print wordFile[i]
        #break
        i = i + 1
    i = 0
    while(i < len(scoreFile)) :
        scoreFile[i] = scoreFile[i].decode('utf-8').rstrip().split('\t')
        if scoreFile[i] == [''] :
            scoreFile[i] = []
        elif scoreFile[i] :
            j = 0
            while(j < len(scoreFile[i])):
                if scoreFile[i][j] :
                    #print 'chak'
                    #print scoreFile[i][j]
                    scoreFile[i][j] = scoreFile[i][j].split(':')
                    #print scoreFile[i][j]
                    scoreFile[i][j][1] = float(scoreFile[i][j][1])
                    j = j + 1
                else :
                    scoreFile.pop(j)
                
        i = i + 1
    filtered = []
    for line in scoreFile :
        fLine = []
        if line :
            for tup in line :
                #print tup
                if tup[0] not in wordFile :
                    fLine.append(tup)
        filtered.append(fLine)
    outFileName = scoreFilePath.replace('.txt', '') + 'filtered' + '.txt'
    outFile = open(outFileName, 'w')
    for line in filtered :
        if line :
            for tup in line :
                outFile.write((tup[0] + ':' + str(tup[1]) + '\t').encode('utf-8'))
        else :
            outFile.write('\n\n')
    outFile.close()
    print 'Written to file : ' + outFileName
    
if __name__ == "__main__":
    if len(sys.argv) == 1 :
        action = raw_input("Action name : \n")
        if not action :
            action = 'coax'
        scoreFileName = raw_input('Score fileaname : \n')
        if not scoreFileName :
            scoreFileName = 'relativeScore_15_10'
            
        dirName = raw_input('Directory Name\n')
        if not dirName :
            dirName = 'cluster'
    elif len(sys.argv) < 4 :
        print "============================================="
        print "Enter all the 3 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "action  scoreFile clusterDir"
        print "Use '_' character for using default value"
        print "============================================="
        
    else :
        if sys.argv[1] == '_' :
            action = 'coax'
        else :
            action = sys.argv[1]
        if sys.argv[2] == '_' :
            scoreFileName = 'relativeScore_15_10'
        else :
            scoreFileName = sys.argv[2]
        if sys.argv[3] == '_' :
            dirName = 'cluster'
        else :
            dirName = sys.argv[3]
            
    corpDir = 'corp'
    wordFileName = 'common100.txt'
    corpDir = corpDir + '/'
    action = action + '/'
    dirName = dirName + '/'
    scoreFileName = scoreFileName + '.txt'
    wordFilePath = corpDir + wordFileName
    scoreFilePath = dirName + action + scoreFileName
    #print scoreFilePath
    #print wordFilePath
    main(action, wordFilePath, scoreFilePath)
