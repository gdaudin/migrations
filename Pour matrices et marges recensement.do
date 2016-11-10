version 12

**Travail sur les matrices de recensement genr�es 1901 et 1911

global dir "/Users/guillaumedaudin/Documents/Recherche/Migrations/Construction BDD"
set more off



/*
**1901

insheet using "$dir/Recensement_1901/Travaux migrations genre 1901/Matrice_complete_1901_pour_stata.txt", tab clear

rename dptorigine name_dptorigine
rename v2 dptorigine
drop v355-v399
drop if dptresid_1_prof_m ==.

reshape long dptresid, i(dptorigine name_dptorigine) j(blouk) string
rename dptresid nbr_recensement

replace blouk = subinstr(blouk,"_"," ",.)
generate dptresid = word(blouk,1)
generate prof = word(blouk,2)
generate sexe=word(blouk,3)
drop if sexe==""

*On met la banlieue avec Paris
replace dptresid="75" if dptresid=="75b" 
*On met tous les status professionnels ensemble
drop blouk
collapse (sum) nbr_recensement, by (dptorigine dptresid sexe)


save "$dir/Recensement_1901/Travaux migrations genre 1901/Matrice_complete_1901.dta", replace

**1911

insheet using "$dir/Recensement_1911/Travaux migrations genre 1911/Matrice_complete_1911_pour_stata.txt", tab clear



reshape long dptorigine, i(dptresid dptresid_nom) j(blouk) string
rename dptorigine nbr_recensement

replace blouk = subinstr(blouk,"_"," ",.)
generate dptorigine = word(blouk,1)
generate prof = word(blouk,2)
generate sexe=word(blouk,3)
drop if sexe==""

replace dptorigine="75" if dptorigine=="75b" 
drop blouk
collapse (sum) nbr_recensement, by (dptorigine dptresid_nom dptresid sexe)

save "$dir/Recensement_1911/Travaux migrations genre 1911/Matrice_complete_1911.dta", replace

**Ensemble
*/
use "$dir/Recensement_1911/Travaux migrations genre 1911/Matrice_complete_1911.dta", clear
generate str blouk = string(dptresid)
drop dptresid
rename blouk dptresid
drop dptresid_nom
generate year = 1911

append using "$dir/Recensement_1901/Travaux migrations genre 1901/Matrice_complete_1901.dta"

replace year = 1901 if year ==.
replace dptorigine="al" if dptorigine=="Alsace_Lorraine"

generate migr_recens = nbr_recens if dptorigine != dptresid
label variable migr_recens "Migrants d'apr�s le recensement"

****Il faut traiter les dpt origine unknown... Nous allons supposer que ce sont tous des immigrants
****Et que leurs origines sont les m�mes que les autres

generate migr_ssunknown = migr_recens if dptorigine!="unknown"
label variable migr_ssunknown "Migrants d'apr�s le recensement, mais sans les unknown"
egen total_immigr_ssunknown = total(migr_ssunknown), by(year dptresid sexe)
generate migr_unknown = migr_recens if dptorigine=="unknown"
egen total_immigr_unknown = total(migr_unknown), by(year dptresid sexe)

drop migr_unknown migr_ssunknown

generate migr_recens_avecunknown = migr_recens + total_immigr_unknown*(migr_recens/total_immigr_ssunknown) if dptorigine !="unknown"
label variable migr_recens_avecunknown "Migrants d'apr�s le recensement, unknown r�partis"


drop total_immigr_unknown total_immigr_ssunknown






save "$dir/Matrice_complete_1901+1911.dta", replace

***************************************************************
**Puis les donn�es hors matrices
***************************************************************

use "$dir/Matrice_complete_1901+1911.dta", clear

**Cr�ation des variables d�partementales
sort year dptresid dptorigine

egen emigr_recens = total (migr_recens), by(year dptorigine sexe)
label variable emigr_recens "�migrants d'apr�s le recensement - sans les unknowns"
egen emigr_recens_avecunknown =  total (migr_recens_avecunknown), by(year dptorigine sexe)
label variable emigr_recens_avecunknown "�migrants d'apr�s le recensement - unknown r�partis tous des migrants"


egen immigr_tot_recens = total (migr_recens), by (year dptresid sexe)
egen tot_immigr_avecunknown = total (migr_recens_avecunknown), by (year dptresid sexe)
assert tot_immigr_avecunknown==immigr_tot_recens
drop tot_immigr_avecunknown 
label variable immigr_tot_recens "Immigrants d'apr�s le recensement - y compris Alsace-Lorraine"
*C'est bien les m�me avec unknown et ss unknown


