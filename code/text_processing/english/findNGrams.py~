#this functions calculates the n-grams from the given words
#this script assumes that the  words are sequencial in the comentaries
#it reads the words.txt file from the specified directory
#calculates the k-grams from commentaries
#if no directory is specified, then it takes words/coax/words.txt
# and puts output into kgrams/*grams.txt

#######################################################################
#                   Author : Diwakar Chauhan
#######################################################################
import os, collections, sys

def main(dirName, action,gramDir, numGram) :
    exDirName = dirName + action
    fileName = exDirName + 'filteredWords.txt'
    fp = open(fileName)
    lines = fp.readlines()
    words = []
    for line in lines :
        line = line.decode('utf-8')
        line = line.split()
        if line != '\n' :
            words.append(line[0])
            
    numWords = len(words)
    if 1 in numGram :
        gramFileName = gramDir + action + 'gram1.txt'
        f = open(gramFileName, "w")
        dic = collections.Counter(words)
        X = []
        Y = []
        Z = []
        freq = float(sum(dic.values()))
        for (y,x) in sorted(zip(dic.values(),dic.keys())):
            X.append(x)
            Y.append(y)
            Z.append(float(y)/freq)
        i = 0
        while i < len(X):   #Printing with frequency
            tmp = X[i].encode("utf-8")
            f.write(tmp+" "+str(Y[i])+ ' ' + str(Z[i]) +'\n')
            i=i+1
        f.close()
        print "K-grams written to file :" + gramFileName
        
    if 2 in numGram :
        gramFileName = gramDir + action + 'gram2.txt'
        f = open(gramFileName, "w")
        i = 0
        biGram = []
        while( i < numWords - 1) :
           biGram.append(' '.join([words[i].rstrip(), words[i+1].rstrip()]))
           i = i + 1
        dic = collections.Counter(biGram)
        X = []
        Y = []
        Z = []
        freq = float(sum(dic.values()))
        for (y,x) in sorted(zip(dic.values(),dic.keys())):
            X.append(x)
            Y.append(y)
            Z.append(float(y)/freq)
        i = 0
        while i < len(X):   #Printing with frequency
            tmp = X[i].encode("utf-8")
            f.write(tmp+" "+str(Y[i])+ ' ' + str(Z[i]) +'\n')
            i=i+1
        f.close()
        print "K-grams written to file :" + gramFileName
        
    if 3 in numGram :
        gramFileName = gramDir + action + 'gram3.txt'
        f = open(gramFileName, "w")
        i = 0
        triGram = []
        while( i < numWords - 2) :
           triGram.append(' '.join([words[i].rstrip(), words[i+1].rstrip(), words[i+2].rstrip()]))
           i = i + 1

        dic = collections.Counter(triGram)
        X = []
        Y = []
        Z = []
        freq = float(sum(dic.values()))
        for (y,x) in sorted(zip(dic.values(),dic.keys())):
            X.append(x)
            Y.append(y)
            Z.append(float(y)/freq)
        i = 0
        
        while i < len(X):   #Printing with frequency
            tmp = X[i].encode("utf-8")
            f.write(tmp+" "+str(Y[i])+ ' ' + str(Z[i]) +'\n')
            i=i+1
        f.close()
        print "K-grams written to file :" + gramFileName
    if 4 in numGram :
        gramFileName = gramDir + action + 'gram4.txt'
        f = open(gramFileName, "w")
        i = 0
        tetraGram = []
        while( i < numWords - 3) :
           tetraGram.append(' '.join([words[i].rstrip(), words[i+1].rstrip(), words[i+2].rstrip(),words[i+3].rstrip()]))
           i = i + 1
           #print biGram
           
        dic = collections.Counter(tetraGram)
        X = []
        Y = []
        Z = []
        freq = float(sum(dic.values()))
        for (y,x) in sorted(zip(dic.values(),dic.keys())):
            X.append(x)
            Y.append(y)
            Z.append(float(y)/freq)
        i = 0
        while i < len(X):
            tmp = X[i].encode("utf-8")
            f.write(tmp+" "+str(Y[i])+ ' ' + str(Z[i]) +'\n')
            i=i+1
        f.close()
        print "K-grams written to file :" + gramFileName
    

if __name__ == "__main__" :
    if len(sys.argv) == 1 :
        dirName = raw_input("Name of the directory containing words.txt")
        if not dirName :
            dirName = 'words'
        
        action = raw_input("Action Name :\n")
        if not action :
            action = 'coax'
        gramDir = raw_input('gramDirName \n')
        if not gramDir :
            gramDir = 'grams'
            
        numGram = raw_input("K-gram value : \n")
        if not numGram :
            numGram = [1,2,3,4]
    elif len(sys.argv) < 5 :
        print "============================================="
        print "Enter all the 4 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "wordFileName action gramDir gramArity(as list)"
        print "Use '_' character for using default value"
        print "============================================="
    else :
        if sys.argv[1] == '_' :
            dirName = 'words'
        else :
            dirName = sys.argv[1]
        if sys.argv[2] == '_' :
            action = 'coax'
        else :
            action = sys.argv[2]
        
        if sys.argv[3] == '_' :
            gramDir = 'grams'
        else :
            gramDir = sys.argv[3]
            
        if sys.argv[4] == '_' :
            numGram = [1,2,3,4]
        else :
            numGram = sys.argv[4].replace('[', '')
            numGram = numGram.replace(']', '')
            numGram = numGram.split(',')
            numGram = map(int, numGram)
            
    dirName = dirName + '/'
    action = action + '/'
    gramDir = gramDir + '/'
    main(dirName, action, gramDir,numGram)
