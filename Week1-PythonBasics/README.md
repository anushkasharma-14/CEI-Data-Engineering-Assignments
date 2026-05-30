# Shopping Dataset Cleaning and Exploration using Pandas

## Objective

This project focuses on exploring, cleaning, and transforming a shopping dataset using Pandas. The dataset was analyzed, cleaned, and enhanced with additional features before being exported as a new CSV file.

## Dataset Exploration

The dataset was explored using Pandas functions such as `head()`, `tail()`, `shape`, `columns`, `dtypes`, `info()`, and `isnull().sum()` to understand its structure, data types, and missing values.

## Missing Value Handling

Missing values were handled by replacing:

* `discount` with `0`
* `what_customers_said` with `"Not Available"`
* `seller_name` with `"Unknown Seller"`
* `seller_information` with `"Not Available"`
* `videos` with `"No Video Available"`
* `variations` with `"No Variations Available"`

## Data Cleaning

Although there were no null values remaining in the dataset after handling missing values but some columns still contains non-informative data.

* The `variations` column mainly contained empty structures such as `[{}]` and `[{},{}]`, so all values were standardized to `"No Variations"`.
* Empty dictionary values (`{}`) in the `best_offer` column were replaced with `"No Offer"`.

## Basic Operations

The dataset was filtered to identify:

* Products with ratings greater than 4.
* Products with discounts greater than 50%.

Selected columns such as product title, rating, initial price, and final price were also analyzed separately.

## Data Integrity Check

The dataset was checked for duplicate records using `duplicated().sum()`. No duplicate entries were found.

## Derived Columns

### Amount Saved

A new column, `amount_saved`, was created to estimate customer savings.

During analysis, it was observed that the `final_price` column contained inconsistent values. In several records, the final price remained equal to the initial price despite a discount being present. Therefore, instead of using `final_price` directly, savings were calculated using:

`amount_saved = initial_price × discount ÷ 100`

### Top Product

A new column, `top_product`, was created to identify products with:

* Rating > 3.5
* Ratings Count > 100

This helps highlight products that are both highly rated and reviewed by a significant number of customers.

## Final Output

The cleaned dataset was exported as:

`cleaned_shopping_dataset.csv`

## Technologies Used

* Python
* Pandas
* Jupyter Notebook
* VS Code

## Conclusion

The dataset was successfully explored, cleaned, and transformed. Missing values and inconsistent records were handled, duplicate records were checked, and new features were created to provide additional insights for future analysis.
