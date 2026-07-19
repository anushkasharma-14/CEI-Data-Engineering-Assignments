import pandas as pd

# Load datasets
customers = pd.read_csv("data/raw/customers.csv")
products = pd.read_csv("data/raw/products.csv")
orders = pd.read_csv("data/raw/orders.csv")
order_items = pd.read_csv("data/raw/order_items.csv")

# Validate emails
def validate_emails(df):

    pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    invalid = df[~df["email"].astype(str).str.match(pattern)]

    return invalid["customer_id"].tolist()

# Customers

def clean_customers(df):

    df = df.drop_duplicates().copy()
    invalid_ids = validate_emails(df)
    df.loc[df["customer_id"].isin(invalid_ids), "email"] = "invalid@email.com"

    return df

# Products

def clean_products(df):
    df = df.drop_duplicates().copy()
    df["product_name"] = (df["product_name"].astype(str).str.strip().str.title())
    return df

# Orders

def clean_orders(df):
    df = df.drop_duplicates().copy()
    df = df.dropna(subset=["customer_id"])

    df["order_date"] = pd.to_datetime(
        df["order_date"],
        format="mixed",
        dayfirst=True
    )

    return df

# Referential Integrity

def check_referential_integrity(orders_df, order_items_df):

    valid_orders = set(orders_df["order_id"])
    invalid_items = order_items_df[~order_items_df["order_id"].isin(valid_orders)]

    return invalid_items

# Order Items

def clean_order_items(df, orders_df):

    df = df.drop_duplicates().copy()
    df["quantity"] = (df["quantity"].abs())
    df = df[df["order_id"].isin(orders_df["order_id"])]

    return df

# Check issues before cleaning
invalid_emails = validate_emails(customers)

invalid_refs = check_referential_integrity(orders,order_items)

# Clean data
customers_clean = clean_customers(customers)
products_clean = clean_products(products)
orders_clean = clean_orders(orders)
order_items_clean = clean_order_items(order_items, orders_clean)

# Save cleaned files
customers_clean.to_csv("data/cleaned/customers_clean.csv", index=False)
products_clean.to_csv("data/cleaned/products_clean.csv", index=False)
orders_clean.to_csv("data/cleaned/orders_clean.csv", index=False)
order_items_clean.to_csv("data/cleaned/order_items_clean.csv", index=False)

# Create issue report
with open("data/issues_report.txt","w") as file:
    file.write("Data Quality Report\n")
    file.write("===================\n\n")
    file.write(f"Invalid Emails: {len(invalid_emails)}\n")

    for email in invalid_emails:file.write(f"{email}\n")
    file.write("\nInvalid Order References: "f"{len(invalid_refs)}\n")

    for order in invalid_refs["order_id"]:file.write(f"{order}\n")

print("Cleaning completed successfully.")
print("Issue report generated.")