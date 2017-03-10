**Conditional convergence Germany

use "C:\Documents and Settings\user\My Documents\Migrations\data\convergence germany\germanyfertility.dta", clear

gen originalyear=year



drop if year>1911

drop if year==1867
drop if year==1875
drop if year==1885
drop if year==1895
drop if year==1905

replace year=1870 if year==1871

*tsset id year, delta(10)
tsset id year, delta(10)


gen fert_obs= indexoftotalfertilityif

generate chg_fert = (exp(F.fert_obs)-exp(fert_obs))/exp(fert_obs)

xi : reg chg_fert fert_obs i.year


******Histogram 

*histogram fert_obs if year >=1869 & year<1921 & fert_obs<=0.5, kdensity by(year) xscale(range(.1 0.5)) yscale(range(0 50)) yline(15(15)45,lcolor(ltbluishgray)) width(0.0125)

histogram fert_obs if originalyear >=1869 & originalyear<1921 & fert_obs<=0.5, kdensity by(originalyear) xscale(range(.1 0.5)) yscale(range(0 50)) yline(15(15)45,lcolor(ltbluishgray)) width(0.0125)