generate blouf = migr_recens_avecunknown  if dptorigine!="al"
egen immigr_ssAL_recens = total (blouf), by(year dptresid sexe)
label variable immigr_ssAL_recens "Immigrants d'apr�s le recensement - sans Alsace-Lorraine"
drop blouf

*Creation variable annuelle/sexe
generate blouf = migr_recens_avecunknown if dptorigine !="al" | dptorigine=="unknown"
egen migr_tot_ssAL=total(blouf), by (year sexe)
drop blouf

egen migr_tot=total(migr_recens_avecunknown), by (year sexe)

egen inhabit = total (nbr_recens), by(year dptresid sexe)
label variable inhabit "Habitants fran�ais d'origine"
replace migr_recens_avecunknown = nbr_recens if dptorigine==dptresid
egen native = total (migr_recens_avecunknown), by(year dptorigine sexe)
label variable native "Natifs du d�partement"
drop native
replace migr_recens_avecunknown = 0 if dptorigine==dptresid



keep if dptorigine==dptresid
drop nbr_recensement migr*

drop dptorigine
generate dpt = real(dptresid)
drop dptresid
save "$dir/Marges_migrations.dta", replace


**Ajout du reste des donn�es******************************************************************

*1891 : Pas par genre, mais nous aide pour la suite :)
insheet using "$dir/Recensement_1891/Emigrants1891PourStata1891.txt", tab clear
merge 1:1 dpt sexe year using "$dir/Marges_migrations.dta"
drop _merge
save "$dir/Marges_migrations.dta", replace

insheet using "$dir/Donnees accroissement naturel/Calcul accroissement naturel Femmesv4.txt", tab clear
drop nom_dpt
merge 1:1 dpt sexe year using "$dir/Marges_migrations.dta"
drop _merge
save "$dir/Marges_migrations.dta", replace

insheet using "$dir/Donnees accroissement naturel/Calcul accroissement naturel Hommesv4.txt", tab clear
drop nom_dpt
drop if dpt==.
merge 1:1 dpt sexe year using "$dir/Marges_migrations.dta"
drop if dpt==.
label variable accroissnaturel10ans "Accroissement naturel de t � t+10"
save "$dir/Marges_migrations.dta", replace

insheet using "$dir/Donnees migrations/share of migrants male female v5.txt", tab clear
rename immigr_ssal_recens immigr_ssAL_recens
save blouk.dta, replace
use "$dir/Marges_migrations.dta", clear
drop _merge
merge 1:1 dpt sexe year using blouk.dta, update
save "$dir/Marges_migrations.dta", replace


insheet using "$dir/Donnees population/Population masculine et feminine totale.txt", tab clear
save blouk.dta, replace
use "$dir/Marges_migrations.dta", clear
drop _merge
merge 1:1 dpt sexe year using blouk.dta, update
drop _merge
drop v6 nom
label variable pop_tot "Population totale"
format pop_tot %11.0gc
save "$dir/Marges_migrations.dta", replace

insheet using "$dir/Donnees population/Population masculine et feminine francaise v4.txt", tab clear
save blouk.dta, replace
use "$dir/Marges_migrations.dta", clear
rename inhabit pop_fr_guillaume
merge 1:1 dpt sexe year using blouk.dta, update
rename inhabit pop_fr
replace pop_fr=pop_fr_guillaume if pop_fr==.
drop pop_fr_guillaume
format pop_fr %11.0gc
label variable pop_fr "Population fran�aise n�e en m�tropole, yc AL"
*format pop_fr_guillaume %11.0gc
drop _merge v6-v10

*list dpt year sexe pop_fr_guillaume pop_fr if abs(pop_fr_guillaume/pop_fr-1)>0.1 & abs(pop_fr_guillaume-pop_fr)!=.

/*
generate emig_frg = 0.124 if year==1861
replace  emig_frg = 0.173 if year==1871
replace  emig_frg = 0.279 if year==1881
replace  emig_frg = 0.177 if year==1891
label variable emig_frg "Taux d'�migration brut des fran�ais vers l'�tranger de t � t+10 en pour mille"

*1901 : 0.15
*/

save "$dir/Marges_migrations.dta", replace


****************************************Travail sur les marges


use "$dir/Marges_migrations.dta", clear
drop if dpt==0
*drop native
drop emigr_recens
rename emigr_recens_avecunknown emigr_recens
rename immigr_tot_recens immigr_recens

