*Dans ce programme, nous essayons de compléter TRAR pour les périodes 1851-1811.
*Le souci est que nous n'avons pas de % d'immigrants pour ces périodes
*Donc nous allons essayer de l'estimer à partir des données TRA
*Puis faire du RAS (dans un autre programme)


**Les résidents dans chaque département à chaque recensement : pas de soucis, ils sont donnés par le recensement.
**Les natifs de chaque département à chaque recensement : difficile.
**natifs(61)=natifs(51)*-décès des natifs du département (y compris les migrants et les nouvelles naissances) + naissances dans le département entre 51 et 60*

*natifs(61) : on l'a
*naissances dans le département entre 51 et 60 : on l'a

*décès des natifs du département = décès des natifs dans le département + décès des natifs hors du département

*décès des natifs dans le département = décès des gens âgés 0-20 dans le département + décès des natifs de plus de 20 ans partout en France (donc les résidents + les émigrants)

*décès des gens âgés 0-20 dans le département = On va prendre les naissances et appliquer le taux de survie de Bonneuil.
*décés des gens âgés de plus de 20 ans dans chaque département = décès totaux - décès des gens âgés 0-20 dans le département
*Tx de mortalité des plus de 20 ans = décés des gens âgés de plus de 20 ans dans chaque département / (population totale-population de moins de 20 ans survivant)
*population de moins de 20 ans survivant = nombre de naissance et appliquer le taux de survie de Bonneuil

*décès des natifs résidents de plus de 20 dans le département = tx de mortalité des plus de 20 ans * nombre de stayers de plus de 20 ans



*décès des natifs émigrants  = somme par département (des tx de mortalité des plus de 20 ans * nombre de immigrés de plus de 20 ans)

*On fait l'hypothès que la structure par age des migrants est la même que celle de la population de + de 20 ans et qu'ils sont soumis au même risque de mortalité.




global dir "~/Documents/Recherche/Migrations/Construction BDD"



*Importation des naissances de 5 ans en 5 ans
import excel using "$dir/Données fécondité/naissances deces 1801-1861 par 5 ans.xlsx", cellrange(A9:DZ100) firstrow sheet(final) clear

keep dptresid naissance*
drop naissances18011805-naissances18561860
drop in 1
*replace naissances1805=  naissances1805/100*365
**Le résultat est systématiquement trop faible
replace naissances1805= (naissances1804+naissances1806)/2

reshape long naissances, i(dptresid) j(annee_naissance)	
rename dptresid dpt_num

save "$dir/temp_naissances.dta", replace

import excel using "$dir/Données Mortalité/Mortalité Bonneuil.xls", cellrange(B4:E31514) firstrow  clear

rename t annee
rename C dpt_nom
rename x tranche_age
rename qx quotien_mort

drop if annee >=1870
replace dpt_nom = "COTE-D'OR" if dpt_nom=="COTE-D-OR"
drop if dpt_nom=="FRANCE"
replace dpt_nom="MEURTHE/MEURTHE-ET-MOSELLE" if dpt_nom=="MEURTHE" 
replace dpt_nom="RHIN(HAUT-)/TERRITOIRE DE BELFORT" if dpt_nom=="RHIN(HAUT-)" 

merge m:1 dpt_nom using "$dir/Dpt Noms-Nums.dta"
display "Il faut que tout soit matched (3)"
tab _merge
drop _merge 
drop dpt_nom
sort dpt_num tranche_age annee

gen annee_naissance = annee - tranche_age 

drop annee
drop if tranche_age >= 20
keep if annee_naissance <= 1861

reshape wide quotien_mort,i(annee_naissance dpt_num) j(tranche_age)



save "$dir/temp_mort.dta", replace

merge 1:1 annee_naissance dpt_num using "$dir/temp_naissances.dta"
drop _merge
erase "$dir/temp_naissances.dta"



gen quotien_mort0_1 = quotien_mort0/2
gen quotien_mort1_4 = quotien_mort0/2
drop quotien_mort0



tsset dpt_num annee_naissance


foreach var of varlist quotien_mort* {
	foreach annee of num 1802(5)1857 {
		replace `var' = L.`var' if annee_naissance==`annee'
	}
	foreach annee of num 1803(5)1858 {
		replace `var' = L2.`var' if annee_naissance==`annee'
	}
	foreach annee of num 1804(5)1859 {
		replace `var' = F2.`var' if annee_naissance==`annee'
	}
	foreach annee of num 1805(5)1860 {
		replace `var' = F.`var' if annee_naissance==`annee'
	}
}
		

