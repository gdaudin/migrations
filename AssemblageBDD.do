***Programme pour créer la base de données de migration + la base de données pour régression
** Avec les données Bonneuil (donc pas de calcul des fertilités)
**version 3 : on rajoute les données urbanisation / fertilité + on enlève les "fert origine" qui ne sont pas le sujet
** + on crée une nouvelle norme (y compris la population restante)
*Version 4 : on crée une prédiction pour le recensement aussi
*Version 5 : on introduit les innovations que j'ai faite dans la construction de la BDD régionale 
*+ On vérifie qu'on a les données pour la diffusion.
*Version 6 : on rajoute le calcul de quelques variables à la fin
*Version 7 : qq ajustements ; passage en version 11.1
*Version 8 : la variable instrumentée doit être calculée avec le coût de transport en log !
*Version 9 : On rajoute une norme de diffusion
*Version 10 : correction de tous_TRA_predict et emigr_TRA_predict + p_pop_emigr (% à la population présente)
*Version 11 : ajout de TRA_Re (TRA compatible avec le recensement, à partir de 1861)
*Version 12 : recherche d'une erreur qui fait que pop_immigr_TRAR=pop_immob_TRAR - Septembre 2011
*	+ Rajout de variables pour cylindrage (TRA TRAR RE, TRA_p TRAR_p RE_p)
*	+ On drop les observations dans TRA_p si il n'y a pas de population immobile
*Version 13 : espérance de vie à 15 ans cylin ss lagguée
*Version 14 : éducation des filles, shares d'émigrants / immigrants en log
*			+ nouvelles variables migrations genrées 
*Tous les fert_dest on été remplacés par f_dest
*Et les fert_ori par f_ori / fert_obs par f_obs
*Version 15 : différenciation hommes/femmes
*Version 16 : instrumentation en panel avec backward 1 Lag + données school choices
*Bug squashed sur l'instrumentation et les retards
*Version 17 : toutes les normes utilisent la fertilité en t plutôt qu'en t-30 pour les birth fertility norms
*Version 18 : retour à t-30
*Version 19 : avec cluster dans le first-stage
*Version 19 : avec cluster dans le first-stage
*Version 20 : avec nouvel instrument qui compare les coûts à ceux de 1830. Mais le first stage ne marche pas
*Version 21 : retour à la version 19
*Version 22 : avec test falsification à l'intérieur
*Version 23 : retour au nouvel instrument + distance
*Version 24 : correction d'un log qui traînait (mais qui n'a pas touché le reste des régressions) - et petite correction dans l'instrumentation
*Version 25 : Ajout de la fécondité pour 1811-1851
*Version 26 : Nouvelle instrumentation (year*dpt_id) + nouvelle organisation des sauvegardes + ajout distance culturelle
*Version 27 : Calcul des normes sans Paris (31 octobre 2013)
*Version 28 : pour le problème avec la régression avec variables croisée, retour à instrumentation
*en cross-section successives
*Version 28 : Retour au panel. On cherche le problème....
*Version 29 : Problème réglé
*Version 30 : Utilisation de la fécondité contemporaine plutôt que -30 pour la norme d'origine
*Je signale l'ancien en ajoutant "3"
**Version 31 : Calcul des parts % à la population du département, et pas que les habitants native FR Calcul pop_FR_native (du coup on enlève TRA)
*Inclusion de la population totale (pas sexe)
**Version 32 : Changement de l'organisation du résultat (plusieurs BDD) + pondération de la norme par le log de la population plutôt que la population






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
*ou TFR

*_`data'_`sexe'_`paris'_`instrument'







version 12.1
clear all
set memory 1g
global dir "~/Documents/Recherche/Migrations/Construction BDD"
capture restore
set more off
set maxvar 8000
set matsize 8000

capture program drop faire_BDD
program faire_BDD
	args data fert sexe paris instrument norme ponderation 
	**Exemple : faire_BDD Coal TRAR t P p migr log 
	
	
	
	*data: TRAR, RE ou TRA
	*fert: Coal ou TFR
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

if "`fert'"=="TFR" {
	use "$dir/Données fécondité/totalfertilityrate1811-1911.dta", clear
	rename dptresid dpt_num
	rename annee_obs annee
	rename dpt_nom dpt
	rename totalfertilityrate f_obs
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




