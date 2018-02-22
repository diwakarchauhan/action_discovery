#this scrpit takes a file containing words as input and removes
#all those words in it which match to the corpus frequency

#change the value of filter to get filter words according to
#their relative frequency in corpus and in the commentary

#####################################################################
#                       Author : Diwakar Chauhan
#####################################################################
import collections, sys

factor = 20 #range in which the words are allowed to useless

def main() :
    if len(sys.argv) == 1 :
        fileName = raw_input("File name containing the words :\n")
        if not fileName :
            fileName = 'words.txt'
        action = raw_input("Action :\n")
        if not action :
            action = 'coax'
        
    elif len(sys.argv) < 3 :
        print "============================================="
        print "Enter all the 2 values to the commandline\n"
        print "The format to the commandline should be as follows : "
        print "worFileName(with extension) actionName"
        print "Use '_' character for using default value"
        print "============================================="
        return
    else :
        if sys.argv[1] == '_' :
            fileName = 'words.txt'
        else :
            fileName = sys.argv[1]
        if sys.argv[2] == '_' :
            action = 'coax'
        else :
            action = sys.argv[2]

    action = action + '/'
    filePath = 'words/' + action + fileName
    
    wordFile = open(filePath).readlines()
    i = 0
    while(i < len(wordFile)) :
        wordFile[i] = wordFile[i].decode('utf-8')
        wordFile[i] = wordFile[i].rstrip()
        i = i + 1
    
    dictionary = collections.Counter(wordFile)
    freqFile = open('words/' + action + 'wordFreq.txt', 'w')
    keys = []
    vals = []
    freqNo = sum(dictionary.values())
    for (val,key) in zip(dictionary.values(), dictionary.keys()) :
        keys.append(key)
        vals.append(val)
        freqFile.write((key.rstrip() + " " + str(val) + '\n').encode('utf-8'))
    freqFile.close()
    print "written to file : " + 'words/' + action + 'wordFreq.txt\n'
    
    corpFile = open('corp/wordSorted.txt').readlines()

    words = []
    freq = []
    for line in corpFile :
        line = line.decode('utf-8')
        line = line.split()
        if len(line) > 2 :
            words.append(line[0])
            freq.append(float(line[2]))
    i = 0
    stripKey = []
    stripFreq = []
    while(i < len(keys)) :
        key = keys[i]
        #find the word in corpus
        if key in words :
            fr = freq[words.index(key)]
            v = float(vals[i])/float(freqNo)
            if v > fr*factor :
                stripKey.append(key)
                stripFreq.append(vals[i])
        elif key not in words :
            stripKey.append(key)
            stripKey.append(vals[i])
        i = i + 1
    filtered = open('words/' + action + 'filteredWords.txt', "w")
    i = 0
    while(i < len(wordFile)) :
        if wordFile[i] in stripKey :
            filtered.write((wordFile[i] + '\n').encode('utf-8'))
        i = i + 1

    filtered.close()
    print 'Written to file : ' + 'words/' + action + 'filteredWords.txt\n'
    
if __name__ == "__main__" :
    main()
