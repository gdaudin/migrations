* Pour faire les matrices de migration TRA compatible avec le recensement
*Deuxième version : août 2012. Doit s'adapter aux nouvelles données + faire méthode intertie plutôt que RAS (?)


version 14.2

clear

use "~/Documents/Recherche/Migrations/Construction BDD/Donnees TRA/Migr_TRA.dta"

*Mise ensemble des datasets

recast double nbr_TRA

replace annee=1871 if annee==1872
rename dptresid dpt
rename annee year
replace sexe=lower(sexe)
joinby dpt year sexe using "~/Documents/Recherche/Migrations/Construction BDD/Marges_migrations_done.dta"
sort dpt
rename dpt dptresid 
keep dptresid dptorigine year sexe immigr_ssAL_recens nbr_TRA



rename dptorigine dpt
joinby dpt year sexe using "~/Documents/Recherche/Migrations/Construction BDD/Marges_migrations_done.dta"
rename dpt dptorigine
gen pop_immob=pop_tot-immigr_ssAL_recens
label var pop_immob "Population totale - les immigrés Français venant d'ailleurs que l'Alsace"

keep dptresid dptorigine year sexe immigr_ssAL_recens emigr_recens_basic pop_immob nbr_TRA

rename immigr_ssAL_recens immigr 
rename emigr_recens_basic emigr
rename year annee


drop if dptresid== 57 | dptresid== 67 |dptresid== 68 |dptresid==99
drop if dptorigine== 57 | dptorigine== 67 |dptorigine== 68 | dptorigine==99
drop if dptresid ==54 & annee==1861
drop if dptresid ==90 & annee==1861
drop if dptorigine==54 & annee==1861
drop if dptorigine==90 & annee==1861



*On scale les émigrants % à la population du dpt d'origine
*En fait, ne sert à rien car cela ne reflate pas plus tard
*generate blouk =nbr_TRA if dptorigine == dptresid
*bys dptorigine annee sexe : egen pop_origine_TRA=max(blouk)
*generate nbr_TRA_reflate = nbr_TRA*pop_origine/pop_origine_TRA
*drop blouk

*Si on ne rajoute pas qqch aux nbr_TRA=0...
*Soucis pour les départements vers lesquels nbr_TRA n'annonce aucun émigrants (5 en 1871, pour les males)
*Dans la méthode CEM, leur nombre se retrouve dans les immigrants vers le département 1
*Alors que dans la méthode RAS, il n'y a pas de transferts...
replace nbr_TRA = 0.001 if nbr_TRA==0





*On se débarasse des ceux qui ne bougent pas
replace nbr_TRA=0 if dptorigin==dptresid

capture restore, not

*Construction de la matrice de mean pour contrainte
foreach i of numlist 1861 1871 1881 1891 1901 1911 {
	foreach j in m f {
	preserve
	keep if annee==`i' & sexe=="`j'" & dptorigine==dptresid
	egen tot_migr=total(emigr)
	drop if dptorigine==1
	drop if dptresid==1
	generate share_emigr=emigr/tot_migr
	generate share_immigr=immigr/tot_migr
	mkmat share_emigr, matrix(blink) rownames(dptorigine) rowprefix(share_emigr_)
	mkmat share_immigr, matrix(blouf) rownames(dptresid) rowprefix(share_immigr_)
	local tot_migr_`i'_`j'=tot_migr
	matrix contraintes_`i'_`j'=blink\blouf
	matrix drop blink blouf	
	restore
	}
}


	


foreach i of numlist 1861 1871  1881 1891 1901 1911 {
	foreach j in m f {
	 	preserve
		keep if annee==`i' & sexe=="`j'"
		
		quietly tabulate dptorigine, generate(dptorigine_)
		quietly tabulate dptresid, generate(dptresid_)
		drop dptorigine_1
		drop dptresid_1
		capture noisily maxentropy dptorigine_* dptresid_*, matrix(contraintes_`i'_`j') prior(nbr_TRA) generate(nbr_TRA_recens_CEM)  total(`tot_migr_`i'_`j'') 
		capture replace nbr_TRA_recens_CEM=pop_origine if dptorigine==dptresid
		drop dptorigine_* dptresid_*
		mstdize nbr_TRA emigr immigr, by(dptorigine dptresid) generate(nbr_TRA_recens_RAS) tol(0.1)
		replace nbr_TRA_recens_RAS=pop_immob if dptorigine==dptresid
		save "~/Documents/Recherche/Migrations/Construction BDD/Donnees migrations/Pour TRA_Recens_`i'_`j'.dta", replace
		restore
	}
	
}




**Avec nbr_TRA_reflate, la méthode RSA ne marche pas :(

use 	"~/Documents/Recherche/Migrations/Construction BDD/Donnees migrations/Pour TRA_Recens_1861_m.dta", clear
append 	using "~/Documents/Recherche/Migrations/Construction BDD/Donnees migrations/Pour TRA_Recens_1861_f.dta"

foreach i of numlist 1871 1881 1891 1901 1911 {
	foreach j in m f {
		append 	using "~/Documents/Recherche/Migrations/Construction BDD/Donnees migrations/Pour TRA_Recens_`i'_`j'.dta"
	}
}


generate ratio = nbr_TRA_recens_CEM/nbr_TRA_recens_RAS
replace ratio=. if ratio==0
summarize ratio
assert r(min)>=0.999 & r(max)<1.001
drop nbr_TRA_recens_CEM
rename nbr_TRA_recens_RAS nbr_TRA_recens


drop ratio
drop    nbr_TRA pop_immob immigr emigr
save "~/Documents/Recherche/Migrations/Construction BDD/Donnees migrations/Matrices_TRA_Recens.dta", replace



