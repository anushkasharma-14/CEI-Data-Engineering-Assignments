# Week 4 - Azure Cloud Fundamentals and Data Pipeline Implementation using ADF

## Overview

This week's assignment focuses on understanding Azure cloud fundamentals and implementing a basic data pipeline using Azure Storage and Azure Data Factory (ADF). Azure resources such as a Resource Group, Storage Account, Blob Containers, and Azure Data Factory were created and configured. The assignment also involved validating a source CSV file using Get Metadata and copying it from one Blob Storage location to another through an ADF pipeline.

## Azure Services Used

* Azure Resource Group
* Azure Storage Account
* Azure Blob Storage
* Azure Data Factory (ADF)
* Azure IAM (Role-Based Access Control)

## Implementation Summary

* Created a Resource Group to manage all Azure resources used in the assignment.
* Created a Storage Account and Blob container for storing the source data.
* Uploaded the Superstore CSV dataset to Azure Blob Storage.
* Created an Azure Data Factory instance and explored the Author, Monitor, and Manage sections.
* Configured a Linked Service to connect Azure Data Factory with Blob Storage.
* Created source and destination datasets for data movement.
* Implemented a Get Metadata activity to validate the source file.
* Developed a pipeline using Get Metadata and Copy Data activities.
* Executed the pipeline and verified successful data transfer.
* Configured IAM roles and granted Azure Data Factory access to Storage.

## Pipeline Workflow

Source CSV File
→ Get Metadata Validation
→ Copy Data Activity
→ Destination Blob Container

## Output

The pipeline successfully validated the source file and copied it to the destination container, generating **Superstore_Copy.csv**.

## Files Included

* Week 4 Assignment Report
* README.md

## Learning Outcomes

* Understanding Azure cloud resources and services
* Working with Azure Blob Storage
* Creating and executing pipelines in Azure Data Factory
* Performing basic file validation and data movement
* Managing access through Azure IAM roles

## Conclusion

This assignment provided hands-on experience with Azure cloud services and Azure Data Factory. A complete data pipeline was successfully built to validate and copy data between Blob Storage containers.
