
set more off

tsset  dptresid annee_obs, delta(10)

label drop _all

** COL 1-2 & 5-6 
xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  i.annee_obs L1.norme_dest  L1.norme_ori L1.norm_dest_x_lnp_pop   L1.norm_ori_x_lnp_pop L1.lnp_pop_emigr L1.lnp_pop_immigr   if cylin==1 , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_Coal_migr_t_linlag,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(3)   label excel
drop f

xi: xtreg  f_obs i.annee_obs L1.norme_dest  L1.norme_ori L1.norm_dest_x_lnp_pop   L1.norm_ori_x_lnp_pop L1.lnp_pop_emigr L1.lnp_pop_immigr   if cylin==1 , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_Coal_migr_t_linlag,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(3)   label excel
drop f



** COL 3-4 & 7-8

xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes revuedesdeuxmondes_newsstand rd2M_fecParis i.annee_obs  L1.norme_dest  L1.norme_ori L1.norm_dest_x_lnp_pop   L1.norm_ori_x_lnp_pop L1.lnp_pop_emigr L1.lnp_pop_immigr   L1.lifeexpectancy15 L1.mortalityratio_1 L1.urban   L1.lnp_industrie  L1.lnp_professionsliberales  L1.lnwomen_education_10yb L1.lnmen_education_10yb L1.lnpropfillescongreganistes L1.lnpropgarconscongreganistes L1.revuedesdeuxmondes_newsstand L1.rd2M_fecParis if cylin==1, fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_Coal_migr_t_linlag,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(3)   label excel
drop f

xi: xtreg  f_obs  i.annee_obs  L1.norme_dest  L1.norme_ori L1.norm_dest_x_lnp_pop   L1.norm_ori_x_lnp_pop L1.lnp_pop_emigr L1.lnp_pop_immigr   L1.lifeexpectancy15 L1.mortalityratio_1 L1.urban   L1.lnp_industrie  L1.lnp_professionsliberales  L1.lnwomen_education_10yb L1.lnmen_education_10yb L1.lnpropfillescongreganistes L1.lnpropgarconscongreganistes L1.revuedesdeuxmondes_newsstand L1.rd2M_fecParis if cylin==1, fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_Coal_migr_t_linlag,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(3)   label excel
drop f


