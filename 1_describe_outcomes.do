gen maleclinic= inlist(clin , "km","sbm")

drop if clinic=="scy"|clinic=="sby"



*** keep adult men only
keep if gender==1
keep if age>18

*** year start
keep if year>2013
keep if dstart<d(1apr2018)

**** drop non-efv or tdf regimens (in observed data)  
drop if (tdf==0 | efv==0)

**era
gen era1=dstart<d(1jan2015)
gen era2=dstart>=d(1jan2015) & dstart<d(1sep2016)
gen era3=dstart>=d(1sep2016)

/* same thing as above, to get same dataset:
cd "D:\Epidata Share\Patient Data\thesis"

use males_imputed_6a, clear
**** drop non-efv or tdf regimens (in observed data) but drop for all imputated datasets
gen drop = _mi_m==0 &  (tdf==0 | efv==0)
bysort pid: egen drop1=max(drop)
drop if drop1==1
drop drop drop1
keep if _mi_m==0
gen exposure = ric12
*replace exposure=2 if clin=="km"
label define out 0 "not RIC by 12 months" 1 "RIC at 12 mnths" 
label values exposure out
*/

global now=date("30 April 2018", "DMY")
****************************
global nowd=c(current_date)




file open scy using "covariates_by_outcome $nowd.csv", write replace

count if ric6!=. 
local n6 = r(N)
count if ric12!=. 
local n12 = r(N)
*file write scy " ART cohort indicators, total RIC in cohort, $total_cohort" _n
file write scy ", Attrition by 6 months, Attrition by 12 months"

file write scy _n ", % (95% CI),  % (95% CI)"
file write scy _n ", N=`n6', N=`n12'"

