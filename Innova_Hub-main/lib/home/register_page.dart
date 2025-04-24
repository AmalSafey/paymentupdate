

import 'package:flutter/material.dart';


class TrainingPage extends StatelessWidget {

  //final CategoryModel categoryModel;

   TrainingPage({ super.key,});

  static const String routeName = 'page';
   //final ApiCartServices cartService = ApiCartServices();
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;

   /*Future<void> fetchCartItems() async {
    setState(() => isLoading = true);
    cartItems = await cartService.fetchCartItems();
    setState(() => isLoading = false);
  }

  void increaseQuantity(int index) {
    setState(() => cartItems[index]["Quantity"] += 1);
    cartService.updateQuantity(
        cartItems[index]["ProductId"], cartItems[index]["Quantity"]);
  }

  void decreaseQuantity(int index) {
    if (cartItems[index]["Quantity"] > 1) {
      setState(() => cartItems[index]["Quantity"] -= 1);
      cartService.updateQuantity(
          cartItems[index]["ProductId"], cartItems[index]["Quantity"]);
    } else {
      removeFromCart(index);
    }
  }

  Future<void> removeFromCart(int index) async {
    await cartService.removeFromCart(cartItems[index]["ProductId"]);
    setState(() => cartItems.removeAt(index));
  }

  Future<void> clearCart() async {
    await cartService.clearCart();
    setState(() => cartItems.clear());
  }

  double getTotalPrice(int index) {
    return cartItems[index]["Price"] * cartItems[index]["Quantity"];
  }*/
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Padding(
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
                                "(${cartItems.length} items)",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          GestureDetector(
                           // onTap: clearCart,
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item["ProductName"],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "66",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                /*  onTap: () =>
                                                      decreaseQuantity(index),*/
                                                  child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.teal),
                                                ),
                                                Text(
                                                  "${item["Quantity"]}",
                                                  style: const TextStyle(
                                                      color: Colors.teal,
                                                      fontSize: 18),
                                                ),
                                                GestureDetector(
                                                  //onTap: () => increaseQuantity(index),
                                                  child: const Icon(Icons.add,
                                                      color: Colors.teal),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                            //  onTap: () = removeFromCart(index),
                                              child: const Icon(Icons.delete,
                                                  color: Colors.red),
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
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}



