*! v1.1 Color_style FRA findfix
*! v1 Color_style FRA 
** Simply puts colors from Palette to style

program color_style
	syntax [anything], [graph * opacity(passthru) list showcase]
	** First install extra palettes
	if "`showcase'"!="" {
		color_showcase `anything'
	}
	
	if "`list'"!="" {
		list_palettes
		exit
	}
	
	** Verify Colorpallette is installed
	capture which colorpalette
	if _rc!=0 {
		display in red "You do not have palettes or colrspace installed"
		display in red "You may want to install them using"
		display `" {stata  `"net install palettes , replace from("https://raw.githubusercontent.com/benjann/palettes/master/")"' }"'
		display `" {stata  `"net install colrspace, replace from("https://raw.githubusercontent.com/benjann/colrspace/master/")"' }"'
		exit
	} 
	capture which grstyle
	if _rc!=0 {
		display in red "You do not have grstyle installed"
		display in red "You may want to install them using"
		display `" {stata  `"ssc install grstyle"' }"'
		exit 
	} 
	
	if runiform()<0.001 {
		easter_egg
	}
	color_stylex `0'
end

program color_showcase
	syntax anything
	capture findfile color_brewer.ado
	capture do "`r(fn)'"
	
	colorpalette, span: `anything', n(1)  / `anything', n(2)  / `anything' , n(3) / `anything', n(4)  / `anything', n(5)  / ///
						`anything', n(6)  / `anything', n(7)  / `anything', n(8)  / `anything', n(9)  / `anything', n(10) / ///
						`anything', n(11) / `anything', n(12) / `anything', n(13) / `anything', n(14) / `anything', n(15)

end