*-------------------------------
*Matrice de migration TRARextended (21-51)
if "`data'"=="TRARE" {


	use "~/Documents/Recherche/Migrations/Construction BDD/Donnees migrations/Matrices_TRARE.dta", clear
	rename nbr_TRARE nbr

	
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
	else {
		display "Nous n'avons que les TRARE pour tout le monde !!
		blif
	}


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
	egen cout_ref=max(cout_trsp1830), by(numpanel)
	*replace cout_transport=ln(cout_transport)
	********BUG REPÉRÉ LE 5 NOVEMBRE 2013
	*replace cout_transport=cout_transport/cout_ref
	*********BUG REPÉRÉ LE 5 NOVEMBRE 2013
	
	
	generate ln_cout_ref=ln(cout_ref)
	generate ln_cout_transport=ln(cout_transport)
	generate ln_dist_culturelle=ln(dist_culturelle)
	
	/*
	********************************************Régression année par année
	display "RE // 1891 // t"
	poisson nbr_RE ln_cout_transport i.dptresid i.dptorigine if annee_obs==1891 & sexe=="t"
	predict nbr_RE_predict_1891 if annee_obs==1891 & sexe=="t"
	replace nbr_RE_predict_1891=0 if nbr_RE_predict_1891 <=0 | nbr_RE_predict_1891 ==.
	
	
	
	
	foreach i of num 1901 1911 {
		generate nbr_RE_predict_`i' =.
		foreach s in m f t {
			display "RE // `i' // `s'"
			poisson nbr_RE ln_cout_transport i.dptresid i.dptorigine if annee_obs==`i' & sexe=="`s'"
			predict nbr_RE_`s'_predict_`i' if annee_obs==`i' & sexe=="`s'"
			replace nbr_RE_predict_`i'= nbr_RE_`s'_predict_`i' if annee_obs==`i' & sexe=="`s'"
			replace nbr_RE_predict_`i'=0 if nbr_RE_predict_`i' <=0 | nbr_RE_predict_`i' ==.
		}
	}
	
	generate nbr_RE_p = nbr_RE_predict_1891 + nbr_RE_predict_1901 + nbr_RE_predict_1911
	replace nbr_RE_p = nbr_RE if dptorigine==dptresid
	drop nbr_RE*predict_1*
	
	
	
	
	foreach j in TRA TRAR  {
		foreach i of num 1861 1871 1881 1891 1901 1911 {
		generate nbr_`j'_predict_`i' =.
				foreach s in m f t {
				display "`j' // `i' // `s'"
				poisson nbr_`j' ln_cout_transport i.dptresid i.dptorigine if annee_obs==`i' & sexe=="`s'"
				predict nbr_`j'_`s'_predict_`i' if annee_obs==`i' & sexe=="`s'"
				replace nbr_`j'_predict_`i'= nbr_`j'_`s'_predict_`i' if annee_obs==`i' & sexe=="`s'"
				replace nbr_`j'_predict_`i'=0 if nbr_`j'_predict_`i' <=0 | nbr_`j'_predict_`i' ==.
			}	
		}
		generate nbr_`j'_predict_CS =  nbr_`j'_predict_1861 + nbr_`j'_predict_1871 + nbr_`j'_predict_1881 + nbr_`j'_predict_1891 + nbr_`j'_predict_1901 + nbr_`j'_predict_1911
		replace nbr_`j'_predict_CS = nbr_`j' if dptorigine==dptresid
		drop nbr_`j'*predict_1*	
	
	}
	
	*/
	***Calcul en panel******************************************
	
	
	
	
	
	/*
	*Falsification
	
	
	rename annee_obs annee
	joinby dptorigine dptresid annee using "$dir/Falsfication first stage/falsification matrix.dta", unmatched(both) _merge(_merge)
	rename annee annee_obs
	replace proxy_pltq = ln(proxy_pltq+0.01)
	foreach j in  TRAR TRA RE {
		generate nbr_`j'_predict_PANEL =.
				foreach s in m f t {
				display "`j' // PANEL // `s'"
				poisson nbr_`j' proxy_pltq i.dptresid i.dptorigine i.annee_obs if sexe=="`s'", robust cluster(numpanel)
		}	
	}
	
	
	*Autre falsification
	generate dif_fec = abs(f_obs-f_ori)
	
	foreach j in  TRAR TRA RE {
		generate nbr_`j'_predict_PANEL =.
				foreach s in m f t {
				display "`j' // PANEL // `s'"
				poisson nbr_`j' dif_fec i.dptresid i.dptorigine i.annee_obs if sexe=="`s'", robust cluster(numpanel)
		}	
	}
	
	
	
	*/
	
	

		display "// PANEL //"
*		poisson nbr_`j' ln_cout_transport  ln_cout_ref i.dptorigine i.dptresid i.annee_obs if sexe=="`s'", robust cluster(numpanel)
		poisson nbr ln_cout_transport  /*L.ln_cout_transport*/ i.dptorigine i.dptresid i.annee_obs , robust cluster(numpanel)
		predict nbr_predict_PANELv1
		replace nbr_predict_PANELv1= nbr_predict_PANELv1
		replace nbr_predict_PANELv1=0 if nbr_predict_PANELv1 <=0 | nbr_predict_PANELv1 ==.
	
		
		*Pour interprétation
		gen delta_cout_transport = (cout_transport-L.cout_transport)/cout_transport
		gen delta_nbr = (nbr-L.nbr)/nbr
		summarize delta_cout_transport delta_nbr, det
		drop delta_cout
		drop delta_nbr
	
	
		



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
	
	
	

	replace nbr= nbr_predict_PANELv1

	
	***************************************Fin Panel
	
	
	
	
	


}
save "$dir/BDD_prov2b_`data'_`fert'_`sexe'_`instrument'.dta", replace


