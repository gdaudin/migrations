**Conditional convergence England and Wales

use "C:\Documents and Settings\user\My Documents\Migrations\data\convergence england\englandfertility.dta", clear

drop if year>1911

tsset id year, delta(10)

gen fert_obs= indexoftotalfertilityif

generate chg_fert = (exp(F.fert_obs)-exp(fert_obs))/exp(fert_obs)

xi : reg chg_fert fert_obs i.year
