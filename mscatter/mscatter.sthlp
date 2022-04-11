{smcl}
{* *! version 1.0  March 2022}{...}

{title:Title}

{phang}
{bf:mscatter} {hline 2} Module create Scatters-plots across different groups. 
{p2colreset}{...}


{title:Syntax}

{p 8 16 2}
{cmd:mscatter} yvar xvar [if] [in] [aweight], [over(varname)] [mscatter_options scatter_options twoway_options]

{synoptset 19 tabbed}{...}
{marker opt}{synopthdr:options}
{synoptline}

{synopt  : {cmd: yvar xvar}} You need to specify two numeric variables (y and x) that will be used for the scatter plot.

{synopt : {cmd: over(varname)}} Indicates a variable that defines the groups to be used for the scatter plot. See examples and description. If Omitted, it would be better to use {help scatter}.

{marker opt}{synopthdr:legend options}
{synoptline}

{synopt : {cmd: alegend}}When Requested, a label will be added to the graph, using the levels of {cmd:over(varname)}. 
The default is not to show any legends.

{synopt : {cmd: legend(*)}}Can be combined with alegend. It is used to add legends to the scatter plot.

{marker opt}{synopthdr:color options}

{synopt : {cmd: color(9)}}Can be used to specify colors for each group defined by {cmd:over(varname)}. 
It has two options. You can either specify a list of colors, or a variable that define those colors.

{synopt : {cmd: colorpalette(*)}}An alternative approach to specify colors. This uses the command {help colorpalette} 
to define colors and use them for the scatter plot. 

{phang2}If neither option is used, colors are assigned based on the current {help scheme}, which uses up to 15 different 
colors.

{marker opt}{synopthdr:scatter options}
{synoptline}

{phang}One can use other {help scatter} specific options including msymbol, msize, msangle,
mfcolor, mlcolor, mlwidth, mlalign, jitter. Be aware that the same option will be applied to each scatter group 
defined by {cmd:over(varname)}.

{marker opt}{synopthdr:twoway options}
{synoptline}

{phang}It is also possible to use any of the {help twoway} options, including {k}labels, {k}titles, name, notes, etc.

{phang}{cmd: Technically, you can combine weights with by(). However, this tends to create problems if there are any groups not observed across the by() variable}

{marker description}{...}
{title:Description}

{p}This module aims to provide an easy way to create scatter plots over different groups. 
{p_end}

{p}For example, say that one is interested in ploting wages against age, across gender. What you would normally do would be
{p_end}

{phang2} twoway scatter wage age if sex==1 || scatter wage age if sex==2, legend(order(1 "Men" 2 "Women"))

{p}Instead you could create a similar graph using the following syntax:{p_end}

{phang2} mscatter wage age, over(sex) alegend

{p}This program should also facilitate using different colors to each sub group. For example, one can simply 
provide the list of colors using {cmd:color(colorlist)}. When you have many subgroups, it may be easier 
to provide a variable with the desired colors {cmd:color(varname)}. Finally, you coud also use the option
{help colorpalette}() to select colors for each group defined by {cmd:over(varname)}.{p_end}

{p}See examples for details

{marker examples}{...}
{title:Examples}

{pstd}Lets start by loading some data:{p_end}

{phang2}
{bf:. {stata "use http://fmwww.bc.edu/RePEc/bocode/o/oaxaca.dta"}}

{pstd}
Say that you want to see the relationship between wages and experience, but differentiating 
by marital status:{p_end}
{phang2}
{bf:{stata "gen mstatus=single+2*married+3*divorced"}}
{bf:{stata "mscatter lnwage age, over(mstatus)"}}

{pstd}
But now you want to add a label to differentiate all groups:{p_end}

{phang2}{bf:{stata "label define mstatus 1 Single 2 Married 3 Divorced"}}{p_end}
{phang2}{bf:{stata "label values mstatus mstatus"}} {p_end}
{phang2}{bf:{stata "mscatter lnwage age, over(mstatus) alegend"}}

{pstd}
But what if you want to try using colors other than the default. You have three options {p_end}

{pstd}Provide a variable with a list of colors {p_end}

{phang2}{bf:{stata `"gen mycolor="forest_green" if mstatus==1 "'}}{p_end}
{phang2}{bf:{stata `"replace mycolor="gold" if mstatus==2"'}} {p_end}
{phang2}{bf:{stata `"replace mycolor="lavender" if mstatus==3"'}} {p_end}
{phang2}{bf:{stata "mscatter lnwage age, over(mstatus) alegend color(mycolor)"}}{p_end}

{pstd}Specify the list of colors manually{p_end}
{phang2}{bf:{stata "mscatter lnwage age, over(mstatus) alegend color(forest_green gold lavender)"}}{p_end}

{pstd}Or use colorpalette:{p_end}
{phang2}{bf:{stata "mscatter lnwage age, over(mstatus) alegend colorpalette(viridis) "}}{p_end}

{pstd}Other than that, you can use standard scatter options, and two way options{p_end}
{phang2}{bf:{stata `"mscatter lnwage age, over(mstatus) alegend colorpalette(magma) msize(4) mfcolor(%40) title("Wages vs age") subtitle("by Marital Status") "'}}
{p_end}

{marker Aknowledgement}{...}
{title:Aknowledgement}

{pstd}
This command came up to existance because I do this kind of graphs often just to visualize multiple groups at the same time. However, it was because someone else ask the question (Davis Kedrosky), that I decided to write up command for this. 
{p_end}

{pstd}
Also, colorpalette is a very powerful command by Ben Jann. Without it, playing with colors would be far more difficult!
{p_end}

{marker Author}{...}
{title:Author}

{pstd}Fernando Rios-Avila{break}
Levy Economics Institute of Bard College{break}
Blithewood-Bard College{break}
Annandale-on-Hudson, NY{break}
friosavi@levy.org

{title:Also see}

{p 7 14 2}
Help:  {helpb colorpalette}, {helpb scatter}

