


*** COUNTERFACTUAL  No Male and Female Migration IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_t_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear
use "C:\Users\User\Documents\Migrations\data\predict\TRAR__TFR_t_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
sort annee_obs
keep if cylin==1
*
by annee_obs: egen mef_obs=mean(ef_obs)
by annee_obs: egen sdef_obs=sd(ef_obs)
gen f_obshighsd=mef_obs+sdef_obs
gen f_obslowsd=mef_obs-sdef_obs
*
by annee_obs: egen mef_obs_predict=mean(ef_obs_predict) 
*
by annee_obs: egen mef_obs_counterfactual_deor0=mean(ef_obs_counterfactual_deor0)
by annee_obs: egen sdef_obs_counterfactual_deor0=sd(ef_obs_counterfactual_deor0)
gen f_obs_counterfactual_deor0highsd=mef_obs_counterfactual_deor0+sdef_obs_counterfactual_deor0
gen f_obs_counterfactual_deor0lowsd=mef_obs_counterfactual_deor0-sdef_obs_counterfactual_deor0
*
drop if annee_obs<1871
*
*graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(black)) (line mef_obs_predict annee_obs, lpattern(dash_dot) lcolor(black)) (line mef_obs_counterfactual_deor0 annee_obs, lwidth(thick) lpattern(solid) lcolor(black)) (line f_obs_counterfactual_deor0lowsd annee_obs, lpattern(dot)  lcolor(black)) (line f_obs_counterfactual_deor0highsd annee_obs, lpattern(dot)  lcolor(black)), legend(label(1 Actual fertility)) legend(label(2 Predicted fertility)) legend(label(3 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0.2 0.32)) ylabel(0.2 (0.05) 0.3)
graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(red))  (line mef_obs_counterfactual_deor0 annee_obs,  lpattern(solid) lcolor(blue))  (line f_obs_counterfactual_deor0lowsd annee_obs, lpattern( shortdash)  lcolor(black)) (line f_obs_counterfactual_deor0highsd annee_obs, lpattern(shortdash)  lcolor(black)), legend(label(1 Actual fertility))  legend(label(2 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0.02 0.04)) ylabel(0.02 (0.005) 0.04)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\Graph_TFR_nofm_mig2.gph", replace
*graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(red))  (line mef_obs_counterfactual_deor0 annee_obs,  lpattern(solid) lcolor(blue))  (line f_obs_counterfactual_deor0lowsd annee_obs, lpattern( shortdash)  lcolor(black)) (line f_obs_counterfactual_deor0highsd annee_obs, lpattern(shortdash)  lcolor(black)), legend(label(1 Actual fertility))  legend(label(2 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0 0.4)) ylabel(0 (0.05) 0.4)
*graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\Graph_TFR_nofm_mig2b.gph", replace

*** COUNTERFACTUAL  Only Female Migrants IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_f_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear
use "C:\Users\User\Documents\Migrations\data\predict\TRAR__TFR_f_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
sort annee_obs
keep if cylin==1
*
by annee_obs: egen mef_obs=mean(ef_obs)
by annee_obs: egen sdef_obs=sd(ef_obs)
gen f_obshighsd=mef_obs+sdef_obs
gen f_obslowsd=mef_obs-sdef_obs
*
by annee_obs: egen mef_obs_predict=mean(ef_obs_predict) 
*
by annee_obs: egen mef_obs_counterfactual_deor0=mean(ef_obs_counterfactual_deor0)
by annee_obs: egen sdef_obs_counterfactual_deor0=sd(ef_obs_counterfactual_deor0)
gen f_obs_counterfactual_deor0highsd=mef_obs_counterfactual_deor0+sdef_obs_counterfactual_deor0
gen f_obs_counterfactual_deor0lowsd=mef_obs_counterfactual_deor0-sdef_obs_counterfactual_deor0
*
drop if annee_obs<1871
*
*graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(black)) (line mef_obs_predict annee_obs, lpattern(dash_dot) lcolor(black)) (line mef_obs_counterfactual_deor0 annee_obs, lwidth(thick) lpattern(solid) lcolor(black)), legend(label(1 Actual fertility)) legend(label(2 Predicted fertility)) legend(label(3 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0.2 0.32)) ylabel(0.2 (0.05) 0.3)
graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(red))  (line mef_obs_counterfactual_deor0 annee_obs,  lpattern(solid) lcolor(blue))  (line f_obs_counterfactual_deor0lowsd annee_obs, lpattern( shortdash)  lcolor(black)) (line f_obs_counterfactual_deor0highsd annee_obs, lpattern(shortdash)  lcolor(black)), legend(label(1 Actual fertility))  legend(label(2 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0.02 0.04)) ylabel(0.02 (0.005) 0.04)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\Graph_TFR_onlyf_mig2.gph", replace
*graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(red))  (line mef_obs_counterfactual_deor0 annee_obs,  lpattern(solid) lcolor(blue))  (line f_obs_counterfactual_deor0lowsd annee_obs, lpattern( shortdash)  lcolor(black)) (line f_obs_counterfactual_deor0highsd annee_obs, lpattern(shortdash)  lcolor(black)), legend(label(1 Actual fertility))  legend(label(2 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0 0.4)) ylabel(0 (0.05) 0.4)
*graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\Graph_TFR_onlyf_mig2b.gph", replace




*** COUNTERFACTUAL  Only male Migrants IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_m_p_P_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear
use "C:\Users\User\Documents\Migrations\data\predict\TRAR__TFR_m_p_P_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
sort annee_obs
keep if cylin==1