*---------------------------------------------------------------------------------
*Calcul des populations d'immigrés et d'émigrés par département
use "$dir/BDD_prov2b_`data'_`fert'_`sexe'_`instrument'.dta", clear


**Introducton du sans paris

if "`paris'"=="SP" {
	replace nbr = 0 if dptresid==75 | dptorigine==75
}




foreach i in migr immob {
	generate pop_`i' = 0
}
replace pop_migr  = nbr 	if dptresid!=dptorigine
replace pop_immob = nbr 	if dptresid==dptorigine




*Calcul du total de population immigrée
save "$dir/BDD_prov3_`data'_`fert'_`sexe'_`instrument'_`paris'.dta", replace



use "$dir/BDD_prov3_`data'_`fert'_`sexe'_`instrument'_`paris'", clear

drop if f_obs==.
if "`data'" !="TRARE" drop if f_obs_min50y==.

collapse (sum) pop_migr pop_immob, by(dptresid annee_obs f_obs f_obs_min50y)
*Le f_obs est uniquement là pour qu'il soit gardé




rename pop_migr pop_immigr


save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'.dta", replace




*Calcul du total de population émigrée
use "$dir/BDD_prov3_`data'_`fert'_`sexe'_`instrument'_`paris'", clear

collapse (sum) pop_migr, by (dptorigine annee_obs)
rename dptorigine dptresid


rename pop_migr pop_emigr


joinby dptresid annee_obs using "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'.dta", unmatched (both)
drop _merge
save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'.dta", replace






***Vérifié (pas récemment) : pas de problème : le taux d'immigration au niveau de la France par année est bien le taux d'émigration 



******Norme calculée suivant l'origine de la population

use "$dir/BDD_prov3_`data'_`fert'_`sexe'_`instrument'_`paris'", clear

if "`norme'"=="migr" {
	local iw pop_migr 
	local f_ori f_ori
	}

if "`norme'"=="migr30" {
	local iw pop_migr
	local f_ori f_ori3
	}

if "`norme'"=="tous"  {
	local iw nbr
	local f_ori f_ori
}

if "`norme'"=="tous30" {
	local iw nbr
	local f_ori f_ori3
}

if "`ponderation'"=="log" {
	display "PONDERATION LOG"
	generate ln_`iw'=max(0,ln(`iw'))
	local iw ln_`iw'
}


save "$dir/blouk.dta", replace




collapse (mean) `f_ori' [iw=`iw'], by(dptresid annee_obs)
rename f_ori norme_ori
joinby dptresid annee_obs using "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'.dta", unmatched (both)
drop _merge
save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace
	
	



use "$dir/blouk.dta", clear

collapse (mean) f_dest [iw=`iw'], by(dptorigine annee_obs)
rename dptorigine dptresid
fillin dptresid annee_obs
rename f_dest norme_dest
drop _fillin



joinby dptresid annee_obs using "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", unmatched (both)

drop _merge




drop if (dpt==54 | dpt==90) & annee_obs==1861
	
save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace


erase "$dir/blouk.dta"
*****************************************************************************************************************************************



*-------------------------------VARIABLES PROFESSIONNELLES

use "$dir/Raphael 2 septembre 2010/industries professions liberales.dta", clear
drop if id==90 | id==99
replace id = 54 if id == 55 | id==57
drop departement yearid autrenom
collapse (mean) p_industrie p_professionsliberales, by(id year)
save "$dir/Prof.dta", replace

use "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", clear
rename dptresid id
rename annee_obs year
replace year = 1872 if year == 1871
joinby id year using "$dir/Prof.dta", unmatched (master)
erase "$dir/Prof.dta"
replace year= 1871 if year == 1872
rename id dptresid
rename year annee_obs

drop _merge

save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace

*----------------------------VARIABLES DÉMOGRAPHIQUES SUPPLÉMENTAIRES


insheet using "$dir/Donnees population/Population masculine et feminine francaise v6.csv", tab clear
drop v6-v10
rename dpt dptresid
rename year annee_obs
drop nom
rename inhabit pop
reshape wide pop, i(dptresid annee_obs) j(sexe) string
rename popf pop_f
rename popm pop_m
generate pop_t = pop_f+pop_m

joinby dptresid annee_obs using "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", unmatched(using)

use "$dir/Donnees accroissement naturel/Calcul accroissement naturel et relatif 1801-1911.dta", clear
keep dptresid population*

reshape long population,i(dptresid) j(annee_obs)
rename population pop_t
joinby dptresid annee_obs using "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", unmatched(using)
drop _merge
save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace


 
 


/*Autre possibilité pour pop

use "$dir/DonneÃÅes diverses/data_pop_dep.dta", clear
rename dpt_num dptresid
rename annee annee_obs
joinby dptresid annee_obs using "$dir/BDD.dta"
save "$dir/BDD.dta", replace
*/




use "$dir/urban6.dta", clear
drop _merge
rename dptresid dpt_num
drop departement yearid
drop if annee_obs==.
*collapse (mean)  urban lifeexpectancy15 mortalityratio_15 survival_15, by(id annee_obs)
save "$dir/urb_mort.dta", replace

use "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace
rename dptresid id
joinby id annee_obs using "$dir/urb_mort.dta", unmatched (master)
drop _merge
rename id dptresid
erase "$dir/urb_mort.dta"
save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace

use "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace
rename dptresid id
joinby id annee_obs using "$dir/educationfille_10yb.dta", unmatched (master)
drop _merge
rename id dptresid
save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace

use "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace
rename dptresid id
joinby id annee_obs using "$dir/educationhomme_10yb.dta", unmatched (master)
drop _merge
rename id dptresid
save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace

*------------------------VARIABLE CHOIX ÉDUCATION

use "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace

joinby dptresid annee_obs using "$dir/Correlates school choice fertility/eleves_pourBDD.dta", unmatched (master)
drop _merge

save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace


*drop _merge

sort dptresid annee_obs

save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace



*------------------------BAD CONTROLS

use "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace

*rename dptresid dpt_resid

joinby dptresid annee_obs using "$dir/Data divers/badcontrols2.dta", unmatched (master)
drop _merge

*rename dpt_resid dptresid

sort dptresid annee_obs




save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace


*---------------------------- Revue de deux mondes (qui dépend de BAD Controls)


use "$dir/BDD_prov_fert_`fert'.dta"

keep if dpt_num==75
drop dpt
rename f_obs f_obs_paris

joinby annee using  "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", unmatched(both)
drop _merge

gen rd2M_fecParis = f_obs_paris*revuedesdeuxmondes_newsstand


save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace




*--------------------------	VARIABLES POUR LES RÉGRESSIONS

use "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace

***Créer des lags

***Créer des lags

*** Les variables de fertilité  in log lags

tsset dptresid annee_obs, delta(10)



local PourLag f_obs norme_dest norme_ori

foreach i in  `PourLag' {
	replace `i' = ln(`i')
	generate lag1_`i'=L.`i'
}








