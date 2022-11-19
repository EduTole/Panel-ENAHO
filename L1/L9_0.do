cls
clear all
glo Data 	"D:\Dropbox\BASES\ENAHO\PANEL\2021\Download" 
glo Base 	"D:\Dropbox\BASES\ENAHO\PANEL\2021\Clean"
glo Out		"E:\EducatePeru\Stata\S9\Data"
glo Imagen	"E:\EducatePeru\Stata\S9\Imagen"

*	use "$Base\tmp340_bianual_1718.dta",clear
*	merge 1:1 numpanh Ano using "$Base\tmp100_bianual_1718.dta", keepusing(rluz ragua) keep(match master) nogen

	
foreach q  in 1718 1819 1920 2021{
	
	if `q'==1718{
	use "$Base\tmp340_bianual_`q'.dta",clear
	keep numpanh rpobre Ano ry rly rmiembros	
	reshape wide rpobre ry rly rmiembros, i(numpanh) j(Ano)
	
	g rvul=.
	replace rvul=1 if rpobre17==0 & rpobre18==1 /*cae en pobreza*/
	replace rvul=2 if rpobre17==1 & rpobre18==1 /*se mantiene en pobreza*/
	replace rvul=3 if rpobre17==0 & rpobre18==0 /*se matiene no no pobreza*/
	replace rvul=4 if rpobre17==1 & rpobre18==0 /*sale de pobreza*/
	
	label define rvul 1 "Cae en Pobreza" 2 "Mantiene Pobreza" 3 "Mantiene no pobre" 4 "Sale pobreza"
	label values rvul rvul
	label var rvul "== Vulnerailidad" 
	tab rvul
	
*	reshape long rvul, i(numpanh) j(Ano)
	rename (rpobre17 ry17 rly17 rmiembros17) (rpobre ry rly rmiembros)
	keep rvul numpanh rpobre ry rly rmiembros
	g rtime="t_`q'"
	
	merge 1:1 numpanh using "${Data}/sumaria-2017-2021-panel.dta",keepusing(facpanel`q') keep(match master) nogen
	
	display "-------------- Ano `q' ---------------------------------"
	duplicates report numpanh
	save "$Out\\data_vul_`q'",replace
	
	}
	
	if `q'==1819{
	use "$Base\tmp340_bianual_`q'.dta",clear	
	merge 1:1 numpanh Ano using "$Base\tmp100_bianual_`q'.dta",keepusing(rluz ragua) keep(match master) nogen
	keep numpanh rpobre Ano ry rly rmiembros	
	reshape wide rpobre ry rly rmiembros, i(numpanh) j(Ano)


	g rvul=.
	replace rvul=1 if rpobre18==0 & rpobre19==1 /*cae en pobreza*/
	replace rvul=2 if rpobre18==1 & rpobre19==1 /*se mantiene en pobreza*/
	replace rvul=3 if rpobre18==0 & rpobre19==0 /*se matiene no no pobreza*/
	replace rvul=4 if rpobre18==1 & rpobre19==0 /*sale de pobreza*/
	
	label define rvul 1 "Cae en Pobreza" 2 "Mantiene Pobreza" 3 "Mantiene no pobre" 4 "Sale pobreza"
	label values rvul rvul
	label var rvul "== Vulnerailidad" 
	tab rvul
	
*	reshape long rvul, i(numpanh) j(Ano)
	rename (rpobre18 ry18 rly18 rmiembros18) (rpobre ry rly rmiembros)
	keep rvul numpanh rpobre ry rly rmiembros

	g rtime="t_`q'"
	
	merge 1:1 numpanh using "${Data}/sumaria-2017-2021-panel.dta",keepusing(facpanel`q') keep(match master) nogen
	display "-------------- Ano `q' ---------------------------------"
	duplicates report numpanh
	
	save "$Out\\data_vul_`q'",replace
	
	}

	if `q'==1920{
	use "$Base\tmp340_bianual_`q'.dta",clear	
	merge 1:1 numpanh Ano using "$Base\tmp100_bianual_`q'.dta",keepusing(rluz ragua) keep(match master) nogen
	keep numpanh rpobre Ano ry rly rmiembros	
	reshape wide rpobre ry rly rmiembros, i(numpanh) j(Ano)

	g rvul=.
	replace rvul=1 if rpobre19==0 & rpobre20==1 /*cae en pobreza*/
	replace rvul=2 if rpobre19==1 & rpobre20==1 /*se mantiene en pobreza*/
	replace rvul=3 if rpobre19==0 & rpobre20==0 /*se matiene no no pobreza*/
	replace rvul=4 if rpobre19==1 & rpobre20==0 /*sale de pobreza*/
	
	label define rvul 1 "Cae en Pobreza" 2 "Mantiene Pobreza" 3 "Mantiene no pobre" 4 "Sale pobreza"
	label values rvul rvul
	label var rvul "== Vulnerailidad" 

	tab rvul
	
*	reshape long rvul, i(numpanh) j(Ano)
	rename (rpobre19 ry19 rly19 rmiembros19) (rpobre ry rly rmiembros)
	keep rvul numpanh rpobre ry rly rmiembros
	g rtime="t_`q'"
	
	merge 1:1 numpanh using "${Data}/sumaria-2017-2021-panel.dta",keepusing(facpanel`q') keep(match master) nogen
	
	display "-------------- Ano `q' ---------------------------------"
	duplicates report numpanh
	save "$Out\\data_vul_`q'",replace
	
	}

	if `q'==2021{
	use "$Base\tmp340_bianual_`q'.dta",clear	
	merge 1:1 numpanh Ano using "$Base\tmp100_bianual_`q'.dta",keepusing(rluz ragua) keep(match master) nogen
	keep numpanh rpobre Ano ry rly rmiembros	
	reshape wide rpobre ry rly rmiembros, i(numpanh) j(Ano)

	g rvul=.
	replace rvul=1 if rpobre20==0 & rpobre21==1 /*cae en pobreza*/
	replace rvul=2 if rpobre20==1 & rpobre21==1 /*se mantiene en pobreza*/
	replace rvul=3 if rpobre20==0 & rpobre21==0 /*se matiene no no pobreza*/
	replace rvul=4 if rpobre20==1 & rpobre21==0 /*sale de pobreza*/
	
	label define rvul 1 "Cae en Pobreza" 2 "Mantiene Pobreza" 3 "Mantiene no pobre" 4 "Sale pobreza"
	label values rvul rvul
	label var rvul "== Vulnerailidad" 

	tab rvul
	
*	reshape long rvul, i(numpanh) j(Ano)
	rename (rpobre20 ry20 rly20 rmiembros20) (rpobre ry rly rmiembros )
	keep rvul numpanh rpobre ry rly rmiembros

	g rtime="t_`q'"
	
	merge 1:1 numpanh using "${Data}/sumaria-2017-2021-panel.dta",keepusing(facpanel`q') keep(match master) nogen
			
	display "-------------- Ano `q' ---------------------------------"
	duplicates report numpanh
	save "$Out\\data_vul_`q'",replace
	
	}
	}

*** Informacion de base datos
*** ----------------------------------------------------
	
u "$Out\data_vul_1718.dta",clear
	append using "$Out\data_vul_1819.dta"
	append using "$Out\data_vul_1920.dta"
	append using "$Out\data_vul_2021.dta"

*** Creando el factor de expansion
egen rfactor=rowtotal(facpanel*)
drop facpanel*

tab rvul rtime
tab rvul rtime, col nofreq
tab rtime rvul , row nofreq
tab rtime rvul [iw=rfactor] , row nofreq


preserve
tab rvul, g(rvuln)
collapse (mean) rvuln1 [iw=rfactor] , by(rtime)
replace rvuln1=rvuln1*100

*format rvuln1 %15.2
graph bar rvuln1, over(rtime) blabel(bar, format(%9.1f)) ytitle("Porcentaje %") title("Poblacion que cae en Pobreza \%") 
graph export "$Imagen\\Figura_1.emf",replace
graph export "$Imagen\\Figura_1.png",replace
restore

