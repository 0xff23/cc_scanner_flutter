import 'package:flutter/material.dart';
import 'package:easy_card_scanner/credit_card_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CardDetails _cardDetails;
  String _creditCardNumber = "";
  String _expDate = "";
  String _type = "";
  String _ownerName = "";

  CardScanOptions scanOptions = const CardScanOptions(
    scanCardHolderName: true,
    enableDebugLogs: true,
    validCardsToScanBeforeFinishingScan: 5,
    possibleCardHolderNamePositions: [
      CardHolderNameScanPosition.aboveCardNumber,
      CardHolderNameScanPosition.belowCardNumber,
    ],
  );

  Future<void> scanCard() async {
    var cardDetails = await CardScanner.scanCard(scanOptions: scanOptions);
    if (!mounted) return;
    setState(() {
      _cardDetails = displayCardInfo(cardDetails)!;
      _creditCardNumber = displayCardInfo(cardDetails)!.cardNumber;
      _expDate = displayCardInfo(cardDetails)!.expiryDate;
      _type = displayCardInfo(cardDetails)!.cardIssuer;
      _ownerName = displayCardInfo(cardDetails)!.cardHolderName;
    });
  }

  CardDetails? displayCardInfo(CardDetails? cardDetails) => cardDetails;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.camera_alt),
            onPressed: () async {
              //await CardScanner.scanCard(scanOptions: scanOptions);
              scanCard();
            }),
        appBar: AppBar(
          title: const Text('Easy Card Scanner'),
        ),
        body: Align(
          alignment: const Alignment(-0.6, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Owner: $_ownerName',
                  style: const TextStyle(height: 1, fontSize: 22)),
              const SizedBox(height: 5),
              Text('Credit card number: $_creditCardNumber',
                  style: const TextStyle(height: 1, fontSize: 22)),
              const SizedBox(height: 5),
              Text('Credit card type: $_type',
                  style: const TextStyle(height: 1, fontSize: 22)),
              const SizedBox(height: 5),
              Text('Credit card expiry date: $_expDate',
                  style: const TextStyle(height: 1, fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}
