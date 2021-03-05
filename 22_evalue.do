

*ssc install evalue



*cd "G:\Epidata Share\Patient Data\thesis"

*use  Model_data_11_combined_km_sbm , clear

gen male_inv = 1-maleclinic
** (Doesn't actually matter if you use inverse or maleclinic
stcox male_inv


quietly matrix b =  e(b) 
display (exp(b[1,1]))
display (exp(b[2,1]))
local hr= string(exp(b[1,1]),"%9.2f")
matrix c = e(V)
display (c[1,1])^0.5
display(exp((b[1,1]-1.96*(c[1,1])^0.5)))
local ll=  (exp((b[1,1]-1.96*(c[1,1])^0.5)))
display(exp((b[1,1]+1.96*(c[1,1])^0.5)))
local ul= (exp((b[1,1]+1.96*(c[1,1])^0.5)))
*CI UL-LL

evalue hr `hr', l(`ll') u(`ul') fig

local lim= r(eval_ci) 
local e= r(eval_est) 
**** inverse RR:
display(1/`e')

***inverse CI lim
display(1/`lim')
 
