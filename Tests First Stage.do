*À partir de "Assemblage BDD.do"



local data TRAR
*ou RE ou TRA
local sexe t
*ou m ou f
local paris P
*ou SP
local instrument p
*ou o
local ponderation log
*ou lin
local norme migr
*ou tous migr30
local fert Coal
*ou CBR

*_`data'_`sexe'_`paris'_`instrument'







version 12.1
clear all
set memory 1g
global dir "~/Documents/Recherche/Migrations/Construction BDD"
capture restore
set more off
set maxvar 8000
set matsize 8000

capture program drop test_first_stage
program test_first_stage
	args data fert sexe paris instrument norme ponderation 
	**Exemple : test_first_stage TRAR Coal  t P p migr log 
	
	
	
	*data: TRAR, RE ou TRA
	*fert: Coal ou CBR
	*sexe: t m f
	*paris: P ou SP
	*instrument: p (predicted / instrumented) or o (original / not instrumented)
	*ponderation : log ou lin
	*norme migr ou migr30

if "`fert'"=="Coal" {
	use "$dir/Données fécondité/bonneuil.dta", clear
	replace var2=v6 if var2==""
	rename var2 dpt
	replace dptresid = 54 if dpt=="MEURTHE"
	replace dptresid = 90 if dpt=="BELFORT"
	replace dptresid = 68 if dpt=="RHIN(HAUT-)"
	replace dptresid = 67 if dpt=="RHIN(BAS-)"
	drop var30 var1 var3 coaleindex1911 v6
	reshape long fert_bon, i(dpt) j(year)
	rename dptresid dpt_num
	rename year annee
	drop if fert_bon==.
	foreach i of numlist 1806 (10) 1906 {
		drop if annee==`i'
	}
	rename fert_bon f_obs
}

if "`fert'"=="CBR" {
	use "$dir/Données fécondité/crudebirthrate1811-1911.dta", clear
	rename dptresid dpt_num
	rename annee_obs annee
	rename dpt_nom dpt
	rename crudebirthrate f_obs
	drop yearid naissances population

}



save "$dir/BDD_prov_fert_`fert'.dta", replace


***************************************************



if "`data'"=="RE" {

	*------------------------------------------------------------------------
	*Ici, je prends les matrices de migration (du recensement 1891 (pas hommes et femmes), 1901 et 1911)
	
	use "$dir/Recensement_1891/Deux_Matrices_Recensement.dta", replace

	drop nbr_TRA
	**Il s'agit des départements 57, 67 et 92 qui sont présents dans TRA, mais pas dans le recensement
	drop if (dptorigine== 57 | dptorigine== 67 | dptorigine== 68 | dptorigine== 92) & annee==1891
	drop if (dptresid== 57 | dptresid== 67 | dptresid== 68 | dptresid== 92) & annee==1891
	*drop _merge
	drop if dptorigine==. | dptorigine==97 | dptorigine==99
	
	rename annee year
	rename  nbr_recens nbr_recensement
	generate sexe="t"
	tostring dptresid dptorigine, replace
	
	joinby dptresid dptorigine year sexe using "$dir/Matrice_complete_1901+1911.dta", update unmatched(both) _merge(_merge)
	drop migr* _merge
	drop if dptorigine == "al" | dptorigine =="unknown"
	destring dptresid dptorigine, replace
	rename year annee
	rename nbr_recensement nbr
	
	

 
	
	if  "`sexe'"=="t" {
		
		fillin sexe annee dptorigine dptresid
		egen tot = total(nbr), by(dptorigine dptresid annee)
		replace nbr=tot if sex=="t" & (annee==1901 | annee==1911) & nbr==.
		drop _fillin
	}
	
	keep if "`sexe'"==sexe
	drop sexe
	
	save "$dir/BDD_prov1_`data'_`sexe'.dta", replace
}


