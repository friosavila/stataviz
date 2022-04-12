set scheme s1mono
spirograph,  r(1 .3 .35 ) s(1.00 6.05 2 )  ///
			 r(2 .3 .35 ) s(1.00 6.05 3 )  ///
			 r(3 .3 .35 ) s(1.00 7.05 4 ) ///
			 r(4 .3 .35 ) s(1.00 7.05 5 ) ///
			 r(5 .3 .35 ) s(1.00 7.05 6 ) rotation(20) adjust(5) default lwidth(.1)
graph export spir1.png, height(1000) replace

spirograph, r(5 .4 2 3 ) s(1 4. 9.95 4 )  ///
			rotation(20) adjust(5) default lwidth(.1)
graph export spir2.png, height(1000) replace

spirograph, r(5 .5   1  )  s(1 6   12.05   )  ///
			r(5 1.5   1 )  s(1 6   12.05   )  ///
			r(2 .5   1  )  s(2 6   11.05   )  ///
			rotation(20) adjust(5) default lwidth(.1) color(navy)
graph export spir3.png, height(1000) replace