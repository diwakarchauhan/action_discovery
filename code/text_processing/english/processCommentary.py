#this file takes the file name of the original commentary and creates two files
# 1 - contains commentary with all stripped silences of user
    # strippedCommentaries/coax/
# 2 - all the words used in the commentaries words/coax
#this script assumes that all the commentaries are kept in the direcory
# commentaries/coax/

##############################################################################

import sys, os

def main():
    dirName = raw_input("Directory of commentaries : \n")
    if not dirName :
       dirName = 'coax'
    dirName = dirName + '/'
    dirPath = 'commentaries/' + dirName
    for root, dirs, files in os.walk(dirPath) :
        for name in files :
            if name == 'all.txt' :
                continue
            print 'Opening commentary file :' + dirPath + name
            fp = open(dirPath + name).readlines() 

            stripFilePath = 'strippedCommentaries/' + dirName
            if not os.path.exists(stripFilePath):
                os.makedirs(stripFilePath)
            print ''.join(['Writing stripped files to to file : ' , stripFilePath, name])
            sfp = open(stripFilePath + name, "w")

            wordPath = 'words/' + dirName
            if not os.path.exists(wordPath):
                os.makedirs(wordPath)
            print ''.join(['Writing words to file : ', wordPath, name])
            wfp = open(wordPath + name, "w")

            lineNo = 1
            for line in fp :
                lineData = line.split('\t\t')
                print ''.join(['Number of segments : ', str(len(lineData)),])
                #print lineData
                if len(lineData) < 3 or lineData[2] == '\n':
                    print ''.join(["line ", str(lineNo),"has no commentary"])
                else :
                    sfp.write(line)
                    lineStr = lineData[2].rstrip()
                    comm = lineStr.split(' ')
                    comm = filter(None, comm)
                    for word in comm :
                        wfp.write(word + '\n')
                lineNo = lineNo + 1
                
            sfp.close()
            wfp.close()
        
if __name__ == "__main__" :
    main()
