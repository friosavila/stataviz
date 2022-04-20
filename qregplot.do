webuse womenwk, clear
set scheme white
qreg wage age education married i.county

qregplot age education married ,  /// Variables to be plotted
estore(e_qreg) /// Request Storing the variables in memory
q(5(5)95) // and indicates what quantiles to plot

graph export qreg_1.png, replace height(500)

qregplot age education married , ///
 from(e_qreg) /// <- Indicates where to look for coefficients
 label // No longer needed to add Q's and request Labels
 graph export qreg_2.png, replace height(500)
 
qregplot age education married , ///
from(e_qreg) label ///
col(1) /// request 1 column with 
 ysize(10) xsize(5) // and different sizes for the graph 

graph export qreg_3.png, replace width(400)

qregplot age education married , ///
from(e_qreg) /// 
col(2)   /// and different sizes for the graph
mtitles("Age in years o Edad en años desde 1900" ///
"Años de Educacion or Years of Education, incluye Highschool" ///
"Is Married - Esta Casado") //<- ads long titles

graph export qreg_4.png, replace height(400)

qregplot age education married , ///
from(e_qreg) /// 
col(2)   /// and different sizes for the graph
mtitles("Age in years o Edad en años desde 1900" ///
"Años de Educacion or Years of Education, incluye Highschool" ///
"Is Married - Esta Casado") ///<- ads long titles
labelopt(lines(2)) // breaks it in two lines

graph export qreg_5.png, replace height(400)


bsqreg wage age education married i.county, reps(25)
color_style bay, select(1)
qregplot age education ,  q(5(5)95) seed(101) label title("BSqreg") ///
ysize(4) xsize(7)
graph export qreg_6.png, replace height(400)


qreg2 wage age education married i.county, 
color_style bay, select(2)
qregplot age education ,  q(5(5)95) seed(101) label title("QREG2: from SSC") ///
ysize(4) xsize(7)
graph export qreg_7.png, replace height(400)

qrprocess wage age education married i.county, 
color_style bay, select(3)
qregplot age education ,  q(5(5)95) seed(101) label title("qrprocess: from SSC") ///
ysize(4) xsize(7)
graph export qreg_8.png, replace height(400)


mmqreg wage age education married, abs( county)
color_style bay, select(4)
qregplot age education ,  q(5(5)95) seed(101) label title("mmqreg: from SSC") ///
ysize(4) xsize(7)
graph export qreg_9.png, replace height(400)

rifhdreg wage age education married, abs( county) rif(q(50))
color_style bay, select(5)
qregplot age education ,  q(5(5)95) seed(101) label title("rifhdreg: from SSC") ///
ysize(4) xsize(7)
graph export qreg_10.png, replace height(400)