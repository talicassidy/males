*gen mi_id =_mi_id
*** data can't be in mi set for re-shape (at end) :
mi extract 1, clear
drop if pscore_mi ==.


*-------------
*without replacement
**---------------------------------------------------------------------
** round 1
*-------------------------------------------------
preserve 
drop if malecli ==1
rename pid control_id
rename pscore pscore_control
gen match=1 
keep control_id pscore_control match
save controls_wr_8.dta, replace
restore

drop if malecli==0
keep pid pscore

levelsof pid, local(levels)
foreach l of local levels {
gen match = 1 if pid ==`l'
merge m:m match using controls_wr_8.dta, update
***** drop patients in clinic database that are already matched (for matching without replacement)
duplicates drop control_id if control_id!=., force
****** make variable showing difference between pscores of case and all possible controls
gen difference = abs(pscore-pscore_control)
***************** Identify minimum difference between pscores of case and all possible controls
bysort pid : egen mindiff= min(difference)
***********keep the matched pair with the minimum time difference
keep if mindiff==difference
**************** drop duplicate patients - in case two patients both had the minimum pscore difference, keep only one match
duplicates drop pid, force
drop _merge match difference mindiff  
}
save matched_1,replace

*******
****reshape (for only 1 match
use matched_1, clear
rename pid pid1
rename control_id pid2
rename pscore pscore1
rename pscore_control pscore2
gen n=_n
reshape long pscore pid, i(n) j(case_control)




/**---------------------------------------------------------------------
** round 2
*-------------------------------------------------
** make file of controls that weren't previously matched
use matched_1, replace
append using controls_wr_8
duplicates tag control_id, gen(tag)
keep if tag==0
keep control_id pscore_control match
save controls_wr_8_round2.dta, replace
****************************
**match 2
use matched_1, replace
rename  control_id control_id1
rename pscore_control pscore_control1

levelsof pid, local(levels)
foreach l of local levels {
gen match = 1 if pid ==`l'
merge m:m match using controls_wr_8_round2.dta, update
***** drop patients in clinic database that are already matched (for matching without replacement)
duplicates drop control_id if control_id!=., force
****** make variable showing difference between pscores of case and all possible controls
gen difference = abs(pscore-pscore_control)
***************** Identify minimum difference between pscores of case and all possible controls
bysort pid : egen mindiff= min(difference)
***********keep the matched pair with the minimum time difference
keep if mindiff==difference
**************** drop duplicate patients - in case two patients both had the minimum pscore difference, keep only one match
duplicates drop pid, force
drop _merge match difference mindiff  
}
save matched_2, replace


*** examine distribution of differences

gen diff1 = pscore- pscore_control1
hist diff1
hist diff1, xtitle("Exposed pscore-Unexposed pscore") title("First nearest Neighbour Match")

gen diff2 = pscore- pscore_control
hist diff2, xtitle("Exposed pscore-Unexposed pscore") title("Second nearest Neighbour Match")
**

****reshape
use matched_2, clear
rename pid pid1
rename control_id1 pid2
rename control_id pid3
rename pscore pscore1
rename pscore_control1 pscore2
rename pscore_control pscore3
gen n=_n
reshape long pscore pid, i(n) j(case_control)


*** check success of matching (table one, pscore distribution, common support?)


