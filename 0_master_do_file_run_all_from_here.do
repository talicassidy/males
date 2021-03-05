cd "directory for data and outputs"

**datasets and outputs in separate folders for male clinic 1 and male clinic 2 and combined analysis

global do_dir= "...directory with other do files"
***********************************************************
** ------------------                    1 

** outcome tables and graphs
*** Note: could move this till after MI now that MI not including whole dataset
use  dataset_full_clean_3_cd4.dta, clear
run "${do_dir}1_describe_outcomes.do"


***********************************************************
** ------------------        2
use  dataset_full_clean_3_cd4.dta, clear

cd males
run "${do_dir}2_MI.do"

save all_imputed.dta, replace

***********************************************************
** ------------------        3
use all_imputed, clear
*** sorts observation in random order so that the can later be matched 1:1 in random order
run "${do_dir}3a_males_data.do"
** crude baseline table of  characteristics
run "${do_dir}3b_male_table_baseline"
*----------------------------------------------------------------------------------------
***************************           choose clinic 
*----------------------------------------------------------------------------------------

*Male clinic 1
*cd sbm
*drop if maleclinic==1 & clinic!= "sbm"
*Male clinic 2
*cd km
*drop if maleclinic==1 & clinic!= "km"
** if combined analysis do not drop or change directory
save males_imputed_6a.dta, replace

***************************************************************
** ------------------        4
use males_imputed_6a, clear
*** generate p scores
run "${do_dir}4a_males_imputed_pscores_combined_kmsbm.do"

save males_pscores_imputed_4a_combined_km_sbm, replace
***************************************************************
** ------------------        5
** match based on pscores
use males_pscores_imputed_4a_combined_km_sbm, clear
tabstat pscore, by(male) statistics(N mean median p25 p75)
run "${do_dir}5a_males_pscore_matching_combined_km_sbm.do"
save cases_controls_matched_combined_km_sbm, replace
***************************************************************
** ------------------        6
clear
use cases_controls_matched_combined_km_sbm
tabstat pscore, by(case) statistics(N mean median p25 p75)

* drop second matched control
drop if case_con ==3
** merge matched controls& exposed with original MI dataset
merge 1:m pid using  males_pscores_imputed_4a_combined_km_sbm
** drop ALL unmatched observations (across all _mi_m)
keep if _merge==3
save merg_match_imputed_6_combined_km_sbm.dta, replace

***************************************************************
** ------------------        7

 use merg_match_imputed_6_combined_km_sbm, clear
run "${do_dir}7a_summary_table_males_CIs.do"
 use merg_match_imputed_6_combined_km_sbm, clear
run "${do_dir}7b_describe_outcomes_matched.do"

***************************************************************
** ------------------        8
use merg_match_imputed_6_combined_km_sbm, clear
run "${do_dir}8a_Cox_prep"
run "${do_dir}8_1a_outcome3_nhls"
save Model_data_8_combined_km_sbm , replace

***************************************************************
** ------------------        9
use  Model_data_8_combined_km_sbm , clear
run "${do_dir}14a_kaplan_meier_curves"
do "${do_dir}14b_person_time_by_clinic"


***************************************************************
** ------------------        10
use  Model_data_8_combined_km_sbm , clear
mi extract 0, clear
replace time=time/365.25
stset time, failure(fail)
*--------------------------------
*drop if pscore_mi ==.
stcox maleclinic

display(   151467/365.25)
** def 2
stset time, failure(fail2)
*--------------------------------
stcox maleclinic

****
 ** Schoenfeld residuals for time dependent covariates
stphtest,  detail
**** GOF TEST
estat phtest
****GRAPHICAL
estat phtest  ,  plot(maleclin) yline(0) xtitle(years)
 graph export "schoenfeld_combined_km_sbm .png" , replace

** ------------------        23   EVALUE
use  Model_data_8_combined_km_sbm , clear
mi extract 0, clear
stset time, failure(fail)
do  "${do_dir}22_evalue"
estat phtest




*** started in beginning of male clinic 1
** male clinic 1 data
use  Model_data_11_combined_km_sbm , clear
mi extract 0, clear
gen k= dstart<d(1jun2016) & clin=="sbm"
bysort n: egen s2014=max(k)
keep if s2014==1
replace fail=0 if dout>=d(1jun2016) & malec==1
replace time=d(1jun2016)-dstart if dout>=d(1jun2016)  & malec==1

replace time=time/30.4
stset time, failure(fail)
stcox maleclinic