*--------------------------------
*Matrices de migration TRA précédentes (d'ailleurs, on va toutes les mettre, ce sera plus simple ?)

if "`data'"=="TRA" {


	use "$dir/Donnees TRA/Migr_TRA.dta"
	replace sexe=lower(sexe)
	
	drop if dptorigine==. | dptorigine==99 | dptorigine==97 | dptresid==99 | dptresid==97
	drop if ((dptresid==54 | dptresid==90) | (dptorigine==54 | dptorigine==90)) & annee==1861 
	drop if annee==1841 | annee==1851
	drop if (dptresid==57 | dptresid==67 | dptresid==68) | (dptorigine==57 | dptorigine==67 | dptorigine==68)
	
	replace annee=1871 if annee==1872
	
	rename nbr_TRA nbr
	
	keep if "`sexe'"==sexe
	drop sexe
	
	
	save "$dir/BDD_prov1_`data'_`sexe'.dta", replace

}



*-------------------------------
*Matrice de migration TRA_Re
if "`data'"=="TRAR" {


	use "~/Documents/Recherche/Migrations/Construction BDD/Donnees migrations/Matrices_TRA_Recens.dta", clear
	rename nbr_TRA_recens nbr

	
	if "`sexe'"=="t" {
		local new = _N + 1
        set obs `new'
		replace sexe="t" in `new'
		fillin sexe annee dptorigine dptresid
		egen tot = total(nbr), by(dptorigine dptresid annee)
		replace nbr=tot if sex=="t" & nbr==.
		drop if dptresid==. | dptorigine==. | annee==.
		drop _fillin
	}
	
	keep if "`sexe'"==sexe
	drop sexe

	save "$dir/BDD_prov1_`data'_`sexe'.dta", replace
}




*-------------------------------------Ici, on met la fécondité

use "$dir/BDD_prov1_`data'_`sexe'.dta", clear



**La fertilité observée -50 ans
rename dptresid dpt_num
rename annee annee_obs
generate annee=1811 if annee_obs==1861
replace annee=1821 if (annee_obs==1872 | annee_obs==1871)
replace annee=1831 if annee_obs==1881
replace annee=1841 if annee_obs==1891
replace annee=1851 if annee_obs==1901
replace annee=1861 if annee_obs==1911
joinby dpt_num annee using "$dir/BDD_prov_fert_`fert'.dta", unmatched(master) _merge(_merge)
rename dpt_num dptresid
rename f_obs f_obs_min50y
drop _merge annee


**La fertilité d'origine à -30
rename dptorigine dpt_num




generate annee=1831 if annee_obs==1861
replace annee=1841 if (annee_obs==1872 | annee_obs==1871)
replace annee=1851 if annee_obs==1881
replace annee=1861 if annee_obs==1891
replace annee=1871 if annee_obs==1901
replace annee=1881 if annee_obs==1911

*generate annee=annee_obs

joinby dpt_num annee using "$dir/BDD_prov_fert_`fert'.dta", unmatched(master) _merge(_merge)
*v25 : unmatched(both) 


rename dpt_num dptorigine
rename dpt dptresid_nom
rename f_obs f_ori3
rename annee annee_origine
drop _merge




**Problème : quid de ceux qui sont nés en 1871 ou avant dans le département 90 ?
**Ou ceux nés avant 1861 dans les départements 6, 73 et 74 ?

bysort annee_origine dptorigine : generate blouf=1 if _n==1 & dptorigine !=6 & dptorigine !=73 & dptorigine !=74
generate fert_ori3_pour_mean = f_ori3*blouf
bysort annee_origine : egen fert_moy30=mean(fert_ori3_pour_mean)


foreach i in 6 73 74 {
	generate blouf_`i' = f_ori3 / fert_moy30 if annee_origine==1861 & dptorigine==`i'
	egen ratio_`i'=max(blouf_`i')
	replace f_ori3 = ratio_`i'*fert_moy30 if annee_origine<=1861 & dptorigine==`i'
	drop blouf_`i' ratio_`i'
}

	generate blouf_90 = f_ori3 / fert_moy30 if annee_origine==1871 & dptorigine==90
	egen ratio_90=max(blouf_90)
	replace f_ori3 = ratio_90*fert_moy30 if annee_origine<=1871 & dptorigine==90
	drop blouf_90 ratio_90
	
drop blouf fert_ori3_pour_mean
	
label var fert_moy30 "Fertilité moyenne 30 ans avant"

************



*Ici, je prends la fertilité de destination
rename dptresid dpt_num
generate annee = annee_obs
joinby dpt_num annee using "$dir/BDD_prov_fert_`fert'.dta", unmatched(master) _merge(_merge)
rename dpt_num dptresid
drop annee _merge dpt
rename f_obs f_dest

*Ici, je prends la fécondité d'origine contemporaine
rename dptorigine dpt_num
generate annee = annee_obs
joinby dpt_num annee using "$dir/BDD_prov_fert_`fert'.dta", unmatched(master) _merge(_merge)
rename dpt_num dptorigine
drop annee _merge dpt
rename f_obs f_ori



**La fertilité observée
rename dptresid dpt_num
rename annee_obs annee
replace annee=1871 if annee==1872
joinby dpt_num annee using "$dir/BDD_prov_fert_`fert'.dta", unmatched(master) _merge(_merge)
rename annee annee_obs
*v25 : unmatched(both)

drop if f_obs==.
rename dpt_num dptresid
drop _merge



save "$dir/BDD_prov2_`data'_`fert'_`sexe'.dta", replace
*******************************************************************************************


if "`instrument'"=="p" {
	*-----------------------
	*Prise de la variable IV
	
	use "$dir/BDD_prov2_`data'_`fert'_`sexe'.dta", clear
	
	
	set obs `=_N+1'
	replace annee_obs=1851 if annee_obs==.
	fillin annee_obs dptorigine dptresid
	drop _fillin
	drop if annee_obs==.
	drop if dptorigine==.
	drop if dptresid==.
		
	generate year=1830 if annee_obs==1851
	replace year=1840 if annee_obs==1861
	replace year=1850 if (annee_obs==1872 | annee_obs==1871)
	replace year=1860 if annee_obs==1881
	replace year=1870 if annee_obs==1891
	replace year=1880 if annee_obs==1901
	replace year=1890 if annee_obs==1911
	
	joinby dptorigine dptresid year using "$dir/chemins de fer/reachability/iv.dta", unmatched(both) _merge(_merge)
	
	joinby dptorigine dptresid year using "$dir/Falsfication first stage/Avec nombre de journeaux/dist_culturelle_full.dta", unmatched(both) _merge(_mergedist_cult)
	
	
	replace annee_obs=year+21 if annee_obs==.
	drop year
	drop if annee_obs>=1912
	drop _merge
	generate poids_transport = 1/cout_transport
	
	
	**Remarque : nous n'avons pas les distances par rapport au Terr. de Belfort.
	**Ce n'est pas très grave, puisque nous n'avons pas les migrants pour 1861 non plus, donc il
	**va sortir des opérations cylindrées.
	
	
	
	save "$dir/BDD_prov2b_`data'_`fert'_`sexe'_`instrument'.dta", replace
	
	*-----------------------------
	*INSTRUMENTATION
	*--------------------------
	
	use "$dir/BDD_prov2b_`data'_`fert'_`sexe'_`instrument'.dta", clear


	generate str panel = string(dptorigine)+"/"+string(dptresid)
	encode panel, generate (numpanel) 
	tsset numpanel annee_obs, delta(10)
	
	generate cout_trsp1830 = cout_transport if annee_obs==1851
	generate cout_trsp1820 = cout_transport if annee_obs==1851
	generate cout_trsp1900 = cout_transport if annee_obs==1911
	egen cout_ref=max(cout_trsp1830), by(numpanel)
	*replace cout_transport=ln(cout_transport)
	********BUG REPÉRÉ LE 5 NOVEMBRE 2013
	*replace cout_transport=cout_transport/cout_ref
	*********BUG REPÉRÉ LE 5 NOVEMBRE 2013
	
	
	local new = _N + 1
    set obs `new'
	replace annee_obs=1841 if annee_obs==.
	local new = _N + 1
    set obs `new'
	replace annee_obs=1921 if annee_obs==.
	fillin annee_obs dptresid dptorigine
	drop if dptresid==.
	drop if dptorigine==.
	tab annee_obs
	bys annee_obs : sum nbr
	
	
	replace  panel = string(dptorigine)+"/"+string(dptresid)
	drop numpanel
	encode panel, generate (numpanel) 
	
	tsset numpanel annee_obs, delta(10)
	
	replace cout_transport = F.cout_transport if annee_obs==1841
	replace cout_transport = L.cout_transport if annee_obs==1921
	
	tab annee_obs if cout_transport!=.
	
	
	
	
	
	generate ln_cout_ref=ln(cout_ref)
	generate ln_cout_transport=ln(cout_transport)
	generate ln_dist_culturelle=ln(dist_culturelle)
	
		bys annee_obs : sum nbr
	
		
		display "// PANEL //"
		drop if strpos("06 54 57 67 68 73 74 90",strofreal(dptresid))!=0
		drop if strpos("06 54 57 67 68 73 74 90",strofreal(dptorigine))!=0
		bys annee_obs : sum nbr
		tsset numpanel annee_obs, delta(10)
*		poisson nbr_`j' ln_cout_transport  ln_cout_ref i.dptorigine i.dptresid i.annee_obs if sexe=="`s'", robust cluster(numpanel)
*		poisson nbr ln_cout_transport  L.ln_cout_transport i.dptorigine i.dptresid i.annee_obs , robust cluster(numpanel)
		poisson nbr ln_cout_transport  L.ln_cout_transport i.dptorigine i.dptresid i.annee_obs , robust cluster(numpanel)
		
		
		predict nbr_predict_PANELv1
		replace nbr_predict_PANELv1= nbr_predict_PANELv1
		replace nbr_predict_PANELv1=0 if nbr_predict_PANELv1 <=0 | nbr_predict_PANELv1 ==.
	
		
		*Pour interprétation
		gen delta_cout_transporttot = (cout_transport-L5.cout_transport)/L5.cout_transport
		gen delta_nbrtot = (nbr-L5.nbr)/L5.nbr
		gen delta_cout_transport = (cout_transport-L.cout_transport)/L.cout_transport
		gen delta_nbr = (nbr-L.nbr)/L.nbr
		summarize cout_transport nbr if annee_obs==1861, det
		summarize delta_cout_transporttot delta_nbrtot cout_transport nbr if annee_obs==1911, det
		summarize delta_cout_transport delta_nbr if annee_obs<=1911 &  annee_obs>=1861, det
		
		

	
	
		



	replace nbr_predict_PANELv1 = nbr if dptorigine==dptresid
*	replace nbr_`j'_predict_PANELv2 = nbr_`j' if dptorigine==dptresid

	

	
	
	/*
	foreach j in  TRA RE TRAR {
		foreach s in t m f {
		correlate nbr_`j'_predict_PANELv1 nbr_`j'_predict_PANELv2 nbr_`j'_predict_CS if dptorigine!=dptresid if sexe=="`s"'
		}
	}
	
	*/
	*/
	
	** La corrélation entre les prédictions en panelv1, panelv2 et pas en panel est très forte à 0.99
	**Donc on remplace le predict par celui en panel
	**Souci : dans panelv2, les instruments ne sont pas significatifs
	*Donc on garde v1
	
	
	

	gen nbr_obs=nbr
	replace nbr= nbr_predict_PANELv1

	
	***************************************Fin Panel
	
	
	
	
	


}
save "$dir/BDD_prov2b_`data'_`fert'_`sexe'_`instrument'.dta", replace
erase "$dir/BDD_prov2b_`data'_`fert'_`sexe'_`instrument'.dta"

end

test_first_stage TRAR Coal  t P p migr log 
*test_first_stage TRAR Coal  m P p migr log 
*test_first_stage TRAR Coal  f P p migr log 


