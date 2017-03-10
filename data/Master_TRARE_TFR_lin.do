log using "C:\Users\User\Documents\Master_TRARE_TFR_lin.log",replace

*** Determinants of the fertility decline in France, 1821-1911: all migrants 
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRARE_TFR_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"

drop if dptresid==90
drop if dptresid==74
drop if dptresid==73
drop if dptresid==56
drop if dptresid==55
drop if dptresid==54
drop if dptresid==6


do "C:\Users\User\Documents\Migrations\data\TRARE_TFR_migr_t_lin.do"


***The fertility decline in France, 1821-1911: only male migration
*use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRARE_TFR_m_o_P_migr_lin_var_old.dta", clear
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
*do "C:\Users\User\Documents\Migrations\data\TRARE_TFR_migr_f_lin.do"

***The fertility decline in France, 1821-1911: only female migration
*use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRARE_TFR_f_o_P_migr_lin_var_old.dta", clear
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
*do "C:\Users\User\Documents\Migrations\data\TRARE_TFR_migr_f_lin.do"

***The fertility decline in France, 1821-1911, excluding migration to and from Seine (Paris and suburbs)
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRARE_TFR_t_o_SP_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"

drop if dptresid==90
drop if dptresid==74
drop if dptresid==73
drop if dptresid==56
drop if dptresid==55
drop if dptresid==54
drop if dptresid==6

do "C:\Users\User\Documents\Migrations\data\TRARE_TFR_migr_t_SP_lin.do"

clear
log close
