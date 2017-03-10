**Conditional convergence

global dir "~/Documents/Recherche/Migrations/Construction BDD"

use "$dir/BDD_var.dta", clear

tsset dptresid annee_obs, delta(10)

generate chg_fert = (exp(F.fert_obs)-exp(fert_obs))/exp(fert_obs)

xi : reg chg_fert fert_obs i.annee

*cd "~/Documents/Recherche/Migrations/Statistiques descriptives/Régression de convergence"

*outreg2 using Convergence, br label excel

