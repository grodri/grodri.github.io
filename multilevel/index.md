---
layout: default
section: multilevel
tab: Home
toc: true
---

<p class="lead"><small>
This section has course materials for Pop 510: Multilevel Models, as offered in 
the Spring of 2018 (Session II). The course registrar's page is
<a href="https://registrar.princeton.edu/course-offerings/course_details.xml?&courseid=009629&term=1184">here</a>.
</small></p>

<button type="button" class="btn btn-default pull-right" data-toggle="collapse"
data-target="#toc">Table of Contents</button>

## Course Materials

The course is organized around four broad topics described below. Course
materials include a collection of computing logs illustrating multilevel
analysis using Stata and R. You can jump directly to any log using the table
of contents.  

![](/images/pdficon_small.png) The beamer slides used in class in the
Spring of 2018 are [available here](slides). A bundle with all
slides arranged four to a page in 2x2 layout is [available
here](pop510handouts.pdf)

A list of my papers on multilevel models, including abstracts and links
to JSTOR where available, as well as the Rodríguez-Goldman data, may be
found in the [multilevel research](/research) section.


### Course Description

This half-course, offered in the second session of the spring term,
provides an introduction to statistical methods for the analysis of
multilevel data, such as data on children, families, and neighborhoods.

-   We review fixed- and random-effects models for the analysis of
    clustered and longitudinal data before moving on to multilevel
    random-intercept and random-slopes models.

-   We discuss model fitting and interpretation, including centering and
    estimation of cross-level interactions.

-   We cover models for continuous as well as binary and count data,
    reviewing the different approaches to estimation in common use,
    including Bayesian inference.

The course emphasizes practical applications. Prerequisite:
[Generalized Linear Models](/glms) or equivalent. 
The [course syllabus is available here](syllabus).

### 1. Linear Models

We start with simple [variance-component models](lang1) using data on
language scores from Snijders and Boskers. Part 2 has [random intercept
and random slope](lang2) models, and Part 3 has [a model with a level-2
predictor](lang3), where the random intercept and slopes depend on
school SES.

We illustrate [growth curve models](oxboys) by replicating an analysis
by Goldstein of the heights of school boys measured on nine occasions
between ages 11 and 13. In addition to random intercepts, slopes and
curvatures, we consider serial correlation among residuals.

The next example deals with [3-level linear models](egm) using growth
curve data on 1721 students in 60 schools. We start with simple
variance-component models and then move to growth curves with random
intercepts and then random slopes. Our analysis concludes with a
comparison of growth curves in schools that differ in observed and
unobserved characteristics.

### 2. Logit Models

We next move to multilevel models for binary data, starting with a
dataset on hospital deliveries of births clustered by mother, which we
analyze using several methods, starting with maximum likelihood via
numeric quadrature [here](hospmle). The Bayesian Models section has
various analyses of this dataset using Markov chain Monte Carlo (MCMC)
methods.

We continue with an application to contraceptive use in
[Bangladesh](bangladesh), where we consider random-intercept and
random-slope models. We also illustrate the estimation of random effects
using maximum likelihood and posterior Bayes estimates.

For a three-level logit model consider the analysis of immunization in
Guatemala. The data are available on the multilevel section of the
website and the book by Rabe-Hesketh and Skrondal has a substantial
analysis.

### 3. Poisson Models

We illustrate a [random-intercept Poisson model](lips) using data on lip
cancer in Scotland from Rabe-Hesketch and Skrondal (2012).

An important application of Poisson models is to survival data. I
describe the calculation of [predicted probabilities](KenyaIcm) after
fitting a piecewise exponential model using data on infant and child
mortality in Kenya, as explained in my chapter in the handbook of
Multilevel Analysis.

### 4. Bayesian Estimation

The notes on how to run multilevel logit models using winBUGS are
[here](hospBUGS), with a link to a compound document that can be run
from WinBUGS. See also [part 2](hospBUGS2), showing how to run WinBUGS
in batch mode, and how to import CODA output into Stata for further
analysis.

JAGS is \"Just Another Gibbs Sampler\", it uses essentially the same
language as winBUGS and works well with R via \`rjags\`. I try it on the
hospital data [here](hospJags)

I also recommend you have a look at the MCMC feature in MLwiN, as
demostrated in class. This is probably the easiest way to estimate
multilevel models using MCMC procedures.

We now have a sample run of Stan, the latest on MCMC estimation using
Hamiltonian Monte Carlo and the No U-Turn Sampler (NUTS), applied to the
hospital delivery data [right here](hospStan).

Stata can fit some multilevel models using Metropolis-Hastings combined
with Gibbs sampling. We illustrate the procedure using the same hospital
delivery data used with WinBUGS and Stan and compare resuts of all
methods [here](hospBayesmh).

### 5. Older Stuff

A collection of MLwiN scripts is available [here](mln), [here](mln2),
and [here](mln3). The lr3 \'manual\' is [here](lr3).

{% include markstat.md %}

<small>Updated Fall 2022</small>

{% include toc.html %}