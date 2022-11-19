*Descarga de Informacion
cls
clear all
gl ubicacion "D:\Dropbox\BASES\ENAHO\PANEL" 
cap mkdir "$ubicacion"


if 1==1{

	mat ENAHO=(763)
	mat MENAHO=J(1,6,0)
	mat MENAHO[1,1]=(1474,1475,1476,1477,1478,1479)	
}

matlist ENAHO
matlist MENAHO

forvalues i=21/21{
	local year=2000
	local year=`year'+`i'
	local t=`i'-20
	
	cd "$ubicacion"
	cap mkdir `year'
	cd `year'

	cap mkdir "Download"
	cd "Download"
	
	scalar r_enaho=ENAHO[`t',1]
*Modulo 01-05 --> modulos hogar y persona	
		foreach j in 1 2 3 4 5 6{
		scalar r_menaho=MENAHO[`t',`j']
		display "`year'" " " r_enaho " " r_menaho
		local mod=r_enaho
		local i=r_menaho
		display "`i'" " " "`year'" " " "`mod'"
		cap copy http://iinei.inei.gob.pe/iinei/srienaho/descarga/STATA/`mod'-Modulo`i'.zip enaho_`year'_mod_`i'.zip 
		cap unzipfile enaho_`year'_mod_`i'.zip, replace
		cap erase enaho_`year'_mod_`i'.zip
		}
		
		
}

*Colocar data on files 
*------------------------------------------------------		
global ubicacion "D:\Dropbox\BASES\ENAHO\PANEL" 


if 1==1{
	mat ENAHO=(763)
	mat MENAHO=J(1,6,0)
	mat TENAHO=J(1,6,0)
	
	mat MENAHO[1,1]=(1474,1475,1476,1477,1478,1479)	
	
	mat TENAHO[1,1]=(100, 300, 400, 500, 500,200)

	
}

forvalues i=21/21{
	local year=2000
	local year=`year'+`i'
	local t=`i'-20

 	cd "$ubicacion"
	cap mkdir `year'
	cd `year'
	global BaseFinal "D:\Dropbox\BASES\ENAHO\\`year'"
	cap mkdir "$BaseFinal"
	
	cd "Download"

*Modulo 01-04 --> Modulos de hogar	
	scalar r_enaho=ENAHO[`t',1]
		foreach j in 1 {
		scalar r_menaho=MENAHO[`t',`j']
		scalar r_tenaho=TENAHO[`t',`j']
		display "`year'" " " r_enaho " " r_menaho " " r_tenaho
		local mod=r_enaho
		local i=r_menaho
		local k=r_tenaho
		display "`i'" " " "`year'" " " "`mod'" " "  "`k'"
		cap copy "`mod'-Modulo`i'\\enaho01-2017-2021-`k'-panel.dta" "enaho01-2017-2021-`k'-panel.dta"
		u "enaho01-2017-2021-`k'-panel.dta",clear
		saveold "$BaseFinal\\enaho01-2017-2021-`k'-panel.dta",replace
		}

*Modulo 300-400-500 --> Modulos de hogar	
	scalar r_enaho=ENAHO[`t',1]
		foreach j in 2 3 4 {
		scalar r_menaho=MENAHO[`t',`j']
		scalar r_tenaho=TENAHO[`t',`j']
		display "`year'" " " r_enaho " " r_menaho " " r_tenaho
		local mod=r_enaho
		local i=r_menaho
		local k=r_tenaho
		display "`i'" " " "`year'" " " "`mod'" " "  "`k'"
		cap copy "`mod'-Modulo`i'\\enaho01a-2017-2021-`k'-panel.dta" "enaho01a-2017-2021-`k'-panel.dta"
		set maxvar 120000 , permanently
		u "enaho01a-2017-2021-`k'-panel.dta",clear
		saveold "$BaseFinal\\enaho01a-2017-2021-`k'-panel.dta",replace
		}

		
}
7

"/iinei/srienaho/descarga/STATA/763-Modulo1474.zip"