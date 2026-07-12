# Week 7 – Delta Lake Assignment

This repository contains my **Week 7 assignment** for the **Celebal Excellence Internship Program – Data Engineering**.

## Objective

Implement incremental data processing using **Delta Lake** by loading data into Delta tables, performing data cleaning, processing incremental updates using the **MERGE** operation, and creating business-ready analytical tables.

## Technologies Used

* Databricks
* Apache Spark
* PySpark
* Delta Lake

## Implementation

The assignment follows the **Medallion Architecture** using **Bronze**, **Silver**, and **Gold** layers.

* Loaded the raw Sample Superstore dataset into the **Bronze** Delta table.
* Processed the data in the **Silver** layer by checking for null values and duplicate records.
* Loaded an incremental dataset and applied the Delta Lake **MERGE** operation to update existing records and insert new records into the Silver table.
* Created **Gold** layer **Fact** and **Dimension** tables from the updated Silver data for analytical reporting.

## Files Included

* **data/** – Contains the input datasets used in the assignment.
* **delta_scd_assignment.ipynb** – Databricks notebook containing the complete implementation with outputs.
* **Week-7 Report.pdf** – Assignment report containing summary of the assignment, implementation details, and results.
