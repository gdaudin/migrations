set more off

log using "C:\Users\USER\Documents\Migrations\data\predict\sum_TRAR__Coal_t_o_P_migr_lin_var_oldpredict1861.log", replace
use "C:\Users\USER\Documents\Migrations\data\predict\TRAR__Coal_t_o_P_migr_lin_var_oldpredict1861.dta",clear
do "C:\Users\USER\Documents\Migrations\data\predict\summary statistics counterfactual\pearson.do"
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1861 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1871 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1881 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1891 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1901 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1911 & cylin==1 
log close

log using "C:\Users\USER\Documents\Migrations\data\predict\sum_TRAR__Coal_t_p_P_migr_lin_var_oldpredict1861.log", replace
use "C:\Users\USER\Documents\Migrations\data\predict\TRAR__Coal_t_p_P_migr_lin_var_oldpredict1861.dta",clear
do "C:\Users\USER\Documents\Migrations\data\predict\summary statistics counterfactual\pearson.do"
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1861 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1871 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1881 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1891 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1901 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1911 & cylin==1 
log close

log using "C:\Users\USER\Documents\Migrations\data\predict\sum_TRAR__Coal_f_o_P_migr_lin_var_oldpredict1861.log", replace
use "C:\Users\USER\Documents\Migrations\data\predict\TRAR__Coal_f_o_P_migr_lin_var_oldpredict1861.dta",clear
do "C:\Users\USER\Documents\Migrations\data\predict\summary statistics counterfactual\pearson.do"
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1861 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1871 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1881 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1891 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1901 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1911 & cylin==1 
log close

log using "C:\Users\USER\Documents\Migrations\data\predict\sum_TRAR__Coal_f_p_P_migr_lin_var_oldpredict1861.log", replace
use "C:\Users\USER\Documents\Migrations\data\predict\TRAR__Coal_f_p_P_migr_lin_var_oldpredict1861.dta",clear
do "C:\Users\USER\Documents\Migrations\data\predict\summary statistics counterfactual\pearson.do"
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1861 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1871 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1881 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1891 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1901 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1911 & cylin==1 
log close


log using "C:\Users\USER\Documents\Migrations\data\predict\sum_TRAR__Coal_m_o_P_migr_lin_var_oldpredict1861.log", replace
use "C:\Users\USER\Documents\Migrations\data\predict\TRAR__Coal_m_o_P_migr_lin_var_oldpredict1861.dta",clear
do "C:\Users\USER\Documents\Migrations\data\predict\summary statistics counterfactual\pearson.do"
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1861 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1871 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1881 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1891 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1901 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1911 & cylin==1 
log close

log using "C:\Users\USER\Documents\Migrations\data\predict\sum_TRAR__Coal_m_p_P_migr_lin_var_oldpredict1861.log", replace
use "C:\Users\USER\Documents\Migrations\data\predict\TRAR__Coal_m_p_P_migr_lin_var_oldpredict1861.dta",clear
do "C:\Users\USER\Documents\Migrations\data\predict\summary statistics counterfactual\pearson.do"
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1861 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1871 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1881 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1891 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1901 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1911 & cylin==1 
log close


log using "C:\Users\USER\Documents\Migrations\data\predict\sum_TRAR__Coal_t_o_SP_migr_lin_var_oldpredict1861.log", replace
use "C:\Users\USER\Documents\Migrations\data\predict\TRAR__Coal_t_o_SP_migr_lin_var_oldpredict1861.dta",clear
do "C:\Users\USER\Documents\Migrations\data\predict\summary statistics counterfactual\pearson.do"
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1861 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1871 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1881 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1891 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1901 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1911 & cylin==1 
log close

log using "C:\Users\USER\Documents\Migrations\data\predict\sum_TRAR__Coal_t_p_SP_migr_lin_var_oldpredict1861.log", replace
use "C:\Users\USER\Documents\Migrations\data\predict\TRAR__Coal_t_p_SP_migr_lin_var_oldpredict1861.dta",clear
do "C:\Users\USER\Documents\Migrations\data\predict\summary statistics counterfactual\pearson.do"
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1861 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1871 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1881 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1891 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1901 & cylin==1 
sum ef_obs ef_obs_predict ef_obs_counterfactual_ori0 ef_obs_counterfactual_dest0 ef_obs_counterfactual_deor0 pearsonstat if annee_obs==1911 & cylin==1 
log close


