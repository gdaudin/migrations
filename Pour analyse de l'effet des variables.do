
****Ce programme étudie les effets sur la fécondité prédite des différentes variables : stocks de migrants, normes et les deux ensemble
*Cela étudie ce qui arrive aux départements à basse et à haute fécondité
*L'augmentation des stocks a très peu d'effet au final
*L'évolution globale repose en gros sur l'évolution des normes
*Le déclin des normes est un peu plus rapide pour les départements à haute fécondité de départ : cela explique la convergence


set more off

display "`c(username)'"
if strmatch("`c(username)'","*daudin*")==1 {
	global dir "~/Dropbox/Migrations"
	cd "$dir"

}




do "$dir/do Github/migrations/Régressions 2nd stage.do"

capture reg_me TRAR t p P standard

estimates restore c

keep if e(sample)
keep if year == 1861 | year== 1911
tsset  dptresid annee_obs, delta(10)


predict fert_predict

preserve



foreach type_norme in ori dest {

restore
preserve

if "`type_norme'"=="ori" local type_pop immigr
if "`type_norme'"=="dest" local type_pop emigr


generate delta_norme_`type_norme' = exp(norme_`type_norme') - exp(L5.norme_`type_norme') if year==1911

replace norme_`type_norme' = L5.norme_`type_norme' if year==1911
replace  norm_`type_norme'_x_lnp_pop = norme_`type_norme'*ln(p_pop_`type_pop'+1) if year==1911


estimates restore c
predict fert_ss_norme_`type_norme'

generate delta_fert_pred=exp(fert_predict) - exp(L5.fert_predict) if year==1911
generate delta_fert_ssnorme_`type_norme' = exp(fert_ss_norme_`type_norme') - exp(L5.fert_predict) if year==1911
generate delta_fert_quenorme_`type_norme' = delta_fert_pred-delta_fert_ssnorme_`type_norme'
generate share_norme_`type_norme' = (abs(delta_fert_pred)-abs(delta_fert_ssnorme_`type_norme'))/abs(delta_fert_pred)



label var share_norme_`type_norme' "Part de la baisse expliquée par norme_`type_norme'"


display "Norme : `type_norme'"
keep if year==1911
summarize delta_fert_pred delta_norme_`type_norme'  delta_fert_ssnorme_`type_norme' delta_fert_quenorme_`type_norme', det

bys low_fert_1861 : summarize delta_fert_pred delta_norme_`type_norme'  delta_fert_ssnorme_`type_norme' delta_fert_quenorme_`type_norme', det

}

foreach type_pop in immigr emigr {

restore
preserve

if "`type_pop'"=="immigr" local type_norme ori
if "`type_pop'"=="emigr" local type_norme dest


generate delta_pop_`type_pop' = (exp(lnp_pop_`type_pop')-1) - (exp(L5.lnp_pop_`type_pop')-1) if year==1911

replace lnp_pop_`type_pop' = L5.lnp_pop_`type_pop' if year==1911
replace p_pop_`type_pop'   = L5.p_pop_`type_pop'   if year==1911
replace  norm_`type_norme'_x_lnp_pop = norme_`type_norme'*ln(p_pop_`type_pop'+1) if year==1911


estimates restore c
predict fert_ss_pop_`type_pop'

generate delta_fert_pred=exp(fert_predict) - exp(L5.fert_predict) if year==1911
generate delta_fert_sspop_`type_pop' = exp(fert_ss_pop_`type_pop') - exp(L5.fert_predict) if year==1911
generate share_pop_`type_pop' = (abs(delta_fert_pred)-abs(delta_fert_sspop_`type_pop'))/abs(delta_fert_pred)
generate delta_fert_quepop_`type_pop' = delta_fert_pred-delta_fert_sspop_`type_pop'

label var share_pop_`type_pop' "Part de la baisse expliquée par pop_`type_pop'"

display "Pop : `type_pop'"
keep if year==1911
summarize delta_fert_pred delta_pop_`type_pop'  delta_fert_sspop_`type_pop' delta_fert_quepop_`type_pop', det

bys low_fert_1861 : summarize delta_fert_pred delta_pop_`type_pop'  delta_fert_sspop_`type_pop' delta_fert_quepop_`type_pop', det

}

foreach type_pop in immigr emigr {

restore
preserve

if "`type_pop'"=="immigr" local type_norme ori
if "`type_pop'"=="emigr" local type_norme dest


generate delta_pop_`type_pop' = (exp(lnp_pop_`type_pop')-1) - (exp(L5.lnp_pop_`type_pop')-1) if year==1911

replace lnp_pop_`type_pop' = L5.lnp_pop_`type_pop' if year==1911
replace p_pop_`type_pop'   = L5.p_pop_`type_pop'   if year==1911
replace norme_`type_norme' = L5.norme_`type_norme' if year==1911
replace  norm_`type_norme'_x_lnp_pop = norme_`type_norme'*ln(p_pop_`type_pop'+1) if year==1911


estimates restore c
predict fert_ss_`type_pop'

generate delta_fert_pred=exp(fert_predict) - exp(L5.fert_predict) if year==1911
generate delta_fert_ss_`type_pop' = exp(fert_ss_`type_pop') - exp(L5.fert_predict) if year==1911
generate share_`type_pop' = (abs(delta_fert_pred)-abs(delta_fert_ss_`type_pop'))/abs(delta_fert_pred)
generate delta_fert_que_`type_pop' = delta_fert_pred-delta_fert_ss_`type_pop'

label var share_`type_pop' "Part de la baisse expliquée par `type_pop' (populations et normes)"

display "Pop : `type_pop'"
keep if year==1911
summarize delta_fert_pred  delta_fert_ss_`type_pop' delta_fert_que_`type_pop', det

bys low_fert_1861 : summarize delta_fert_pred delta_fert_ss_`type_pop' delta_fert_que_`type_pop', det

}



