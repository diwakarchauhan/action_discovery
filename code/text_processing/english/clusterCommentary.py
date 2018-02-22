#this script seperates the commentaries of each of the cluster created by
#hierarchical clustering
#the input to the script is the file containing the culuster info

###################################################################
import sys

def merge(cluster) :
    cluster = cluster.rstrip()
    cluster = cluster.split('\t\t')
    i = 0
    while i < len(cluster) :
        cluster[i] = cluster[i].split(':')
        cluster[i] = map(int, cluster[i])
        i = i + 1
    i = 0
    while i < len(cluster) - 1:
        if cluster[i][1] >= cluster[i+1][0] and cluster[i][1] < cluster[i+1][1] :
            cluster[i][1] = cluster[i+1][1]
            cluster.remove(cluster[i+1])
        elif cluster[i][1] > cluster[i+1][1] :
            cluster.remove(cluster[i+1])
            i = i + 1
        else :
            i = i + 1
    #remove the smaller intervals
    i = 0
    while i < len(cluster) :
        if cluster[i][1] - cluster[i][0] <= 25 :
            cluster.remove(cluster[i])
        else :
            i = i + 1

    return cluster

def main(clFileName, comFileName, wFileName, intFileName) :
    clusterFile = open(clFileName).readlines()
    comm = open(comFileName).readlines()
    i=0
    while i<len(comm):
        comm[i] = comm[i].decode('utf-8')
        comm[i] = comm[i].replace(u'\ufeff', '')
        comm[i] = comm[i].split("\t\t")
        comm[i][0] = float(comm[i][0])
        comm[i][1] = float(comm[i][1])
        i = i+1
        
    f = open(wFileName, "w")
    i = 1
    thres = 0.7
    intf = open(intFileName, 'w')
    #print clusterFile
    for cluster in clusterFile :
        #print "unmerged"
        #print cluster
        cluster = merge(cluster)
        print "Length of cluster is : "  + str(len(cluster))
        com = []
        #com.append(str(i)) #enumerate the lines
        for interval in cluster :
            intf.write(str(interval[0]) + ':'+ str(interval[1]) + '\t\t')
            for item in comm :
                append = False
                if interval[0] > item[0] and interval[1] < item[1] :
                    if float(interval[1] - interval[0] + 1)/float(item[1] - item[0] + 1) > thres :
                        append = True
                elif interval[0] <= item[0] and interval[1] >= item[1] :
                    append = True
                elif interval[0] >= item[0] and interval[0] <= item[1] and interval[1] > item[1] :
                    if float(item[1] - interval[0] + 1)/float(item[1] - item[0] + 1) :
                        append = True
                elif interval[0] < item[0] and interval[1] <= item[1] and interval[1] > item[0] :
                    if float(interval[1] - item[0] + 1)/float(item[1] - item[0] + 1) > thres :
                        append = True
                if append and len(item) > 2 and item[2] !='\n' :
                    com.append(item[2].rstrip())
            com.append('\t\t') #add tabs for different intervals
        intf.write('\n')
        f.write((' '.join(com) + '\n').encode('utf-8'))
        i = i + 1
    f.close()
    intf.close()
    print "Intervals written to file " + intFileName
    print "Concept written to file " + wFileName

if __name__ == "__main__" :
    if len(sys.argv) == 1 :
        action = raw_input('Action name : \n')
        if not action :
            action = 'coax'
        
        clFileName = raw_input('Cluster file name : \n')
        if not clFileName :
            clFileName = 'frameCluster'
            
        comFileName = raw_input('Commentary fileName : \n')
        if not comFileName :
            comFileName = 'all'
    elif len(sys.argv) < 4:
        print "============================================="
        print "Enter all the 3 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "action clusterFileName commentaryFileName"
        print "Use '_' character for using default value"
        print "============================================="
        
    else :
        if sys.argv[1] == '_' :
            action = 'coax'
        else :
            action = sys.argv[1]

        if sys.argv[2] == '_' :
            clFileName = 'frameCluster'
        else :
            clFileName = sys.argv[2]
            
        if sys.argv[3] == '_' :
            comFileName = 'all'
        else :
            comFileName = sys.argv[3]
            
    action = action + '/'
    comFileName = 'commentaries/' + action + comFileName + '.txt'
    writeFileName = 'cluster/' + action + clFileName.replace('frameC', 'c')+ 'Commentary.txt'#coax/clusterCommentary.txt
    intFileName = 'cluster/' + action + clFileName.replace('frameC','c') + 'Interval.txt'
    clFileName = '../videoInfo/' + action + clFileName + '.txt'
    main(clFileName, comFileName, writeFileName, intFileName)