program list_palettes 
	display as result "Right now, this are the options for palettes. " _newline
	foreach i in  anemone apricot archambault austria bay benedictus berry bottlerocket1 bottlerocket2 cascades cassatt1 cassatt2 cavalcanti1 ceriselimon chevalier1 coconut cranraspberry cross darjeeling1 darjeeling2 degas demuth derain egypt fantasticfox1 frenchdispatch gauguin grandbudapest1 grandbudapest2 greek hiroshige hokusai1 hokusai2 hokusai3 homer1 homer2 ingres isfahan1 isfahan2 isleofdogs1 isleofdogs2 java johnson juarez kandinsky keylime kiwisandia klimt lake lakota lemon lime manet mango melonpomelo monet moonrise1 moonrise2 moonrise3 moreau morgenstern moth murepepino mushroom nattier navajo newkingdom nizami okeeffe1 okeeffe2 orange paired pamplemousse paquin passionfruit peachpear peru1 peru2 pillement pinafraise pissaro pommebaya pure redon renoir robert royal1 royal2 rushmore sailboat shuksan shuksan2 signac spring starfish stevens sunset sunset2 tam tangerine tara thomas tiepolo troy tsimshian vangogh1 vangogh2 vangogh3 veronese winter wissing zissou1 airbnb facebook google etsy twitter x23andme aventura badbunny1 badbunny2 badgyal beckyg calle13 daddy1 daddy2 don ivyqueen karolg natti nicky ozuna planb rosalia shakira wyy targaryen targaryen2 stark stark2 lannister martell tully greyjoy baratheon baratheon2 tyrell white_walkers jon_snow margaery daenerys game_of_thrones wildfire arya draco_malfoy ravenclaw luna_lovegood ravenclaw2 gryffindor gryffindor2 hermione_granger ronweasley sprout harry_potter slytherin always mischief newt_scamander ronweasley2 alaquod bangor crait durorthod eutrostox gley natrudoll paleustalf podzol redox redox2 rendoll vitrixerand  {
		local cnt = `cnt'+1
		display _cont "`i'" " "
		if mod(`cnt',7)==0 display " "
	}
	capture findfile color_brewer.ado
	capture do "`r(fn)'"
	/*Paired*/
end

program color_stylex
	syntax anything, [graph * opacity(passthru)]
	capture findfile color_brewer.ado
	capture do "`r(fn)'"
	if "`graph'"=="" {
		if strpos( "`0'" , ",") == 0 local to0 `0', nograph 
		else local to0 `0' nograph 
		
		grstyle init
		colorpalette `to0'
	}
	else {
		syntax anything, graph *
		*if strpos( "`0'" , ",") == 0 local to0 `0', 
		*else local to0 `0' // 		
		grstyle init
		colorpalette: `anything', `options'
		colorpalette `anything', `options' nograph
	}
	
	
	forvalues i =1/`=r(n)' {
		grstyle color p`i'      "`r(p`i')'"
		grstyle color p`i'mark  "`r(p`i')'"
		grstyle color p`i'markline  "`r(p`i')'"
		grstyle color p`i'markfill  "`r(p`i')'"
		*grstyle color p`i'label  "`r(p`i')'"
		grstyle color p`i'lineplot  "`r(p`i')'"
		grstyle color p`i'line  "`r(p`i')'"
		grstyle color p`i'area  "`r(p`i')'"
		grstyle color p`i'arealine  "`r(p`i')'" 
		grstyle color p`i'bar   "`r(p`i')'"
		grstyle color p`i'barline   "`r(p`i')'"
		grstyle color p`i'box   "`r(p`i')'"
		grstyle color p`i'boxline   "`r(p`i')'"
		grstyle color p`i'boxmarkline   "`r(p`i')'"
		grstyle color p`i'boxmarkfill   "`r(p`i')'"
		grstyle color p`i'dot   "`r(p`i')'"
		grstyle color p`i'dotmarkfill "`r(p`i')'"
		grstyle color p`i'dotmarkline "`r(p`i')'"
		grstyle color p`i'pie   "`r(p`i')'"
		grstyle color p`i'arrow "`r(p`i')'"
		grstyle color p`i'aline  "`r(p`i')'" 
		grstyle color p`i'solid "`r(p`i')'"
		grstyle color p`i'boxmark "`r(p`i')'"
		grstyle color p`i'dotmark "`r(p`i')'"
		grstyle color p`i'other "`r(p`i')'"
		
	}
	forvalues i =`=r(n)+1'/15 {
		grstyle color p`i'            gs0
		grstyle color p`i'markline    gs0
		grstyle color p`i'markfill    gs0
		*grstyle color p`i'label  "`r(p`i')'"
		grstyle color p`i'line        gs0
		grstyle color p`i'lineplot    gs0
		grstyle color p`i'bar         gs0
		grstyle color p`i'barline     gs0
		grstyle color p`i'box         gs0
		grstyle color p`i'boxline     gs0
		grstyle color p`i'dot         gs0
		grstyle color p`i'pie         gs0
		grstyle color p`i'arrow       gs0
		grstyle color p`i'area        gs0
		grstyle color p`i'arealine    gs0
		grstyle color p`i'aline       gs0
		grstyle color p`i'solid       gs0
		grstyle color p`i'mark        gs0
		grstyle color p`i'boxmark     gs0
		grstyle color p`i'dotmark      gs0
		grstyle color p`i'dotmarkfill gs0
		grstyle color p`i'dotmarkline gs0
		grstyle color p`i'other       gs0		
	}
		grstyle color histogram    "`r(p1)'"
        grstyle color histogram_line  "`r(p1)'"
 
		grstyle color matrix        "`r(p1)'"
        grstyle color matrixmarkline    "`r(p1)'"
		

end

program easter_egg
display in w "{p}This is a small easter egg! And you are lucky because only 0.1% of people may ever see this!{p_end}"
display in w "{p}And here the hidden Message, In August 2022, Im turning 40, but most important, im turing a DAD! {p_end}"
display in w "{p}All right, that is it! {p_end}"
end 

program _mystyle, rclass
	syntax anything

