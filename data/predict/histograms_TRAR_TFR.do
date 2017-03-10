
*** Fertility distribution of departments
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_o_P_migr_lin_var_old.dta", clear

drop if year <1861
keep if cylin==1
gen ef_obs=exp(f_obs)
*histogram ef_obs, normal xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs)

histogram ef_obs, normal  yscale(range(0 400)) ylabel(0(100) 400) xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_TFR_fertility.gph", replace

*** COUNTERFACTUAL  No Male and Female Migration IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_t_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__TFR_t_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
keep if cylin==1
*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs)

histogram ef_obs_counterfactual_deor0, normal  yscale(range(0 400)) ylabel(0(100) 400) xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs , iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_TFR_nomf_mig.gph", replace

*** COUNTERFACTUAL  Only Female Migrants IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_f_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__TFR_f_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
keep if cylin==1

*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs)

histogram ef_obs_counterfactual_deor0, normal  yscale(range(0 400)) ylabel(0(100) 400) xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs, iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_TFR_onlyf_mig.gph", replace

*** COUNTERFACTUAL  Only male Migrants IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_m_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__TFR_m_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
keep if cylin==1
*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs)

histogram ef_obs_counterfactual_deor0, normal  yscale(range(0 400)) ylabel(0(100) 400) xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs, iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_TFR_onlym_mig.gph", replace

*** COUNTERFACTUAL  Excluding Migration to Paris -  IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_t_p_SP_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__TFR_t_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
keep if cylin==1
*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs)

histogram ef_obs_counterfactual_deor0, normal  yscale(range(0 400)) ylabel(0(100) 400) xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs, iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_TFR_exclParis_mig.gph", replace


*****************
 
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_t_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__TFR_t_p_P_migr_lin_var_oldpredict1861.dta", clear

*drop if annee_obs<1871
*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs)
keep if cylin==1

histogram ef_obs_counterfactual_ori0, normal  yscale(range(0 400)) ylabel(0(100) 400) xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs , iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_TFR_counterfactual_ori0.gph", replace


*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_t_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear

use "C:\Users\User\Documents\Migrations\data\predict\TRAR__TFR_t_p_P_migr_lin_var_oldpredict1861.dta", clear

*drop if annee_obs<1871
*histogram ef_obs_counterfactual_deor0, normal xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs)
keep if cylin==1

histogram ef_obs_counterfactual_dest0, normal  yscale(range(0 400)) ylabel(0(100) 400) xscale(range(0 0.05)) xlabel(0(0.01)0.05) by(annee_obs , iyaxes ixaxes)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\histogram_TFR_counterfactual_dest0.gph", replace