***This computes the explanatory variables in shares 

** Share of immobile and migrating population in each departement. Always as the share of the resident population


gen pop_FR_native=pop_immob+pop_immigr
foreach i in emigr immigr {
	gen p_pop_`i' = pop_`i'/pop_`sexe'
	replace p_pop_`i'	=. if pop_immob==0
	gen lnp_pop_`i'		= ln(1+p_pop_`i')
	label var lnp_pop_`i' "ln(1+p_pop_`i')"
	gen lag1_p_pop_`i'	= L.p_pop_`i'
	gen lag1_lnp_pop_`i'= L.lnp_pop_`i'
	gen lnpop_`i' 	= ln(pop_`i')
}





*******************variables croisées et lagguées
***Si se termine par lag : toute la variable lagguée
***Si commence par lag : que la variable de fertilité
** Les variables de fertilité sont toujours en log
** On met les shares en log aussi quand cela commence par ln
** 

**f_d_p_pop_... : fecondité de destination *...

foreach i in emigr immigr {

	if "`i'"=="emigr" {
		gen norm_dest_x_p_pop=p_pop_`i'*norme_dest
		label var norm_dest_x_p_pop "norme_dest*p_émigrants"
		gen norm_dest_x_p_pop_lg=L.norm_dest_x_p_pop
		label var norm_dest_x_p_pop_lg "lag(norme_dest*p_émigrants)"
		
		gen norm_dest_x_lnp_pop=lnp_pop_`i'*norme_dest
		label var norm_dest_x_lnp_pop "norme_dest*ln(p_émigrants+1)"
		gen norm_dest_x_lnp_pop_lg=L.norm_dest_x_lnp_pop
		label var norm_dest_x_lnp_pop_lg "lag(norme_dest*ln(p_émigrants+1))"
	}
	
	if "`i'"=="immigr" {
		gen norm_ori_x_p_pop=p_pop_`i'*norme_ori
		label var norm_ori_x_p_pop "norme_ori*p_immigr"
		gen norm_ori_x_p_pop_lg=L.norm_ori_x_p_pop
		label var norm_ori_x_p_pop_lg "lag(norme_dest*p_immigr)"
		
		gen norm_ori_x_lnp_pop=lnp_pop_`i'*norme_ori
		label var norm_ori_x_lnp_pop "norme_dest*ln(p_immigr+1)"
		gen norm_ori_x_lnp_pop_lg=L.norm_ori_x_p_pop
		label var norm_ori_x_lnp_pop_lg "lag(norme_dest*ln(p_immigr+1))"						
	}
				
}


