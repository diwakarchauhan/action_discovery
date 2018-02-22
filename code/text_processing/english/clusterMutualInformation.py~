# This script calculates the Mutual informaion of a cluster
# in either supervised labeling or unsupervised clustering
#   input Files :
#       ClusterCommentary.txt
#       clusterInterval.txt

####################################################################
#                   Author : Diwakar Chauhan
####################################################################
import sys, collections, math



def main(dirName, commFileName, intFileName, action, gram, threshold) :
    dirName = dirName + '/'
    action = action + '/'
    intFilePath = dirName + action + intFileName + '.txt'
    commFilePath = dirName + action + commFileName + '.txt'
    gramFilePath = 'grams/' + action + gram + '.txt'
    
    intFile = open(intFilePath).readlines()
    gramFile = open(gramFilePath).readlines()
    commFile = open(commFilePath).readlines()
    i = 0
    sumTime = 0.0
    totalFrames = 598.0
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
        for interval in intFile[i] :
            if interval :
                sumTime = sumTime + float(interval[1] - interval[0]) + 1
        i = i + 1
    frac = sumTime/totalFrames
    freq = 0.0
    #calculate the total number of words in all the commentaries
    for line in gramFile :
        line = line.decode('utf-8').split()
        freq = freq + float(line[len(line) - 2])
    i = 0
    while(i < len(commFile)) :
        commFile[i] = commFile[i].decode('utf-8').rstrip()
        commFile[i] = commFile[i].split()
        if len(commFile[i]) < 2 or commFile[i][0] == '\n' or commFile[i][1] :
            commFile[i] = collections.Counter(commFile[i])
        else :
            j = 0
            commFile[i] = commFile[i].split()
            while(j < len(commFile[i])):
                commFile[i][j] = collections.Counter(commFile[i][j])
                j = j + 1
        i = i + 1
    mInfo = []
    i = 0
    for comm in commFile :
        MI = []
        jp = 0
        for interval in intFile[i] :
            if interval :
                jp = jp + float(interval[1] - interval[0]) + 1
        jp = jp/totalFrames
        if isinstance(comm, list) :
            assert(len(intFile[i]) > 1)
            j = 0
            for seg in comm :
                jp = float(intFile[i][j][1] - intFile[i][j][0]) + 1
                for word in seg.keys() :
                    freqFrac = 0.0
                    mi = 0
                    for seg1 in comm :
                        if word in seg1.keys() :
                            freqFrac  = freqFrac + seg1[word]
                    freqFrac = float(freqFrac)/freq
                    if jp :
                        mi = jp*math(jp/(frac*freqFrac))
                    MI.append((mi, word))
        else :            
            for word in comm.keys() :
                freqFrac = float(comm[word])/freq
                mi = 0
                if jp :
                   mi = jp*math.log(jp/(frac*freqFrac))
                MI.append((mi,word))
        mInfo.append(sorted(MI, reverse=True))
        i = i + 1
        
    num = commFileName.replace('cluster', '')
    num = commFileName.replace('Commentary','')
    outFileName = dirName + action + 'mutualinformation' + num + '.txt'
    outFile = open(outFileName, 'w')
    #print threshold
    for mi in mInfo :
        if mi :
            for tup in mi :
                if tup[0] > threshold :
                    outFile.write((tup[1] + ':' + str(tup[0]) + '\t').encode('utf-8'))
        outFile.write('\n\n\n')
    outFile.close()
    print "Written to file : " + outFileName
if __name__=="__main__" :
    if len(sys.argv) == 1 :
        dirName = raw_input('Directory name : \n')
        if not dirName :
            dirName = 'cluster'
            
        commFileName = raw_input('Commentary file name : \n')
        if not commFileName :
            commFileName = 'cluster_15_10Commentary'
            
        intFileName = raw_input('Interval file name : \n')
        if not intFileName :
            intFileName = 'cluster_15_10interval'
            
        action = raw_input('Action name : \n')
        if not action :
            action = 'coax'
            
        gram = raw_input('gram file name : \n')
        if not gram :
            gram = 'gram1'
        threshold = raw_input('Threshold for Mutual Information: \n')
        if not threshold :
            threshold = 0.3
            
    elif len(sys.argv) < 7 :
        print "============================================="
        print "Enter all the 6 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "clusterName clusterCommentaryFileName intervalFileName action gram threshold"
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
            intFileName = 'cluster_15_10interval'
        else :
            intFileName = sys.argv[3]
        if sys.argv[4] == '_' :
            action = 'coax'
        else :
            action = sys.argv[4]
        if sys.argv[5] == '_' :
            gram = 'gram1'
        else :
            gram = sys.argv[5]
        if sys.argv[6] == '_' :
            threshold = 0.3
        else :
            threshold = sys.argv[6]
    threshold = float(threshold)
    #print threshold
    main(dirName, commFileName, intFileName, action, gram, threshold)
