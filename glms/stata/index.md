---
layout: default
section: glms
tab: "Stata Logs"
---

<button type="button" class="btn btn-default pull-right" data-toggle="collapse" 
data-target="#toc" style="margin-top:1ex">
Table of Contents</button>

## Stata Logs


The "Stata Logs" show how to reproduce the result of (practically) all
the analysis in my [lecture notes](/glms/notes) on Generalized Linear Models.
The material is organized by Chapters and Sections using exactly the same 
numbering system as the notes, so section 2.8 of the logs deals with the analysis 
of covariance models described in section 2.8 of the notes.

The logs combine a narrative with actual Stata commands and output. The
text boxes set in a typewritter font contain commands or instructions to 
Stata, followed by the resulting output. You can tell the commands apart because 
they appear on lines beginning with a dot, or on continuation lines beginning 
with a greater than sign. The overall format is similar to that
used in the Stata manuals themselves.

The best way to use these transcripts is sitting by a computer, trying the 
different commands as you read along, probably with a printed copy of the notes 
by the side. I also recommend that you try to answer the few questions and 
exercises posed along the way. If you follow this procedure you will notice that 
sometimes I use the continuation comment /// to indicate that a command continues 
on another line. If you are using Stata interactively, just keep typing on the 
command window and the text will wrap.

While interactive use is probably good for learning, for more serious work I 
recommend that you prepare your commands in a "do file" and then ask Stata to run 
it. If nothing else, this will help document your work and ensure that you can 
reproduce your results. 

Even better, use the [markstat](https://grodri.github.io/markstat) command
to combine a narrative written in Markdown with Stata commands and output.  
These logs were all produced using `markstat`, and you will find the source 
code on GitHub, just follow the link near the top-right of very log. 

The "Stata Logs" were first published in January 1993 and targeted Stata
version 3. Revisions were completed to target newer releases roughly every 
couple of years. The current edition was run using Stata 17 and was last 
updated in the Fall of 2022.

{% include toc.html %}
