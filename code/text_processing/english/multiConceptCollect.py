#this script calculates the concept based on multiple objects
#input
#       TriangleMovementRecord : movement record for multiple triangles

############################################################################
import sys

highThreshold = 0.8
lowThreshold = 0.4
def main() :
    dirOneName = 'concept1'
    dirTwoName = 'concept2'
    if len(sys.argv) == 1 :
        action = raw_input('Action Name : \n')
        if not action :
            action = 'coax'

        
        includeOne = raw_input('concept1(1) or notConcept1(0) ??\n')
        if not includeOne or includeOne == '0' :
            includeOne = False
            dirOneName = 'conceptNot1'

        
        includeTwo = raw_input('concept2(1) or notConcept2(0) ??\n')
        if not includeTwo or includeTwo == '0' :
            includeTwo = False
            dirTwoName = 'conceptNot2'
    elif len(sys.argv) < 4:
        print "============================================="
        print "Enter all the 3 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "actonName concept1(T/F) concept2(T/F)"
        print "Use '_' character for using default value"
        print "============================================="
        return
    
    else :
        if sys.argv[1] == '_' :
            action = 'coax'
        else :
            action = sys.argv[1]
        if sys.argv[2] == '_' or sys.argv[2] == 0 :
            includeOne = False
            dirOneName = 'conceptNot1'
        else :
            includeOne = True

        if sys.argv[3] == '_' or sys.argv[3] == 0 :
            includeTwo = False
            dirTwoName = 'conceptNot2'
        else :
            includeTwo = True

         
    action  = action + '/'
    
    moveRec1 = open('concept1/' + action + 'MovementRecord.txt').readlines()
    moveRec2 = open('concept2/' + action + 'MovementRecord.txt').readlines()
    inp = open('commentaries/' + action + 'all.txt').readlines()

    i = 0
    while i<len(inp):
        inp[i] = inp[i].decode('utf-8')
        inp[i] = inp[i].replace(u'\ufeff', '')
        inp[i] = inp[i].split("\t\t")
        inp[i][0] = float(inp[i][0])
        inp[i][1] = float(inp[i][1])
        i = i + 1

    i = 0
    while i<len(moveRec1):
        moveRec1[i] = moveRec1[i].split()
        moveRec1[i][0] = float(moveRec1[i][0])
        moveRec1[i][1] = float(moveRec1[i][1])
        i = i + 1

    i = 0
    while i<len(moveRec2):
        moveRec2[i] = moveRec2[i].split()
        moveRec2[i][0] = float(moveRec2[i][0])
        moveRec2[i][1] = float(moveRec2[i][1])
        i = i + 1
    
        
    dirName = dirOneName + dirTwoName
    
    concept = []    
    for item in inp:
        calc = 0.0
        calc2 = 0.0
        for it in moveRec1 :
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
            
        for it in moveRec2 :  
            if it[0]>=item[0] and it[1]<=item[1]:
                calc2 = calc2 + it[1] - it[0] + 1
            elif it[0]<item[0] and it[1]>item[0]:
                calc2 = calc2 + item[1] - item[0] + 1
            elif it[0]>=item[0] and it[0]<=item[1] and it[1]>item[1]:
                calc2 = calc2 + item[1] - it[0] + 1
            elif it[0]<item[0] and it[1]<=item[1] and it[1]>item[0]:
                calc2 = calc2 + it[1] - item[0] + 1
            else:
                pass
            
        calc = calc/(item[1] - item[0] + 1)
        calc2 = calc2/(item[1] - item[0] + 1)
        
        if includeOne and includeTwo:
            if calc >= highThreshold and calc2 >= highThreshold :
                    concept.append(item)
        elif includeOne and not includeTwo :
            if calc >= highThreshold and calc2 < lowThreshold :
                concept.append(item)
        elif not includeOne and includeTwo :
            if calc < lowThreshold and calc2 >= highThreshold :
                concept.append(item)
        elif not includeOne and not includeTwo :
            if calc < lowThreshold and calc2 < lowThreshold :
                concept.append(item)
    f = open(dirName + '/' + action + dirName + '.txt', "w")
    for item in concept :
        if len(item) > 2 :
            f.write((str(item[0])+'\t\t'+str(item[1])+'\t\t'+item[2]).encode('utf-8'))
        else :
            f.write((str(item[0])+'\t\t'+str(item[1])+'\t\t'+'\n').encode('utf-8'))
    f.close()
    
    print 'Written to file ' + dirName + '/' + action + dirName + '.txt\n'

            
if __name__ == "__main__" :
    main()