save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", replace




*************************
** Share of population working in the industrial sector and as professionals et éducation et autre

use "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta", clear

*** in log


foreach i of varlist p_industrie p_professionsliberales women_education_10yb men_education_10yb /*
				*/ urban lifeexpectancy15 mortalityratio_1 propelevescongreganistes propfillescongreganistes propgarconscongreganistes {
	gen ln`i'=ln(`i')
	gen lag1_ln`i'=L.ln`i'
}

joinby using "$dir/Dpt Noms-Nums.dta", unmatched(master)
drop _merge


tabulate annee_obs


save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'_var.dta", replace


***********************
** Création des variables pour inclusion dans les régressions

use "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'_var.dta", replace


*Vérifie s'il y a de variables manquantes sur une ligne
egen blink= rmiss(f_obs norme_dest   norme_ori lag1_norme_dest   /*
				*/ lag1_f_obs lnlifeexpectancy15 lnmortalityratio_1 lnurban   lnp_industrie  lnp_professionsliberales/*
				*/ lag1_lnlifeexpectancy15 lag1_lnmortalityratio_1 lag1_lnurban lag1_lnp_industrie /*
				*/ lag1_lnp_professionsliberales   norm_dest_x_p_pop norm_dest_x_p_pop_lg/*
				*/ p_pop_emigr lag1_p_pop_emigr  lnwomen_education_10yb lag1_lnwomen_education_10yb /*
				*/ lnpropelevescongreganistes lnpropfillescongreganistes lnpropgarconscongreganistes/*
				*/ lag1_lnpropelevescongreganistes lag1_lnpropfillescongreganistes lag1_lnpropgarconscongreganistes /*
				*/ norm_ori_x_p_pop norm_ori_x_p_pop_lg)
