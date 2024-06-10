import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'dart:html' show HttpRequest;

class PaymentPage extends StatefulWidget {
  final String price;
  const PaymentPage({super.key, required this.price});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map<String, dynamic>? paymentLinks;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    fetchPaymentLinks();
  }

  Future<void> fetchPaymentLinks() async {
    try {
      setState(() {
        _loading = true;
      });
      final response = await HttpRequest.getString('payment_links.json');
      final dynamic responseData = json.decode(response);

      if (responseData is Map<String, dynamic>) {
        final links = responseData[widget.price];
        setState(() {
          paymentLinks = links != null ? Map<String, dynamic>.from(links) : null;
          debugPrint("=========>>> ${paymentLinks!['phonepe']}");
          _loading = false;
        });
      } else {
        throw Exception('Invalid response format');
      }
    } catch (error) {
      setState(() {
        _loading = false;
      });
      print("Error fetching payment links: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.all(10),
          height: 40,
          width: 40,
          child: Image.asset('assets/Jio-Logo-768x483.png', height: 10, width: 10),
        ),
        backgroundColor: const Color(0xFF0F3CC9),
        title: Row(
          children: [
            const SizedBox(),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.brightness_6, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Pay ₹${widget.price} using UPI",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          paymentButton("assets/phonePe.png", "PhonePe", paymentLinks!['phonepe']),
                        ],
                      ),
                    ).paddingAll(20),
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/Paymentpage bottom.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/PaymentPageLast.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget paymentButton(String imagePath, String title, String url) {
    return GestureDetector(
      onTap: () {
        html.window.open(url, "_blank");
      },
      child: Container(
        width: 400,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            SizedBox(
              height: 40,
              width: 40,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
