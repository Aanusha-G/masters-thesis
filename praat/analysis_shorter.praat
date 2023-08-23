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
printline File'tab$'Word'tab$'Vowel Type'tab$'Vowel'tab$'Vowel Duration (msec)'tab$'POA'tab$'MOA'tab$'Consonant Duration (msec)'tab$'Burst Duration'tab$'f0'tab$'f1_onset'tab$'f1_mid'tab$'f2_onset'tab$'f2_mid

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

  select Sound 'baseFile$'
  formant = To Formant (burg)... 0 5 5000 0.025 50
  select Sound 'baseFile$'
  pitch = To Pitch... 0.0 75.0 600.0

  select TextGrid 'baseFile$'

  n = Get number of intervals... vc_tier

  for i from 1 to n
    select TextGrid 'baseFile$'
    
    vc_label$ = Get label of interval... vc_tier i
    
    if vc_label$ <> ""

      poa_label$ = Get label of interval... poa_tier i
      moa_label$ = Get label of interval... moa_tier i
      cv_label$ = Get label of interval... cv_tier i

      vc_start = Get start point... vc_tier i
      vc_end = Get end point... vc_tier i
      vc_dur = (vc_end - vc_start)
      vc_mid = vc_start + (0.5*vc_dur)
      vc_onset = vc_start + (0.05*vc_dur)
      vc_dur = vc_dur*1000

      #5500 for females, 5000 for males
      con_start = Get start point... poa_tier i
      con_end = Get end point... poa_tier i
      con_dur = (con_end - con_start)*1000

      burst_start = Get start point... burst_tier i
      burst_end = Get end point... burst_tier i
      burst_dur = (burst_end - burst_start)*1000

      cv_start = Get start point... cv_tier i
      cv_end = Get end point... cv_tier i
      cv_dur = (cv_end - cv_start)
      cv_mid = cv_start + (0.5*cv_dur)
      cv_onset = cv_start + (0.05*cv_dur)
      cv_dur = cv_dur*1000

      word_int = Get interval at time... word_tier vc_mid
      word_label$ = Get label of interval... word_tier word_int

      select 'formant'
      f1_onset[1] = Get value at time... 1 'vc_onset' Hertz Linear
      f2_onset[1] = Get value at time... 2 'vc_onset' Hertz Linear
      f1_mid[1] = Get value at time... 1 'vc_mid' Hertz Linear
      f2_mid[1] = Get value at time... 2 'vc_mid' Hertz Linear

      f1_onset[2] = Get value at time... 1 'cv_onset' Hertz Linear
      f2_onset[2] = Get value at time... 2 'cv_onset' Hertz Linear
      f1_mid[2] = Get value at time... 1 'cv_mid' Hertz Linear
      f2_mid[2] = Get value at time... 2 'cv_mid' Hertz Linear

      select 'pitch'
      f0[1] = Get value at time... 'vc_mid' Hertz Linear
      f0[2] = Get value at time... 'cv_mid' Hertz Linear

      #printline 'baseFile$''tab$''word_label$''tab$'1'tab$''vc_label$''tab$''vc_dur:2''tab$''poa_label$''tab$''moa_label$''tab$''con_dur:2''tab$''burst_dur''tab$'f0'tab$'f1[1]'tab$'f2[1]
      #printline 'tab$''word_label$''tab$'2'tab$''cv_label$''tab$''cv_dur:2''tab$''poa_label$''tab$''moa_label$''tab$''con_dur:2''tab$''burst_dur''tab$'f0'tab$'f1[2]'tab$'f2[2]

      appendInfoLine: baseFile$ , tab$ , word_label$ , tab$ ,"1" , tab$ , vc_label$ , tab$ , fixed$(vc_dur,2) , tab$ , poa_label$ , tab$ , moa_label$ , tab$ , fixed$(con_dur,2) , tab$ , fixed$(burst_dur,2) , tab$ , fixed$(f0[1],2) , tab$ , fixed$(f1_onset[1],2) , tab$, fixed$(f1_mid[1],2) , tab$ , fixed$(f2_onset[1],2), tab$, fixed$(f2_mid[1],2)
      appendInfoLine: tab$, word_label$ , tab$, "2" , tab$, cv_label$ , tab$, fixed$(cv_dur,2) , tab$, poa_label$ , tab$, moa_label$ , tab$, fixed$(con_dur,2) , tab$,fixed$(burst_dur, 2) , tab$, fixed$(f0[2],2) , tab$, fixed$(f1_onset[2],2) , tab$, fixed$(f1_mid[2],2) , tab$, fixed$(f2_onset[2],2), tab$, fixed$(f2_mid[2],2)


      endif
  endfor

endfor