gen deces_de_jeunes_1851_1860 = 0
gen deces_de_jeunes_1841_1850 = 0
gen deces_de_jeunes_1831_1840 = 0
gen deces_de_jeunes_1821_1830 = 0
gen deces_de_jeunes_1811_1820 = 0
		
		
*On va supposer : on va supposer que le quotien de mortalité entre 0 et 1 est égal à celui entre 1 et 4
*Dupaquier, p. 287 t. III

		
foreach end_per of num 1860(-10)1820 {

	local start_per = `end_per'-9
	
	gen naissances_de_jeunes_`start_per'_`end_per'=naissances if annee_naissance<=`end_per' & annee_naissance>`end_per'-20
	
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort0_1  if annee_naissance>=`start_per' & annee_naissance<=`end_per'
	
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort1_4/4 if annee_naissance>=`start_per'-1 & annee_naissance<=`end_per'-1
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort1_4/4 if annee_naissance>=`start_per'-2 & annee_naissance<=`end_per'-2
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort1_4/4 if annee_naissance>=`start_per'-3 & annee_naissance<=`end_per'-3
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort1_4/4 if annee_naissance>=`start_per'-4 & annee_naissance<=`end_per'-4
	
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort5/5 if annee_naissance>=`start_per'-5 & annee_naissance<=`end_per'-5
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort5/5 if annee_naissance>=`start_per'-6 & annee_naissance<=`end_per'-6
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort5/5 if annee_naissance>=`start_per'-7 & annee_naissance<=`end_per'-7
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort5/5 if annee_naissance>=`start_per'-8 & annee_naissance<=`end_per'-8
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort5/5 if annee_naissance>=`start_per'-9 & annee_naissance<=`end_per'-9
	
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort10/5 if annee_naissance>=`start_per'-10 & annee_naissance<=`end_per'-10
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort10/5 if annee_naissance>=`start_per'-10 & annee_naissance<=`end_per'-11
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort10/5 if annee_naissance>=`start_per'-10 & annee_naissance<=`end_per'-12
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort10/5 if annee_naissance>=`start_per'-10 & annee_naissance<=`end_per'-13
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort10/5 if annee_naissance>=`start_per'-10 & annee_naissance<=`end_per'-14
	
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort15/5 if annee_naissance>=`start_per'-10 & annee_naissance<=`end_per'-15
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort15/5 if annee_naissance>=`start_per'-10 & annee_naissance<=`end_per'-16
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort15/5 if annee_naissance>=`start_per'-10 & annee_naissance<=`end_per'-17
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort15/5 if annee_naissance>=`start_per'-10 & annee_naissance<=`end_per'-18
	replace deces_de_jeunes_`start_per'_`end_per' = deces_de_jeunes_`start_per'_`end_per'+naissances*quotien_mort15/5 if annee_naissance>=`start_per'-10 & annee_naissance<=`end_per'-19

}
		
	
	
collapse (sum) deces_de_jeunes* naissances_de_jeunes*, by(dpt_num)
format * %9.0fc
blif


foreach annee of num 1821(10)1861 {

	local start_per = `annee'-10
	local end_per = `annee'-1
	
	gen nbr_de_jeunes_`annee' = naissances_de_jeunes_`start_per'_`end_per'-deces_de_jeunes_`start_per'_`end_per'
}

keep dpt_num deces_de_jeunes* nbr_de_jeunes* naissances_de_jeunes_*


*****Nous avons obtenu le nbr de jeunes (donc stayers) vivant dans chaque département à chaque recensement
save "$dir/temp_nbr_&deces_de_jeunes.dta", replace
erase  "$dir/temp_mort.dta"


import excel using "$dir/Données fécondité/naissances deces 1801-1861 par 5 ans.xlsx", cellrange(A9:JB100) firstrow sheet(final) clear

drop in 1
keep dptresid deces*
drop deces18011805 deces18111815 deces18211825 deces18311835 deces18411845 deces18511855
reshape long deces, i(dptresid) j(annee)
rename dptresid dpt_num	

foreach end_per of num 1860(-10)1820 {

	local start_per = `end_per'-9
	
	gen deces_`start_per'_`end_per'=deces if annee<=`end_per' & annee>`start_per'
		

}


collapse (sum) deces_*, by(dpt_num)

foreach annee of num 1821(10)1861 {

	local start_per = `annee'-10
	local end_per = `annee'-1
	
	rename deces_`start_per'_`end_per' deces_`annee'
	label var deces_`annee' "Décès totaux de `start_per' à `end_per'"
}
	

merge 1:1 dpt_num using "$dir/temp_nbr_&deces_de_jeunes.dta"
erase "$dir/temp_nbr_&deces_de_jeunes.dta"
drop _merge

foreach annee of num 1821(10)1861 {

	local start_per = `annee'-10
	local end_per = `annee'-1
	
	rename deces_de_jeunes_`start_per'_`end_per' deces_de_jeunes_`annee'
	label var deces_de_jeunes_`annee' "Décès de jeunes de `start_per' à `end_per'"
	
	rename naissances_de_jeunes_`start_per'_`end_per' naissances_de_jeunes_`annee'
	label var naissances_de_jeunes_`annee' "Naissances de `start_per' à `end_per'"
	
	gen deces_de_vieux_`annee' = deces_`annee' - deces_de_jeunes_`annee'
	label var deces_de_vieux_`annee' "Décès de vieux de `start_per' à `end_per'"
	
	
}


reshape long nbr_de_jeunes_ deces_de_vieux_ deces_de_jeunes_ deces_ naissances_de_jeunes_, i(dpt_num) j(annee)

rename nbr_de_jeunes_ nbr_de_jeunes
rename deces_ deces
rename deces_de_vieux_ deces_de_vieux
rename deces_de_jeunes_ deces_de_jeunes
rename naissances_de_jeunes_ naissances_de_jeunes 

label var deces_de_vieux "Décès entre t-1 et t-10 de personnes âgées de + de 20 ans"
label var deces_de_jeunes "Décès entre t-1 et t-10 de personnes âgées de - de 20 ans"
label var deces "Décès entre t-1 et t-10"
label var nbr_de_jeunes "Nombres de jeunes en t"
label var naissances_de_jeunes "Naissances entre t-1 et t-10"

rename dpt_num dptresid
drop if dptresid==74 | dptresid==73 | dptresid==6

save  "$dir/Données_pour_TRARE.dta", replace



*****On a fini avec les données démographiques. Maintenant, on peut l'intégrer au TRAR pour faire le TRAE













