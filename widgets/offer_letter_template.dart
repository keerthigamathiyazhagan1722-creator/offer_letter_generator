import 'package:flutter/material.dart';
import '../models/offer_letter_model.dart';

class OfferLetterTemplate extends StatelessWidget {
  final OfferLetter offer;

  const OfferLetterTemplate({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                offer.company,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Center(
              child: Text(
                'OFFER LETTER',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text('Date: ${DateTime.now().toString().split(' ')[0]}'),
            const SizedBox(height: 15),

            Text('Dear ${offer.candidate},'),
            const SizedBox(height: 10),

            Text(
              'We are pleased to offer you the position of ${offer.role} '
              'at ${offer.company}. Based on your skills, Qualifications and performance, '
              'we believe you will be a valuable asset to our organization.',
            ),

            const SizedBox(height: 10),

            Text('Salary Package: ${offer.salary}'),
            const SizedBox(height: 5),
            Text('Joining Date: ${offer.joiningDate}'),

            const SizedBox(height: 15),

            const Text(
              'Terms & Conditions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            const Text(
              '• You will be on probation for 6 months.\n'
              '• You are expected to follow company policies.\n'
              '• Either party may terminate employment with one month notice.\n'
              '• This offer is subject to document verification.',
            ),

            const SizedBox(height: 20),

            const Text('Sincerely,'),
            const SizedBox(height: 5),
            Text(offer.company),

            const SizedBox(height: 30),

            const Text('Employee Acceptance'),
            const SizedBox(height: 10),
            const Text('Signature: ______________________'),
          ],
        ),
      ),
    );
  }
}
