#this script processes the corpus
#it extracts the words from the corpus and
#k-grams and their frequency
#this script assumes the corpus file to be in file corp/corpus.txt

###########################################################################
#this function removes the useless characters from the corp
#the useless characters involve numbers, special characters
import collections

def removeUseless(corp) :
    #remove the numbers in corpus
    a = '1234567890'
    for ch in a :
        corp = corp.replace(ch, '')
    #remove special characters in the corpus
    a = '~!@#$%^&*()[]{}`_-+=|\\/;:\'".><,?'
    for ch in a :
        corp = corp.replace(ch, ' ')
    a = [u'\u0966', u'\u0967', u'\u0968', u'\u0969', u'\u096a', u'\u096b', u'\u096c', u'\u096d',u'\u096e',u'\u096f']
    for ch in a :
        corp = corp.replace(ch, '')
    corp = ' '.join(corp.split())
    return corp

def main() :
    fileName = 'corpus.txt'
    dirName = 'corp/'
    filePath = dirName + fileName
    corpFile = open(filePath)
    corp = corpFile.readlines()
    corp = ''.join(corp)
    corp = removeUseless(corp.decode('utf-8'))
    filt = open(dirName + 'filteredCorpus.txt', "w")
    filt.write(corp.encode('utf-8'))
    dictionary = collections.Counter(corp.split())
    X = []
    Y = []
    Z = []
    f = open(dirName + 'words.txt', 'w')
    freq = float(sum(dictionary.values()))
    for (y,x) in zip(dictionary.values(),dictionary.keys()):
        X.append(x)
        Y.append(y)
        Z.append(float(y)/freq)
    i = 0
    while i < len(X):
        tmp = X[i].encode("utf-8")
        f.write(tmp+" "+str(Y[i])+' ' + str(Z[i]) + '\n')
        i=i+1
    f.close()
    #store the sorted commentary
    X = []
    Y = []
    Z = []
    f = open(dirName + 'wordSorted.txt', 'w')
    for (y,x) in sorted(zip(dictionary.values(),dictionary.keys()), reverse = True):
        X.append(x)
        Y.append(y)
        Z.append(float(y)/freq)
    i = 0
    while i < len(X):
        tmp = X[i].encode("utf-8")
        f.write(tmp+" "+str(Y[i])+' ' + str(Z[i]) + '\n')
        i=i+1
    f.close()
if __name__ == "__main__" :
    main()
