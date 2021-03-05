*CLINIC TO KEEP
**** drop non-efv or tdf regimens (in observed data) but drop for all imputated datasets
gen drop = _mi_m==0 &  (tdf==0 | efv==0)
bysort pid: egen drop1=max(drop)
drop if drop1==1
drop drop drop1

 
* non imputed dataset:
*keep if _mi_m==0

matrix P = J(20,2,.)
matrix colname P = rsquared sig_model

*** use WHO stage 1 vs 2-4 as a binary variable instead of ordinal 1 2,3,4?
*gen stage1=	fhv_stage_who==1
** generate pscores for each imputed dataset
gen pscore=.
*file open r2 using "r2_males.csv", write replace

 quietly forvalues x=1/20 {
logistic maleclinic  age year cd4   fhv_stage_who    if _mi_m==`x'  
predict pscore`x'  if _mi_m==`x'  
replace pscore=pscore`x' if pscore`x' !=.  
*file write r2 _n "e(r2_p)"
matrix P[`x',1] = e(r2_p)
matrix P[`x',2] = e(p)
} 

matrix list P
/*** display mean of pseudo Rsquared from Pscore models
mata:
Z=st_matrix("P")
mean(Z)
end
 *file close r2
*/
** gen variable for average pscore
bysort _mi_id : egen av_pscore = mean(pscore)
rename pscore pscore_mi
rename av_pscore pscore
drop pscore1 pscore2 pscore3 pscore4 pscore5 pscore6 pscore7 pscore8 pscore9 pscore10 pscore11 pscore12 pscore13 pscore14 pscore15 pscore16 pscore17 pscore18 pscore19 pscore20
** look at distribution of pscore by exposure
hist pscore, by(maleclin)
graph box pscore if _mi_m ==1, by(maleclin)
outsheet maleclinic pscore using "pscores_males_distribution_combined.csv" if _mi_m==1, comma replace
** id

** save


*save males_pscores_imputed_7a, replace
* main model
*save males_pscores_imputed_7a_combined_km_sbm, replace
*no year, dstart
*save males_pscores_imputed_7a_1$exclude, replace
*no year, dstart +era
*save males_pscores_imputed_7a_2$exclude, replace
*no CD4 
*save males_pscores_imputed_7a_3$exclude, replace

**** density plot
/*
twoway (kdensity pscore if malecli==1) (kdensity pscore if malecli==2) ///
 (kdensity pscore if malecli==0, lpattern(dash)), legend(off) ///
 xtitle("propensity score")  ytitle("Density") ///
 graphregion(color(white)) plotregion(color(white)) bgcolor(white) ylab(,nogrid) ///
 title("Full model")   saving(full, replace)

twoway (kdensity pscore if malecli==1) (kdensity pscore if malecli==2) ///
 (kdensity pscore if malecli==0, lpattern(dash)), legend(off) ///
 xtitle("propensity score")  ytitle("Density") ///
 graphregion(color(white)) plotregion(color(white)) bgcolor(white) ylab(,nogrid) ///
 title("No year in model")   saving(no_year, replace)
 
 
 
twoway (kdensity pscore if malecli==1) (kdensity pscore if malecli==2) ///
 (kdensity pscore if malecli==0, lpattern(dash)), legend(off) ///
 xtitle("propensity score")  ytitle("Density") ///
 graphregion(color(white)) plotregion(color(white)) bgcolor(white) ylab(,nogrid) ///
 title("No year or CD4 in model")   saving(nocd4, replace)
 
 
 graph combine full.gph no_year.gph   , title("Propensity Distributions by Exposure - Male Clinic 2")

 
 
