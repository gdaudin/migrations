*Dans ce programme, nous essayons de compléter TRAR pour les périodes 1851-1811.
*Le souci est que nous n'avons pas de % d'immigrants pour ces périodes
*Donc nous allons essayer de l'estimer à partir des données TRA
*Puis faire du RAS (dans un autre programme)


global dir "~/Documents/Recherche/Migrations/Construction BDD"

use "$dir/Donnees migrations/Matrices_TRA_Recens.dta", clear

keep if annee==1861

egen nbr_TRAR_resid=sum(nbr_TRA_recens), by(annee dptresid sexe)
egen nbr_TRAR_origi=sum(nbr_TRA_recens), by(annee dptorigine sexe)


