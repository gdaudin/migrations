
*À partir de TRAR_migr_t_lin_varbadcontrols.do





set more off

display "`c(username)'"
if strmatch("`c(username)'","*daudin*")==1 {
	global dir "~/Dropbox/Migrations"
	cd "$dir"

}


local source TRAR
*TRAR, TRA ou RE
local sample t
*t, f ou m : total, hommes ou femmes
local instr o
*o (pas instrumenté) ou p (instrumenté)
local controls standard
*none (pas de contrôles) standard (contrôles normaux) bad (tous les contrôles)
local Paris P
*P avec Paris SP sans Paris

capture program drop reg_me
program reg_me
args source sample instr Paris controls
*reg_&_me TRAR t o P standard



use "$dir/files/BDD 130614/BDD_`source'_`sample'_`instr'_`Paris'_migr_lin_var.dta", clear

generate yearid=annee_obs
generate dpt_resid=dptresid


if "`controls'"=="bad" {
	merge 1:1 dpt_resid annee_obs using  "$dir/files/badcontrols.dta"
	drop if _merge==2
}



************D'abord, on change les noms




set more off



*** Table ALL Columns - TRAR - 



tsset  dptresid annee_obs, delta(10)

label drop _all

******************************

label var f_obs "log(Fertility) (t)"
label var lag1_f_obs "log(Fertility) (t-1)"
label var p_industrie "Industries t-1"
label var p_professionsliberales "Professionals (t)"
label var lifeexpectancy15 "Life Expectancy at Age 30 (t)"
label var mortalityratio_1 "Infant Mortality (t)"
label var urban "log(Urban) (t)"
label var lnp_industrie "log(Industries) (t)"
label var lnp_professionsliberales "log(Professionals) (t)"
gen lag1_mortalityratio_1=L1.mortalityratio_1 
label var lag1_mortalityratio_1  "Infant Mortality (t-1)"
gen lag1_urban=L1.urban
label var lag1_urban "log(Urban) (t-1)"
label var lag1_lnp_industrie "log (Industries) (t-1)"
label var lag1_lnp_professionsliberales "log(Professionals) (t-1)"


*******************************

*********************************************************************
gen lag1_lifexpectancy15=L1.lifeexpectancy15
label var lag1_lifexpectancy15 "Life Expectancy Age 15 (t-1)"
label var lifeexpectancy15 "Life Expectancy Age 15 (t)"


*gen lnpropelevescongreganistes=log(propelevescongreganistes)
*gen lnpropfillescongreganistes=log(propfillescongreganistes)
*gen lnpropgarconscongreganistes=log(garconscongreganistes)
label var lnpropelevescongreganistes "log(Share of Pupils in Primary Catholic Schools) (t)"
label var lnpropfillescongreganistes "log(Share of Girls in Primary Catholic Schools) (t)"
label var lnpropgarconscongreganistes "log(Share of Boys in Primary Catholic Schools) (t)"



label var lnwomen_education_10yb "log(Female Education (t))"
label var lag1_lnwomen_education_10yb  "log(Female Education (t-1))"
label var lnmen_education_10yb "log(Male Education (t))"
label var lag1_lnmen_education_10yb "log(Male Education (t-1))"

if "`controls'"=="bad" {

	gen  female_not_recognized=1-femalerecognized
	gen  male_not_recognized=1-malerecognized
	gen  children_not_recognized=1- childrenrecognized

	replace children_not_recognized = log(1+children_not_recognized)
	replace female_not_recognized= log(1+female_not_recognized)
	replace male_not_recognized= log(1+male_not_recognized)


	replace  totalnumberofperiodicals= log(1+ totalnumberofperiodicals)
	replace childrenrecognized = log(1+childrenrecognized)
	replace femalerecognized= log(1+femalerecognized)
	replace malerecognized= log(1+malerecognized)
	replace childrenoutwedlock = log(1+childrenoutwedlock)
	replace femaleoutwedlock = log(1+femaleoutwedlock)
	replace maleoutwedlock = log(1+maleoutwedlock)
	replace mariesf3539= log(1+mariesf3539)
	replace mariesm3539= log(1+mariesm3539)
	replace mariesf3034 = log(1+mariesf3034)
	replace mariesm3034= log(1+mariesm3034)
	replace mariesf2529 = log(1+mariesf2529)
	replace mariesm2529 = log(1+mariesm2529)
	replace mariesf2024 = log(1+mariesf2024)
	replace mariesm2024= log(1+mariesm2024)

}

drop if annee_obs==1841

***Détermine les deux samples
capture : summarize f_obs if annee_obs==1861, det
gen low_fert_1861 = 0
replace low_fert_1861 = 1 if annee_obs==1861 & f_obs <= r(p50)
bys dpt_resid : egen blouk = max(low_fert_1861)
replace low_fert_1861 = blouk
drop blouk
******

local outreg_file results/2ndstage_`source'_`sample'_`instr'_`controls'_`Paris'
rm results/2ndstage_`source'_`sample'_`instr'_`controls'_`Paris'.txt
rm results/2ndstage_`source'_`sample'_`instr'_`controls'_`Paris'.xml


