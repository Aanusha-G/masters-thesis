#extract speaker names only
file=open("C:\Users\La Alquimista\Desktop\\ty,dy.txt", 'r')
name_list, big_list=[],[]
for i in file:
	#word_list=nltk.word_tokenize(i)
	word_list=str.split(i,' ')
	if i[0]=='<':
		if len(word_list)<= 15:
			name_list.append(word_list[-1])
			big_list.append(i)

with open("C:\Users\La Alquimista\Desktop\python_ty,dy_speakers.txt",'a') as f:
	for i in name_list:
		f.write(i)
		f.write('\n')

with open("C:\Users\La Alquimista\Desktop\python_ty,dy.txt",'a') as f:
	for i in big_list:
		f.write(i)
		f.write('\n')

#save sentences according to speaker
for i in range(0,len(big_list)):
	with open("C:\\Users\La Alquimista\Desktop\\textfiles\\%s.txt" %name_list[i][1:-2],'a') as f:
		f.write(big_list[i])

		