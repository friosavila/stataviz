cscript
sysuse auto, clear
two scatter price mpg if foreign == 1 || ///
    scatter price mpg if foreign == 0
	
graph export sct_1.png, height(400)

ssc install linkplot
linkplot price mpg , link(foreign) asyvars recast(scatter)
graph export sct_2.png, height(400)

set scheme white
mscatter price mpg , over(rep78)  alegend msize(3) by(foreign) legend(cols(5))
graph export sct_3.png, height(400)

webuse nlswork
mscatter ln_wage ttl_exp , over(age) colorpalette(magma ) alegend
graph export sct_4.png, height(400) replace


mscatter ln_wage ttl_exp , over(grade) colorpalette(magma ) by(race, legend(off) cols(3))
graph export sct_5.png, height(400) replace
