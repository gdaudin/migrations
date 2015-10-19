
set more off




*** Table ALL Columns - TRAR - 

tsset  dptresid annee_obs, delta(10)

label drop _all

******************************

label var f_obs "log(Fertility) (t)"
label var lag1_f_obs "log(Fertility) (t-1)"
label var p_industrie "Industries t-1"
label var p_professionsliberales "Professionals (t)"
label var lifeexpectancy15 "Life Expectancy at Age 30 (t)"
label var mortalityratio_1 "Infant Mortality (t)"
label var urban "log(Urban) (t)"
label var lnp_industrie "log(Industries) (t)"
label var lnp_professionsliberales "log(Professionals) (t)"
gen lag1_mortalityratio_1=L1.mortalityratio_1 
label var lag1_mortalityratio_1  "Infant Mortality (t-1)"
gen lag1_urban=L1.urban
label var lag1_urban "log(Urban) (t-1)"
label var lag1_lnp_industrie "log (Industries) (t-1)"
label var lag1_lnp_professionsliberales "log(Professionals) (t-1)"


*******************************

*********************************************************************
gen lag1_lifexpectancy15=L1.lifeexpectancy15
label var lag1_lifexpectancy15 "Life Expectancy Age 15 (t-1)"
label var lifeexpectancy15 "Life Expectancy Age 15 (t)"


*gen lnpropelevescongreganistes=log(propelevescongreganistes)
*gen lnpropfillescongreganistes=log(propfillescongreganistes)
*gen lnpropgarconscongreganistes=log(garconscongreganistes)
label var lnpropelevescongreganistes "log(Share of Pupils in Primary Catholic Schools) (t)"
label var lnpropfillescongreganistes "log(Share of Girls in Primary Catholic Schools) (t)"
label var lnpropgarconscongreganistes "log(Share of Boys in Primary Catholic Schools) (t)"



label var lnwomen_education_10yb "log(Female Education (t))"
label var lag1_lnwomen_education_10yb  "log(Female Education (t-1))"
label var lnmen_education_10yb "log(Male Education (t))"
label var lag1_lnmen_education_10yb "log(Male Education (t-1))"

gen  female_not_recognized=1-femalerecognized
gen  male_not_recognized=1-malerecognized
gen  children_not_recognized=1- childrenrecognized

replace children_not_recognized = log(1+children_not_recognized)
replace female_not_recognized= log(1+female_not_recognized)
replace male_not_recognized= log(1+male_not_recognized)


replace  totalnumberofperiodicals= log(1+ totalnumberofperiodicals)
replace childrenrecognized = log(1+childrenrecognized)
replace femalerecognized= log(1+femalerecognized)
replace malerecognized= log(1+malerecognized)
replace childrenoutwedlock = log(1+childrenoutwedlock)
replace femaleoutwedlock = log(1+femaleoutwedlock)
replace maleoutwedlock = log(1+maleoutwedlock)
replace mariesf3539= log(1+mariesf3539)
replace mariesm3539= log(1+mariesm3539)
replace mariesf3034 = log(1+mariesf3034)
replace mariesm3034= log(1+mariesm3034)
replace mariesf2529 = log(1+mariesf2529)
replace mariesm2529 = log(1+mariesm2529)
replace mariesf2024 = log(1+mariesf2024)
replace mariesm2024= log(1+mariesm2024)

drop if annee_obs==1841









** Columns 2 & 5

xi: xtreg  f_obs norme_dest   norme_ori norm_dest_x_lnp_pop   norm_ori_x_lnp_pop lnp_pop_emigr lnp_pop_immigr lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_migr_t_lin_varbadcontrols_checks,br addstat(within r2, e(r2), adjusted r2, e(r2_a), f-stat, e(F), prob > f, f) adec(2)   label excel
drop f


xi: xtreg  f_obs norme_dest   lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_migr_t_lin_varbadcontrols_checks,br addstat(within r2, e(r2), adjusted r2, e(r2_a), f-stat, e(F), prob > f, f) adec(2)   label excel
drop f


xi: xtreg  f_obs    norme_ori  lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_migr_t_lin_varbadcontrols_checks,br addstat(within r2, e(r2), adjusted r2, e(r2_a), f-stat, e(F), prob > f, f) adec(2)   label excel
drop f

xi: xtreg  f_obs norme_dest   norme_ori lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_migr_t_lin_varbadcontrols_checks,br addstat(within r2, e(r2), adjusted r2, e(r2_a), f-stat, e(F), prob > f, f) adec(2)   label excel
drop f

xi: xtreg  f_obs  lnp_pop_emigr  lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_migr_t_lin_varbadcontrols_checks,br addstat(within r2, e(r2), adjusted r2, e(r2_a), f-stat, e(F), prob > f, f) adec(2)   label excel
drop f

xi: xtreg  f_obs  lnp_pop_immigr lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_migr_t_lin_varbadcontrols_checks,br addstat(within r2, e(r2), adjusted r2, e(r2_a), f-stat, e(F), prob > f, f) adec(2)   label excel
drop f

xi: xtreg  f_obs lnp_pop_emigr lnp_pop_immigr lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_migr_t_lin_varbadcontrols_checks,br addstat(within r2, e(r2), adjusted r2, e(r2_a), f-stat, e(F), prob > f, f) adec(2)   label excel
drop f

xi: xtreg  f_obs norme_dest   norme_ori lnp_pop_emigr lnp_pop_immigr lifeexpectancy15 mortalityratio_1 urban   lnp_industrie  lnp_professionsliberales  lnwomen_education_10yb lnmen_education_10yb lnpropfillescongreganistes lnpropgarconscongreganistes i.annee_obs if cylin==1  , fe robust  cluster(dptresid)
generate f=Fden(e(df_m),e(df_r),e(F))
outreg2 using TRAR_migr_t_lin_varbadcontrols_checks,br addstat(within r2, e(r2), adjusted r2, e(r2_a), f-stat, e(F), prob > f, f) adec(2)   label excel
drop f

clear
log close
