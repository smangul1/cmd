#!/usr/bin/python2.7 -tt



import sys



reads = range(48)

for kk in range(48):

  reads[kk] = open('./index_' + str(kk+1) + '.qseq', 'w')



index = range(48)

index[0] = 'ATCACG'

index[1] = 'CGATGT'

index[2] = 'TTAGGC'

index[3] = 'TGACCA'

index[4] = 'ACAGTG'

index[5] = 'GCCAAT'

index[6] = 'CAGATC'

index[7] = 'ACTTGA'

index[8] = 'GATCAG'

index[9] = 'TAGCTT'

index[10] = 'GGCTAC'

index[11] = 'CTTGTA'

index[12] = 'AGTCAA'

index[13] = 'AGTTCC'

index[14] = 'ATGTCA'

index[15] = 'CCGTCC'

index[16] = 'GTAGAG'

index[17] = 'GTCCGC'

index[18] = 'GTGAAA'

index[19] = 'GTGGCC'

index[20] = 'GTTTCG'

index[21] = 'CGTACG'

index[22] = 'GAGTGG'

index[23] = 'GGTAGC'

index[24] = 'ACTGAT'

index[25] = 'ATGAGC'

index[26] = 'ATTCCT'

index[27] = 'CAAAAG'

index[28] = 'CAACTA'

index[29] = 'CACCGG'

index[30] = 'CACGAT'

index[31] = 'CACTCA'

index[32] = 'CAGGCG'

index[33] = 'CATGGC'

index[34] = 'CATTTT'

index[35] = 'CCAACA'

index[36] = 'CGGAAT'

index[37] = 'CTAGCT'

index[38] = 'CTATAC'

index[39] = 'CTCAGA'

index[40] = 'GACGAC'

index[41] = 'TAATCG'

index[42] = 'TACAGC'

index[43] = 'TATAAT'

index[44] = 'TCATTC'

index[45] = 'TCCCGA'

index[46] = 'TCGAAG'

index[47] = 'TCGGCA'



def demultiplex(readsinfile, indexinfile, mismatches=0):

  

  readsopen = open(readsinfile, 'rU')

  read_lines = readsopen.readlines()

  indexopen = open(indexinfile, 'rU')

  index_lines = indexopen.readlines()

  readsopen.close()

  indexopen.close()

  

  if mismatches==0:

    for kk in range(len(index_lines)):

      index_col = index_lines[kk].split()

      for ll in range(48):

        if (index_col[8][:6] == index[ll]) or (index_col[8][1:6] == index[ll][1:6]):

          reads[ll].write(read_lines[kk])

          break

  else:

    for kk in range(len(index_lines)):

      index_col = index_lines[kk].split()

      for ll in range(48):  

        mm = 0

        for jj in range(6):

          if index_col[8][jj] != index[ll][jj]:

            mm += 1

          if mm > mismatches:

            break

          elif jj == 5:

            reads[ll].write(read_lines[kk])

            break



def main():

  if sys.argv[-1] == '1':

    mismatches = 1

    sys.argv.pop()

    for kk in range(len(sys.argv)/2):

      demultiplex(sys.argv[kk+1], sys.argv[kk+(len(sys.argv)/2)+1], mismatches)

  else:

    for kk in range(len(sys.argv)/2):

      demultiplex(sys.argv[kk+1], sys.argv[kk+(len(sys.argv)/2)+1])



  sys.stderr.write('Done with demultiplexing.\n')



if __name__ == '__main__':

  main()


