log using "C:\Users\User\Documents\Master_TRAR_TFR_lin_predict_dataconstruction.log",replace

set more off


*******OLS***********************************************************************************
*********************************************************************************************
*** Determinants of the fertility decline in France, 1861-1911: all migrants OLS

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_o_P_migr_lin_var_old.dta", clear

do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_deor0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_P_migr_lin_var_old_predict11861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_ori0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_P_migr_lin_var_old_predict21861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_dest0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_P_migr_lin_var_old_predict31861.dta", replace

                                                              
use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_P_migr_lin_var_old_predict11861.dta", clear
sort yearid
merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_P_migr_lin_var_old_predict21861.dta"
drop _merge 
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_predict1861.dta", replace

merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_P_migr_lin_var_old_predict31861.dta"
drop _merge
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR__TFR_t_o_P_migr_lin_var_oldpredict1861.dta", replace


*********************************************************************************************
*** Determinants of the fertility decline in France, 1861-1911: only men OLS

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_m_o_P_migr_lin_var_old.dta", clear

do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_deor0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_o_P_migr_lin_var_old_predict11861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_m_o_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_ori0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_o_P_migr_lin_var_old_predict21861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_m_o_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_dest0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_o_P_migr_lin_var_old_predict31861.dta", replace


use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_o_P_migr_lin_var_old_predict11861.dta", clear
sort yearid
merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_o_P_migr_lin_var_old_predict21861.dta"
drop _merge 
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_predict1861.dta", replace

merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_o_P_migr_lin_var_old_predict31861.dta"
drop _merge
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR__TFR_m_o_P_migr_lin_var_oldpredict1861.dta", replace

*********************************************************************************************
*** Determinants of the fertility decline in France, 1861-1911: only women OLS

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_f_o_P_migr_lin_var_old.dta", clear

do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_deor0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_o_P_migr_lin_var_old_predict11861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_f_o_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_ori0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_o_P_migr_lin_var_old_predict21861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_f_o_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_dest0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_o_P_migr_lin_var_old_predict31861.dta", replace


use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_o_P_migr_lin_var_old_predict11861.dta", clear
sort yearid
merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_o_P_migr_lin_var_old_predict21861.dta"
drop _merge 
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_predict1861.dta", replace

merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_o_P_migr_lin_var_old_predict31861.dta"
drop _merge
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR__TFR_f_o_P_migr_lin_var_oldpredict1861.dta", replace

*********************************************************************************************
*** Determinants of the fertility decline in France, 1861-1911 excluding migration to and from Seine (Paris and suburbs) OLS

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_o_SP_migr_lin_var_old.dta", clear

do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_deor0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_SP_migr_lin_var_old_predict11861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_o_SP_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_ori0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_SP_migr_lin_var_old_predict21861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_o_SP_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_dest0.do"
*drop _merge
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_SP_migr_lin_var_old_predict31861.dta", replace


use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_SP_migr_lin_var_old_predict11861.dta", clear
sort yearid
merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_SP_migr_lin_var_old_predict21861.dta"
drop _merge 
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_predict1861.dta", replace

merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_o_SP_migr_lin_var_old_predict31861.dta"
drop _merge
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR__TFR_t_o_SP_migr_lin_var_oldpredict1861.dta", replace


*******************************************************
*******************************************************


*******IV***********************************************************************************
*********************************************************************************************
*** Determinants of the fertility decline in France, 1861-1911: all migrants IV

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_p_P_migr_lin_var_old.dta", clear

do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_deor0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_P_migr_lin_var_old_predict11861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_p_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_ori0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_P_migr_lin_var_old_predict21861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_p_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_dest0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_P_migr_lin_var_old_predict31861.dta", replace


use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_P_migr_lin_var_old_predict11861.dta", clear
sort yearid
merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_P_migr_lin_var_old_predict21861.dta"
drop _merge 
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_predict1861.dta", replace

merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_P_migr_lin_var_old_predict31861.dta"
drop _merge
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR__TFR_t_p_P_migr_lin_var_oldpredict1861.dta", replace


*********************************************************************************************
*** Determinants of the fertility decline in France, 1861-1911: only men IV

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_m_p_P_migr_lin_var_old.dta", clear

do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_deor0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_p_P_migr_lin_var_old_predict11861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_m_p_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_ori0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_p_P_migr_lin_var_old_predict21861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_m_p_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_dest0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_p_P_migr_lin_var_old_predict31861.dta", replace


use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_p_P_migr_lin_var_old_predict11861.dta", clear
sort yearid
merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_p_P_migr_lin_var_old_predict21861.dta"
drop _merge 
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_predict1861.dta", replace

merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_m_p_P_migr_lin_var_old_predict31861.dta"
drop _merge
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR__TFR_m_p_P_migr_lin_var_oldpredict1861.dta", replace

*********************************************************************************************
*** Determinants of the fertility decline in France, 1861-1911: only women IV

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_f_p_P_migr_lin_var_old.dta", clear

do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_deor0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_p_P_migr_lin_var_old_predict11861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_f_p_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_ori0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_p_P_migr_lin_var_old_predict21861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_f_p_P_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_dest0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_p_P_migr_lin_var_old_predict31861.dta", replace


use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_p_P_migr_lin_var_old_predict11861.dta", clear
sort yearid
merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_p_P_migr_lin_var_old_predict21861.dta"
drop _merge 
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_predict1861.dta", replace

merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_f_p_P_migr_lin_var_old_predict31861.dta"
drop _merge
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR__TFR_f_p_P_migr_lin_var_oldpredict1861.dta", replace

*********************************************************************************************
*** Determinants of the fertility decline in France, 1861-1911 excluding migration to and from Seine (Paris and suburbs) IV

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_p_SP_migr_lin_var_old.dta", clear

do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_deor0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_SP_migr_lin_var_old_predict11861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_p_SP_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_ori0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_SP_migr_lin_var_old_predict21861.dta", replace

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_p_SP_migr_lin_var_old.dta", clear
do "C:\Users\USER\Documents\Migrations\data\predict\counterfactual_dest0.do"
*drop _merge
drop if yearid==.
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_SP_migr_lin_var_old_predict31861.dta", replace


use "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_SP_migr_lin_var_old_predict11861.dta", clear
sort yearid
merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_SP_migr_lin_var_old_predict21861.dta"
drop _merge 
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR_predict1861.dta", replace

merge 1:1 yearid using "C:\Users\USER\Documents\Migrations\data\predict\TRAR_TFR_t_p_SP_migr_lin_var_old_predict31861.dta"
drop _merge
sort yearid
save "C:\Users\USER\Documents\Migrations\data\predict\TRAR__TFR_t_p_SP_migr_lin_var_oldpredict1861.dta", replace

***************** PANELS
do "C:\Users\User\Documents\Migrations\data\predict\evolution of fertility in France2_TRAR_TFR.do"
do "C:\Users\User\Documents\Migrations\data\predict\evolution of fertility in France2 dest0_TRAR_TFR.do"
do "C:\Users\User\Documents\Migrations\data\predict\evolution of fertility in France2 ori0_TRAR_TFR.do"


***************** HISTOGRAMS

do "C:\Users\User\Documents\Migrations\data\predict\histograms_TRAR_TFR.do"

log close
***************** SUMMARY STATISTICS

do "C:\Users\User\Documents\Migrations\data\predict\sum_TRAR_TFR.do"





clear
