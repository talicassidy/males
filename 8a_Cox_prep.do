
** tabulate covariates and outcomes (ric6 and 12?)


replace outcome=20 if (dout!=. & dout>d(1april2018))
replace dout=d(1april2018) if (dout==. & outcome==20) | (dout!=. & dout>d(1april2018))
gen time=dout-dstart
gen fail = inlist(outcome, 11, 40, 41)

**---------------------outcome 2
*
gen fail1 = (inlist(outcome, 11, 40, 41) ) | (dout1!=.)
replace dout1= dout if  dout1==. 
gen time1=dout1-dstart

*** make cateogrical  vars
**-------------------------------------------------------------------------

*******************************************************



**ERA
gen era = 1 if dstart<d(1jan2015)
replace era = 2 if dstart>=d(1jan2015) & dstart<d(1sep2016)
replace era = 3 if dstart>=d(1sep2016)
label define era 1 "<350" 2 "<500" 3 "UTT"
label values era era
	
*** CD4 
gen cd4cat = 1 if cd4<200
replace cd4cat = 2 if cd4>=200 & cd4<350
replace cd4cat = 3 if cd4>=350 & cd4<500
replace cd4cat = 4 if cd4>=500

label define cd4cat 1 "<200" 2 "200-350" 3 "350-500" 4 ">500"
	label values cd4cat cd4cat
	
** age
gen agecat = 1 if age<25
replace agecat = 2 if age>=25 & age<35
replace agecat = 3 if age>=35 & age<45
replace agecat = 4 if age>=45

label define agecat 1 "<25" 2 "25-35" 3 "35-45" 4 ">45"
	label values agecat agecat
**---------------------------------------------------




 **----------------------------------------------------
 ********     assumptions : https://stats.idre.ucla.edu/stata/seminars/stata-survival/ 
 **----------------------------------------------------
 




