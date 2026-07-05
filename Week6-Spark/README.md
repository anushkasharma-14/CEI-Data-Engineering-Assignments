# Week 6 - Apache Spark DataFrames

This repository contains my **Week 6** assignment completed as part of the **Celebal Technologies Data Engineering Internship**.

## Objective

The objective of this assignment is to understand the fundamentals of **Apache Spark** and perform data loading, filtering, and transformation using **Spark DataFrames**. It also focuses on key Spark concepts such as lazy evaluation, in-memory processing, shuffle operations, and DataFrame immutability.

## Tasks Performed

* Created a Spark Session
* Loaded CSV and Parquet datasets into Spark DataFrames
* Explored datasets using `show()`, `printSchema()`, and column inspection
* Performed data filtering based on conditions
* Selected required columns from datasets
* Handled missing values in the dataset
* Removed duplicate records
* Renamed columns and casted data types
* Created new derived columns
* Applied aggregation and grouping operations
* Compared CSV (row-based) and Parquet (columnar) formats
* Built a simple data processing pipeline (read → transform → write)
* Understood performance concepts like Lazy Evaluation, Shuffle, and Predicate Pushdown

## Files Included

* sparkAssignment.ipynb - Jupyter Notebook containing all Spark operations
* Week-6 Report.pdf - Report containing theory answers, code, and insights
* data/source.csv - CSV dataset containing sample records
* data/source.parquet - Parquet dataset containing sample records used for comparison and processing
* output-csv/ - Folder containing processed output data saved in CSV format
* README.md - Overview of the Week 6 assignment

## Tools & Technologies

* Python
* Apache Spark (PySpark)
* Jupyter Notebook
* CSV & Parquet datasets

## Learning Outcomes

Through this assignment, I learned how Spark efficiently processes large datasets using DataFrames. I gained hands-on experience in data loading, transformation, filtering, and optimization techniques. I also understood important Spark concepts such as lazy evaluation, shuffle operations, DataFrame immutability, and the differences between CSV and Parquet file formats.