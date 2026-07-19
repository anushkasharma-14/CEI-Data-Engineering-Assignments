from datetime import datetime

def test_invalid_order_reference():
    orders = ["ORD001", "ORD002"]
    order_id = "ORD999"
    if order_id not in orders:
        print("Invalid order reference detected")

def test_discount():
    discount = 150
    if discount > 100:
        print("Invalid discount detected")

def test_zero_quantity():
    quantity = 0
    if quantity == 0:
        print("Zero quantity detected")

def test_future_date():
    order_date = datetime(2027,1,1)
    if order_date > datetime.now():
        print("Future order date detected")

if __name__ == "__main__":

    test_invalid_order_reference()
    test_discount()
    test_zero_quantity()
    test_future_date()