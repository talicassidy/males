
 
 ***** person time 

 drop if case_contr==3
 keep if _mi_m==0
 tab male
 
 replace time = time/365
 tabstat time, statistics(N mean median p25 p75 sum)
  tabstat time, statistics(N mean median p25 p75 sum) by(male)
 
 