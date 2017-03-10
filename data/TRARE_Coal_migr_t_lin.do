
set more off

tsset  dptresid annee_obs, delta(10)

label drop _all

**** 1821-1911
** Column 1 
xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  i.annee_obs   , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRARE_Coal_migr_t_lin,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(1)   label excel
drop f

**** 1821-1851
** Column 2 
xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  i.annee_obs  if annee_obs<1861 , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRARE_Coal_migr_t_lin,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(1)   label excel
drop f

**** 1861-1911
** Column 3 
xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  i.annee_obs  if cylin==1 &  annee_obs>1851 , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRARE_Coal_migr_t_lin,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(1)   label excel
drop f



