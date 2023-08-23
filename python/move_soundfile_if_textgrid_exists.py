import shutil
import os
dest="C:\Users\La Alquimista\Desktop\New_Annotations"
src_base1 ="C:\Users\La Alquimista\Desktop\shruti\SHRUTI-Bangla Speech Corpus\WAV\MALE"
src_base2 ="C:\Users\La Alquimista\Desktop\shruti\SHRUTI-Bangla Speech Corpus\WAV\FEMALE"
male=["abd","amitava","bd","chan","chandan","deb","jit","jyotirmoy","kunal","mainak","moy","padma","plb","rajashree","samaresh","sandi","sayan","sm","smt","styabrata","sudha","suman","suparna","suparnakdas","swarnendu","xxx"]
female =["manika","msm","punam","rita","ritwika","shyamoshree","suranjana","tml"]
def extract():
	for i in male:
		folder=src_base1+ "\\" +i
		#print folder
		name_list=os.listdir(folder)
		for j in name_list:
			filebase = str.split(j,'.')[0]
			fileext = str.split(j,'.')[1]
			textgrid = folder+ '\\'+ filebase+".TextGrid"
			wav = folder + '\\' + filebase + ".wav"
			if fileext == "wav" and os.path.exists(textgrid) == True:
				shutil.copy(wav,dest)
				shutil.copy(textgrid,dest)
				print wav," moved"
	for i in female:
		folder=src_base2+ "\\" + i
		#print folder
		name_list=os.listdir(folder)
		for j in name_list:
			filebase = str.split(j,'.')[0]
			fileext = str.split(j,'.')[1]
			textgrid = folder+ '\\'+ filebase+".TextGrid"
			wav = folder + '\\' + filebase + ".wav"
			if fileext == "wav" and os.path.exists(textgrid) == True:
				shutil.copy(wav,dest)
				shutil.copy(textgrid,dest)
				print wav," moved"