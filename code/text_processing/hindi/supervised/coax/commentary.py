#this script extracts the commentary corresponding to labeled cluster
#in superviesd clustering
#input to the script is actions.txt file

###########################################################################
#                      Author : Diwakar Chauhan
###########################################################################
threshold = 0.8

def main(labelName, commentaryFile) :
    outFile = open('labelCommentary.txt', 'w')
    labels = open(labelName).readlines()
    i = 0
    while(i < len(labels)) :
        labels[i] = labels[i].decode('utf-8')
        labels[i] = labels[i].replace(u'\ufeff','').rstrip()
        labels[i] = labels[i].split('\t\t')
        if len(labels[i]) > 2 and labels[i] != '\n' :
            labels[i][0] = float(labels[i][0])
            labels[i][1] = float(labels[i][1])
        i = i + 1
    comm = open(commentaryFile).readlines()
    i = 0
    while(i < len(comm)) :
        comm[i] = comm[i].decode('utf-8').replace(u'\ufeff','').rstrip().split('\t\t')
        if len(comm[i]) > 2 and comm[i] != '\t' :
            comm[i][0] = float(comm[i][0])
            comm[i][1] = float(comm[i][1])
        i = i + 1
    allComm = []
    for label in labels :
        labelComm = []
        val = float(label[1] - label[0])
        for line in comm :
            includeComm = False
            if label[0] <= line[0] and label[1] >= line[1] :
                includeComm = True
            elif label[0] > line[0] and label[1] < line[0] :
                if (val/float(line[1] - line[0]) > 0.5 ):
                    includeComm = True #dont include relatively long commentary
            elif label[0] <= line[0] and label[1] > line[0] and label[1] <= line[1] :
                if (label[1] - line[0])/val > threshold :
                    includeComm = True
            elif label[0] > line[0] and label[1] >=  line[1] and line[1] > label[0] :
                if (line[1] - label[0])/val > threshold :
                    includeComm = True
            else :
                pass
            if includeComm :
                labelComm.append(line[2])
        for com in labelComm :
            outFile.write((com + '\t\t').encode('utf-8'))
        outFile.write('\n')
        allComm.append(labelComm)
    print 'Number of segments of unmerged Commentary : ' + str(len(allComm)) 
    #now merge the similar clusters
    #here we know that 0, 2 and 8th are similar clusters
    if len(allComm) > 8 :
        allComm[0] = allComm[0] + allComm[2] + allComm[8]
        allComm.pop(8)
        allComm.pop(2)
    else :
        print "Number of cluster are less than the given index for merging"
    outFile1 = open('labelCommentaryMerged.txt', 'w')
    for labelC in allComm :
        for comm in labelC :
            outFile1.write((comm + '\t\t').encode('utf-8'))
        outFile1.write('\n')
    print 'Number of segments of merged commentary : '  + str(len(allComm))
    outFile1.close()
    outFile.close()
    
if __name__ == "__main__" :
    labelName = raw_input("Actions labels : \n")
    if not labelName :
        labelName = 'actions.txt'
    commentaryFile = raw_input('Commentary File: \n')
    if not commentaryFile :
        commentaryFile = 'all'
    action = raw_input('Action Name : \n')
    if not action :
        action = 'coax'
    action = action + '/'
    commentaryFile = '../../commentaries/' + action + commentaryFile + '.txt'
    
    main(labelName, commentaryFile)
