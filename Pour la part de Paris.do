**Pour calculer la part des migrants depuis Paris et vers Paris (en TRAR)

 use "/Users/guillaumedaudin/Documents/Recherche/Migrations/Construction BDD/Donnees migrations/Matrices_TRA_Recens.dta", clear
 
 
replace nbr_TRA_recens=0 if dptorigine==dptresid

egen nbr_migr = total(nbr_TRA_recens)
egen nbr_emigr = total(nbr_TRA_recens), by ( dptorigine)
egen nbr_immigr = total (nbr_TRA_recens), by ( dptresid)


egen nbr_migr_year = total(nbr_TRA_recens), by(annee)
egen nbr_emigr_year = total(nbr_TRA_recens), by (annee dptorigine)
egen nbr_immigr_year = total (nbr_TRA_recens), by (annee dptresid)

gen share_emigr = nbr_emigr/nbr_migr
gen share_immigr=nbr_immigr/nbr_migr

gen share_emigr_year = nbr_emigr_year/nbr_migr_year
gen share_immigr_year=nbr_immigr_year/nbr_migr_year

tab share_emigr if dptorigine==75
tab share_immigr if dptresid==75
