import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jiooffer/payment_page.dart';
import 'package:jiooffer/recharge_page.dart';
// import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // setPathUrlStrategy();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyWebApp());
}

class MyWebApp extends StatelessWidget {
  const MyWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/rechargePage', page: () => const RechargePage(mobileNumber: '')),
        GetPage(name: '/rechargePage/paymentPage', page: () => const PaymentPage(price: '')),
      ],
      title: 'Jio Offer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
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
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeroSection(),
            SizedBox(height: 10),
            SizedBox(width: 1000, child: RechargeSection()),
            SizedBox(height: 10),
            AfterRecharge(),
            SizedBox(height: 20),
            AfterVideo(),
          ],
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/a.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'The Best Thing In Life Are FREE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 46,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'High speed connectivity, digital delights, and many priceless moments.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF0F3CC9), // Text color
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Get Jio Sim',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                style: ButtonStyle(
                  side: WidgetStateProperty.all(
                      const BorderSide(color: Colors.white)), // Border color
                  foregroundColor: WidgetStateProperty.all(Colors.white), // Text color
                ),
                onPressed: () {},
                child: const Text("Let's celebrate"),
              ),
            ],
          ),
        ],
      ).paddingOnly(left: 20),
    );
  }
}

class RechargeSection extends StatefulWidget {
  const RechargeSection({super.key});

  @override
  State<RechargeSection> createState() => _RechargeSectionState();
}

class _RechargeSectionState extends State<RechargeSection> {
  final TextEditingController mobileNumberController = TextEditingController();
  String? errorMessage;

  void navigateToRechargePage() {
    String mobileNumber = mobileNumberController.text.trim();
    if (mobileNumber.startsWith('123')) {
      setState(() {
        errorMessage = 'Invalid Mobile number.';
      });
    } else if (mobileNumber.length == 10) {
      Get.to(() => RechargePage(
            mobileNumber: mobileNumberController.text.trim(),
          ));
      setState(() {
        errorMessage = null;
      });
    } else {
      setState(() {
        errorMessage = 'Please enter a valid 10-digit mobile number.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(height: 55, child: Image.asset('assets/cell-phone.png')),
                  const Text(
                    'Mobile Recharge',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: mobileNumberController,
                decoration: InputDecoration(
                  labelText: 'Enter Jio Mobile Number',
                  hintText: '123456789',
                  border: const OutlineInputBorder(),
                  errorText: errorMessage,
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                decoration: const BoxDecoration(
                    color: Color(0xffE3E8FD), borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20, child: Image.asset('assets/discount-badge.png')),
                    const Text(
                      "Recharge with a Rs.149 plan for a month full of digital delights.",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: navigateToRechargePage,
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
                    style:
                        TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class AfterRecharge extends StatelessWidget {
  const AfterRecharge({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine screen size
    bool isSmallScreen = MediaQuery.of(context).size.width < 700;

    return Column(
      children: [
        const Text(
          'In the spotlight',
          style: TextStyle(fontFamily: 'RobotoSlab', fontWeight: FontWeight.w900, fontSize: 50),
        ),
        Text(
          'The best deals, new launches, and top-selling products right now.',
          style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 20),
        ),
        const SizedBox(height: 50),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: 20)],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/jio1-ezgif.com-video-to-gif-converter.gif'),
                    const SizedBox(height: 20),
                    const Text(
                      """Say "Cheese!" India's Favourite selfie phone is here""",
                      style: TextStyle(
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("Get a JioPhone Next now for only ₹ 4499.",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontFamily: 'RobotoSlab',
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF0F3CC9), // Text color
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Explore now',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("""Say "Cheese!" India's Favourite selfie phone is here""",
                              style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 50),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis),
                          Text("Get a JioPhone Next now for only ₹ 4499.",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontFamily: 'RobotoSlab',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 25),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF0F3CC9), // Text color
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Explore now',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Image.asset('assets/jio1-ezgif.com-video-to-gif-converter.gif'),
                  ],
                ),
        ),
      ],
    ).paddingSymmetric(horizontal: isSmallScreen ? 30 : 100);
  }
}

class AfterVideo extends StatelessWidget {
  const AfterVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        'assets/footer.153f35181d1adde12abf.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
