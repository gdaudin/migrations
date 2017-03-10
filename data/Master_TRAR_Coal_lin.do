log using "C:\Users\User\Documents\Master_TRAR_Coal_lin.log",replace

*** Determinants of the fertility decline in France, 1861-1911: all migrants (Main Table - Table 2)
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin.do"

*** Migration in 1861-1911 and lagged fertility in 1811-1861 (Table 3)
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_fobsmin50y_migr_t_lin.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_fobsmin50y_migr_t_lin.do"


***Migration and the fertility decline, 1861-1911, accounting for newspapers and construction of new buildings of organized religions
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin_robust1.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin_robust1.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin_robust2.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin_robust2.do"


***Migration and the fertility decline, 1861-1911, accounting for out-of-wedlock births, age at marriage 
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin_robust3.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin_robust3.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin_robust4.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lin_robust4.do"




***The fertility decline in France, 1861-1911: only male migration
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_m_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_m_lin.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_m_p_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_m_lin.do"



***The fertility decline in France, 1861-1911: only female migration
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_f_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_f_lin.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_f_p_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_f_lin.do"




***The fertility decline in France, 1861-1911, excluding migration to and from Seine (Paris and suburbs)
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_SP_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_SP_lin.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_SP_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_SP_lin.do"




***Determinants of the fertility decline in France, 1861-1911 – spatial regressions
use "C:\Users\USER\Documents\Migrations\data\distance2_norepetitionbalanced.dta", clear
spmat    idistance  WS latitude_radian longitude_radian , id( dptresid ) dfunction(rhaversine)
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lingeo.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_lingeo.do"


*****Determinants of the fertility decline in France, 1861-1911 – Lagged  Variables
use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_o_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_linlag.do"

use "C:\Users\User\Documents\Migrations\files\BDD 2017 03 03\BDD_TRAR_Coal_t_p_P_migr_lin_var_old.dta", clear
do "C:\Users\User\Documents\Migrations\data\variabledefs.do"
do "C:\Users\User\Documents\Migrations\data\TRAR_Coal_migr_t_linlag.do"




clear mata
clear matrix
clear
log close
