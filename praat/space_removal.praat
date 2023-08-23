form Input directory name with final slash
    comment Enter directory where soundfiles are kept:
    sentence soundDir C:\Users\La Alquimista\Desktop\Annotated_Sounds
    comment Enter directory where TextGrids are kept:
    sentence textDir C:\Users\La Alquimista\Desktop\Annotated_Sounds
endform

clearinfo

# lists all .wav files
#Create Strings as file list... list 'soundDir$'\*.wav

# lists all .TextGrid files
Create Strings as file list... list 'textDir$'\*.TextGrid

## Uncomment following line to read in files from a list
# Read Strings from raw text file... 'listDir$'\list.txt

# loop that goes through all files

numberOfFiles = Get number of strings

for ifile to numberOfFiles
  select Strings list
  fileName$ = Get string... ifile
  #baseFile$ = fileName$ - ".wav"
  baseFile$ = fileName$ - ".TextGrid"

  # Read in the Sound files and TextGrid files with that base name

  sound$ = soundDir$+ "\" + baseFile$ + ".wav"
  textgrid$ = textDir$ + "\" + baseFile$ + ".TextGrid"
 
  Read from file... 'sound$'
  Read from file... 'textgrid$'

  vc_tier = 1
  poa_tier = 2
  moa_tier = 3
  burst_tier = 4 
  cv_tier = 5
  word_tier = 6

  select TextGrid 'baseFile$'

  n = Get number of intervals... vc_tier

  for i from 1 to n
    select TextGrid 'baseFile$'
    
    vc_label$ = Get label of interval... vc_tier i
    poa_label$ = Get label of interval... poa_tier i
    moa_label$ = Get label of interval... moa_tier i
    burst_label$ = Get label of interval... burst_tier i
    cv_label$ = Get label of interval... cv_tier i

    vc_label$ = replace$ (vc_label$, " ", "", 10)
    poa_label$ = replace$ (poa_label$, " ", "", 10)
    moa_label$ = replace$ (moa_label$, " ", "", 10)
    burst_label$ = replace$ (burst_label$, " ", "", 10)
    cv_label$ = replace$ (cv_label$, " ", "", 10)


    if vc_label$ <> ""
	word_label$ = Get label of interval... word_tier i
	word_interval = Get interval at time... word_tier utterance_start
	word_label$ = replace$ (word_label$, " ", "", 10)
    endif
	
    select TextGrid 'baseFile$'
	Write to text file... 'textgrid$'

  endfor

endfor
