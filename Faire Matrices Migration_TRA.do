***Fait les matrices de migration à partir des données TRA
*v2 : **Modification 15/02/12 2 : - Migration à 20 ans
	**	: différenciation hommes / femmes
*v3 : on rajoute le calcul de l'âge moyen des migrants.






*************
*Programme pour une année et un sexe

capture program drop TRAuneannee 

program TRAuneannee

global dir "/Users/guillaumedaudin/Documents/Recherche/Migrations/Construction BDD/Donnees TRA"

use "$dir/BaseTRA_Modif.dta", clear

if "`2'"!="T" {
	keep if sexe=="`2'"
}

generate annee_migr = anna+20


***Pour calculer l'age moyen des migrants
generate migrant = 1 if `1'>=annee_migr & dcdept!=naisdept & andc>=`1' 
generate age = `1'-anna
display `1' "`2'"
*codebook age if migrant==1

replace dcdept=naisdept if annee_migr > `1'
quietly table naisdept dcdept if andc>=`1' & anna<=`1',format (%5.0g) replace

**Remettre les départements qui manquent complètement
joinby naisdept dcdept using "$dir/ListeDptTRA.dta", unmatched(both)

drop _merge
drop if dcdept==99 | dcdept==97


fillin naisdept dcdept
replace table1 = 0 if table1==.
drop _fillin


rename table1 nbr_TRA
rename naisdept dptorigine
rename dcdept dptresid
generate annee=`1'
generate sexe="`2'"

if annee == 1841 & sexe =="T" {
	}
else {
	append using "$dir/Migr_TRA.dta"
}

save "$dir/Migr_TRA.dta", replace

end
***********

foreach i in 1841 1851 1861 1872 1881 1891 1901 1911 {
	foreach j in T M F {
		TRAuneannee `i' `j'
	}
}