if "`anything'"=="Anemone" local mystyle #009474  #11c2b5  #72e1e1  #f1f4ee  #efddcf  #dcbe9b  #b0986c
else if "`anything'"=="Apricot" local mystyle #D72000 #EE6100 #FFAD0A #1BB6AF #9093A2 #132157
else if "`anything'"=="Archambault" local mystyle #88a0dc  #381a61  #7c4b73  #ed968c  #ab3329  #e78429  #f9d14a
else if "`anything'"=="Austria" local mystyle #a40000  #16317d  #007e2f  #ffcd12  #b86092  #721b3e  #00b7a7
else if "`anything'"=="Bay" local mystyle #00496f  #0f85a0  #edd746  #ed8b00  #dd4124
else if "`anything'"=="Benedictus" local mystyle #9a133d  #b93961  #d8527c  #f28aaa  #f9b4c9  #f9e0e8  #ffffff  #eaf3ff  #c5daf6  #a1c2ed  #6996e3  #4060c8  #1a318b
else if "`anything'"=="Berry" local mystyle #B25D91 #CB87B4 #EFC7E6 #1BB6AF #088BBE #172869
else if "`anything'"=="BottleRocket1" local mystyle #A42820  #5F5647  #9B110E  #3F5151  #4E2A1E  #550307  #0C1707
else if "`anything'"=="BottleRocket2" local mystyle #FAD510  #CB2314  #273046  #354823  #1E1E1E
else if "`anything'"=="Cascades" local mystyle #2d4030 #516823 #dec000 #e2e260 #677e8e #88a2b9
else if "`anything'"=="Cassatt1" local mystyle #b1615c  #d88782  #e3aba7  #edd7d9  #c9c9dd  #9d9dc7  #8282aa  #5a5a83
else if "`anything'"=="Cassatt2" local mystyle #2d223c  #574571  #90719f  #b695bc  #dec5da  #c1d1aa  #7fa074  #466c4b  #2c4b27  #0e2810 
else if "`anything'"=="Cavalcanti1" local mystyle #D8B70A  #02401B  #A2A475  #81A88D  #972D15
else if "`anything'"=="CeriseLimon" local mystyle #EE4244 #F8D961 #B6D944 #638E6E #3C5541  #132157
else if "`anything'"=="Chevalier1" local mystyle #446455  #FDD262  #D3DDDC  #C7B19C
else if "`anything'"=="Coconut" local mystyle #881C00 #AF6125 #F4E3C7 #1BB6AF #0076BB #172869
else if "`anything'"=="CranRaspberry" local mystyle #D9565C #F28A8A #EDA9AB #1BB6AF #088BBE #172869
else if "`anything'"=="Cross" local mystyle #c969a1  #ce4441  #ee8577  #eb7926  #ffbb44  #859b6c  #62929a  #004f63  #122451 
else if "`anything'"=="Darjeeling1" local mystyle #FF0000  #00A08A  #F2AD00  #F98400  #5BBCD6
else if "`anything'"=="Darjeeling2" local mystyle #ECCBAE  #046C9A  #D69C4E  #ABDDDE  #000000
else if "`anything'"=="Degas" local mystyle #591d06  #96410e  #e5a335  #556219  #418979  #2b614e  #053c29
else if "`anything'"=="Demuth" local mystyle #591c19  #9b332b  #b64f32  #d39a2d  #f7c267  #b9b9b8  #8b8b99  #5d6174  #41485f  #262d42
else if "`anything'"=="Derain" local mystyle #efc86e  #97c684  #6f9969  #aab5d5  #808fe1  #5c66a8  #454a74
else if "`anything'"=="Egypt" local mystyle #dd5129  #0f7ba2  #43b284  #fab255
else if "`anything'"=="FantasticFox1" local mystyle #DD8D29  #E2D200  #46ACC8  #E58601  #B40F20
else if "`anything'"=="FrenchDispatch" local mystyle #90D4CC  #BD3027  #B0AFA2  #7FC0C6  #9D9C85
else if "`anything'"=="Gauguin" local mystyle #b04948  #811e18  #9e4013  #c88a2c  #4c6216  #1a472a
else if "`anything'"=="GrandBudapest1" local mystyle #F1BB7B  #FD6467  #5B1A18  #D67236
else if "`anything'"=="GrandBudapest2" local mystyle #E6A0C4  #C6CDF7  #D8A499  #7294D4
else if "`anything'"=="Greek" local mystyle #3c0d03  #8d1c06  #e67424  #ed9b49  #f5c34d
else if "`anything'"=="Hiroshige" local mystyle #e76254  #ef8a47  #f7aa58  #ffd06f  #ffe6b7  #aadce0  #72bcd5  #528fad  #376795  #1e466e
else if "`anything'"=="Hokusai1" local mystyle #6d2f20  #b75347  #df7e66  #e09351  #edc775  #94b594  #224b5e
else if "`anything'"=="Hokusai2" local mystyle #abc9c8  #72aeb6  #4692b0  #2f70a1  #134b73  #0a3351
else if "`anything'"=="Hokusai3" local mystyle #d8d97a  #95c36e  #74c8c3  #5a97c1  #295384  #0a2e57
else if "`anything'"=="Homer1" local mystyle #551f00  #a62f00  #df7700  #f5b642  #fff179  #c3f4f6  #6ad5e8  #32b2da
else if "`anything'"=="Homer2" local mystyle #bf3626  #e9724c  #e9851d  #f9c53b  #aeac4c  #788f33  #165d43
else if "`anything'"=="Ingres" local mystyle #041d2c  #06314e  #18527e  #2e77ab  #d1b252  #a97f2f  #7e5522  #472c0b
else if "`anything'"=="Isfahan1" local mystyle #4e3910  #845d29  #d8c29d  #4fb6ca  #178f92  #175f5d  #1d1f54
else if "`anything'"=="Isfahan2" local mystyle #d7aca1  #ddc000  #79ad41  #34b6c6  #4063a3
else if "`anything'"=="IsleofDogs1" local mystyle #9986A5  #79402E  #CCBA72  #0F0D0E  #D9D0D3  #8D8680
else if "`anything'"=="IsleofDogs2" local mystyle #EAD3BF  #AA9486  #B6854D  #39312F  #1C1718
else if "`anything'"=="Java" local mystyle #663171  #cf3a36  #ea7428  #e2998a  #0c7156
else if "`anything'"=="Johnson" local mystyle #a00e00  #d04e00  #f6c200  #0086a8  #132b69
else if "`anything'"=="Juarez" local mystyle #a82203  #208cc0  #f1af3a  #cf5e4e  #637b31  #003967
else if "`anything'"=="Kandinsky" local mystyle #3b7c70  #ce9642  #898e9f  #3b3a3e
else if "`anything'"=="KeyLime" local mystyle #D84D16 #FFF800 #8FDA04 #009F3F #132157
else if "`anything'"=="KiwiSandia" local mystyle #D18F55  #FF3F38 #FF8C8D  #AFDE62 #3CBC38 #4F5791  #132157
else if "`anything'"=="Klimt" local mystyle #df9ed4  #c93f55  #eacc62  #469d76  #3c4b99  #924099
else if "`anything'"=="Lake" local mystyle #362904  #54450f  #45681e  #4a9152  #64a8a8  #85b6ce  #cde5f9  #eef3ff
else if "`anything'"=="Lakota" local mystyle #04a3bd  #f0be3d  #931e18  #da7901  #247d3f  #20235b
else if "`anything'"=="Lemon" local mystyle #F7AA14 #F5D000 #F7E690 #1BB6AF #088BBE #172869
else if "`anything'"=="Lime" local mystyle #2CB11B #95C65C #BDDE9B #1BB6AF #0076C0 #172869
else if "`anything'"=="Manet" local mystyle #3b2319  #80521c  #d29c44  #ebc174  #ede2cc  #7ec5f4  #4585b7 #225e92  #183571  #43429b  #5e65be 
else if "`anything'"=="Mango" local mystyle #FF5300 #9ED80B #43B629 #1BB6AF #8F92A1 #172869 
else if "`anything'"=="MelonPomelo" local mystyle #EE404E #F99D53 #F9E7C2 #24C852 #4F5791  #132157 
else if "`anything'"=="Monet" local mystyle #4e6d58  #749e89  #abccbe  #e3cacf  #c399a2  #9f6e71  #41507b #7d87b2  #c2cae3 
else if "`anything'"=="Moonrise1" local mystyle #F3DF6C  #CEAB07  #D5D5D3  #24281A
else if "`anything'"=="Moonrise2" local mystyle #798E87  #C27D38  #CCC591  #29211F
else if "`anything'"=="Moonrise3" local mystyle #85D4E3  #F4B5BD  #9C964A  #CDC08C  #FAD77B
else if "`anything'"=="Moreau" local mystyle #421600  #792504  #bc7524  #8dadca  #527baa  #104839  #082844
else if "`anything'"=="Morgenstern" local mystyle #7c668c  #b08ba5  #dfbbc8  #ffc680  #ffb178  #db8872  #a56457
else if "`anything'"=="Moth" local mystyle #4a3a3b  #984136  #c26a7a  #ecc0a1  #f0f0e4
else if "`anything'"=="MurePepino" local mystyle #D64358 #EAFB88 #3C8C4D #DFCEE0 #4F5791  #132157
else if "`anything'"=="Mushroom" local mystyle #4f412b  #865a3c  #ba783e  #e69c4c  #fbcc74  #fffbda
else if "`anything'"=="Nattier" local mystyle #52271c  #944839  #c08e39  #7f793c  #565c33  #184948  #022a2a
else if "`anything'"=="Navajo" local mystyle #660d20  #e59a52  #edce79  #094568  #e1c59a
else if "`anything'"=="NewKingdom" local mystyle #e1846c  #9eb4e0  #e6bb9e  #9c6849  #735852
else if "`anything'"=="Nizami" local mystyle #dd7867  #b83326  #c8570d  #edb144  #8cc8bc  #7da7ea  #5773c0 #1d4497
else if "`anything'"=="OKeeffe1" local mystyle #6b200c  #973d21  #da6c42  #ee956a  #fbc2a9  #f6f2ee  #bad6f9 #7db0ea  #447fdd  #225bb2  #133e7e 
else if "`anything'"=="OKeeffe2" local mystyle #fbe3c2  #f2c88f  #ecb27d  #e69c6b  #d37750  #b9563f  #92351e
else if "`anything'"=="Orange" local mystyle #EF7C12 #FCA315 #F4B95A #1BB6AF #088BBE #172869
else if "`anything'"=="Pamplemousse" local mystyle #EA7580 #F6A1A5 #F8CD9C #1BB6AF #088BBE #172869
else if "`anything'"=="Paquin" local mystyle #831818  #c62320  #f05b43  #f78462  #feac81  #f7dea3  #ced1af  #98ab76  #748f46  #47632a  #275024
else if "`anything'"=="PassionFruit" local mystyle #C70E7B  #FC6882 #A6E000 #1BB6AF #6C6C9D #172869
else if "`anything'"=="PeachPear" local mystyle #FF3200 #E9A17C #E9E4A6 #1BB6AF #0076BB #172869
else if "`anything'"=="Peru1" local mystyle #b5361c  #e35e28  #1c9d7c  #31c7ba  #369cc9  #3a507f
else if "`anything'"=="Peru2" local mystyle #65150b  #961f1f  #c0431f  #b36c06  #f19425  #c59349  #533d14
else if "`anything'"=="Pillement" local mystyle #a9845b  #697852  #738e8e  #44636f  #2b4655  #0f252f
else if "`anything'"=="PinaFraise" local mystyle #F44B4B #F19743 #F1F1A8 #92D84F #7473A6  #132157
else if "`anything'"=="Pissaro" local mystyle #134130  #4c825d  #8cae9e  #8dc7dc  #508ca7  #1a5270  #0e2a4d
else if "`anything'"=="PommeBaya" local mystyle #C23A4B #FBBB48 #EFEF46 #31D64D #132157
else if "`anything'"=="Pure" local mystyle #AFDFEF #54BCD1 #1BB6AF #0099D5 #007BC3 #172869 
else if "`anything'"=="Redon" local mystyle #5b859e  #1e395f  #75884b  #1e5a46  #df8d71  #af4f2f  #d48f90
else if "`anything'"=="Renoir" local mystyle #17154f  #2f357c  #6c5d9e  #9d9cd5  #b0799a  #f6b3b0  #e48171 #bf3729  #e69b00 #f5bb50  #ada43b  #355828
else if "`anything'"=="Robert" local mystyle #11341a  #375624  #6ca4a0  #487a7c  #18505f  #062e3d
else if "`anything'"=="Royal1" local mystyle #899DA4  #C93312  #FAEFD1  #DC863B
else if "`anything'"=="Royal2" local mystyle #9A8822  #F5CDB4  #F8AFA8  #FDDDA0  #74A089
else if "`anything'"=="Rushmore" local mystyle #E1BD6D  #EABE94  #0B775E  #35274A  #F2300F
else if "`anything'"=="Rushmore1" local mystyle #E1BD6D  #EABE94  #0B775E  #35274A  #F2300F
else if "`anything'"=="Sailboat" local mystyle #6e7cb9  #7bbcd5  #d0e2af  #f5db99  #e89c81  #d2848d
else if "`anything'"=="Shuksan" local mystyle #33271e  #74677e  #ac8eab  #d7b1c5  #ebbdc8  #f2cec7  #f8e3d1  #fefbe9
else if "`anything'"=="Shuksan2" local mystyle #5d74a5  #b0cbe7  #fef7c7  #eba07e  #a8554e
else if "`anything'"=="Signac" local mystyle #fbe183  #f4c40f  #fe9b00  #d8443c  #9b3441  #de597c  #e87b89 #e6a2a6  #aa7aa1  #9f5691  #633372  #1f6e9c  #2b9b81  #92c051 
else if "`anything'"=="Spring" local mystyle #d8aedd  #bf9bdd  #cb74ad  #e69e9c  #ffc3a3  #fbe4c6
else if "`anything'"=="Starfish" local mystyle #24492e  #015b58  #2c6184  #59629b  #89689d  #ba7999  #e69b99
else if "`anything'"=="Stevens" local mystyle #042e4e  #307d7f  #598c4c  #ba5c3f  #a13213  #470c00
else if "`anything'"=="Sunset" local mystyle #41476b  #675478  #9e6374  #c67b6f  #de9b71  #efbc82  #fbdfa2
else if "`anything'"=="Sunset2" local mystyle #1d457f  #61599d  #c36377  #eb7f54  #f2af4a
else if "`anything'"=="Tam" local mystyle #ffd353  #ffb242  #ef8737  #de4f33  #bb292c  #9f2d55  #62205f  #341648
else if "`anything'"=="Tangerine" local mystyle #EF562A #EC921D #F7B449 #FFED00 #1BB6AF #9093A2 #132157 
else if "`anything'"=="Tara" local mystyle #eab1c6  #d35e17  #e18a1f  #e9b109  #829d44
else if "`anything'"=="Thomas" local mystyle #b24422  #c44d76  #4457a5  #13315f  #b1a1cc  #59386c  #447861 #7caf5c
else if "`anything'"=="Tiepolo" local mystyle #802417  #c06636  #ce9344  #e8b960  #646e3b  #2b5851  #508ea2 #17486f
else if "`anything'"=="Troy" local mystyle #421401  #6c1d0e  #8b3a2b  #c27668  #7ba0b4  #44728c  #235070 #0a2d46
else if "`anything'"=="Tsimshian" local mystyle #582310  #aa361d  #82c45f  #318f49  #0cb4bb  #2673a3  #473d7d
else if "`anything'"=="VanGogh1" local mystyle #2c2d54  #434475  #6b6ca3  #969bc7  #87bcbd  #89ab7c  #6f9954
else if "`anything'"=="VanGogh2" local mystyle #bd3106  #d9700e  #e9a00e  #eebe04  #5b7314  #c3d6ce  #89a6bb #454b87
else if "`anything'"=="VanGogh3" local mystyle #e7e5cc  #c2d6a4  #9cc184  #669d62  #447243  #1f5b25  #1e3d14 #192813
else if "`anything'"=="Veronese" local mystyle #67322e  #99610a  #c38f16  #6e948c  #2c6b67  #175449  #122c43
else if "`anything'"=="Winter" local mystyle #2d2926  #33454e  #537380  #81a9ad  #ececec
else if "`anything'"=="Wissing" local mystyle #4b1d0d  #7c291e  #ba7233  #3a4421  #2d5380
else if "`anything'"=="Zissou1" local mystyle #3B9AB2  #78B7C5  #EBCC2A  #E1AF00  #F21A00

return local mystyle `mystyle' 
end

*else if "`anything'"=="Paired" local mystyle #C70E7B  #FC6882 #007BC3 #54BCD1 #EF7C12 #F4B95A #009F3F #8FDA04 #AF6125 #F4E3C7 #B25D91 #EFC7E6  #EF7C12 #F4B95A