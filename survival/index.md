---
layout: default
section: survival
tab: Home
toc: true
---

<div class="lead"><small>
This section has course materials for Pop509: Survival Analysis, as offered in 
the Spring of 2018 (Session I). The course registrar's page is
<a href="https://registrar.princeton.edu/course-offerings/course_details.xml?courseid=009628&term=1184">here</a>.
</small></div>

<button type="button" class="btn btn-default pull-right" data-toggle="collapse"
data-target="#toc">Table of Contents</button>

## Course Materials

The course is organized around five topics listed below. The materials for each 
topic usually include a handout in PDF format and one or more computing logs
in HTML format showing how to do the relevant calculations in R and
Stata. You can use the table of contents to jump directly to each computing log. 

![](/images/pdficon_small.png) The beamer slides used in class in the Spring of 2
018 are available [here](slides). A bundle with all slides arranged four to a 
page in 2x2 layout is available [here](pop509handouts.pdf). 

### Course Description

This half-course offered in the first half of the spring term focuses on
the statistical analysis of time-to-event or survival data. We introduce
the hazard and survival functions; censoring mechanisms, parametric and
non-parametric estimation, and comparison of survival curves. We cover
continuous and discrete-time regression models with emphasis on Cox's
proportional hazards model and partial likelihood estimation. We discuss
competing risk models, unobserved heterogeneity, and multivariate
survival models including event history analysis. 

The course emphasizes basic concepts and techniques, as well as applications 
in social science research using R or Stata. Prerequisite: 
[Generalized Linear Models](glms) or equivalent.
For a more detailed description of the course, including a list
of topics covered each week, [see the syllabus](syllabus), available 
also in printer-friendly [PDF](pop509syllabus.pdf).

### 1. Parametric Models

Materials for week 1 include a handhout on
![](/images/pdficon_small.png) [Parametric Survival Models](ParametricSurvival.pdf), 
a plot of the 2013 U.S. [survival and hazard functions](us2013), and a 
computing log fitting [log-normal and weibull](recid1) parametric models to 
recidivism data.

### 2. Non-Parametric Estimation

Weeks 2 and 3 are devoted to
![](/images/pdficon_small.png)
[Non-parametric Estimation](NonParametricSurvival.pdf) in Survival Models.
Computing materials include a 
log applying [Kaplan-Meier and Mantel-Haenzsel](gehan), and a log
fitting [Cox's proportional hazards](cox) model to a two-group comparison. 
See also this application of [Cox regression](recid2) to the recidivism data. 
We compare flexible [discrete and continuous time](recid3) models fit to the 
same data. By popular demand we have added an example fitting
[splines in a piecewise exponential model](pwespline).

### 3. Competing Risks

Week 4 deals with
![](/images/pdficon_small.png) [Competing Risks](CompetingRisks.pdf), the
analysis of survival time when there are multiple causes of failure.
Additional materials include a discussion of
![](/images/pdficon_small.png) [cumulative incidence](cumulativeIncidence.pdf),
including estimation of the cumulative incidence function (CIF) and Fine
and Gray's competing risk model, and an expanded computing log fitting
competing risk models to the tenure of U.S. [Supreme Court
justices](justices). THERE ARE TWO OR THREE MORE PAGES HERE
A competing risk simulation is [here](simcomp).

### 4. Unobserved Heterogeneity

In week 5 we tackle 
![](/images/pdficon_small.png) [Unobserved Heterogeneity](UnobservedHeterogeneity.pdf),
discussing univariate frailty models and the identification problem,
including very useful formulas for converting back and forth between
subject-specific and population-average hazards. Illustrations include
two shiny apps, one shows [frailty](frailtyApp) acting on
proportional hazards, and another shows how [heterogeneity](heterogeneityApp) 
can undo a mortality crossover.

### 5. Multivariate Survival

Week 6 is devoted to
![](/images/pdficon_small.png) [Multivariate Survival](MultivariateSurvival.pdf),
where we review various approaches to the analysis of multiple-spell
survival data, focusing on shared-frailty models. Don't miss the
computing handouts fitting shared frailty models to child survival data
from Guatemala, we fit a [piecewise exponential](frailty) model using
Stata and a [Cox model](frailtyr) using R. We also have a discussion of [model
interpretation](frailty2) via post-estimation, including computation of survival 
probabilities, and a closing note on [log-normal frailty](frailty2r).

{% include markstat.md %}

<small>Updated fall 2022</small>

{% include toc.html %}
