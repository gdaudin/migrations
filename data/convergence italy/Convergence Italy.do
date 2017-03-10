**Conditional convergence Italy

use "C:\Documents and Settings\user\My Documents\Migrations\data\convergence italy\italyfertlity.dta", clear



*gen originalyear=year

drop if id==110040
drop if id==110060

drop if year<1871
drop if year>1911


*tsset id year, delta(10)
tsset id year, delta(10)


gen fert_obs= indexoftotalfertilityif

generate chg_fert = (exp(F.fert_obs)-exp(fert_obs))/exp(fert_obs)

xi : reg chg_fert fert_obs i.year


******Histogram 

histogram fert_obs if year >=1869 & year<1921 & fert_obs<=0.5, kdensity by(year) xscale(range(.1 0.5)) yscale(range(0 50)) yline(15(15)45,lcolor(ltbluishgray)) width(0.0125)

