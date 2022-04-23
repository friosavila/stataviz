use http://fmwww.bc.edu/RePEc/bocode/o/oaxaca.dta, clear
set scheme s1color
gen mstatus=single +2*married +3*divorced
label define mstatus 1 single 2 married 3 divorced
label values mstatus mstatus
   
label define female 0 Male 1 Female
label values female female  
two (kdensity lnwage if mstatus==1 , recast(area)) ///
    (kdensity lnwage if mstatus==2 , recast(area)) ///
    (kdensity lnwage if mstatus==3 , recast(area)), ///   
	legend(order(1 "Single" 2 "Married" 3 "Divorced")) 
	
graph export joy1.png, replace height(400)	

joy_plot lnwage, over(mstatus)
graph export joy2.png, replace height(400)	   

joy_plot lnwage, over(mstatus) gap0 color(%50)
graph export joy3.png, replace height(400)	

joy_plot lnwage, over(mstatus) dadj(3)  alegend legend(cols(3)) 
graph export joy4.png, replace height(400)	

joy_plot lnwage, over(mstatus) dadj(1) violin  iqr
graph export joy5.png, replace height(400)	

qui:color_style, list
joy_plot lnwage, over(educ) dadj(3)  ///
bwadj2(.5) right  colorpalette(vangogh1, opacity(80)) lcolor(white) 
graph export joy6.png, replace height(400)	

set scheme white
color_style ozuna,  
joy_plot lnwage, over(mstatus) by(female) dadj(2) alegend fcolor(%10)
graph export joy7.png, replace height(400)	
joy_plot lnwage, over(mstatus) by(female) alegend violin fcolor(*.80)
graph export joy8.png, replace height(400)	


joy_plot lnwage, over(mstatus) by(female) alegend violin fcolor(*.80) ///
iqr(10 90) iqrlcolor(*1.2) iqrlwidth(1)
graph export joy9.png, replace height(400)	

