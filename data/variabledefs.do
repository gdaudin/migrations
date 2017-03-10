
*do "C:\Users\User\Documents\Migrations\data\variabledefs.do"

tsset  dptresid annee_obs, delta(10)

label drop _all

******************************

label var f_obs "log(Fertility) (t)"
label var lag1_f_obs "log(Fertility) (t-1)"
label var p_industrie "Industries t-1"
label var p_professionsliberales "Professionals (t)"
label var    lifeexpectancy15 "Life Expectancy at Age 30 (t)"
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


label var rd2M_fecParis "Revue des Deux Mondes Outlets (t)* Fertility of Seine (t)"
label var revuedesdeuxmondes_newsstand "Revue des Deux Mondes Outlets (t)"


label var norme_dest "Emigrants' Residence Norm (t)"
label var norme_ori   "Immigrants' Birthplace Norm (t)"
label var norm_dest_x_lnp_pop "Emigrants' Residence Norm (t) * Share of Emigrants(t)"
label var norm_ori_x_lnp_pop "Immigrants' Birthplace Norm (t)* Share of Immigrants (t)"
label var lnp_pop_emigr "Share of Emigrants (t)"
label var lnp_pop_immigr "Share of Immigrants (t)"


label var eglise "New Catholic Church"
label var egliseorthodoxe "New Orthodox Church"
label var templeprotestant "New Protestant Temple"
label var logemaconnique "New Freemason Lodge"
