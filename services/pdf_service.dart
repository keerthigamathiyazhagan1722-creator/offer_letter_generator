import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PdfService {
  static Future<void> generateAndDownloadPdf({
    required String companyName,
    required String candidateName,
    required String jobRole,
    required String salary,
    required String joiningDate,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    companyName,
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.SizedBox(height: 8),

                pw.Center(
                  child: pw.Text(
                    'OFFER LETTER',
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.SizedBox(height: 25),

                pw.Text(
                  'Date: ${DateTime.now().toString().split(' ')[0]}',
                ),

                pw.SizedBox(height: 20),

                pw.Text('Dear $candidateName,'),

                pw.SizedBox(height: 12),

                pw.Text(
                  'We are pleased to offer you the position of $jobRole at $companyName. '
                  'Based on your skills, Qualifications and performance, we believe you '
                  'will be a valuable asset to our organization.',
                  textAlign: pw.TextAlign.justify,
                ),

                pw.SizedBox(height: 15),

                pw.Text('Salary Package: $salary'),
                pw.SizedBox(height: 6),
                pw.Text('Joining Date: $joiningDate'),

                pw.SizedBox(height: 18),

                pw.Text(
                  'Terms & Conditions:',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),

                pw.SizedBox(height: 8),

                pw.Text(
                   You will be on probation for 6 months.\n'
                   You are expected to follow company policies.\n'
                   Either party may terminate employment with one month notice.\n'
                   This offer is subject to document verification.',
                ),

                pw.SizedBox(height: 25),

                pw.Text('Sincerely,'),
                pw.SizedBox(height: 6),
                pw.Text(companyName),

                pw.SizedBox(height: 35),

                pw.Text(
                  'Employee Acceptance',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 12),
                pw.Text('Signature: ______________________'),
              ],
            ),
          );
        },
      ),
    );

    final Uint8List bytes = await pdf.save();

    if (kIsWeb) {
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "offer_letter.pdf")
        ..click();

      html.Url.revokeObjectUrl(url);
    }
  }
}


