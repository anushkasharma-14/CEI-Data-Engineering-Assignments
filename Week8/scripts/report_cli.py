import sqlite3
from datetime import datetime, timedelta

DATABASE = "database/ecommerce.db"

def connect_database():
    try:
        return sqlite3.connect(DATABASE)

    except sqlite3.Error as error:
        print("Database connection error:")
        print(error)
        exit()

def generate_report(report_type):

    queries = {
        "daily": """
        SELECT
            DATE(o.order_date) AS date,
            COUNT(DISTINCT o.order_id) AS total_orders,
            ROUND(SUM(
                oi.quantity * oi.unit_price *
                (1 - oi.discount_percent / 100)
            ),2) AS revenue,
            COUNT(DISTINCT o.customer_id) AS unique_customers

        FROM orders o

        JOIN order_items oi
        ON o.order_id = oi.order_id

        WHERE DATE(o.order_date)
        BETWEEN ? AND ?

        GROUP BY DATE(o.order_date)
        ORDER BY date;
        """,


        "weekly": """
        SELECT
            strftime('%Y-%W', o.order_date) AS week,
            COUNT(DISTINCT o.order_id) AS total_orders,
            ROUND(SUM(
                oi.quantity * oi.unit_price *
                (1 - oi.discount_percent / 100)
            ),2) AS revenue,
            COUNT(DISTINCT o.customer_id) AS unique_customers

        FROM orders o

        JOIN order_items oi
        ON o.order_id = oi.order_id

        WHERE DATE(o.order_date)
        BETWEEN ? AND ?

        GROUP BY week
        ORDER BY week;
        """,


        "monthly": """
        SELECT
            strftime('%Y-%m', o.order_date) AS month,
            COUNT(DISTINCT o.order_id) AS total_orders,
            ROUND(SUM(
                oi.quantity * oi.unit_price *
                (1 - oi.discount_percent / 100)
            ),2) AS revenue,
            COUNT(DISTINCT o.customer_id) AS unique_customers

        FROM orders o

        JOIN order_items oi
        ON o.order_id = oi.order_id

        WHERE DATE(o.order_date)
        BETWEEN ? AND ?

        GROUP BY month
        ORDER BY month;
        """
    }

    return queries[report_type]


def top_products(start_date, end_date):

    return """
    SELECT
        p.product_name,
        SUM(oi.quantity) AS quantity_sold,

        ROUND(SUM(
            oi.quantity * oi.unit_price *
            (1 - oi.discount_percent / 100)
        ),2) AS revenue

    FROM order_items oi

    JOIN orders o
    ON oi.order_id = o.order_id

    JOIN products p
    ON oi.product_id = p.product_id

    WHERE DATE(o.order_date)
    BETWEEN ? AND ?

    GROUP BY p.product_name

    ORDER BY revenue DESC

    LIMIT 3;
    """


def get_revenue(connection, start_date, end_date):

    query = """
    SELECT ROUND(SUM(
        oi.quantity * oi.unit_price *
        (1 - oi.discount_percent / 100)
    ),2)

    FROM orders o

    JOIN order_items oi
    ON o.order_id = oi.order_id

    WHERE DATE(o.order_date)
    BETWEEN ? AND ?
    """

    cursor = connection.cursor()
    cursor.execute(query, (start_date, end_date))
    result = cursor.fetchone()

    return result[0] or 0

def display_results(cursor, rows):

    headers = [column[0] for column in cursor.description]

    print("\nReport Result")
    print("-" * 60)
    print(" | ".join(headers))
    print("-" * 60)

    for row in rows:
        print(" | ".join(str(value) for value in row))

def main():

    print("E-Commerce Analytics Reporting Tool")
    report_type = input("Enter report type (daily/weekly/monthly): ").lower()

    if report_type not in ["daily", "weekly", "monthly"]:
        print("Invalid report type")
        return

    start_date = input("Enter start date (YYYY-MM-DD): ")
    end_date = input("Enter end date (YYYY-MM-DD): ")
    
    try:
        start = datetime.strptime(start_date, "%Y-%m-%d")
        end = datetime.strptime(end_date, "%Y-%m-%d")

    except ValueError:
        print("Invalid date format")
        return

    connection = connect_database()
    cursor = connection.cursor()

    try:
        # Main report

        cursor.execute(generate_report(report_type), (start_date, end_date))
        rows = cursor.fetchall()

        if rows:
            display_results(cursor, rows)
        else:
            print("No data found")

        # Top 3 products
        print("\nTop 3 Products")
        print("-" * 60)

        cursor.execute(top_products(start_date, end_date), (start_date, end_date))
        products = cursor.fetchall()

        if products:
            for product in products:
                print(product)

        else:
            print("No products found")

        # Previous period comparison
        days = (end - start).days + 1
        previous_end = start - timedelta(days=1)
        previous_start = (previous_end - timedelta(days=days-1))

        current_revenue = get_revenue(connection, start_date, end_date)

        previous_revenue = get_revenue(
            connection,
            previous_start.strftime("%Y-%m-%d"),
            previous_end.strftime("%Y-%m-%d")
        )

        print("\nPrevious Period Comparison")
        print("-" * 60)

        if previous_revenue:
            change = ((current_revenue - previous_revenue) / previous_revenue) * 100

            print("Revenue Change:",round(change, 2),"%")

        else:
            print("Previous period data not available")

    except sqlite3.Error as error:
        print("Database error:")
        print(error)

    finally:
        cursor.close()
        connection.close()

if __name__ == "__main__":
    main()