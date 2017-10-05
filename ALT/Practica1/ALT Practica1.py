import sys

def subCrecienteLarga2(seq):
    numberOfSequences = len(seq)
    results = [1]*numberOfSequences
    for i in range(numberOfSequences):
        subSeq = seq[:i+1]
        for j in range(len(subSeq)-1):
            if (subSeq[j] < subSeq[i] and results[i] <= results[j]):
                results[i]=results[j]+1
    return results

def subCrecienteLarga4(seq):
    numberOfSequences = len(seq)
    results = [1]*numberOfSequences
    backTracking = {}
    for elem in seq:
        backTracking[elem]=(1,None)
    for i in range(numberOfSequences):
        subSeq = seq[:i+1]
        for j in range(len(subSeq)-1):
            if (subSeq[j] < subSeq[i] and results[i] <= results[j]):
                results[i]=results[j]+1
                #Add new Max length to entry and previous number in the sequence
                backTracking[seq[i]]=(backTracking[seq[i]][0]+1,seq[j])

    #We get a number we want to search the sequence for, in this case the one with the maximum length
    Number=seq[results.index(max(results))]
    answer=[]
    #Unrolling the dictionary to get the sequence of an answer
    while Number is not None:
        answer.append(Number)
        Number=backTracking[Number][1]
    answer.reverse()
    return answer



print(subCrecienteLarga4([210,816,357,107,889,635,733,930,842,542]))

