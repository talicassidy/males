*** drop those at youth clinics

drop if clinic=="scy"|clinic=="sby"

*** keep adult men only
keep if gender==1
keep if age>18

*** year start
keep if year>2013
keep if dstart<d(1apr2018)

**** drop regimens
*drop if tdf==0 | efv==0

****expand data so that those that weren't imputed are also observations in each dataset
gen n=21 if _mi_miss==0
expand n
bysort _mi_id: gen num=_n if _mi_miss==0
replace num=num-1
replace _mi_m= num if _mi_m==0 & num!=.
** randomise order and number
set seed 1987
gen random= runiform()  if _mi_m==1
sort random
gen id=_n if _mi_m==1 
bysort _mi_id: egen pid=max(id)
**save
