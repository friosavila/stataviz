{smcl}
{* *! version 1.0  March 2022}{...}

{title:Title}

{phang}
{bf:joy_plot} {hline 2} Module create joy/violin plots across different groups. 
{p2colreset}{...}

{title:Syntax}

{p 8 16 2}
{cmd:joy_plot} varname [if] [in] [aweight], [over(varname)] [joy_plot_options color_options legend_options twoway_options]

{synoptset 19 tabbed}{...}
{marker opt}{synopthdr:options}
{synoptline}
{synopt  : {cmd: varname}} You need to specify a single variable that will be used to create plots (kdensity, or line).

{synopt : {cmd: over(varname)}} Indicates a variable that defines the groups to be used for the joy_plot. If you omit this, you probably would prefer using {help kdensity} directly. See Descriptions for details. 

{marker opt}{synopthdr:joy_plot options}
{synoptline}

{phang} This options are used to modify some aspects specific to the looks of the joy_plot

{synopt : {cmd:radj(#)}}When used, the Range used for the plots will be extended beyong the max or min values of the {cmd: varname}. Defeult 0.

{synopt : {cmd:range(#1 #2)}}When used, It sets the range for the plot to be between #1 and #2. The default uses the sample min and max.

{synopt : {cmd:dadj(#)}}When used, the hight of the densities will be adjusted. This allows for plots to overal each other. Default is 1.

{synopt : {cmd:bwadj(#)}}Should be between 0 and 1. It is used to determine the bandwidth for each subplot. When bwadj=0, all plots use the simple Bandwidth average. When bwadj=1, all plots will use the bandwidth determined by kdensity. One can choose something intermediate.

{synopt : {cmd:bwadj2(#)}}Any possitive number. It is use to change the Bandwith across all plots. One can, for example, modify all
bandwidths to be half (bwdj2=0.5) of the one originally estimated. Default is 1.

{synopt : {cmd:kernel(kfun)}}This can be used to select a particular type of kernel function for the plots. Default is Gaussian.

{synopt : {cmd:nobs(#)}}This is used to define how many points to be used for the plot. Larger number creates a smoother figure, but uses more memory. Default is 200.	

{marker opt2}{synopthdr:Other options}
{synoptline}

{phang} These options can be used to modify the look of the legend, or text describing the groups.

{synopt : {cmd:strict}}Unless specified, the value labels, or values of {cmd:over(variable)} will be used to label groups. using "strict" 
will not no text, if a value label is undefined.

{synopt : {cmd:notext}}WHen used, no text will be added on the vertical axis.

{synopt : {cmd:textopt(opts)}}When producing joy_plots, one can use this option to change some aspects of the group indentifiers. See {help added_text_options} or details. 

{synopt : {cmd:right}}When used, it will put the text identifying groups on the right of the plot. The default is to add this text on the left.

{synopt : {cmd:offset(#)}}When used, It request to offset (move) the text # points to the right (+) or left (-).

{synopt : {cmd:gap0}}When used, all joy_plots will be drawn starting at 0. This will be similar to producing various {help kdensity} plots, but using areas. Cannot be combined with {cmd:violin}

{synopt : {cmd:alegend}}When used, It will add a legend with all values defined in {cmd:over(varname)} to the graph. The default is not to show any legends. Can be combined with {help legend_options}

{synopt : {cmd:iqr}}When specified, 3 additional lines will be added to the graph, indicating the 25th, 50th and 95th percentiles.

{synopt : {cmd:violin}}When specified, it produces a violin type plot, rather than the kernel density plots. 

{marker opt}{synopthdr:color options}
{synoptline}

{synopt : {cmd: color(colorlist)}}Can be used to specify colors for each group defined by {cmd:over(varname)}, using 
a list of colors. If you add only fewer colors than groups in {cmd:over(varname)}, subsequent groups will use last specified color. 
For example if you type color(red blue), but over(var) has 3 groups, the last group will also be assigned the "blue" color.

{synopt : {cmd: colorpalette(*)}}An alternative approach to specify colors. This uses the command {help colorpalette} 
to define colors and use them for the scatter plot. 

{phang}If neither option is used, colors are assigned based on the current {help scheme}, which uses up to 15 different 
colors.

{marker opt}{synopthdr:Other color options}
{synoptline}

{phang}One can use other {help rarea} specific options including  fcolor,  fintensity, lcolor, 
lwidth, lpattern, lalign, lstyle. Be aware that the same option will be applied to each sub rarea defined by {cmd:over(varname)}.

{marker opt}{synopthdr:twoway options}
{synoptline}

{phang}It is also possible to use any of the {help twoway} options, including {k}labels, {k}titles, name, notes, etc. It cannot be combined with "by() option."


{marker description}{...}
{title:Description}

{p}This module aims to provide an easy way to create joy_plots/ridgeplots and violin plots, over different groups.
{p_end}

{p}For example, say that one is interested in visualizing the wage distribution for men and women. What you would normally do would be
{p_end}

{phang2} twoway kdensity wage if sex==1 || kdensity wage age if sex==2, legend(order(1 "Men" 2 "Women"))

{p}Instead you could create a similar graph using the following syntax:{p_end}

{phang2} joy_plot wage , over(sex) 

{p}And if you would prefer a violin plot, you could use the following{p_end}
{phang2} joy_plot wage , over(sex)  violin

{p}This program should also facilitate using different colors to each sub group. For example, one can simply 
provide the list of colors using {cmd:color(colorlist)}. You coud also use the option
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
{bf:{stata "gen mstatus=single+2*married+3*divorced"}}{p_end}
{phang2}
{bf:{stata "joy_plot lnwage , over(mstatus)"}}

{pstd}
But now you want to add a label to differentiate all groups, and show this as a legend:{p_end}

{phang2}{bf:{stata "label define mstatus 1 Single 2 Married 3 Divorced"}}{p_end}
{phang2}{bf:{stata "label values mstatus mstatus"}} {p_end}
{phang2}{bf:{stata "joy_plot lnwage, over(mstatus) alegend notext"}}

{pstd}
But what if you want to try using colors other than the default. You have three options {p_end}

{pstd}Provide a list of colors manually{p_end}
{phang2}{bf:{stata "joy_plot lnwage  , over(mstatus) alegend color(navy gold)"}}{p_end}

{pstd}Or use colorpalette:{p_end}
{phang2}{bf:{stata "joy_plot lnwage  , over(mstatus) alegend colorpalette(blues) notext"}}{p_end}

{pstd}You could also use rarea options, and two way options{p_end}
{phang2}{bf:{stata `"joy_plot lnwage  , over(mstatus) color(gs10) iqr right title("Wages distribution") subtitle("by Marital Status") "'}}
{p_end}

{pstd}You could also request producing a graph that ignores the lower tail of the distribution. {p_end}
{phang2}{bf:{stata `"joy_plot lnwage  , over(mstatus) iqr range(2 5) title("Wages distribution") subtitle("by Marital Status") "'}}
{p_end}

{marker Aknowledgement}{...}
{title:Aknowledgement}

{pstd}
This command came up to existance because I do this kind of graphs often just to visualize multiple groups at the same time. Since I was in a programming mood, I decided to write up a command for this. 
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
Help:  {helpb colorpalette}, {helpb scatter}, {helpb kdensity}

