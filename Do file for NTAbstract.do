
use "~/Documents/Recherche/2010 Migrations/Construction BDD/Données fécondité/bonneuil.dta", clear
replace var2=v6 if var2==""
rename var2 dpt
replace dptresid = 54 if dpt=="MEURTHE"
replace dptresid = 90 if dpt=="BELFORT"
replace dptresid = 68 if dpt=="RHIN(HAUT-)"
replace dptresid = 67 if dpt=="RHIN(BAS-)"
drop var30 var1 var3 coaleindex1911 v6
reshape long fert_bon, i(dpt) j(year)
rename dptresid id
rename dpt name
drop if fert_bon==.
rename fert_bon indexoftotalfertilityif

gen country="France"

/*
foreach i of numlist 1806 (10) 1906 {
	drop if year==`i'
}
*/

global dir ~/Documents/Recherche/2010 Migrations/do Github/migrations/data

append using "$dir/convergence germany/germanyfertility.dta"
replace country = "Germany" if country==""
append using "$dir/convergence italy/italyfertility.dta"
replace country="Italy" if country==""
append using "$dir/convergence england/englandfertility.dta"
replace country="England & Wales" if country==""
append using "$dir/convergence spain/spainfertility.dta"
replace country="Spain" if country==""

gen originalyear=year

gen fert_obs= indexoftotalfertilityif

replace fert_obs=. if fert_obs==0

keep if year >=1851 & year <=1914


foreach country in Germany Italy England Spain France {
	local graphname graph_`country'
	 if "`country'"=="England" local country="England & Wales"
	vioplot fert_obs if country=="`country'", over(originalyear) title("`country'") name(`graphname', replace) ///
		yscale(range(0.1 0.6)) ylabel(0.1 (0.1) 0.6) ytitle("Coal Fertility Index") ///
		xlabel(, angle(vertical)) /// xscale(range(1851 1911)) xlabel(1851 (10) 1911)
		
		
}

graph combine graph_France graph_England, title("Fertility evolution and dispersion") cols(1)  /// graph_Germany graph_Spain 

graph export "~/Dropbox/Migrations/Graph for NTAbstract.pdf", replace




---------------------

clear
use "~/Documents/Recherche/2010 Migrations/do Github/migrations/data/predict/TRAR__Coal_t_p_P_migr_lin_var_oldpredict1861.dta"
*replace ef_obs=ef_obs*10
*replace ef_obs_predict=ef_obs_predict*10

vioplot ef_obs , over(annee_obs) title("Observed") name(Observed, replace) ///
		yscale(range(0.1 0.6)) ylabel(0.1 (0.1) 0.6) ytitle("Coal Fertility Index") ///
		xlabel(, angle(vertical)) /// xscale(range(1851 1911)) xlabel(1851 (10) 1911)
		
vioplot ef_obs_predict , over(annee_obs) title("Counterfactual") name(Counterfactual, replace) ///
		yscale(range(0.1 0.6)) ylabel(0.1 (0.1) 0.6) ytitle("Coal Fertility Index") ///
		xlabel(, angle(vertical)) /// xscale(range(1851 1911)) xlabel(1851 (10) 1911)

graph combine Observed Counterfactual, title(",,,") cols(1)	
 
