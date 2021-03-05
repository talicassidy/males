

mi stset time, failure(fail)
*mi stset time1, failure(fail1)
    
**-----------KAplan meier curves
	
sts graph if _mi_m==1,  by(maleclin) title("1. Exposure Group") saving(exp, replace) legend( label( 1 "Unexposed") label(  2 "Exposed" ) )   
sts graph if _mi_m==1,  by(fhv_stage)  title("2. WHO stage") legend( label( 1 "1") label(  2 "2" ) label(  3 "3" )  label(  4 "4" ) )  saving(stage, replace)
sts graph if _mi_m==1,  by(agecat)  title("3. Age") legend( label( 1 "18-25") label(  2 "25-25" ) label(  3 "35-45" )  label(  4 "45<" ) ) saving(age, replace)
sts graph if _mi_m==1,  by(cd4cat)  title("4. CD4 count") legend( label( 1 "<200") label( 2 "200-350" ) label(  3 "350-500" )  label(  4 "500<" ) ) saving(cd4, replace)
sts graph if _mi_m==1,  by(era)  title("5. Initiation era") legend( label( 1 "<350") label( 2 "<500" ) label(  3 "no CD4 threshold" ) ) saving(era, replace)
sts graph if _mi_m==1,  by(year)  title("6. Initiation year") legend( label( 1 "2014") label( 2 "2015") label( 3 "2016") label( 4 "2017") label( 5 "2018") ) saving(year, replace)
graph combine exp.gph stage.gph age.gph cd4.gph era.gph year.gph, title("Kaplan Meier Curves by Covariates, #1")
graph export "kaplan_meiers_combined_km_sbm.png", replace

 replace time = time/30.4
mi stset time, failure(fail)
sts graph if _mi_m==1,  tmax(48) graphregion(color(white)) /// 
 by(maleclin) title("Kaplan-Meier Survival Estimates")   ///
 subtitle("Time to attrition by exposure group") xtitle("months") ///
 legend( label( 1 "General clinics") label(  2 "Male clinics" ) region(col(white)) )    ///
plot1(lcolor(navy)) plot2(lcolor(orange)lpattern(dash)) 
graph export "kaplan_meiers_clnic_combined_km_sbm.png", replace




 
 ***** person time 

use  Model_data_11_combined_km_sbm , clear
 drop if case_contr==3
 keep if _mi_m==0
 tab male
 
 replace time = time/365
 tabstat time, statistics(N mean median p25 p75 sum)
  tabstat time, statistics(N mean median p25 p75 sum) by(male)
 
 