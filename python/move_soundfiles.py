dest="C:\Users\La Alquimista\Desktop\Extracted_consonantwise\\ty"
src_base1 ="C:\Users\La Alquimista\Desktop\shruti\SHRUTI-Bangla Speech Corpus\WAV\MALE"
src_base2 ="C:\Users\La Alquimista\Desktop\shruti\SHRUTI-Bangla Speech Corpus\WAV\FEMALE"
f=open("C:\Users\La Alquimista\Desktop\consonant_wise\\ty",'r') 
name_list=[]
for i in f:
	name_list.append(i)

import shutil
import os
def extract():
	for i in name_list:
		folder=str.split(i,"_")[0]
		#print folder
		src=src_base1+'\\'+folder
		#print src
		if os.path.isdir(src) == False:
			src=src_base2+'\\'+folder
		src_file=src+'\\'+str.split(i,'\n')[0]+".wav"
		#dest_file=dest+'\\'+str.split(i,'\n')[0]+".wav"
		#print dest_file
		if os.path.exists(src_file) == True:
			#shutil.move(src_file,dest)
			shutil.copy(src_file,dest)
			print src_file," moved"

