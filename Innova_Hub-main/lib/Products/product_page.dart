
import 'package:flutter/material.dart';
import 'package:innovahub_app/Custom_Widgets/quick_alert.dart';
import 'package:innovahub_app/Models/product_response.dart';
import 'package:innovahub_app/Products/payment_page.dart';
import 'package:innovahub_app/core/Api/cart_services.dart';
import 'package:innovahub_app/core/Api/comment_service.dart';
import 'package:innovahub_app/core/Constants/Colors_Constant.dart';
import 'package:quickalert/models/quickalert_type.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  static const String routeName = 'product_page'; // route Name pf this page:

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var productcomment;
  TextEditingController input = TextEditingController();
  TextEditingController output = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productcomment = ModalRoute.of(context)!.settings.arguments as ProductResponse;
  }

  void addComment() async {
    if (input.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Comment cannot be empty!")),
      );
      return;
    }

    String message =
        await CommentService.postComment(productcomment.productId, input.text);

    if (message == "Comment added successfully!") {
      setState(() {
        output.text = input.text;
        input.clear();
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments
        as ProductResponse; // receive data:

    return Scaffold(
      backgroundColor: Constant.white3Color,
      appBar: AppBar(
        //shadowColor: Constant.whiteColor,
        backgroundColor: Constant.whiteColor,
        elevation: 0,
        title: const Text(
          'Innova',
          style: TextStyle(
              color: Constant.blackColorDark,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 24,
              backgroundImage:
                  AssetImage('assets/images/image-13.png'), // ضع الصورة هنا
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Constant.mainColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(80),
                ),
              ),
              width: double.infinity,
              height: 70,
              child: const Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Necklaces',
                  style: TextStyle(
                      fontSize: 24,
                      color: Constant.whiteColor,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  arguments.productImage,
                  fit: BoxFit.cover,
                  width: 350,
                ),
              ),
            ),
            SizedBox(
              height: 75,
              //width: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        arguments.productImage, // استبدلها بالصور الفعلية
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      /*const CircleAvatar(backgroundColor: Colors.grey, radius: 30,
                      backgroundImage: AssetImage('assets/images/owner.png'),
                      ),*/
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          //color: Colors.grey, // لون الخلفية في حال لم يتم تحميل الصورة
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/owner.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(arguments.authorName,
                          style: const TextStyle(
                              color: Constant.blackColorDark,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.message,
                          color: Constant.mainColor,
                          size: 25,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    arguments.name,
                    style: const TextStyle(
                        color: Constant.blackColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    arguments.price.toString(),
                    style: const TextStyle(
                        color: Constant.blackColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    arguments.description,
                    style: const TextStyle(
                        color: Constant.blackColorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Constant.blackColorDark,
                        size: 30,
                      ),
                      onPressed: () {}),
                  const Spacer(),
                  const Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_border,
                            color: Constant.greyColor,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Constant.greyColor,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Constant.greyColor,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Constant.greyColor,
                          ),
                          Icon(
                            Icons.star_border,
                            color: Constant.greyColor,
                          ),
                        ],
                      ),
                      Text(
                        " 0 Review(s)",
                        style: TextStyle(color: Constant.greyColor4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Constant.whiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available quantity: ${arguments.stock}', // text:
                    style: const TextStyle(
                      color: Constant.greyColor4,
                      fontSize: 15,
                      //fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Constant.whiteColor,
                      border: Border.all(
                        color: Constant.greyColor4,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.remove,
                        size: 30,
                        color: Constant.mainColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "$quantity",
                    style: const TextStyle(
                        color: Constant.mainColor, fontSize: 25),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Constant.whiteColor,
                      border: Border.all(
                        color: Constant.greyColor4,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (quantity < arguments.stock) {
                            quantity++;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 30,
                        color: Constant.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PaymentPage.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constant.mainColor,
                          minimumSize: const Size(1, 60)),
                      child: const Text(
                        "Buy Now",
                        style:
                            TextStyle(color: Constant.whiteColor, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        addToCart(arguments.productId, quantity).then((value) {
                          if (value) {
                            quickAlert(
                                context: context,
                                title: "Added to cart successfully",
                                type: QuickAlertType.success);
                          } else {
                            quickAlert(
                                context: context,
                                title: "Error adding to cart",
                                type: QuickAlertType.error);
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              color: Constant.greyColor2,
                              width: 1), // لون وسمك الحدود
                          backgroundColor: Constant.whiteColor,
                          minimumSize: const Size(1, 60)),
                      child: const Text(
                        "Add to cart",
                        style: TextStyle(
                            color: Constant.black2Color, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Comments",
                    style: TextStyle(
                        color: Constant.blackColorDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: input,
                          decoration: InputDecoration(
                            fillColor: Constant.whiteColor,
                            hintText: "What do you think?",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  const BorderSide(color: Constant.greyColor2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Constant.greyColor2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Constant.greyColor2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          addComment(); // Function to add comment:
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Constant.mainColor,
                            minimumSize: const Size(1, 50)),
                        child: const Row(
                          children: [
                            Text(
                              "Add",
                              style: TextStyle(
                                  color: Constant.whiteColor, fontSize: 18),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.send,
                              color: Constant.whiteColor,
                              size: 23,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),*/
            const SizedBox(height: 20),
           /* Container(
              height: 160,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Constant.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  output.text.isNotEmpty ? output.text : "No Comments yet !",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Constant.greyColor4,
                  ),
                ),
              ),
            ),*/
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


