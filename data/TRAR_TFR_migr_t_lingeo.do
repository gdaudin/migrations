
set more off






keep if cylin==1
tsset  dptresid annee_obs, delta(10)


** Columns 1 & 3

xsmle   f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr    , fe robust  cluster(dptresid) wmat(WS)
outreg2 using TRAR_TFR_migr_t_lingeo,br addstat(Within R2, e(r2_w), R2, e(r2), Log-pseudolikelihood, e(ll), Mean of fixed effects, e(a_avg)) adec(1)   label excel

*xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
*generate f=Fden(e(df_m),e(df_r),e(F))
*outreg2 using TRAR_TFR_migr_t_lin,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(1)   label excel
*drop f





** Columns 2 & 4
xsmle   f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes revuedesdeuxmondes_newsstand rd2M_fecParis    , fe robust  cluster(dptresid) wmat(WS)
outreg2 using TRAR_TFR_migr_t_lingeo,br addstat(Within R2, e(r2_w), R2, e(r2), Log-pseudolikelihood, e(ll), Mean of fixed effects, e(a_avg)) adec(1)   label excel

*xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes revuedesdeuxmondes_newsstand rd2M_fecParis i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
*generate f=Fden(e(df_m),e(df_r),e(F))
*outreg2 using TRAR_TFR_migr_t_lin,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(3)   label excel
*drop f


