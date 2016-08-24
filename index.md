---
layout: lesson
root: .
lastupdated: March 21, 2016
contributors: ["Sarah Supp", "John Blischak","Gavin Simpson","Tracy Teal","Greg Wilson","Diego Barneche"," Stephen Turner","Francois Michonneau"]
maintainers: ["Francois Michonneau", "Auriel Fournier"]
domain: Ecology
topic: R for data analysis
software: R
dataurl: http://dx.doi.org/10.6084/m9.figshare.1314459
status: Teaching
---

# Note

This particular set of lessons has revisions by
[Karl Broman](http://kbroman.org) for a
[Data Carpentry workshop](http://uw-madison-aci.github.io/2016-06-01-uwmadison/)
at UW-Madison on 23-24 August 2016. The official Data Carpentry R-Ecology
lessons are at <http://www.datacarpentry.org/R-ecology-lesson/>.

# Data Carpentry {{ page.topic }} for {{ page.domain }}


Data Carpentry's aim is to teach researchers basic concepts, skills,
and tools for working with data so that they can get more done in less
time, and with less pain. The lessons below were designed for those interested
in working with {{page.domain %}} data in {{page.topic %}}.

This is an introduction to R designed for participants with no programming
experience. These lessons can be taught in 3/4 of a day. They start with some
basic information about R syntax, the RStudio interface, and move through how to
import CSV files, the structure of data.frame, how to deal with factors, how to
add/remove rows and columns, and finish with how to calculate summary statistics
for each level and a very brief introduction to plotting.


**Content Contributors: {{page.contributors | join: ', ' %}}**


**Lesson Maintainers: {{page.maintainers | join: ', ' %}}**


**Lesson status: {{ page.status }}**

<!--
  [Information on Lesson Status Categories]()
-->

<!-- ###### INDEX OF LESSONS ON THIS TOPIC ###### -->

## Lessons:

1. [Introduction to R](01-intro-to-R.html)
3. [Aggregating and analyzing data with dplyr](02-dplyr.html)
4. [Data visualization with ggplot2](03-ggplot2.html)
5. [Reproducible reports with R Markdown](04-rmarkdown.html)
6. [Capstone project](capstone.html)

## Data

The data for this lesson is available as a single CSV file,
<http://kbroman.org/datacarp/portal_data_joined.csv>.

We'll download the file during the course of the lesson.


### Requirements

Data Carpentry's teaching is hands-on, so participants are encouraged to use
their own computers to insure the proper setup of tools for an efficient workflow.
*These lessons assume no prior knowledge of the skills or tools*, but working
through this lesson requires working copies of the software described below.
To most effectively use these materials, please make sure to install everything
*before* working through this lesson.

{% if page.software == "Python" %}
{% include pythonSetup.html %}
{% elsif page.software == "Spreadsheets" %}
{% include spreadsheetSetup.html %}
{% elsif page.software == "R" %}
{% include rSetup.html %}
{% else %}
{% include anySetup.html %}
{% endif %}

<p><strong>Twitter</strong>: @datacarpentry</p>
