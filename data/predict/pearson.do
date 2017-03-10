 keep if cylin==1
 sort annee_obs
 by annee_obs: egen pearsonstat=sum((ef_obs_predict-ef_obs)^2/ef_obs_predict)
 
 