*Résume l'information
gen blouk = 0 if blink >=1
replace blouk =1 if blink==0
*Calcule le nombre d'années avec variable manquante par département
bys dptresid: egen cylin_lag=sum(blouk)
*Et mets à zéro ceux qui ne sont pas au max
summarize cylin_lag, mean
replace cylin_lag=0 if cylin_lag !=r(max)
replace cylin_lag=1 if cylin_lag ==r(max)
*Mets à zéro les années où aucun département n'a toutes les variables
bys annee_obs: egen blof=sum(blouk)
replace cylin_lag=0 if blof==0


drop blink blouk blof

*drop __*


*Vérifie s'il y a de variables manquantes sur une ligne
egen blinkl= rmiss(f_obs norme_dest   norme_ori   /*
				*/ lnlifeexpectancy15 lnmortalityratio_1 lnurban   lnp_industrie  lnp_professionsliberales/*
				*/  norm_dest_x_p_pop /*
				*/ p_pop_emigr  lnwomen_education_10yb  /*
				*/ lnpropelevescongreganistes lnpropfillescongreganistes lnpropgarconscongreganistes /*
				*/ norm_ori_x_p_pop )
*Résume l'information
gen bloukl = 0 if blink >=1
replace blouk =1 if blink==0
*Calcule le nombre d'années avec variable manquante par département
bys dptresid: egen cylin=sum(blouk)
*Et mets à zéro ceux qui ne sont pas au max
summarize cylin, mean
replace cylin=0 if cylin !=r(max)
replace cylin=1 if cylin ==r(max)
*Mets à zéro les années où aucun département n'a toutes les variables
bys annee_obs: egen blof=sum(blouk)
replace cylin=0 if blof==0

drop blink blouk blof

*drop __*

drop year

label data "data `data' sexe `sexe' paris `paris' instrument `instrument' pondération `ponderation' norme `norme' fécondité `fert'"

if "`data'"=="TRARE" append using "$dir/BDD_TRAR_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'_var.dta"

save "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'_var.dta", replace

label data drop

saveold "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'_var_old.dta", version(13) replace




****Nettoyage

erase  "$dir/BDD_prov_fert_`fert'.dta"

erase  "$dir/BDD_prov1_`data'_`sexe'.dta"

erase "$dir/BDD_prov2_`data'_`fert'_`sexe'.dta"

erase "$dir/BDD_prov2b_`data'_`fert'_`sexe'_`instrument'.dta"

erase "$dir/BDD_prov3_`data'_`fert'_`sexe'_`instrument'_`paris'.dta"

erase "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'.dta"

erase "$dir/BDD_`data'_`fert'_`sexe'_`instrument'_`paris'_`norme'_`ponderation'.dta"




end


faire_BDD TRAR Coal t P o migr lin

faire_BDD TRARE Coal t P o migr lin



/*

foreach data in TRAR RE TRA {
	foreach fert in Coal TFR {
		foreach sexe in t m f {
			foreach instrument in o p {
				foreach paris in P SP {
					foreach norme in migr migr30 {
						foreach ponderation in log lin {
							faire_BDD `data' `fert' `sexe' `paris' `instrument' `norme' `ponderation'
	
						}
					}
				}
			}
		}
	}
}










/*


faire_BDD TRAR t P p lin migr 


faire_BDD TRAR t P p lin migr30
faire_BDD TRAR t P o lin migr30

faire_BDD TRAR f P o lin migr
faire_BDD TRAR f P p lin migr

faire_BDD TRAR m P o lin migr
faire_BDD TRAR m P p lin migr

faire_BDD TRAR t SP p lin migr
faire_BDD TRAR t SP o lin migr








