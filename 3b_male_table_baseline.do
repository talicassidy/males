global nowd=c(current_date)

keep if _mi_m==0
drop if tdf==0 | efv==0
label define male 0 "general clinics" 1 "Male Clinic 1" 2 "Male Clinic 2" 
gen exposure = maleclin
*if separating two male clinics:
replace exposure=2 if clin=="km"

 file open scy using "baseline_vars_$nowd .csv", write replace
**-----



*twoway (kdensity pscore if exposure==1) (kdensity pscore if exposure==0, lpattern(dash)), legend( label( 1 "Exposed") label(  2 "Unexposed" ) ) xtitle("propensity score") title("Density Plot of Propensity Scores After Matching ($exclude )")
label values exposure male
*file write scy " ART cohort indicators, total RIC in cohort, $total_cohort" _n
levelsof exposure, local(levels)
foreach l of local levels {
local lbe : value label exposure
local vlabel : label `lbe' `l'
file write scy ",`vlabel'"
}

file write scy _n "N"
foreach l of local levels {

count if exposure ==`l'
local n = r(N)
file write scy ",`n'" 
}

file write scy _n "Year of ART initiation, % (95% CI)"
file write scy _n "  2014"
foreach l of local levels {
count if exposure ==`l'  
local n = r(N)
count if exposure ==`l' & year==2014
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n " 2015"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & year==2015
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n "  2016"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & year==2016
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n " 2017"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & year==2017
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}
file write scy _n " 2018"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & year==2018
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}



file write scy _n "  After 1 Sept 2016"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & dstart>=d(1sep2016)
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}


file write scy _n "Age, % (95% CI)"




file write scy _n "  18-24 years"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l' &  age<25
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}
file write scy _n "  25-34 years"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l' &  age>25 & age <=35
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n "  35+ years"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l' &  age>35
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n "Median age (years) (IQR)"
foreach l of local levels {
summ age if exposure ==`l', d
local median=round(r(p50),.1)
local p25=round(r(p25),.1)
local p75=round(r(p75),.1)
file write scy ",`median' (`p25'-`p75')" 
}




/*
file write scy _n "N (%) on TB treatment at start of ART treatment"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & tb_fhv==1 
local ny = r(N)
local p=round(100*`ny'/(`n'))
file write scy ",`ny' (`p'%)" 
}
*/
file write scy _n "Baseline WHO stage, % (95% CI)"
file write scy _n "  Stage 1"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & fhv_stage==1
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n "  Stage 2"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & fhv_stage==2
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n " Stage 3"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & fhv_stage==3
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n "  Stage 4"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & fhv_stage==4
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n "  Stage 2-4"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & inlist(fhv_stage,2,3,4)
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n " Stage missing"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & fhv_stage==.
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}


file write scy _n "Baseline CD4 Count (cells/mm3) , % (95% CI)"






file write scy _n " <200"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l' &  cd4<200
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}
file write scy _n " 200-349 "
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l' &  cd4>=200 & cd4 <350
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}
file write scy _n " 350-500"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l' &  cd4>=350 & cd4 <=500
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n "  >500"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l' &   cd4 >500  & cd4!=.
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}



file write scy _n "  Missing"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & cd4==.
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n "Median CD4 count (IQR)"
foreach l of local levels {
summ cd4 if exposure ==`l', d
local median=round(r(p50),.1)
local p25=round(r(p25),.1)
local p75=round(r(p75),.1)
*file write scy ", `p'% " 
file write scy ",`median' (`p25'-`p75')" 
}


file write scy _n "N (%) starting on EFV-free regimens"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & efv==0
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n "N (%) starting on TDF-free regimens"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & tdf==0
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}
file write scy _n "N (%) missing regimen information"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & (tdf==.|efv==.)
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}

file write scy _n "N (%) ever in club at clinic"
foreach l of local levels {
count if exposure ==`l'
local n = r(N)
count if exposure ==`l'  & everclub==1
local ny = r(N)
local p=round(100*`ny'/(`n'))
local ll = round( 100*  (`ny'/(`n')-1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ll')
local ul = round( 100*  (`ny'/(`n')+1.96*((`ny'/(`n'))*(1-`ny'/(`n'))/`n')^0.5))
display(`ul')
file write scy ", `p'% " 
*file write scy ", `p'% (`ll'-`ul')" 
}



file close scy

