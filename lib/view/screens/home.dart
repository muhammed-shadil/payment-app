import 'package:flutter/material.dart';
import 'package:payment/view/widgets/banner_ads.dart';
import 'package:payment/view/widgets/main_actiontile.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Razorpay _razorpay;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(String amount) async {
    var options = {
      'key': 'rzp_test_ETJHOCczkb7QSX',
      'amount': int.parse(amount) * 100,
      'name': 'Geeksynergy',
      'description': 'Fine T-Shirt',
      'prefill': {
        'contact': '7025510522',
        'email': 'muhammedshadil220@gmail.com'
      },
      'external': {
        'wallets': ['google-pay']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  final List<Map<String, dynamic>> transferMoneyActions = [
    {'icon': Icons.account_circle, 'label': "To Mobile number"},
    {'icon': Icons.home, 'label': "To Bank/ UPI ID"},
    {'icon': Icons.account_balance_wallet, 'label': "To Self Account"},
    {'icon': Icons.account_balance, 'label': "Check Balance"},
  ];

  final List<Map<String, dynamic>> rechargeAndPayBillsActions = [
    {'icon': Icons.phone_android, 'label': "Mobile"},
    {'icon': Icons.attach_money, 'label': "Loan "},
    {'icon': Icons.credit_card, 'label': "Credit Card"},
    {'icon': Icons.home, 'label': "Rent"},
  ];

  void _showPaymentModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20,
              left: 10,
              right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter Payment Amount',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () {
                  if (_amountController.text.isNotEmpty) {
                    Navigator.pop(context); // Close the modal
                    openCheckout(
                        _amountController.text); // Pass the entered amount
                  } else {
                      Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "Please enter a valid amount",
                        toastLength: Toast.LENGTH_SHORT);
                  }
                },
                child: const Text(
                  'Proceed to Pay',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 200.0,
        height: 50.0,
        child: ElevatedButton(
          onPressed: () {
            _showPaymentModal();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: Colors.purple,
          ),
          child: const Text(
            'Make Payment',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.purple),
            ),
            SizedBox(width: 10),
            Text(
              "Add Address",
              style: TextStyle(color: Colors.white),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 10),
          Icon(Icons.help_outline),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Section
            const BannerAds(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Transferable Money",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: transferMoneyActions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: MainAction(
                          icon: transferMoneyActions[index]["icon"],
                          label: transferMoneyActions[index]["label"]),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Recharge & Pay Bills",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: rechargeAndPayBillsActions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MainAction(
                        icon: rechargeAndPayBillsActions[index]["icon"],
                        label: rechargeAndPayBillsActions[index]["label"]);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 10,
                  ),
                ),
              ),
            ),
            const BannerAds()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "",
          ),
        ],
      ),
    );
  }
}
