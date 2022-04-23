program mscatter
	* If nothing is done, all goes to 0
	*syntax  anything(everything), [*] 
	if `c(stata_version)'<16 {
		display in red "You need Stata 16 or higher to run this command"
		error 99
	}
	
	if runiform()<0.001 {
		easter_egg
	}
	mscatterx `0'
end

program byparse, rclass
	syntax [anything], [*]
	if "`anything'"!=""	return local byvlist `anything'
	return local byopt   `options'
end

program easter_egg
display in w "{p}This is a small easter egg! And you are lucky because only 0.1% of people may ever see this!{p_end}"
display in w "{p}I should have come up with this at some point. And hopefully Stata will use this too (officially) {p_end}"
display in w "{p}Granted, using color in papers is tough (most prints are black and white). However, if you are into visualizations, color palettes are your friends {p_end}"
display in w "{p}All right, that is it! {p_end}"
end 

program mscatterx 
 	syntax varlist(max=2)   [if] [in] [aw/], [over(varname)] [ alegend legend(string asis) color(string asis) colorpalette(string asis) by(string) ///
										msymbol(passthru) msize(passthru) ///
										msangle(passthru) mfcolor(passthru) mlcolor(passthru) strict ///
										mlwidth(passthru) mlalign(passthru) jitter(passthru) jitterseed(passthru) * ]
	** First Parse
	tempvar touse
	qui:gen byte `touse'=0
	qui:replace `touse'=1 `if' `in'
	** over?
	if "`over'"=="" {
		tempvar over
		qui:gen byte `over'=1
	}
	tempname new
	** Check color 
	capture confirm var `color'
	if _rc==0 	local myvlist `color'
	** check by
	
	byparse `by'
	***	
	local byvlist `r(byvlist)'
	local byopts  `r(byopt)'
	*display "`myvlist' `varlist' `byvlist' `over' `exp'"

	** markout only works with numeric	
	capture confirm numeric var `over'
	if _rc!=0 {
		tempvar nover
		encode `over', gen(`nover')
		local over `nover'
	}
	
	markout `touse' `varlist' `byvlist' `over' `exp'
	
	local myvlist `myvlist' `varlist' `byvlist' `over' `exp'
	
	** Put into Frame
	frame put `myvlist' if `touse', into(`new')
	
	frame `new':	{
		**Check Weight 
		if "`exp'"!="" local wexp [aw=`exp']
		
		** Check over to be numeric.

		** sort so 1 per over
		
 		tempvar flag
		bysort `over':gen __flag=_n
		 
		sort __flag `over'
		qui:levelsof `over' , local(lvlby)
		*** here WE DO COLORS
		if `"`color'"'!="" {
			** two options. variable or color list
			** If color variable. then use first obs
			capture confirm var `color'
			** Color by Variable
			if _rc==0 {
				local cnt = 0
				foreach i of local lvlby {
					local cnt = `cnt' +1 	
					
					local pscatter `pscatter' ///
					(scatter `varlist' if `over'==`i', ///
					color( "`=`color'[`cnt']'" ) ///
					`msymbol' `msize' `msangle' `mfcolor' `mlcolor' ///
					`mlwidth' `mlalign' `jitter' `jitterseed')
				}
			}
			** or by color list
			else {
				local cnt = 0
				foreach i of local lvlby {
					local cnt = `cnt' +1 		
					local col:word `cnt' of `color'
					local pscatter `pscatter' ///
					(scatter `varlist' if `over'==`i', ///
					color( `"`col'"' ) ///
					`msymbol' `msize' `msangle' `mfcolor' `mlcolor' ///
					`mlwidth' `mlalign' `jitter' `jitterseed')
				}
			}
		}		
		else {
			** If there is no color list, two options
			** 1 Use color palette option: Auto extrapolate and assign
			** 2 use default styles colors
			if "`colorpalette'"!="" {
				local cnt: word count `lvlby'
				if strpos(  `"`colorpalette'"' , ",") == 0 local colorpalette  `"`colorpalette', nograph n(`cnt')"'
				else local colorpalette  `"`colorpalette' nograph n(`cnt')"' 
				local cn = 0
				colorpalette `colorpalette'
				foreach i of local lvlby {
					local cn = `cn'+1
					local ll:word `cn' of `r(p)'
					local pscatter `pscatter' (scatter `varlist' if `over'==`i' `wexp', color("`ll'") ///
												`msymbol' `msize' `msangle' `mfcolor' `mlcolor' ///
												`mlwidth' `mlalign' `jitter' `jitterseed' )
				}
			}
			else {
				local cn = 0
				*colorpalette `colorpalette'
				foreach i of local lvlby {
					local cn = `cn'+1
					local pscatter `pscatter' (scatter `varlist' if `over'==`i' `wexp', /*pstyle(p`cn')*/ ///
												`msymbol' `msize' `msangle' `mfcolor' `mlcolor' ///
												`mlwidth' `mlalign' `jitter' `jitterseed' )
				}
			}
		  }
		 ** Then just Scatter, but...One more component, legend. Default Legend off
		 if "`alegend'"=="" & `"`legend'"' == ""   local mylegend legend(off)
		 if "`alegend'"=="" & `"`legend'"' != ""   local mylegend legend(`legend')
		 if "`alegend'"!="" {
		 	local cn 
		 	foreach i of local lvlby {
					local cn = `cn'+1
					local slg: label (`over') `i', `strict'
					local mylegend `mylegend' `cn' "`slg'"
				}
			local mylegend legend(order(`mylegend') `legend')	
		 }
		** the figure 
		
		two `pscatter', `options' by(`by') `mylegend'
	}
end 
