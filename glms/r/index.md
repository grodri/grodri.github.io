---
layout: default
section: glms
tab: "R Logs"
---

<button type="button" class="btn btn-default pull-right" data-toggle="collapse"
data-target="#toc" style="margin-top:1ex">Table of Contents</button>

<h2><img src="http://www.r-project.org/Rlogo.jpg" style="width:36px" class="icon"/>  Logs</h2>

The "R Logs" show how to reproduce the results of (practically) all the analyses in
my [lecture notes](/glms/notes) on Generalized Linear Models.
The material is organized by Chapters and Sections using exactly the same numbering system 
as the notes, so section 2.8 of the logs deals with the analysis of covariance models 
described in section 2.8 of the notes. Use the Table of Contents to jump directly to
any section.

The transcripts are formatted versions of R input and output.
The text boxes set in a typewriter font contain R function calls, followed by the resulting output. 
You can tell the input lines because they are preceded by R's prompt, a greater than sign (&gt;),
or the continuation prompt, a plus sign (+).
The rest of the text set in the standard font represents comments or annotations, except for 
references to R functions or packages, which are also set in a typewriter-style font. 

The best way to use these transcripts is sitting by a computer, typing in the code as you
read along, probably with a printed copy of the notes by the side. I also recommend that 
you try to answer the few questions and exercises posed along the way.

While interactive use is probably good for learning, for more serious work I recommend that 
you prepare an R script collecting all your code and then run it, ideally sending the
output to a file. 
Even better, use `rmarkdown` to combine a narrative written using Markdown with R input 
and output. These logs were all produced using `rmarkdown`, and you will find the source
code on GitHub, just follow the link near the top-right of every log.

The purpose of these notes is to illustrate the use of R in statistical analysis, 
not to provide a primer or tutorial. I have, however, written a short tutorial 
that you can find [here](/r). Please consult the R online help and documentation for more 
information.

To get started download R for free from the R project home page at 
[www.r-project.org](https://www.r-project.org/). You will be asked to
select a mirror site and will then be able to download binaries for Linux,
macOS, or Windows.

I recommend that you also download R Studio, an excellent Integrated Development Environment
(IDE) for R, from it's home at <a href="http://RStudio.com">RStudio.com</a>. This is
not strictly necessary, but it makes editing and running R as well as `rmarkdown` scripts
much easier.  R Studio is free and works on Linux, macOS, and Windows. 

P.S. The note on robust standard errors in R is [here](robust).

{% include toc.html %}
