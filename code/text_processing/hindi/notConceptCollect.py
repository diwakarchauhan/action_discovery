#This file creates concept data for red triangle
#It takes input, the movement records for the concept and
#commentaries for the video and based on that, creates
# concepts corresponding to red triangle

import codecs, sys, collections, os

threshold = 0.5
#If any of the narration frame sequence occupies more than the threshold
#in the movement record than it is selected.

def main():
    if len(sys.argv) == 1 :
        cName = raw_input("Concept name:\n")
        if not cName :
            cName = 'conceptNot1'
            
        dirName = raw_input("Enter the name of the directory : \n")
        if not dirName :
            dirName = "coax/"
        
    elif len(sys.argv) < 3:
        print "============================================="
        print "Enter all the 2 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "conceptName actionName"
        print "Use '_' character for using default value"
        print "============================================="
        
    else :
        if sys.argv[1] == '_' :
            cName = 'conceptNot1'
        else :
            cName = sys.argv[1]
        if sys.argv[2] == '_' :
            dirName = 'coax/'
        else :
            dirName = sys.argv[2]


    inp = open("commentaries/" + dirName + "all.txt").readlines()
    cdName = cName + '/'
            
    mr1 = open(cdName + dirName + "MovementRecord.txt").readlines()
    if not mr1 :
        print "Unable to open the file of movement record \n"
    f1 = open(cdName + dirName + cName + ".txt",'w')
    if not f1 :
        print "Unable to open the file to write concept.\n"

    
    #Assumption: Person will speak about the moving object
    i=0
    while i<len(inp):
        inp[i] = inp[i].decode('utf-8')
        inp[i] = inp[i].replace(u'\ufeff', '')
        inp[i] = inp[i].split("\t\t")
        inp[i][0] = float(inp[i][0])
        inp[i][1] = float(inp[i][1])
        i = i+1


    #Getting c1.txt
    i=0
    while i<len(mr1):
        mr1[i] = mr1[i].split()
        mr1[i][0] = float(mr1[i][0])
        mr1[i][1] = float(mr1[i][1])
        i = i+1
            
    c1 = []
    i = 0
    for item in inp:
        calc = 0.0
        for it in mr1:  
            if it[0]>=item[0] and it[1]<=item[1]:
                calc = calc + it[1] - it[0] + 1
            elif it[0]<item[0] and it[1]>item[0]:
                calc = calc + item[1] - item[0] + 1
            elif it[0]>=item[0] and it[0]<=item[1] and it[1]>item[1]:
                calc = calc + item[1] - it[0] + 1
            elif it[0]<item[0] and it[1]<=item[1] and it[1]>item[0]:
                calc = calc + it[1] - item[0] + 1
            else:
                pass
        calc = calc/(item[1]-item[0]+1)
        #print calc
        if (calc < threshold):
            c1.append(item)
        i = i+1
    for item in c1:
        if len(item)>2:
            f1.write((str(item[0])+'\t\t'+str(item[1])+'\t\t'+item[2]).encode('utf-8'))
        else:
            f1.write((str(item[0])+'\t\t'+str(item[1])+'\t\t\n').encode('utf-8'))
    
    f1.close()
    print "Written to file : "+cdName + dirName + cName + ".txt"
    
if __name__ == '__main__':
    main()
