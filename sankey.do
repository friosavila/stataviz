use immigration, clear
set scheme white
sankey_plot x0 from x1 to, width0(value) extra xsize(4) ysize(6)

graph export sankey_1.png, height(800) replace

egen fcode=group(from)
egen tcode=group(to)
replace fcode=fcode*10
replace tcode=tcode*10
sankey_plot x0 fcode x1 tcode, /// coordinates for levels (x0 x1) and the from to data
width0(value)  /// value of the flows, (migration)
label0(from) label1(to) /// Labels for 
adjust xsize(4) ysize(6)

graph export sankey_2.png, height(800) replace


sankey_plot week0 y0 week1 y1, width0(candidates) adjust extra label0(label0) label1(label1) ///
xlabel(0 "Starts" 1 "Week 1" 2 "Week 2" 3 "Week 3" 4 "Week 4" 5 "Week 5" 6 "Week 6") fillcolor(gs10%40) gap(.2) ///
xsize(8) ysize(5)
graph export sankey_3.png, height(400) replace

sankey_plot married pet happy , ///
wide width(freq) /// Need to indicate the data is wide, and notice its width() is not width0()
fillcolor(%50) xlabel("",nogrid) gap(0.1) tight /// Tight groups things together
title("The Secret to Happyness") ///
subtitle("Have Pets!: Nora and Bruce!") note("Nora and Bruce are my family dogs!")
graph export sankey_4.png, height(400) replace
