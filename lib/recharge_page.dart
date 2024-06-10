import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiooffer/payment_page.dart';

class RechargePage extends StatefulWidget {
  final String mobileNumber;

  const RechargePage({super.key, required this.mobileNumber});

  @override
  State<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends State<RechargePage> {
  late Timer _timer;
  int _remainingTime = 15 * 60; // 15 minutes in seconds

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  String _formatTime(int timeInSeconds) {
    final minutes = timeInSeconds ~/ 60;
    final seconds = timeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xffF1F5F9),
              child: Row(
                children: [
                  const Text(
                    'Mobile Number: ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.mobileNumber,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Change"),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: const Color(0xffF1F5F9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Special Offer Ends In:'),
                  const Icon(Icons.timer, color: Colors.black54),
                  const SizedBox(width: 5),
                  Text(
                    _formatTime(_remainingTime),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: rechargePlans.length,
                itemBuilder: (context, index) {
                  final plan = rechargePlans[index];
                  final imageList = List<String>.from(plan['imageList']!);
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: const Color(0xffE3E8FD),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xff334155),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              plan['type']!,
                              style: TextStyle(
                                color: Colors.grey.shade200,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                '₹${plan['price']}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '₹${plan['originalPrice']}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    "UNLIMITED",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red.shade900,
                                    ),
                                  ),
                                  Text(
                                    "TRUE 5G DATA",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade900),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'View Details',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'VALIDITY',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    plan['validity']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'DATA',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    plan['data']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'VOICE',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Unlimited',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'SMS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '100/day',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "SUBSCRIPTIONS",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: imageList.map((image) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Image.asset(image, width: 30, height: 30),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Get.to(() => PaymentPage(price: plan['price']));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Color(0xFF0A2885),
                              ),
                              width: double.infinity,
                              child: const Text(
                                "Recharge",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

List<Map<String, dynamic>> rechargePlans = [
  {
    'type': 'SPECIAL',
    'price': '149',
    'originalPrice': '666',
    'validity': '84 days',
    'data': '1.5 GB/day',
    'sms': '100/day',
    'imageList': [
      "assets/JioTV.png",
      "assets/JioCiema.png",
      "assets/Jio-Savan.png",
      "assets/jiocloud.png"
    ]
  },
  {
    'type': 'SPECIAL',
    'price': '199',
    'originalPrice': '1099',
    'validity': '84 days',
    'data': '2.0 GB/day',
    'sms': '100/day',
    'imageList': [
      "assets/JioTV.png",
      "assets/JioCiema.png",
      "assets/Jio-Savan.png",
      "assets/jiocloud.png",
      "assets/netflix.png",
      "assets/amazonprime.png"
    ]
  },
  {
    'type': 'SPECIAL',
    'price': '249',
    'originalPrice': '1499',
    'validity': '84 days',
    'data': '3.0 GB/day',
    'sms': '100/day',
    'imageList': [
      "assets/JioTV.png",
      "assets/JioCiema.png",
      "assets/Jio-Savan.png",
      "assets/jiocloud.png",
      "assets/netflix.png",
      "assets/amazonprime.png",
      "assets/DisneyHotstar.png",
      "assets/SonyLiv.png",
      "assets/zee.png"
    ]
  },
];

List<String> imageList = [
  "assets/JioTV.png",
  "assets/JioCiema.png",
  "assets/Jio-Savan.png",
  "assets/jiocloud.png",
  "assets/netflix.png",
  "assets/amazonprime.png",
  "assets/DisneyHotstar.png",
  "assets/SonyLiv.png",
  "assets/zee.png"
];
