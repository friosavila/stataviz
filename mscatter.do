
sysuse auto, clear
two scatter price mpg if foreign == 1 || ///
    scatter price mpg if foreign == 0
	
graph export sct_1.png, height(400) replace

ssc install linkplot
linkplot price mpg , link(foreign) asyvars recast(scatter)
graph export sct_2.png, height(400) replace

set scheme white
mscatter price mpg , over(rep78)  alegend msize(3) by(foreign) legend(cols(5))
graph export sct_3.png, height(400) replace


mscatter ln_wage ttl_exp , over(age) colorpalette(magma ) alegend
graph export sct_4.png, height(400) replace


mscatter ln_wage ttl_exp , over(grade) colorpalette(magma ) by(race, legend(off) cols(3))
graph export sct_5.png, height(400) replace


webuse nlswork, clear
set seed 10
keep if runiform()<.2
set scheme white
color_style tableau
mscatter ln_wage ttl_exp , over(race)  ///
 fit(qfitci) mfcolor(%5) mlcolor(%5) alegend ytitle("Log Wages")
 graph export sct_6.png, height(400) replace

 
mscatter ln_wage ttl_exp , over(race)  ///
fit(qfitci) mfcolor(%5) mlcolor(%5) ///
noscatter  /// Asks not to show the scatter points
alegend ytitle("Log Wages") 
 graph export sct_7.png, height(400) replace