generate blouk = string(dpt)+sexe
encode blouk, gen(panvar)
tsset panvar year, delta(10)
drop blouk

**Traitement AL

*Il faut que dans la matrice, le nombre d'�migrants soit �gal au nombre d'immigrants
*Pour 1872, 1901 et 1911, on a les deux (avec AL et sans AL)
*Pour 1891, on a que sans AL
*Pour 1881, on a que avec AL
*Il faut donc compl�ter 1881. Ce qu'on va faire avec 1901 et 1872.

generate ratio_ssAL=immigr_ssAL_recens/immigr_recens
generate blink_1901 = ratio_ssAL if year==1901
generate blink_1871 = ratio_ssAL if year==1871
bysort dpt sexe : egen ratio_ssAL_1901 = max(blink_1901)
bysort dpt sexe : egen ratio_ssAL_1871 = max(blink_1871)
replace immigr_ssAL_recens=immigr_recens*ratio_ssAL_1901^(1/3)*ratio_ssAL_1871^(2/3) if year==1881

replace ratio_ssAL=immigr_ssAL_recens/immigr_recens
generate blink_1881= ratio_ssAL if year==1881
bysort dpt sexe : egen ratio_ssAL_1881=max(blink_1881)
replace immigr_recens=immigr_ssAL_recens/ratio_ssAL_1901^0.5/ratio_ssAL_1881^0.5 if year==1891

*Pour 1861, il faut aussi le faire car nous n'aurons pas le nombre d'�migrants pour l'AL (ni m�me la Meurthe-et-Moselle).
*Mais il n'y a pas de liens logique entre le nombre d'immigrants d'AL avant 1871 et celui d'apr�s
*On va supposer que la structure reste la m�me, mais que le nombre change pas.
*Et que les immigrants viennent d'AL en proportion de la population

**Identification AL
generate AL=1 if dpt ==54 | dpt ==57 | dpt == 67 | dpt==68 | dpt==90
replace AL=0 if AL ==.
bysort sexe year : egen pop_tot_AL = total(pop_tot*AL)  	if year ==1861
bysort sexe year : egen pop_tot_FR = total(pop_tot)     	if year ==1861

bysort sexe year : egen tot_immigr=total(immigr_recens) 	if year==1861
replace immigr_ssAL_recens = immigr_recens*ratio_ssAL_1871 	if year==1861
bysort sexe year : egen blouf=total(immigr_ssAL_recens) 	if year==1861
replace immigr_ssAL_recens = immigr_ssAL_recens*tot_immigr/blouf*(pop_tot_FR-pop_tot_AL)/pop_tot_FR if year==1861
drop blouf

drop blink_1901 blink_1881 blink_1871 ratio_ssAL_1901 ratio_ssAL_1871 ratio_ssAL_1881 tot_immigr

generate pop_fr_ssAL=pop_fr-immigr_recens+immigr_ssAL_recens



*codebook pop_fr_ssAL



