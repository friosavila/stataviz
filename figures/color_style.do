sysuse auto, clear
color_style s2
font_style default

set scheme white
graph pie mpg, over(rep78)
graph export "C:\Users\Fernando\Documents\GitHub\stataviz\figures\pie_1.png", as(png) name("Graph") height(400) replace

color_style tableau
graph pie mpg, over(rep78)
graph export "C:\Users\Fernando\Documents\GitHub\stataviz\figures\pie_2.png", as(png) name("Graph") height(400) replace

color_style egypt
graph pie mpg, over(rep78)
graph export "C:\Users\Fernando\Documents\GitHub\stataviz\figures\pie_3.png", as(png) name("Graph") height(400) replace

color_style egypt, n(5) 
graph pie mpg, over(rep78)
graph export "C:\Users\Fernando\Documents\GitHub\stataviz\figures\pie_4.png", as(png) name("Graph") height(400) replace

color_style #2b2d42 #8d99ae #edf2f4 #ef233c #d90429
graph pie mpg, over(rep78)
graph export "C:\Users\Fernando\Documents\GitHub\stataviz\figures\pie_5.png", as(png) name("Graph") height(400) replace

two scatter mpg price if rep78==1 || ///
    scatter mpg price if rep78==2 || ///
    scatter mpg price if rep78==3 || ///
    scatter mpg price if rep78==4 || ///
    scatter mpg price if rep78==5
	
	graph export "C:\Users\Fernando\Documents\GitHub\stataviz\figures\scatter_1.png", as(png) name("Graph") replace
	
font_style Harrington
* Hogwarts Colors
color_style #b20003 #044d0f #dfb000 #004485 #151515
graph pie mpg, over(rep78) title(Hogwarts School) ///
legend(order(1 "Gryffindor" 2 "Hufflepuff" 3 "Ravenclaw" 4 "Slytherin" 5 "Muggles"))	
	graph export "C:\Users\Fernando\Documents\GitHub\stataviz\figures\pie_6.png", as(png) name("Graph") replace  height(400)
