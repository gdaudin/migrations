
log using "C:\Users\User\Documents\summary statistics.log",replace


set more off


******** COALE FERTILITY INDEX

*** Determinants of the fertility decline in France, 1861-1911: all migrants (Main Table - Table 2)
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear
gen ef_obs=exp(f_obs)
gen enorme_dest=exp(norme_dest)
gen enorme_ori=exp(norme_ori)
sum ef_obs enorme_dest   enorme_ori p_pop_emigr p_pop_immigr if cylin==1
sum f_obs_min50y  if cylin==1


*use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_P_migr_lin_var_old.dta", clear
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
*do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin.do"



***The fertility decline in France, 1861-1911: only male migration
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_m_o_P_migr_lin_var_old.dta", clear
gen ef_obs=exp(f_obs)
gen enorme_dest=exp(norme_dest)
gen enorme_ori=exp(norme_ori)
sum ef_obs enorme_dest   enorme_ori p_pop_emigr p_pop_immigr if cylin==1
sum f_obs_min50y  if cylin==1


*use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_m_p_P_migr_lin_var_old.dta", clear
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
*do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_m_lin.do"



***The fertility decline in France, 1861-1911: only female migration
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_f_o_P_migr_lin_var_old.dta", clear
gen ef_obs=exp(f_obs)
gen enorme_dest=exp(norme_dest)
gen enorme_ori=exp(norme_ori)
sum ef_obs enorme_dest   enorme_ori p_pop_emigr p_pop_immigr if cylin==1


*use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_f_p_P_migr_lin_var_old.dta", clear
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
*do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_f_lin.do"




***The fertility decline in France, 1861-1911, excluding migration to and from Seine (Paris and suburbs)
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_SP_migr_lin_var_old.dta", clear
gen ef_obs=exp(f_obs)
gen enorme_dest=exp(norme_dest)
gen enorme_ori=exp(norme_ori)
sum ef_obs enorme_dest   enorme_ori p_pop_emigr p_pop_immigr if cylin==1


*use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_SP_migr_lin_var_old.dta", clear
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
*do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_SP_lin.do"


***************** TOTAL FERTILITY RATE

*** Determinants of the fertility decline in France, 1861-1911: all migrants (Main Table - Table 2)
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_o_P_migr_lin_var_old.dta", clear
gen ef_obs=exp(f_obs)
gen enorme_dest=exp(norme_dest)
gen enorme_ori=exp(norme_ori)
sum ef_obs enorme_dest   enorme_ori p_pop_emigr p_pop_immigr if cylin==1

*use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_p_P_migr_lin_var_old.dta", clear
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
*do "C:\Users\User\Documents\Migrations\data\TRAR_TFR_migr_t_lin.do"


***The fertility decline in France, 1861-1911: only male migration
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_m_o_P_migr_lin_var_old.dta", clear
gen ef_obs=exp(f_obs)
gen enorme_dest=exp(norme_dest)
gen enorme_ori=exp(norme_ori)
sum ef_obs enorme_dest   enorme_ori p_pop_emigr p_pop_immigr if cylin==1

*use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_m_p_P_migr_lin_var_old.dta", clear
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
*do "C:\Users\User\Documents\Migrations\data\TRAR_TFR_migr_m_lin.do"



***The fertility decline in France, 1861-1911: only female migration
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_f_o_P_migr_lin_var_old.dta", clear
gen ef_obs=exp(f_obs)
gen enorme_dest=exp(norme_dest)
gen enorme_ori=exp(norme_ori)
sum ef_obs enorme_dest   enorme_ori p_pop_emigr p_pop_immigr if cylin==1

*use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_f_p_P_migr_lin_var_old.dta", clear
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
*do "C:\Users\User\Documents\Migrations\data\TRAR_TFR_migr_f_lin.do"




***The fertility decline in France, 1861-1911, excluding migration to and from Seine (Paris and suburbs)
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_o_SP_migr_lin_var_old.dta", clear
gen ef_obs=exp(f_obs)
gen enorme_dest=exp(norme_dest)
gen enorme_ori=exp(norme_ori)
sum ef_obs enorme_dest   enorme_ori p_pop_emigr p_pop_immigr if cylin==1

*use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_TFR_t_p_SP_migr_lin_var_old.dta", clear
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
*do "C:\Users\User\Documents\Migrations\data\TRAR_TFR_migr_t_SP_lin.do"


** TRARE

*** Determinants of the fertility decline in France, 1821-1911: all migrants 
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRARE_Coal_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"

drop if dptresid==90
drop if dptresid==74
drop if dptresid==73
drop if dptresid==56
drop if dptresid==55
drop if dptresid==54
drop if dptresid==6

gen ef_obs=exp(f_obs)
gen enorme_dest=exp(norme_dest)
gen enorme_ori=exp(norme_ori)
sum ef_obs enorme_dest   enorme_ori p_pop_emigr p_pop_immigr 


******************* CONTROL VARIABLES
***use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear

sum lifeexpectancy15 mortalityratio_1 urban   p_industrie  p_professionsliberales  women_education_10yb men_education_10yb if cylin==1
sum propfillescongreganistes propgarconscongreganistes revuedesdeuxmondes_newsstand if cylin==1
**** 
gen  female_not_recognized=1-femalerecognized
gen  male_not_recognized=1-malerecognized
gen  children_not_recognized=1- childrenrecognized



sum totalnumberofperiodicals eglise egliseorthodoxe templeprotestant if cylin==1
sum childrenoutwedlock children_not_recognized mariesm2024 mariesf2024 mariesm2529 mariesf2529 mariesm3034 mariesf3034 if cylin==1



clear
log close