by annee_obs: egen mef_obs=mean(ef_obs)
by annee_obs: egen sdef_obs=sd(ef_obs)
gen f_obshighsd=mef_obs+sdef_obs
gen f_obslowsd=mef_obs-sdef_obs
*
by annee_obs: egen mef_obs_predict=mean(ef_obs_predict) 
*
by annee_obs: egen mef_obs_counterfactual_deor0=mean(ef_obs_counterfactual_deor0)
by annee_obs: egen sdef_obs_counterfactual_deor0=sd(ef_obs_counterfactual_deor0)
gen f_obs_counterfactual_deor0highsd=mef_obs_counterfactual_deor0+sdef_obs_counterfactual_deor0
gen f_obs_counterfactual_deor0lowsd=mef_obs_counterfactual_deor0-sdef_obs_counterfactual_deor0
*
drop if annee_obs<1871
*
*graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(black)) (line mef_obs_predict annee_obs, lpattern(dash_dot) lcolor(black)) (line mef_obs_counterfactual_deor0 annee_obs, lwidth(thick) lpattern(solid) lcolor(black)), legend(label(1 Actual fertility)) legend(label(2 Predicted fertility)) legend(label(3 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0.2 0.32)) ylabel(0.2 (0.05) 0.3)
graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(red))  (line mef_obs_counterfactual_deor0 annee_obs,  lpattern(solid) lcolor(blue))  (line f_obs_counterfactual_deor0lowsd annee_obs, lpattern( shortdash)  lcolor(black)) (line f_obs_counterfactual_deor0highsd annee_obs, lpattern(shortdash)  lcolor(black)), legend(label(1 Actual fertility))  legend(label(2 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0.02 0.04)) ylabel(0.02 (0.005) 0.04)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\Graph_TFR_onlym_mig2.gph", replace
*graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(red))  (line mef_obs_counterfactual_deor0 annee_obs,  lpattern(solid) lcolor(blue))  (line f_obs_counterfactual_deor0lowsd annee_obs, lpattern( shortdash)  lcolor(black)) (line f_obs_counterfactual_deor0highsd annee_obs, lpattern(shortdash)  lcolor(black)), legend(label(1 Actual fertility))  legend(label(2 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0 0.4)) ylabel(0 (0.05) 0.4)
*graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\Graph_TFR_onlym_mig2b.gph", replace



*** COUNTERFACTUAL  Excluding Migration to Paris -  IV Fertility distribution of departments
*use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_t_p_SP_migr_lin_varbadcontrols_counterfactual1861\TRAR_predict1861.dta", clear
use "C:\Users\User\Documents\Migrations\data\predict\TRAR__TFR_t_p_SP_migr_lin_var_oldpredict1861.dta", clear

drop if annee_obs<1861
sort annee_obs
keep if cylin==1
*
by annee_obs: egen mef_obs=mean(ef_obs)
by annee_obs: egen sdef_obs=sd(ef_obs)
gen f_obshighsd=mef_obs+sdef_obs
gen f_obslowsd=mef_obs-sdef_obs
*
by annee_obs: egen mef_obs_predict=mean(ef_obs_predict) 
*
by annee_obs: egen mef_obs_counterfactual_deor0=mean(ef_obs_counterfactual_deor0)
by annee_obs: egen sdef_obs_counterfactual_deor0=sd(ef_obs_counterfactual_deor0)
gen f_obs_counterfactual_deor0highsd=mef_obs_counterfactual_deor0+sdef_obs_counterfactual_deor0
gen f_obs_counterfactual_deor0lowsd=mef_obs_counterfactual_deor0-sdef_obs_counterfactual_deor0
*
drop if annee_obs<1871
*
*graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(black)) (line mef_obs_predict annee_obs, lpattern(dash_dot) lcolor(black)) (line mef_obs_counterfactual_deor0 annee_obs, lwidth(thick) lpattern(solid) lcolor(black)), legend(label(1 Actual fertility)) legend(label(2 Predicted fertility)) legend(label(3 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0.2 0.32)) ylabel(0.2 (0.05) 0.3)
graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(red))  (line mef_obs_counterfactual_deor0 annee_obs,  lpattern(solid) lcolor(blue))  (line f_obs_counterfactual_deor0lowsd annee_obs, lpattern( shortdash)  lcolor(black)) (line f_obs_counterfactual_deor0highsd annee_obs, lpattern(shortdash)  lcolor(black)), legend(label(1 Actual fertility))  legend(label(2 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0.02 0.04)) ylabel(0.02 (0.005) 0.04)
graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\Graph_TFR_exclParis_mig2.gph", replace
*graph twoway (line mef_obs annee_obs, lpattern(solid)  lcolor(red))  (line mef_obs_counterfactual_deor0 annee_obs,  lpattern(solid) lcolor(blue))  (line f_obs_counterfactual_deor0lowsd annee_obs, lpattern( shortdash)  lcolor(black)) (line f_obs_counterfactual_deor0highsd annee_obs, lpattern(shortdash)  lcolor(black)), legend(label(1 Actual fertility))  legend(label(2 Counterfactual fertility)) xscale(range(1871 1911)) xlabel(1871(10)1911) yscale(range(0 0.4)) ylabel(0 (0.05) 0.4)
*graph save Graph "C:\Users\USER\Documents\Migrations\data\predict\Graph_TFR_exclParis_mig2b.gph", replace
