
gen maleclinic= inlist(clin , "km","sbm")
gen youthclinic= inlist(clin, "sby","scy")
drop if clinic=="scy"|clinic=="sby"

* drop 2 missing genders
drop if gender==.

*** keep adult men only
keep if gender==1
keep if age>18

*** year start
keep if year>2013
keep if dstart<d(1apr2018)
***
drop if tdf==0 | efv==0

*keep foldernumber maleclinic exposure cd4 dcd4 firstvl firstvldate lastvl lastvldate fhv_stage_who gender preg_fhv tb_fhv outcome dout dob club visit1 lastvisit clubvisit1 lastclubvisit clubpatient everclubpatient tdf efv clinic age ric3 ric6 ric12 sbm km
keep  id_data_raw year fhv_stage_who age cd4  cd4_date ric6 ric12 maleclinic clin  outcome dout dout1 youthclinic preg_fhv tdf efv gender age dob dstart firstvl firstvldate lastvldate lastvl  visit1 lastvisit clubvisit1 lastclubvisit clubpatient everclubpatient
**eras
*** use WHO stage 1 vs 2-4 as a binary variable instead of ordinal 1 2,3,4?
gen stage1=	fhv_stage_who==1
replace stage1=. if  fhv_stage_who==.

*** outcome and time vars

replace outcome=20 if (dout!=. & dout>d(1april2018))
replace dout=d(1april2018) if (dout==. & outcome==20) | (dout!=. & dout>d(1april2018))
gen time=dout-dstart
gen fail = inlist(outcome, 11, 40, 41)
*****

gen era1=dstart<d(1jan2015)
gen era2=dstart>=d(1jan2015) & dstart<d(1sep2016)
gen era3=dstart>=d(1sep2016)
mi set mlong
*mi misstable summ foldernumber cd4 dcd4 firstvl firstvldate lastvl lastvldate fhv_stage_who gender preg_fhv tb_fhv outcome dout dob club visit1 lastvisit clubvisit1 lastclubvisit clubpatient everclubpatient tdf efv clinic age ric3 ric6 ric12 sbm km
mi misstable summ fhv_stage_who age cd4  ric6 maleclinic age tdf efv gender 
**
mi register imputed fhv_stage_who  cd4 
mi register regular ric6 maleclinic gender youthclinic age dstart time fail
*https://www.ssc.wisc.edu/sscc/pubs/stata_mi_impute.htm
mi impute chained    (ologit) fhv_stage_who (truncreg,ll(0)) cd4  = age time fail era2 era3  dstart  maleclinic  , add(2) rseed(1987)

drop time fail 
*mi impute chained     (truncreg,ll(0)) cd4 (logit) stage1 tdf  efv = age gender year  youthclinic , add(20) rseed(1987)


