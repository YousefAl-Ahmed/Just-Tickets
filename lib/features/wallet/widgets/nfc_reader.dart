import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:just_tickets/classes/ticket.dart';

class NFCReader extends ConsumerStatefulWidget {
  final Ticket selectedTicket;

  const NFCReader({super.key, required this.selectedTicket});

  @override
  _NFCReaderState createState() => _NFCReaderState();
}

class _NFCReaderState extends ConsumerState<NFCReader> {
  String _nfcStatus = 'Ready to scan ticket';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Ticket')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _nfcStatus,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _startNFCSession,
              child: const Text('Start NFC Scan'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _startNFCSession() async {
    try {
      // Check NFC availability
      var availability = await FlutterNfcKit.nfcAvailability;
      if (availability != NFCAvailability.available) {
        setState(() {
          _nfcStatus = 'NFC is not available on this device.';
        });
        return;
      }

      // Update status
      setState(() {
        _nfcStatus = 'Scanning... Please hold your device near the ticket.';
      });

      // Start NFC polling
      var tag = await FlutterNfcKit.poll();

      // Debugging: Print raw tag data
      print('Tag data: ${tag.toJson()}');

      // Check for NDEF availability
      if (tag.ndefAvailable == true) {
        // Read decoded NDEF records
        final ndefRecords = await FlutterNfcKit.readNDEFRecords();
        for (var record in ndefRecords) {
          if (record.payload != null) {
            final ticketId = String.fromCharCodes(record.payload!);

            // Validate ticket ID
            if (ticketId == widget.selectedTicket.ticketId) {
              setState(() {
                _nfcStatus = 'Ticket validated successfully!';
              });
              await FlutterNfcKit.finish(iosAlertMessage: "Success");
              return;
            }
          }
        }
      }

      // If no valid ticket ID was found
      setState(() {
        _nfcStatus = 'Invalid ticket or no valid NDEF data found.';
      });
      await FlutterNfcKit.finish(iosErrorMessage: "Failed");
    } catch (e) {
      // Handle errors
      setState(() {
        _nfcStatus = 'Error: ${e.toString()}';
      });
      await FlutterNfcKit.finish(iosErrorMessage: "Error occurred");
    }
  }
}
