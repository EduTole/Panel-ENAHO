
*Descarga de Informacion
cls
clear all
glo path 	"D:\Dropbox\BASES\ENAHO"
glo Data 	"D:\Dropbox\BASES\ENAHO\PANEL\2021\Download" 
glo disel	"${path}/DISEL-MTPE" // Informacion de mtpe
glo clean 	"D:\Dropbox\BASES\ENAHO\PANEL\2021\Clean"
*Crear la carpeta
cap mkdir "$clean"

*--------------------------------------------------------
* MANEJO DE BASE DE DATOS
*--------------------------------------------------------
* Definimos un global para las variables que tendre que construir en la base panel
	**********************************************************
	* PANEL MODULO 340 sumaria
	***********************************************************
glo var1821 "mes_18 mes_19 mes_20 mes_21 conglome_18 conglome_19 conglome_20 conglome_21 vivienda_18 vivienda_19 vivienda_20 vivienda_21 hogar_18 hogar_19 hogar_20 hogar_21 estrato_18 estrato_19 estrato_20 estrato_21 dominio_18 dominio_19 dominio_20 dominio_21  mieperho_18 mieperho_19 mieperho_20 mieperho_21 gashog2d_18 gashog2d_19 gashog2d_19 gashog2d_20 gashog2d_21 pobreza_18 pobreza_19 pobreza_20 pobreza_21 linea_18 linea_19 linea_20 linea_21 factor07_18 factor07_19 factor07_20 factor07_21 hpanel_1821 numpanh"
	
	*Variables finales
	local key_vars factor07 gashog2d mieperho linea mes conglome vivienda hogar pobreza numpanh Ano rpobre ry rly rbrecha rseveri rmiembros rpond time

		**********************************************************
	
	foreach q in 1821{
		
	*Informacion del 2018 a 2021		
		if `q'==1821{
		u $var1821 using "${Data}/sumaria-2017-2021-panel.dta", clear
		keep if hpanel_`q' ==1

		keep numpanh factor07_* gashog2d_* mieperho_* linea_* mes_* conglome_* vivienda_* hogar_* pobreza_*
		reshape long factor07_ gashog2d_ mieperho_ linea_ mes_ conglome_ vivienda_ hogar_  pobreza_  , i(numpanh) j(Ano)
		*rkids* rkids6* rkids12* rnkids* rnkids6* rnkids12*
	
		foreach i in 2018 2019 2020 2021{
		local j=`i'-2000
		replace Ano=20`j' if Ano==`i'
		}
	
	rename (factor07_ gashog2d_ mieperho_ linea_ mes_ conglome_ vivienda_ hogar_ pobreza_ ) (factor07 gashog2d mieperho linea mes conglome vivienda hogar pobreza )
	
		do "${disel}/r0.-rpobre.do"
		g time="`q'"

		duplicates drop conglome vivienda hogar Ano , force
		duplicates report conglome vivienda hogar  Ano	
		
		}
	g yy=`q'
	keep yy `key_vars'
	d
	saveold "${clean}/tmp340_trianual_`q'.dta",replace		
}

*** Panel bianuales
*********************************
glo var1718 "mes_17 mes_18 conglome_18 conglome_17 vivienda_18 vivienda_17 hogar_18 hogar_17 estrato_18 estrato_17 dominio_18 dominio_17 mieperho_18 mieperho_17 gashog2d_18 gashog2d_17 pobreza_18 pobreza_17 linea_18 linea_17 factor07_18 factor07_17 hpanel_1718 numpanh"

glo var1819 "mes_18 mes_19 conglome_18 conglome_19 vivienda_18 vivienda_19 hogar_18 hogar_19 estrato_18 estrato_19 dominio_18 dominio_19 mieperho_18 mieperho_19 gashog2d_18 gashog2d_19 pobreza_18 pobreza_19 linea_18 linea_19 factor07_18 factor07_19 hpanel_1819 numpanh"

glo var1920 "mes_19 mes_20 conglome_19 conglome_20 vivienda_19 vivienda_20 hogar_19 hogar_20 estrato_19 estrato_20 dominio_19 dominio_20 mieperho_19 mieperho_20 gashog2d_19 gashog2d_20 pobreza_19 pobreza_20 linea_19 linea_20 factor07_19 factor07_20 hpanel_1920 numpanh"

