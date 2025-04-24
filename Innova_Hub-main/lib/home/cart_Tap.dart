import 'package:flutter/material.dart';
import 'package:innovahub_app/Products/payment_page.dart';
import 'package:innovahub_app/core/Api/cart_services.dart';
import 'package:innovahub_app/core/Constants/Colors_Constant.dart';

class CartTap extends StatefulWidget {
  static const String routeName = "cart";

  const CartTap({super.key});

  @override
  State<CartTap> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartTap> {
  final CartService cartService = CartService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    setState(() => isLoading = true);
    CartController.cartItems = await cartService.fetchCartItems();
    setState(() => isLoading = false);
  }

  Future<void> clearCart() async {
    await cartService.clearCart();
    setState(() => CartController.cartItems.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CartController.cartItems.isEmpty
              ? const Center(
                  child: Text(
                    "🛒 Cart is empty",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Shopping Cart ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "(${CartController.cartItems.length} items)",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: clearCart,
                            child: Container(
                              height: 25,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.teal,
                                ),
                              ),
                              child: const Center(child: Text("Clear")),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Expanded(child: ListWidget()),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, PaymentPage.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constant.mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          minimumSize: const Size(220, 50),
                        ),
                        child: const Text(
                          'check out',
                          style: TextStyle(
                              fontSize: 18, color: Constant.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class CartController {
  static List<Map<String, dynamic>> cartItems = [];
  static double calculateTotalCartPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item["Price"] * item["Quantity"];
    }
    return total;
  }

  static double getTotalPrice(int index) {
    return cartItems[index]["Price"] * cartItems[index]["Quantity"];
  }

  static void increaseQuantity(int index) {
    cartItems[index]["Quantity"] += 1;
  }

  static void decreaseQuantity(int index) {
    if (cartItems[index]["Quantity"] > 1) {
      cartItems[index]["Quantity"] -= 1;
    } else {
      removeFromCart(index);
    }
  }

  static void removeFromCart(int index) {
    cartItems.removeAt(index);
  }
}

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: CartController.cartItems.length,
      itemBuilder: (context, index) {
        final item = CartController.cartItems[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Container(
                height: 85,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                  item["HomePictureUrl"],
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["ProductName"],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${CartController.getTotalPrice(index).toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() =>
                                    CartController.decreaseQuantity(index));
                              },
                              child:
                                  const Icon(Icons.remove, color: Colors.teal),
                            ),
                            Text(
                              "${item["Quantity"]}",
                              style: const TextStyle(
                                  color: Colors.teal, fontSize: 18),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() =>
                                    CartController.increaseQuantity(index));
                              },
                              child: const Icon(Icons.add, color: Colors.teal),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                                () => CartController.removeFromCart(index));
                          },
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
