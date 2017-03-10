
*** Fertility distribution of departments
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear

drop if year <1861
keep if cylin==1
gen ef_obs=exp(f_obs)
*histogram ef_obs, normal xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs)

histogram ef_obs, normal  yscale(range(0 40)) ylabel(0(10)40) xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_fertility.gph", replace

*** COUNTERFACTUAL  No Male and Female Migration IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_t_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__Coal_t_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
keep if cylin==1
*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs)

histogram ef_obs_counterfactual_deor0, normal  yscale(range(0 40)) ylabel(0(10)40) xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs , iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_nomf_mig.gph", replace

*** COUNTERFACTUAL  Only Female Migrants IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_f_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__Coal_f_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
keep if cylin==1

*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs)

histogram ef_obs_counterfactual_deor0, normal  yscale(range(0 40)) ylabel(0(10)40) xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs, iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_onlyf_mig.gph", replace

*** COUNTERFACTUAL  Only male Migrants IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_m_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__Coal_m_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
keep if cylin==1
*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs)

histogram ef_obs_counterfactual_deor0, normal  yscale(range(0 40)) ylabel(0(10)40) xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs, iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_onlym_mig.gph", replace

*** COUNTERFACTUAL  Excluding Migration to Paris -  IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_t_p_SP_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__Coal_t_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
keep if cylin==1
*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs)

histogram ef_obs_counterfactual_deor0, normal  yscale(range(0 40)) ylabel(0(10)40) xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs, iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_exclParis_mig.gph", replace


*****************
 
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_t_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__Coal_t_p_P_migr_lin_var_oldpredict1861.dta", clear

*drop if annee_obs<1871
*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs)
keep if cylin==1

histogram ef_obs_counterfactual_ori0, normal  yscale(range(0 40)) ylabel(0(10)40) xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs , iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_counterfactual_ori0.gph", replace


*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_t_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__Coal_t_p_P_migr_lin_var_oldpredict1861.dta", clear

*drop if annee_obs<1871
*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs)
keep if cylin==1

histogram ef_obs_counterfactual_dest0, normal  yscale(range(0 40)) ylabel(0(10)40) xscale(range(0 0.6)) xlabel(0(0.2)0.6) by(annee_obs , iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_counterfactual_dest0.gph", replace


