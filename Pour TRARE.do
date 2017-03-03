version 14.2

clear

global dir "~/Documents/Recherche/Migrations/Construction BDD"


use "$dir/Donnees accroissement naturel/Calcul accroissement naturel et relatif 1801-1911.dta", clear
keep dptresid population*

reshape long population,i(dptresid) j(annee)

save "$dir/temp_population.dta", replace






use "~/Documents/Recherche/Migrations/Construction BDD/Donnees TRA/Migr_TRA.dta"

*Mise ensemble des datasets

recast double nbr_TRA

keep if annee <=1851
keep if sexe=="T"
drop sexe

drop if dptresid== 57 | dptresid== 67 |dptresid== 68 |dptresid==99 |dptresid==54 |dptresid==90
drop if dptorigine== 57 | dptorigine== 67 |dptorigine== 68 | dptorigine==99 |dptorigine==54 |dptorigine==90



merge m:1 dptresid annee using "$dir/temp_population.dta"
keep if _merge==3
drop _merge

save "$dir/temp_popu+matr_TRA.dta", replace


***********Puis on passe année par année

foreach annee of num 1851(-10)1821 {
	local annee_after = `annee' + 10
	if `annee'==1851 {
		use "$dir/Donnees migrations/Matrices_TRA_Recens.dta", clear

		keep if annee==1861
		collapse (sum) nbr_TRA_recens,by(annee dptresid dptorigine)

		egen nbr_TRAR_resi=sum(nbr_TRA_recens), by(annee dptresid)


		merge m:1 dptresid annee using "$dir/Données_pour_TRARE.dta"
		drop if _merge==2
		drop _merge

		generate nbr_TRARE_orig_1851 = nbr_TRA_recens*(1+deces_de_vieux/(nbr_TRAR_resi-nbr_de_jeunes))
		replace  nbr_TRARE_orig_1851 = nbr_TRARE_orig_1851 + deces_de_jeunes - naissances_de_jeunes10 if dptorigine==dptresid 
		format * %9.0fc
		
		
	}
	if `annee'<=1841 {
		local annee_after = `annee' + 10
		use "~/Documents/Recherche/Migrations/Construction BDD/temp_Matrices_TRARE_`annee_after'.dta"
		egen nbr_TRARE_resi=sum(nbr_TRARE), by(annee dptresid)
		keep if annee==`annee_after'
		
		merge m:1 dptresid annee using "$dir/Données_pour_TRARE.dta"
		drop if _merge==2
		drop _merge

		generate nbr_TRARE_orig_`annee' = nbr_TRARE*(1+deces_de_vieux/(nbr_TRARE_resi-nbr_de_jeunes))
		replace  nbr_TRARE_orig_`annee' = nbr_TRARE_orig_`annee' + deces_de_jeunes - naissances_de_jeunes10 if dptorigine==dptresid 
		format * %9.0fc
		*if `annee'==1841 blif
		
		
	}
	
	collapse (sum) nbr_TRARE_orig_`annee', by(dptorigine)
	gen annee = `annee'
	rename nbr_TRARE_orig_`annee' nbr_TRARE_orig

	merge 1:m annee dptorigine using "$dir/temp_popu+matr_TRA.dta"
	keep if _merge==3
	drop _merge

	drop if dptresid==74 | dptresid==73 | dptresid==6
	drop if dptorigine==74 | dptorigine==73 | dptorigine==6


	***Le nombre total de natifs calculés par TRARE n'est pas le même que le nombre total de résidents du recensement.
	***Donc je fais une règle de trois pour effacer les "natifs» en trop.
	egen natif_tot = total(nbr_TRARE_orig)
	egen pop_tot = total(population)

	gen population_adj = population * natif_tot/pop_tot

	egen pop_adjtot = total(population_adj)
	assert pop_adjtot== natif_tot

	replace nbr_TRA = 0.001 if nbr_TRA==0

	mstdize nbr_TRA nbr_TRARE_orig population_adj, by(dptorigine dptresid) generate (nbr_TRARE) tol(5)

	keep annee dptorigine dptresid nbr_TRARE

	save "~/Documents/Recherche/Migrations/Construction BDD/temp_Matrices_TRARE_`annee'.dta", replace
}
	
use "~/Documents/Recherche/Migrations/Construction BDD/temp_Matrices_TRARE_1851.dta", replace
erase "~/Documents/Recherche/Migrations/Construction BDD/temp_Matrices_TRARE_1851.dta"

foreach annee of num 1841(-10)1821 {
	append using "~/Documents/Recherche/Migrations/Construction BDD/temp_Matrices_TRARE_`annee'.dta"
	erase "~/Documents/Recherche/Migrations/Construction BDD/temp_Matrices_TRARE_`annee'.dta"
}

gen sexe ="t"
save "$dir/Donnees migrations/Matrices_TRARE.dta", replace

erase "$dir/temp_popu+matr_TRA.dta"
erase "$dir/temp_population.dta" 