file write scy _n "Total"
foreach   var in ric6 ric12 {

count if `var' !=. 
local n = r(N)
count if `var' ==0 
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "Year of ART initiation"
file write scy _n "  2014"
foreach  var in ric6 ric12 {
count if `var' !=. & year==2014
local n = r(N)
count if `var' ==0 & year==2014
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "  2015"
foreach  var in ric6 ric12 {
count if `var' !=. & year==2015
local n = r(N)
count if `var' ==0 & year==2015
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "  2016"
foreach   var in ric6 ric12 {
count if `var' !=. & year==2016
local n = r(N)
count if `var' ==0 & year==2016
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "  2017"
foreach  var in ric6 ric12 {
count if `var' !=. & year==2017
local n = r(N)
count if `var' ==0 & year==2017
local ny = r(N)
local p=round(100*`ny'/(`n'))

local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n " Eligibility CD4<350 (before 2015)"
foreach var in ric6 ric12 {
count if `var' !=.  & dstart<d(1jan2015)
local n = r(N)
count if `var' ==0 & dstart<d(1jan2015)
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n " Eligibility CD4<500 (1 jan 2015- 31 Aug 2016)"
foreach var in ric6 ric12 {
count if `var' !=.  & dstart<d(1sep2016)  & dstart>=d(1jan2015)
local n = r(N)
count if `var' ==0 & dstart<d(1sep2016) & dstart>=d(1jan2015)
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "  All eligible (1 Sept 2016)"
foreach   var in ric6 ric12 {
count if `var' !=.  & dstart>=d(1sep2016)
local n = r(N)
count if `var' ==0 & dstart>=d(1sep2016)
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "  After 1 Sept 2016 and CD4<500"
foreach   var in ric6 ric12 {
count if `var' !=.  & dstart>=d(1sep2016) & cd4<500
local n = r(N)
count if `var' ==0 & dstart>=d(1sep2016)  & cd4<500
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}



file write scy _n "Age"
file write scy _n "  18-24 years"
foreach  var in ric6 ric12 {
count if `var' !=.  & age<25
local n = r(N)
count if `var' ==0 &  age<25
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}
file write scy _n "  25-34 years"
foreach  var in ric6 ric12 {
count if `var' !=.  & age>25 & age <=35
local n = r(N)
count if `var' ==0 &  age>25 & age <=35
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n " 35+ years"
foreach  var in ric6 ric12 {
count if `var' !=.  & age>35
local n = r(N)
count if `var' ==0 &  age>35
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}




file write scy _n "WHO stage at initiation"
file write scy _n "  Stage 1"
foreach  var in ric6 ric12 {
count if `var' !=.  & fhv_stage==1
local n = r(N)
count if `var' ==0 & fhv_stage==1
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}



file write scy _n "Stage 2"
foreach  var in ric6 ric12 {
count if `var' !=.  & fhv_stage==2
local n = r(N)
count if `var' ==0 & fhv_stage==2
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}


file write scy _n "Stage 3"
 
foreach  var in ric6 ric12 {
count if `var' !=.  & fhv_stage==3
local n = r(N)
count if `var' ==0 & fhv_stage==3
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}


file write scy _n "Stage 4"

foreach  var in ric6 ric12 {
count if `var' !=.  & fhv_stage==4
local n = r(N)
count if `var' ==0 & fhv_stage==4
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "Stage 2-4"

foreach  var in ric6 ric12 {
count if `var' !=.  & inlist(fhv_stage,2,3,4)
local n = r(N)
count if `var' ==0 & inlist(fhv_stage,2,3,4)
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}


file write scy _n "Stage missing"
foreach  var in ric6 ric12 {
count if `var' !=.  & fhv_stage==.
local n = r(N)
count if `var' ==0 & fhv_stage==.
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}


file write scy _n "Baseline CD4 Count"



file write scy _n "<200"
foreach  var in ric6 ric12 {
count if `var' !=.  & cd4<200
local n = r(N)
count if `var' ==0 &  cd4<200
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}
file write scy _n "200-350 "
foreach  var in ric6 ric12 {
count if `var' !=.  & cd4>=200 & cd4 <350
local n = r(N)
count if `var' ==0 &  cd4>=200 & cd4 <350
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}
file write scy _n "350-500"
foreach  var in ric6 ric12 {
count if `var' !=.  & cd4>=350 & cd4 <=500
local n = r(N)
count if `var' ==0 &  cd4>=350 & cd4 <=500
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n ">500"
foreach  var in ric6 ric12 {
count if `var' !=.  & cd4 >500 & cd4!=.
local n = r(N)
count if `var' ==0 &   cd4 >500  & cd4!=.
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}


file write scy _n "CD4 count missing"
foreach  var in ric6 ric12 {
count if `var' !=.  &  cd4==.
local n = r(N)
count if `var' ==0 &    cd4==.
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "ART Regimen at initiation"
file write scy _n "EFV-free regimens"
foreach  var in ric6 ric12 {
count if `var' !=.  & efv==0
local n = r(N)
count if `var' ==0 &   efv==0
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "TDF-free regimens"
foreach  var in ric6 ric12 {
count if `var' !=.  & tdf==0
local n = r(N)
count if `var' ==0 &   tdf==0
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}
file write scy _n "TDF-EFV regimens"
foreach  var in ric6 ric12 {
count if `var' !=.  & tdf==1 & efv==1
local n = r(N)
count if `var' ==0 &   tdf==1 & efv==1
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "missing regimen information" 
foreach  var in ric6 ric12 {
count if `var' !=.  & (tdf==.|efv==.)
local n = r(N)
count if `var' ==0 &   (tdf==.|efv==.)
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}
file write scy _n "ever in club at clinic"
foreach  var in ric6 ric12 {
count if `var' !=.  &  everclub==1
local n = r(N)
count if `var' ==0 &   everclub==1
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}
file write scy _n "never in club at clinic"
foreach  var in ric6 ric12 {
count if `var' !=.  &  everclub==0
local n = r(N)
count if `var' ==0 &   everclub==0
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
}

file write scy _n "Exposure group"
file write scy _n "Controls"
foreach  var in ric6 ric12 {
count if `var' !=.  &  !inlist(clin, "sbm","km")
local n = r(N)
count if `var' ==0 &    !inlist(clin, "sbm","km")
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
} 

file write scy _n "Male Clinic 1"
foreach  var in ric6 ric12 {
count if `var' !=.  &  inlist(clin, "sbm")
local n = r(N)
count if `var' ==0 &    inlist(clin, "sbm")
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
} 
file write scy _n "Male Clinic 2"
foreach  var in ric6 ric12 {
count if `var' !=.  &  inlist(clin, "km")
local n = r(N)
count if `var' ==0 &    inlist(clin, "km")
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ",`p'%"  
*file write scy ",`p'% (`ll'-`ul')"  
} 


file close scy


twoway (kdensity age if ric12==0) (kdensity age if ric12==1, lpattern(dash)), legend( label( 1 "Attrition 12 mths") label(  2 "In care at 12 mths" ) ) xtitle("Age at ART initiation") title("Density Plot of Age by 12 month Attrition")


twoway (kdensity cd4 if ric12==0) (kdensity cd4 if ric12==1, lpattern(dash)), legend( label( 1 "Attrition 12 mths") label(  2 "In care at 12 mths" ) ) xtitle("CD4 count at ART initiation") title("Density Plot of CD4 count by 12 month Attrition")
graph export  "graph.png", replace

