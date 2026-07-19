import random
from faker import Faker
import pandas as pd

# Initialize Faker
fake = Faker()

# For reproducible results
random.seed(42)
Faker.seed(42)

def generate_customers(num_customers=500):
    customers = []
    customer_types = ["REGULAR", "PREMIUM", "VIP"]

    for i in range(1, num_customers + 1):
        customers.append({
            "customer_id": f"CUST{i:04d}",
            "customer_name": fake.name(),
            "email": fake.email(),
            "registration_date": fake.date_between(
                start_date="-3y",
                end_date="today"
            ),
            "customer_type": random.choice(customer_types)
        })

    return pd.DataFrame(customers)


def introduce_invalid_emails(df):
    count = max(1, int(len(df) * 0.02))
    indexes = random.sample(list(df.index), count)
    for index in indexes:
        df.loc[index, "email"] = (
            df.loc[index, "email"].replace("@", "")
        )

    return df


def generate_products(num_products=500):
    categories = {
        "Electronics": ["Laptop", "Mobile", "Tablet", "Headphones"],
        "Clothing": ["Shirt", "Jeans", "Jacket", "T-Shirt"],
        "Home": ["Chair", "Table", "Sofa", "Lamp"],
        "Books": ["Novel", "Biography", "Comics", "Dictionary"]
    }

    products = []

    for i in range(1, num_products + 1):
        category = random.choice(list(categories.keys()))
        subcategory = random.choice(categories[category])

        products.append({
            "product_id": f"PROD{i:04d}",
            "product_name": subcategory,
            "category": category,
            "subcategory": subcategory,
            "cost_price": random.randint(100, 50000)
        })

    return pd.DataFrame(products)


def introduce_product_name_issues(df):
    count = max(1, int(len(df) * 0.05))

    indexes = random.sample(list(df.index), count)

    for index in indexes:
        name = df.loc[index, "product_name"]

        if random.choice([True, False]):
            name = "  " + name + "  "
        else:
            name = name.swapcase()

        df.loc[index, "product_name"] = name

    return df

def generate_orders(customers_df, num_orders=500):
    statuses = ["PLACED", "SHIPPED", "DELIVERED", "CANCELLED", "RETURNED"]
    regions = ["NORTH", "SOUTH", "EAST", "WEST"]

    customer_ids = customers_df["customer_id"].tolist()
    orders = []

    for i in range(1, num_orders + 1):
        order_date = fake.date_time_between(
            start_date="-2y",
            end_date="now"
        )

        orders.append({
            "order_id": f"ORD{i:04d}",
            "customer_id": random.choice(customer_ids),
            "order_date": order_date.strftime(
                "%Y-%m-%d %H:%M:%S"
            ),
            "status": random.choice(statuses),
            "region_code": random.choice(regions)
        })

    return pd.DataFrame(orders)


def introduce_order_issues(df):
    # 5% NULL customer IDs
    count = max(1, int(len(df) * 0.05))
    indexes = random.sample(list(df.index), count)
    df.loc[indexes, "customer_id"] = None

    # Wrong date format
    count = max(1, int(len(df) * 0.05))

    indexes = random.sample(list(df.index), count)

    for index in indexes:
        date = pd.to_datetime(df.loc[index, "order_date"])

        df.loc[index, "order_date"] = (
            date.strftime("%d-%m-%Y %H:%M:%S")
        )

    return df

def generate_order_items(orders_df, products_df, num_items=1000):
    order_ids = orders_df["order_id"].tolist()
    product_ids = products_df["product_id"].tolist()

    order_items = []

    for i in range(1, num_items + 1):
        order_items.append({
            "item_id": f"ITEM{i:04d}",
            "order_id": random.choice(order_ids),
            "product_id": random.choice(product_ids),
            "quantity": random.randint(1, 5),
            "unit_price": random.randint(200, 60000),
            "discount_percent": random.randint(0, 100)
        })

    return pd.DataFrame(order_items)

def introduce_order_item_issues(df):
    # 3% negative quantity
    count = max(1, int(len(df) * 0.03))
    indexes = random.sample(list(df.index), count)
    df.loc[indexes, "quantity"] *= -1

    # Invalid order reference for integrity testing
    df.loc[df.index[0], "order_id"] = "ORD99999"

    return df

def introduce_duplicates(df):
    count = max(1, int(len(df) * 0.02))

    duplicates = df.sample(count, random_state=42)

    return pd.concat([df, duplicates], ignore_index=True)

def save_csv(df, filename):
    df.to_csv(
        f"data/raw/{filename}",
        index=False
    )

    print(f"{filename} generated successfully.")


if __name__ == "__main__":

    customers = generate_customers()
    customers = introduce_invalid_emails(customers)
    customers = introduce_duplicates(customers)
    save_csv(customers, "customers.csv")

    products = generate_products()
    products = introduce_product_name_issues(products)
    products = introduce_duplicates(products)
    save_csv(products, "products.csv")

    orders = generate_orders(customers)
    orders = introduce_order_issues(orders)
    orders = introduce_duplicates(orders)
    save_csv(orders, "orders.csv")

    order_items = generate_order_items(orders, products)
    order_items = introduce_order_item_issues(order_items)
    order_items = introduce_duplicates(order_items)

    save_csv(order_items,"order_items.csv")

    print("\nAll datasets generated successfully!")