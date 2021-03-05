** ----------------   outcome 3



*** merge back to raw data to get folder numbres
merge m:1 id_data_raw using dataset_full_clean_3_cd4 , gen(merge)
keep if merge==3

rename folder folder_number
merge m:1 folder using "G:\Epidata Share\Patient Data\thesis\sensitivity analysis\data_checks", gen(merge_checks) 

keep if merge_checks!=2
****** CHECK IF NEXT VL beFORE or close to DOUT and at same clinic - then not really a TFO
replace date_next_vl=. if date_next_vl < dout 
replace date_next_vl=. if date_next_vl < dout+30  & clin==facility 
replace date_next_vl=. if clin==facility 

***
gen fail2=fail
replace fail2=0 if date_next - dout <365 

***
