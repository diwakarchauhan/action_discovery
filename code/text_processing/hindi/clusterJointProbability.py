#This file calculates the joint probability for the clusters
#created by unsupervised clustering of supervised labeling
#input Files :
#           cluster/clusterCommentary
#           cluster/cluserInterval
# The joint ptobability for all the words in a cluster will be same
#because all of them appear in one cluster appear for identical time
#interval out of total video, so no need to explitly calculate it
#claculated in Mutual Information
#######################################################################
#                       Author : Diwakar Chauhan
#######################################################################
import sys

def main(dirName, commFileName, intFileName, action, numFrames, gram) :
    action = action + '/'
    dirName = dirName + '/'
    commFilePath = dirName + action + commFileName + '.txt'
    intFilePath = dirName + action  + intFileName + '.txt'
    gramFilePath = 'grams/' + action + gram + '.txt'
    
    commFile = open(commFilePath).readlines()
    intFile = open(intFilePath).readlines()
    gramFile = open(gramFilePath).readlines()
    
    i = 0
    while(i < len(intFile)) :
        intFile[i] = intFile[i].rstrip()
        intFile[i] = intFile[i].split('\t\t')
        j = 0
        while(j < len(intFile[i])) :
            if intFile[i][j] :
                intFile[i][j] = intFile[i][j].split(':')
                intFile[i][j] = map(int, intFile[i][j])
            else :
                intFile[i][j] = []
            j = j + 1
        i = i + 1
    i = 0
    while(i < len(commFile)) :
        commFile[i] = commFile[i].decode('utf-8').rstrip()
        commFile[i] = commFile[i].split()
        commFile[i] = collections.Counter(commFile[i])
        i = i + 1

    for line in gramFile :
        line = line.decode('urf-8').rstrip()
        line = line.split()
        line.pop()
        line.pop()
        line = ' '.join(line)
        for commLine in commFile :
            if line in commLine.keys():
if __name__ == "__main__" :
    if len(sys.argv) == 1 :
        dirName = raw_input('Directory name : \n')
        if not dirName :
            dirName = 'cluster'
            
        commFileName = raw_input('Commentary file name : \n')
        if not commFileName :
            commFileName = 'cluster_15_10Commentary'
        intFileName = raw_input('Interval file name : \n')
        if not intFileName :
            intFileName = 'cluster_15_10Interval'
        action = raw_input('Action name : \n')
        if not action :
            action = 'coax'

        numComm = raw_input("Number of commentary")
        if not numComm :
            numComm = 14.0
        gram = raw_input("Gram file name  : \n")
        if not gram :
            gram = 'gram1'
        
    elif len(sys.argv) < 6 :
        print "============================================="
        print "Enter all the 6 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "clusterName clusterCommentaryFileName action numberOfCommentary gram1"
        print "Use '_' character for using default value"
        print "============================================="
    else :
        if sys.argv[1] == '_' :
            dirName = 'cluster'
        else :
            dirName = sys.argv[1]
        if sys.argv[2] == '_' :
            commFileName = 'cluster_15_10Commentary'
        else :
            commFileName = sys.argv[2]
        if sys.argv[3] == '_' :
            intFileName = 'cluster_15_interval'
        else :
            intFileName = sys.argv[3]
        if sys.argv[4] == '_' :
            action = 'coax'
        else :
            action = sys.argv[4]
        if sys.argv[5] == '_' :
            numComm = 14.0
        else :
            numComm = float(sys.argv[5])
        if sys.argv[6] == '_' :
            gram = 'gram1'
        else :
            gram = sys.argv[6]
        numComm = float(numComm)*598
    main(dirName, commFileName, intFileName, action, numComm, gram)