/*
*Pour le calcul num�ro 1 : en utilisant les diff�rences
*Mais c'est compliqu� d'utiliser des diff�rences avec ce genre de donnn�es !
*Pop(t)=Pop(t-1)+acc_nat-emigration vers l'�tranger
*		- (�migr�s vers la France(t)-�migr�s vers la France(t-1))
*		+ (immigr�s depuis la France(t)-immigr�s depuis la France(t-1))
*Modulo le fait que les gens peuvent �migrer puis mourrir. Donc on fera un r�gle de trois � la fin (?) Ou autre solution
*<=> �migr�s vers la France (t-1) = Pop(t)-Pop(t-1)-acc_nat+emigration vers l'�tranger+�migr�s vers la France(t)
*	-(immigr�s depuis la France(t)-immigr�s depuis la France(t-1))
**L'accroissement naturel l� ne devrait �tre que celui des natives (pour les morts en tous les cas). Restent les enfants quand m�me...

tsset panvar year, delta(10)

generate delta_pop_fr_ssAL = F.pop_fr_ssAL-pop_fr_ssAL
generate delta_pop_fr = F.pop_fr-pop_fr
generate emig_frg_ssAL = emig_frg*10/1000*(pop_fr_ssAL+F.pop_fr_ssAL)/2
generate emig_frg_tot = emig_frg*10/1000*(pop_fr+F.pop_fr)/2
*replace emig_frg_ssAL=emig_frg_ssAL*10 if dpt == 22 | dpt==20 | dpt==74 | dpt==66 | dpt==64 | dpt==40
generate delta_immigr_ssAL = (F.immigr_ssAL_recens-immigr_ssAL_recens)
generate delta_immigr = (F.immigr_recens-immigr_recens)
generate accroissnaturel10ans_nat = nc10ans*(pop_tot/pop_tot)-dc10ans/2*((pop_fr-immigr_recens)/pop_tot+(F.pop_fr-F.immigr_recens)/F.pop_tot)


*************************************
***Traitement �migration �trang�re
*On utilise ce qu'on sait de 1901-1911 pour calculer la part de chq d�partement dans l'�migration vers l'�tranger
*generate emig_frg_ssAL = emigr_recens - F.emigr_recens - delta_pop_fr_ssAL + accroissnaturel10ans_fr_ssAL + delta_immigr_ssAL if year==1901
*Cela aurait �t� bien, mais cela ne marche pas : beaucoup de chiffres n�gatifs.
*Dur, dur de travailler avec plusieurs ann�es de recensement
*******************************






generate emigr_recens_temp=.
generate blink = .

foreach i of numlist 1891 1881 1871 {
	replace emigr_recens_temp = F.emigr_recens + delta_pop_fr_ssAL-accroissnaturel10ans_nat+emig_frg_ssAL - delta_immigr_ssAL if year==`i'
*	codebook emigr_recens if year==`i'

	bysort sexe year : egen tot_immigr=total(immigr_ssAL_recens)
	*Pour �viter les chiffres n�gatifs !
	quietly tsset panvar year, delta(10)
	*replace emigr_recens = F.emigr_recens *(tot_immigr/F.tot_immigr) if emigr_recens<=0
	replace emigr_recens_temp = 100 if emigr_recens_temp<=0
	**(3 modif en 1891, 21 en modification en 1881, 24 en 1871)

	**Mise en proportion pour que la somme des �migrants soit celle des immigrants
	bysort sexe year :  egen tot_emigr=total(emigr_recens_temp)
	replace blink= tot_immigr/tot_emigr if year ==`i'
	
	replace emigr_recens = emigr_recens_temp *tot_immigr/tot_emigr if year==`i'
	drop tot_immigr tot_emigr
	
	quietly tsset panvar year, delta(10)
	}
	
	tabulate blink year
	
***********Puis traitement de 1861
replace emigr_recens =  F.emigr_recens + delta_pop_fr-accroissnaturel10ans_nat+emig_frg_tot  - delta_immigr if year==1861
	
bysort sexe year : egen tot_immigr=total(immigr_recens)
quietly tsset panvar year, delta(10)
*replace emigr_recens = F.emigr_recens *(tot_immigr/F.tot_immigr) if emigr_recens<=0
replace emigr_recens = 100 if emigr_recens<=0
**(46 modifications)


replace emigr_recens=. if AL==1 & year ==1861
*Ne devrait �tre utile que pour la Meurthe, qui ne peut pas �tre mise en lien avec la Meurthe et Moselle (toutes les deux 54)
bysort sexe year : egen pop_tot_AL = total(pop_tot*AL) if year ==1861
bysort sexe year : egen pop_tot_FR = total(pop_tot) if year ==1861

	
bysort sexe year :  egen tot_emigr=total(emigr_recens)
*Il faut enlever les immigrants qui viennent des d�partements d'AL pour que l'�quilibre se fasse bien.
*On fait l'hypoth�se qu'ils viennent des d�partements d'AL en % de la population de cette derni�re
replace emigr_recens = emigr_recens *tot_immigr/tot_emigr*(pop_tot_FR-pop_tot_AL)/pop_tot_FR if year==1861
drop tot_immigr tot_emigr

*/
***************************************************************************************
*Deuxi�me m�thode, plus simple, sans utiliser l'accroissement naturel

generate float double emigr_recens_basic = emigr_recens if year ==1901 | year==1911 
generate ratio_emigr_basic = emigr_recens_basic/(pop_fr-immigr_recens) if year ==1901 | year==1911 


quietly tsset panvar year, delta(10)

*D'abord pour 1891 (on dispose du nombre de migrants, sexes m�lang�s)
replace emigr_recens_basic= F.ratio_emigr_basic*(F.ratio_emigr_basic/FF.ratio_emigr_basic)*(pop_fr-immigr_recens) if year==1891

*Je le fais tourner plusieurs fois pour r�pondre � la fois aux contraintes li�es au nombres d'immigrants de chq sexe et � celles li�es 
*au nombre d'emigrants de chq d�partement

