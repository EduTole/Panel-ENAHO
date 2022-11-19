
*Descarga de Informacion
cls
clear all
glo path 	"D:\Dropbox\BASES\ENAHO"
glo Data 	"D:\Dropbox\BASES\ENAHO\PANEL\2021\Clean"
glo disel	"${path}/DISEL-MTPE" // Informacion de mtpe
glo Out 	"E:\EducatePeru\Stata\S9\Data" 

*Crear la carpeta
cap mkdir "$clean"

*=======================================================
* union de modulos
*=======================================================
	foreach q in 1821{	
	u "${Data}/tmp500_trianual_`q'.dta",clear
	merge 1:1 p201pcor Ano using "${Data}/tmp300_trianual_`q'.dta",keep(match) keepusing(reduca rlengua) nogen
	}
	mdesc

	*Solo a los jefes de hogar
	keep if p203==1
	
	*Solo ingresos mayores al 5% de su distribucion
	sum r6, detail
	local p5=r(p5)
	keep if r6>`p5'
	
	mdesc
	keep if reduca!=.
	keep if r3!=.	
	
	*------------------------------------
	* Generacion de variable experiencia
	*------------------------------------
	*Variable experiencia
	*Experiencia laboral 
	/*
	gen a_exper=p208a-reduca-5 if ocu500<=3 & p208a>0
	replace a_exper=. if a_exper<=1 
	
	gen b_exper=p208a-14 if ocu500<=3 & p208a>0
	replace b_exper=. if b_exper<=1
	gen rexper = min(a_exper, b_exper)	
	g rexpersq=rexper*rexper	
	*/
	do "${disel}/55.- rexper.do"

	*Generacion de variables de mujer
	g rmujer=(p207==2)
	label var rmujer "=1 si es mujer"
	*Generacion informalidad
	g rinfo=(ocupinf==1)
	label var rinfo "=1 si es informal"
	
	sum r6 rexper reduca
	
	*Codigo 
	egen codigo_persona=concat(conglome vivienda hogar codperso)
	
	* Construccion de Panel Data de observaciones (personas)
	*--------------------------------------------------------------
	
	preserve
	collapse (count) Ano, by(p201pcor  ) //lista de empresas unicas
	gsort -p201pcor  
	gen id = (_n) //numero correlativo
	g panel=Ano	
	tab panel
	tempfile DATA1
	save `DATA1', replace
	restore
	
	merge m:1 p201pcor using `DATA1' , keepusing(id panel) nogen
	
	*Solo se filtra los casos panel
	tab panel
	tab Ano 
	tab Ano if panel==4
	keep if panel==4
	
	
	*Las variables que se usaran
	keep p201pcor Ano rmu r6 rmujer rexper rexpersq rgedad_2 rgedad_1 reduca r8 rArea rDpto rinfo r11 rmu rpea rflp
	order p201pcor Ano rmu r6 rmujer rexper rexpersq rgedad_2 rgedad_1 reduca r8 rArea rDpto rinfo r11 rmu rpea rflp
	
	saveold "${Out}/BD9.dta",replace

	
	