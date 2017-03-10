
*** Table ALL Columns - TRAR - 



tsset  dptresid annee_obs, delta(10)

keep if cylin==1

xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes  revuedesdeuxmondes_newsstand rd2M_fecParis i.annee_obs if cylin==1  , fe robust  cluster(dptresid)


sort  dptresid annee_obs
quietly by dptresid: replace norme_dest=norme_dest[_n-1] if  norme_dest[_n-1]~=.


sort  dptresid annee_obs
quietly by dptresid: replace norm_dest_x_lnp_pop=norm_dest_x_lnp_pop[_n-1] if  norm_dest_x_lnp_pop[_n-1]~=.


sort  dptresid annee_obs
quietly by dptresid: replace norme_ori=norme_ori[_n-1] if  norme_ori[_n-1]~=.

sort  dptresid annee_obs
quietly by dptresid: replace  norm_ori_x_lnp_pop= norm_ori_x_lnp_pop[_n-1] if   norm_ori_x_lnp_pop[_n-1]~=.

sort  dptresid annee_obs
quietly by dptresid: replace lnp_pop_emigr=lnp_pop_emigr[_n-1] if lnp_pop_emigr[_n-1]~=.


sort  dptresid annee_obs
quietly by dptresid: replace lnp_pop_immigr=lnp_pop_immigr[_n-1] if lnp_pop_immigr[_n-1]~=.

sort  dptresid annee_obs
quietly by dptresid: replace rd2M_fecParis=rd2M_fecParis[_n-1] if rd2M_fecParis[_n-1]~=.



predict f_obs_counterfactual_deor0, xb

gen ef_obs=exp(f_obs)
gen ef_obs_counterfactual_deor0=exp(f_obs_counterfactual_deor0)

sort yearid