glo var2021 "mes_20 mes_21 conglome_20 conglome_21 vivienda_20 vivienda_21 hogar_20 hogar_21 estrato_20 estrato_21 dominio_20 dominio_21 mieperho_20 mieperho_21 gashog2d_20 gashog2d_21 pobreza_20 pobreza_21 linea_20 linea_21 factor07_20 factor07_21 hpanel_2021 numpanh"


	foreach q in 1718 1819 1920 2021 {	
	
	*Informacion del 2017 a 2018		
		if `q'==1718{
		u $var1718 using "${Data}/sumaria-2017-2021-panel.dta", clear
		keep if hpanel_`q' ==1

		keep numpanh factor07_* gashog2d_* mieperho_* linea_* mes_* conglome_* vivienda_* hogar_* pobreza_*
		reshape long factor07_ gashog2d_ mieperho_ linea_ mes_ conglome_ vivienda_ hogar_  pobreza_  , i(numpanh) j(Ano)
		*rkids* rkids6* rkids12* rnkids* rnkids6* rnkids12*
	
		foreach i in 2017 2018{
		local j=`i'-2000
		replace Ano=20`j' if Ano==`i'
		}
	
	rename (factor07_ gashog2d_ mieperho_ linea_ mes_ conglome_ vivienda_ hogar_ pobreza_ ) (factor07 gashog2d mieperho linea mes conglome vivienda hogar pobreza )
	
		do "${disel}/r0.-rpobre.do"
		g time="t`q'"

		duplicates drop conglome vivienda hogar Ano , force
		duplicates report conglome vivienda hogar  Ano	
		
		merge m:1 numpanh using "${Data}/sumaria-2017-2021-panel.dta",keepusing(facpanel`q') keep(match master) nogen


		}
		
		
		*Informacion del 2018 a 2019		
		if `q'==1819{
		u $var1819 using "${Data}/sumaria-2017-2021-panel.dta", clear
		keep if hpanel_`q' ==1

		keep numpanh factor07_* gashog2d_* mieperho_* linea_* mes_* conglome_* vivienda_* hogar_* pobreza_*
		reshape long factor07_ gashog2d_ mieperho_ linea_ mes_ conglome_ vivienda_ hogar_  pobreza_  , i(numpanh) j(Ano)
		*rkids* rkids6* rkids12* rnkids* rnkids6* rnkids12*
	
		foreach i in 2018 2019{
		local j=`i'-2000
		replace Ano=20`j' if Ano==`i'
		}
	
	rename (factor07_ gashog2d_ mieperho_ linea_ mes_ conglome_ vivienda_ hogar_ pobreza_ ) (factor07 gashog2d mieperho linea mes conglome vivienda hogar pobreza )
	
		do "${disel}/r0.-rpobre.do"
		g time="t`q'"

		duplicates drop conglome vivienda hogar Ano , force
		duplicates report conglome vivienda hogar  Ano	
		
		merge m:1 numpanh using "${Data}/sumaria-2017-2021-panel.dta",keepusing(facpanel`q') keep(match master) nogen


		}
		
	*Informacion del 2019 a 2020		
		if `q'==1920{
		u $var1920 using "${Data}/sumaria-2017-2021-panel.dta", clear
		keep if hpanel_`q' ==1

		keep numpanh factor07_* gashog2d_* mieperho_* linea_* mes_* conglome_* vivienda_* hogar_* pobreza_*
		reshape long factor07_ gashog2d_ mieperho_ linea_ mes_ conglome_ vivienda_ hogar_  pobreza_  , i(numpanh) j(Ano)
		*rkids* rkids6* rkids12* rnkids* rnkids6* rnkids12*
	
		foreach i in 2019 2020{
		local j=`i'-2000
		replace Ano=20`j' if Ano==`i'
		}
	
	rename (factor07_ gashog2d_ mieperho_ linea_ mes_ conglome_ vivienda_ hogar_ pobreza_ ) (factor07 gashog2d mieperho linea mes conglome vivienda hogar pobreza )
	
		do "${disel}/r0.-rpobre.do"
		g time="t`q'"

		duplicates drop conglome vivienda hogar Ano , force
		duplicates report conglome vivienda hogar  Ano	

		merge m:1 numpanh using "${Data}/sumaria-2017-2021-panel.dta",keepusing(facpanel`q') keep(match master) nogen
		
		}

	*Informacion del 2020 a 2021		
		if `q'==2021{
		u $var2021 using "${Data}/sumaria-2017-2021-panel.dta", clear
		keep if hpanel_`q' ==1

		keep numpanh factor07_* gashog2d_* mieperho_* linea_* mes_* conglome_* vivienda_* hogar_* pobreza_*
		reshape long factor07_ gashog2d_ mieperho_ linea_ mes_ conglome_ vivienda_ hogar_  pobreza_  , i(numpanh) j(Ano)
		*rkids* rkids6* rkids12* rnkids* rnkids6* rnkids12*
	
		foreach i in 2020 2021{
		local j=`i'-2000
		replace Ano=20`j' if Ano==`i'
		}
	
	rename (factor07_ gashog2d_ mieperho_ linea_ mes_ conglome_ vivienda_ hogar_ pobreza_ ) (factor07 gashog2d mieperho linea mes conglome vivienda hogar pobreza )
	
		do "${disel}/r0.-rpobre.do"
		g time="t`q'"
		duplicates drop conglome vivienda hogar Ano , force
		duplicates report conglome vivienda hogar  Ano	
		
		merge m:1 numpanh using "${Data}/sumaria-2017-2021-panel.dta",keepusing(facpanel`q') keep(match master) nogen

		}			
		
	g yy=`q'
	keep yy `key_vars' facpanel*
	d
	saveold "${clean}/tmp340_bianual_`q'.dta",replace		
}
	
	