foreach i of numlist 1/4 {

	bysort sexe year : egen tot_immigr=total(immigr_ssAL_recens) if year==1891		
	bysort sexe year :  egen tot_emigr=total(emigr_recens_basic) if year==1891
	replace emigr_recens_basic = emigr_recens_basic *tot_immigr/tot_emigr if year==1891
	drop tot_immigr tot_emigr

	bysort dpt year :  egen tot_emigr=total(emigr_recens_basic)
	replace emigr_recens_basic = emigr_recens_basic *emigr_recens_mf/tot_emigr if year==1891
	drop  tot_emigr
}


replace ratio_emigr_basic = emigr_recens_basic/(pop_fr-immigr_recens) if year==1891
quietly tsset panvar year, delta(10)



foreach i of numlist  1881 1871  {
	replace emigr_recens_basic= F.ratio_emigr_basic*(((F.ratio_emigr_basic/FF.ratio_emigr_basic)*(FF.ratio_emigr_basic/FFF.ratio_emigr_basic))^0.5)*(pop_fr-immigr_recens) if year==`i'

	bysort sexe year : egen tot_immigr=total(immigr_ssAL_recens) if year==`i'		
	bysort sexe year :  egen tot_emigr=total(emigr_recens_basic) if year==`i'
	replace emigr_recens_basic = emigr_recens_basic *tot_immigr/tot_emigr if year==`i'
	drop tot_immigr tot_emigr

	replace ratio_emigr_basic = emigr_recens_basic/(pop_fr-immigr_recens) if year==`i'
	quietly tsset panvar year, delta(10)
}


***********Puis traitement de 1861

replace emigr_recens_basic= F.ratio_emigr_basic*((F.ratio_emigr_basic/FF.ratio_emigr_basic)*(FF.ratio_emigr_basic/FFF.ratio_emigr_basic))^0.5*(pop_fr-immigr_recens) if year==1861
	
*list dpt sexe year emigr_recens_basic if dpt==75
replace immigr_ssAL_recens=. if AL==1 & year==1861
bysort sexe year : egen float tot_immigr=total(immigr_ssAL_recens) if year==1861

**traitement AL

replace emigr_recens_basic=. if AL==1 & year ==1861
*Ne devrait �tre utile que pour la Meurthe, qui ne peut pas �tre mise en lien avec la Meurthe et Moselle (toutes les deux 54)

	
bysort sexe year :  egen float tot_emigr=total(emigr_recens_basic) if year==1861
*Il faut enlever les immigrants qui viennent des d�partements d'AL pour que l'�quilibre se fasse bien.

replace emigr_recens_basic = emigr_recens_basic *tot_immigr/tot_emigr if year==1861
bysort sexe year :  egen float test=total(emigr_recens_basic) if year==1861
assert tot_immigr==test

*drop tot_immigr tot_emigr


 
replace ratio_emigr_basic = emigr_recens_basic/(pop_fr-immigr_recens) if year==1861




/*	
***************************************************************************************
*Pour v�rifier les r�sultats

replace ratio_emigr_basic = emigr_recens_basic/(pop_fr-immigr_recens)
generate ratio_emigr = emigr_recens/(pop_fr-immigr_recens)

sort sexe dpt year
list dpt sexe year ratio_emigr ratio_emigr_basic if dpt==75

twoway (scatter ratio_emigr year) (scatter ratio_emigr_basic year) if dpt==75

preserve

collapse (sum) emigr_recens_basic immigr_ssAL_recens , by(year)

list

restore	

*keep dpt sexe year emigr_recens immigr_recens immigr_ssAL_recens pop_fr
*replace immigr_recens = immigr_ssAL_recens if year !=1861
*drop immigr_ssAL_recens
*/



save "$dir/Marges_migrations_done.dta", replace


exit

****


list dpt year sexe pop_fr_ssAL emigr_recens immigr_recens emig_frg_ssAL delta_immigr_ssAL /*
*/ delta_pop_fr_ssAL accroissnaturel10ans_fr_ssAL if emigr_recens<=0 

*Pour 1871, les d�partements avec emigrants n�gatifs sont le 20, 64, 66, 74 (Corse, Pyr�nn�es Atlantiques, Pyr�nn�es Orientales, Savoie)
*Tous des d�partements avec probablement pas mal d'�migration vers l'�tranger. 
*Et le 22 et 40 (C�tes-du-Nord et Dordogne) : des marins qui partent ?








