
version 15.1
global dir "~/Documents/Recherche/2010 Migrations/Construction BDD"
capture restore
set more off
set matsize 8000


capture program drop corr_p_o
program corr_p_o
args data fert sexe paris norme ponderation

							
use  "$dir/BDD_`data'_`fert'_`sexe'_o_`paris'_`norme'_`ponderation'_var.dta", clear


keep annee_obs dptresid f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr
rename * *_o
rename annee_obs_o annee_obs
rename dptresid_o dptresid



merge 1:1 annee_obs dptresid using   "$dir/BDD_`data'_`fert'_`sexe'_p_`paris'_`norme'_`ponderation'_var.dta"

	foreach v in norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr {
		rename `v' `v'_p
		corr `v'_o `v'_p
	}
	


end



corr_p_o TRAR Coal t P migr30 log


/*

foreach data in TRAR RE TRA {
	foreach fert in Coal CBR {
		foreach sexe in t m f {
				foreach paris in P SP 	{
					foreach norme in migr migr30 {
						foreach ponderation in log lin {

						}
					}
				}
			}
		}
	}



