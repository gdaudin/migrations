**.do pour faire les graphiques


cd "/Users/guillaumedaudin/Documents/Recherche/Migrations/Statistiques descriptives/Graphiques après régression"
use BDD_var_TRAR_predict1861.dta, clear

preserve

drop if efert_obs_counterfactual_p_deor0>=0.5
foreach i in efert_obs_counterfactual_p_deor0 /*counter_IV*/ /*
	*/ efert_obs_counterfactual_deor0 /*counter*/ efert_obs_predict_p /*estim_IV
	*/ efert_obs_predict /*estim*/ efert_obs /*observée*/{
	keep if year>=1861
	
	drop if `i' >= 0.5 | `i'<=0.1
	codebook `i'
	histogram `i', kdensity by(year) xscale(range(.1 0.5)) yscale(range(0 50)) yline(15(15)45,lcolor(ltbluishgray)) width(0.0125)
	graph save `i', replace
}


restore


*histogram efert_obs if year >=1861 & efert_obs<=0.5, kdensity by(year) xscale(range(.1 0.5)) yscale(range(0 50)) yline(15(15)45,lcolor(ltbluishgray)) width(0.0125) 