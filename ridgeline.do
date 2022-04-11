set scheme white
ridgeline_plot new_deaths date, over(country)
graph export ridge1.png, height(400) replace

ridgeline_plot new_deaths date, over(country) ///
normalize /// Normalizes height within country
textopt(size(small) placement(e)) /// changes text size
dadj(3) // and allows for overlap

graph export ridge2.png, height(400) replace


color_style shakira, n(15)
ridgeline_plot new_deaths date, over(country) ///
normalize /// Normalizes height within country
notext alegend /// automatic legend
dadj(3) // and allows for overlap

graph export ridge3.png, height(400) replace



ridgeline_plot new_deaths date, over(country) ///
notext alegend /// automatic legend
stack colorpalette(daddy2) lwidth(0)

graph export ridge4.png, height(400) replace

ridgeline_plot new_deaths date, over(country) ///
notext alegend /// automatic legend
stream colorpalette(viridis) lwidth(0) ///
ylabel("")

graph export ridge5.png, height(400) replace

ridgeline_plot new_deaths date, over(country) ///
notext alegend /// automatic legend
stream(3) stack100  ///
colorpalette(peru2) lwidth(0) ///
ylabel("")

graph export ridge6.png, height(400) replace
