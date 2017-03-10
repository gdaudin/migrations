
set more off







tsset  dptresid annee_obs, delta(10)

label drop _all


** Columns 1 & 3


xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_Coal_migr_m_lin,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(1)   label excel
drop f

** Marginal effects


xi: xtreg  f_obs norme_dest   norme_ori  norm_dest_x_lnp_pop     norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr i.annee_obs if cylin==1    , fe robust  cluster(dptresid)
estimates store c
*foreach i in norme_dest  norm_dest_x_lnp_pop norm_dest_x_lnp_pop   {
foreach i in norme_dest  norm_dest_x_lnp_pop     {
            quietly summarize `i' if e(sample) 

            local mean`i'=r(mean)
}

display "for norme_dest "
nlcom _b[norme_dest]+_b[norm_dest_x_lnp_pop]*`meannorm_dest_x_lnp_pop', post
outreg2  using TRAR_Coal_migr_m_lin, br label excel


xi: xtreg  f_obs norme_dest norme_ori    norm_dest_x_lnp_pop                norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr i.annee_obs if cylin==1    , fe robust  cluster(dptresid)
estimates store c
****foreach i in f_dest_emigr_TRAR_Coal_p  f_d_lnp_pop_emigr_TRAR_Coal_p lnp_pop_emigr_TRAR_Coal_p l {
foreach i in norme_dest    norm_dest_x_lnp_pop  {
            quietly summarize `i' if e(sample) 

         local mean`i'=r(mean)
}
display "for lnp_pop_emigr_TRAR"
***nlcom _b[lnp_pop_emigr_TRAR_Coal_p]+ _b[xx]*`meanf_dest_emigr_TRAR_Coal_p '+ _b[l1_fert_obs_lnp_pop_emigr_TRAR_Coal_p]*`meanlag1_fert_obs'+ _b[_p], post
***nlcom _b[lnp_pop_emigr_TRAR_Coal_p]+ _b[xx]*`meanf_dest_emigr_TRAR_Coal_p '+ _b[l1_fert_obs_lnp_pop_emigr_TRAR_Coal_p]*`meanlag1_fert_obs', post
nlcom _b[norm_dest_x_lnp_pop]+ _b[norm_dest_x_lnp_pop]*`meannorme_dest ', post
outreg2  using TRAR_Coal_migr_m_lin, br label excel


xi: xtreg  f_obs norme_dest    norme_ori  norm_dest_x_lnp_pop              norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr i.annee_obs if cylin==1    , fe robust  cluster(dptresid)
estimates store c
****foreach i in f_dest_emigr_TRAR_Coal_p  f_d_lnp_pop_emigr_TRAR_Coal_p lnp_pop_emigr_TRAR_Coal_p   {
foreach i in norme_dest       norm_dest_x_lnp_pop    norm_ori_x_lnp_pop  {
            quietly summarize `i' if e(sample) 

            local mean`i'=r(mean)
}

display "for norme_ori"
nlcom _b[norme_ori ]+_b[norm_ori_x_lnp_pop]*`meannorm_ori_x_lnp_pop', post
outreg2  using TRAR_Coal_migr_m_lin, br label excel


xi: xtreg  f_obs norme_dest    norme_ori  norm_dest_x_lnp_pop             norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr i.annee_obs if cylin==1    , fe robust  cluster(dptresid)
estimates store c
foreach i in norme_ori  norm_dest_x_lnp_pop  norm_ori_x_lnp_pop    {
            quietly summarize `i' if e(sample) 

         local mean`i'=r(mean)
}
display "for norm_ori_x_lnp_pop"
nlcom _b[norm_ori_x_lnp_pop]+ _b[norm_ori_x_lnp_pop]*`meannorme_ori ', post
outreg2  using TRAR_Coal_migr_m_lin, br label excel

*************************








** Columns 2 & 4

xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes revuedesdeuxmondes_newsstand rd2M_fecParis i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_Coal_migr_m_lin,br addstat(Within R2, e(r2), Adjusted R2, e(r2_a), F-stat, e(F), Prob>F-stat, f) adec(3)   label excel
drop f

** Marginal effects


xi: xtreg  f_obs norme_dest   norme_ori  norm_dest_x_lnp_pop     norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes revuedesdeuxmondes_newsstand rd2M_fecParis i.annee_obs if cylin==1    , fe robust  cluster(dptresid)
estimates store c
*foreach i in norme_dest  norm_dest_x_lnp_pop norm_dest_x_lnp_pop   {
foreach i in norme_dest  norm_dest_x_lnp_pop     {
            quietly summarize `i' if e(sample) 

            local mean`i'=r(mean)
}

display "for norme_dest "
nlcom _b[norme_dest]+_b[norm_dest_x_lnp_pop]*`meannorm_dest_x_lnp_pop', post
outreg2  using TRAR_Coal_migr_m_lin, br label excel


xi: xtreg  f_obs norme_dest norme_ori    norm_dest_x_lnp_pop                norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes revuedesdeuxmondes_newsstand rd2M_fecParis i.annee_obs if cylin==1    , fe robust  cluster(dptresid)
estimates store c
****foreach i in f_dest_emigr_TRAR_Coal_p  f_d_lnp_pop_emigr_TRAR_Coal_p lnp_pop_emigr_TRAR_Coal_p l {
foreach i in norme_dest    norm_dest_x_lnp_pop  {
            quietly summarize `i' if e(sample) 

         local mean`i'=r(mean)
}
display "for lnp_pop_emigr_TRAR"
***nlcom _b[lnp_pop_emigr_TRAR_Coal_p]+ _b[xx]*`meanf_dest_emigr_TRAR_Coal_p '+ _b[l1_fert_obs_lnp_pop_emigr_TRAR_Coal_p]*`meanlag1_fert_obs'+ _b[_p], post
***nlcom _b[lnp_pop_emigr_TRAR_Coal_p]+ _b[xx]*`meanf_dest_emigr_TRAR_Coal_p '+ _b[l1_fert_obs_lnp_pop_emigr_TRAR_Coal_p]*`meanlag1_fert_obs', post
nlcom _b[norm_dest_x_lnp_pop]+ _b[norm_dest_x_lnp_pop]*`meannorme_dest ', post
outreg2  using TRAR_Coal_migr_m_lin, br label excel


xi: xtreg  f_obs norme_dest    norme_ori  norm_dest_x_lnp_pop              norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes  revuedesdeuxmondes_newsstand rd2M_fecParis i.annee_obs if cylin==1    , fe robust  cluster(dptresid)
estimates store c
****foreach i in f_dest_emigr_TRAR_Coal_p  f_d_lnp_pop_emigr_TRAR_Coal_p lnp_pop_emigr_TRAR_Coal_p   {
foreach i in norme_dest       norm_dest_x_lnp_pop    norm_ori_x_lnp_pop  {
            quietly summarize `i' if e(sample) 

            local mean`i'=r(mean)
}

display "for norme_ori"
nlcom _b[norme_ori ]+_b[norm_ori_x_lnp_pop]*`meannorm_ori_x_lnp_pop', post
outreg2  using TRAR_Coal_migr_m_lin, br label excel


xi: xtreg  f_obs norme_dest    norme_ori  norm_dest_x_lnp_pop             norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr  lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes  revuedesdeuxmondes_newsstand rd2M_fecParis i.annee_obs if cylin==1    , fe robust  cluster(dptresid)
estimates store c
foreach i in norme_ori  norm_dest_x_lnp_pop  norm_ori_x_lnp_pop    {
            quietly summarize `i' if e(sample) 

         local mean`i'=r(mean)
}
display "for norm_ori_x_lnp_pop"
nlcom _b[norm_ori_x_lnp_pop]+ _b[norm_ori_x_lnp_pop]*`meannorme_ori ', post
outreg2  using TRAR_Coal_migr_m_lin, br label excel

*************************
