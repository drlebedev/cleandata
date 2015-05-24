---
title: "Data Cleanup Guide"
author: "Kirill Lebedev"
date: "Saturday, May 23, 2015"
output: html_document
---

## Overview

This project includes R script to clean up  data collected from the accelerometers from the Samsung Galaxy S smartphone

## Usage

Use the following code to download and clean data:

```
source("run_analysis.R");
run_analysis();
```

## Script details

Cleaning script contains the following functions:

### init

> Init function is used to prepare data and env for clean/analyze
> data folder could be set via init parameter "project_folder"
> function returns unpacked data folder

### mergedata
> mergedata function is used to merge data from files in one data.frame
  result is a data frame with 563 columns, where:
  
     columns 1:561 contains features from test and train data
     column 562 contains subjects from test and train data
     column 563 contains labels from test and train data

### nameandfilter
> nameandfilter function is used to properly name dataframe columns base on data in features txt
 also it filters columns leaving only mean and standard deviation features

### nameactivity
> nameactivity function is used to replace numeric data in activity column with activity name

### clean 
> clean function generates tidy result dataset from parameter

### run_analysis
> Main entry point of script. Start run_analysis() from console to get result.txt in result folder


