#this script process the commentary of the clusters
#input files :
#       The file contaiing commentaries for the clusters
#       cluster/clusterCommentaries.txt


#algorithm :
#       for some word in a line assign positive number
#       if count the number of occurances of this word in other clusters
#       divide the score of the word with its occurance in other cluster
#       can handle same word to be occuring multiple times in commentary
#       (In this case every occurance of the word in othe cluster is summed
#         and divided to get the score)

###########################################################################
#                      Author : Diwakar Chauhan
###########################################################################
import collections, sys
#threshold = 0.003

def main(dirName, action, fileName, threshold):
    filePath = dirName + action + fileName
    clComm = open(filePath).readlines()
    
    print "Number of lines read : " + str(len(clComm)) + '\n'
    i = 0
    while(i < len(clComm)) :
        clComm[i] = clComm[i].decode('utf-8').rstrip()
        clComm[i] = clComm[i].split()
        clComm[i] = collections.Counter(clComm[i])
        s = float(sum(clComm[i].values()))
        j = 0
        #for key in clComm[i].keys() :
        #    clComm[i][key] = float(clComm[i][key])/s
            #print clComm[i].values()[j]
        #    j = j + 1
        i = i + 1
        
    i = 0
    rf = []
    while(i < len(clComm)) :
        rfl  = []
        for key in clComm[i].keys() :
            negFreq = 0.0
            for cluster in clComm :
                #if cluster != clComm[i] : #uncomment this line and ajust 2 lines
                                            #below to get the freq in non-this clusters
                if key in cluster.keys() :
                    #add the frequency of occurance in each occcurance
                    negFreq = negFreq + float(cluster[key])
            if negFreq :
                rel = float(clComm[i][key])/negFreq
            else :
                 rel = float(clComm[i][key])#.values()[clComm[i].keys().index(key)])
            #rel = rel/sum(clComm[i].values())
            rfl.append((key, negFreq, rel))
        rf.append(rfl)
        i = i + 1
    fn = fileName.replace('cluster', '')
    fn = fn.replace('Commentary', '')
    fn = fn.replace('.txt', '')
    of1 = 'rfEvaluation' + fn + '.txt'
    of2 = 'relativeScore' + fn + '.txt'
    outFile = open(dirName + action + of1 , "w")
    scoreFile = open(dirName + action + of2, "w")

    for rfl in rf :
        i = 0
        rfl.sort(key=lambda tup:tup[1], reverse=True)
        rfl2 = sorted(rfl, key=lambda tup:tup[2], reverse=True)
        while(i < len(rfl)):
            if rfl :
                outFile.write((rfl[i][0] + ':' + str(rfl[i][1])+'\t').encode('utf-8'))
                if rfl2[i][2] > threshold :
                    scoreFile.write((rfl2[i][0] + ':' + str(rfl2[i][2]) + '\t').encode('utf-8'))
            i = i + 1
            
        outFile.write('\n\n\n\n'.encode('utf-8'))
        scoreFile.write('\n\n\n\n'.encode('utf-8'))
        
    outFile.close()
    scoreFile.close()
    print "written to file : " + dirName + action + 'rfEvaluation' + fn + '.txt'
    print "Written to file : " + dirName + action + 'relativeScore' + fn + '.txt'
    
if __name__ == "__main__" :
    if len(sys.argv) == 1 :
        dirName = raw_input('Cluster Name : \n')
        if not dirName :
            dirName = 'cluster'
        
        action = raw_input("Action Name : \n")
        if not action :
            action = 'coax'
        
        fileName = raw_input("Cluster commentary file : \n")
        if not fileName :
            fileName = 'clusterCommentary'
        threshold = float(raw_input("Threshold : \n"))
        if not threshold :
            threshold = 0.003
            
    elif len(sys.argv) < 5 :
        print "============================================="
        print "Enter all the 4 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "clusterName action clusterCommentaryFileName threshold"
        print "Use '_' character for using default value"
        print "============================================="
    else :
        if sys.argv[1] == '_' :
            dirName = 'cluster'
        else :
            dirName = sys.argv[1]

        if sys.argv[2] == '_' :
            action = 'coax'
        else :
            action = sys.argv[2]

        if sys.argv[3] == '_' :
            fileName = 'clusterCommentary'
        else :
            fileName = sys.argv[3]
        if sys.argv[4] == '_' :
            threshold = 0.003
        else :
            threshold = float(sys.argv[4])
            
    dirName = dirName + '/'
    action = action + '/'
    fileName = fileName + '.txt'
    main(dirName, action, fileName, threshold)