***************************************************************************************************
local var_explicatives norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  i.annee_obs
if "`controls'"=="bad" | "`controls'"=="standard" local var_explicatives `var_explicatives' lifeexpectancy15 mortalityratio_1 urban  /*
	*/lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes
if "`controls'"=="bad"  local var_explicatives `var_explicatives' totalnumberofperiodicals childrenoutwedlock children_not_recognized /*
	*/ mariesm2024 mariesf2024 mariesm2529 mariesf2529 mariesm3034 mariesf3034 mariesm3539 mariesf3539

** Columns 1 & 4


xi: xtreg  f_obs  `var_explicatives' i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
estimates store c
outreg2 using `outreg_file',br addstat(within r2, e(r2), adjusted r2, e(r2_a), f-stat, e(F), prob > f, f) adec(1)   label excel
drop f




** Marginal effects



estimates restore c

foreach i in norme_dest norme_ori lnp_pop_emigr lnp_pop_immigr     {
	quietly summarize `i' if e(sample) 
	local mean`i'=r(mean)
	foreach j of num 0 1 {
		quietly summarize `i' if e(sample) & low_fert_1861==`j'
		if `j'==1 local mean`i'_low_fert  = r(mean)
		if `j'==0 local mean`i'_high_fert = r(mean)
	}	
*display "`i' /// `mean`i''  /// `mean`i'_low_fert'///`mean`i'_high_fert'"
}



display "for norme_dest "
estimates restore c
nlcom _b[norme_dest]+_b[norm_dest_x_lnp_pop]*`meanlnp_pop_emigr', post
outreg2  using `outreg_file', br label excel ctitle("me norm_dest") 




foreach j of num 0 1 {
		estimates restore c
		if `j'==1 nlcom _b[norme_dest]+_b[norm_dest_x_lnp_pop]*`meanlnp_pop_emigr_low_fert', post
		if `j'==1 outreg2  using `outreg_file', br label excel ctitle("me norm_dest-low fert")
		if `j'==0 nlcom _b[norme_dest]+_b[norm_dest_x_lnp_pop]*`meanlnp_pop_emigr_high_fert', post
		if `j'==0 outreg2  using `outreg_file', br label excel ctitle("me norm_dest-high fert")
	}



display "for norme_ori-------------------------"
estimates restore c
nlcom _b[norme_ori ]+_b[norm_ori_x_lnp_pop]*`meanlnp_pop_immigr', post
outreg2  using `outreg_file', br label excel ctitle("me norm_ori") 

foreach j of num 0 1 {
		estimates restore c
		if `j'==1 nlcom _b[norme_ori]+_b[norm_ori_x_lnp_pop]*`meanlnp_pop_immigr_low_fert', post
		if `j'==1 outreg2  using `outreg_file', br label excel ctitle("me norm_ori-low fert")
		if `j'==0 nlcom _b[norme_ori]+_b[norm_ori_x_lnp_pop]*`meanlnp_pop_immigr_high_fert', post
		if `j'==0 outreg2  using `outreg_file', br label excel ctitle("me norm_ori-high fert")
	}





display "for lnp_pop_emigr----------------------"
estimates restore c
nlcom _b[lnp_pop_emigr]+ _b[norm_dest_x_lnp_pop]*`meannorme_dest', post
outreg2  using `outreg_file', br label excel ctitle("me lnp_pop_emigr") 


foreach j of num 0 1 {
		estimates restore c
		if `j'==1 nlcom _b[lnp_pop_emigr]+ _b[norm_dest_x_lnp_pop]*`meannorme_dest_low_fert', post
		if `j'==1 outreg2  using `outreg_file', br label excel ctitle("me lnp_pop_emigr-low fert")
		if `j'==0 nlcom _b[lnp_pop_emigr]+ _b[norm_dest_x_lnp_pop]*`meannorme_dest_high_fert', post
		if `j'==0 outreg2  using `outreg_file', br label excel ctitle("me lnp_pop_emigr-high fert")
	}

display "for lnp_pop_immigr-------------------------"
estimates restore c
nlcom _b[lnp_pop_immigr]+ _b[norm_ori_x_lnp_pop]*`meannorme_ori', post
outreg2  using `outreg_file', br label excel ctitle("me lnp_pop_immigr")



foreach j of num 0 1 {
		estimates restore c
		if `j'==1 nlcom _b[lnp_pop_immigr]+ _b[norm_ori_x_lnp_pop]*`meannorme_ori_low_fert', post
		if `j'==1 outreg2  using `outreg_file', br label excel ctitle("me lnp_pop_immigr-low fert")
		if `j'==0 nlcom _b[lnp_pop_immigr]+ _b[norm_ori_x_lnp_pop]*`meannorme_ori_high_fert', post
		if `j'==0 outreg2  using `outreg_file', br label excel ctitle("me lnp_pop_immigr-high fert")
	}
	
	
	
	
end

*********Appel des programmes
*reg_me TRAR t o P standard
*reg_me TRAR t p P standard
*reg_me TRAR t p P none
*reg_me TRAR t p P bad




*************************





