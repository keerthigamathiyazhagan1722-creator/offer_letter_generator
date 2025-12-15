import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../models/offer_letter_model.dart';
import '../widgets/offer_letter_template.dart';
import '../services/pdf_service.dart';
import '../services/image_service.dart';
import 'login_screen.dart';

class OfferFormScreen extends StatefulWidget {
  const OfferFormScreen({super.key});

  @override
  State<OfferFormScreen> createState() => _OfferFormScreenState();
}

class _OfferFormScreenState extends State<OfferFormScreen> {
  final TextEditingController company = TextEditingController();
  final TextEditingController candidate = TextEditingController();
  final TextEditingController role = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController joiningDate = TextEditingController();

  final ScreenshotController screenshotController = ScreenshotController();

  OfferLetter? offer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer Letter Generator'),
        actions:[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (){
              Navigator.pushReplacement( 
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
               );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildField(company, 'Company Name'),
            buildField(candidate, 'Candidate Name'),
            buildField(role, 'Job Role'),
            buildField(salary, 'Salary Package'),
            buildField(joiningDate, 'Joining Date'),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  offer = OfferLetter(
                    company: company.text,
                    candidate: candidate.text,
                    role: role.text,
                    salary: salary.text,
                    joiningDate: joiningDate.text,
                  );
                });
              },
              child: const Text('Generate Offer Letter'),
            ),

            const SizedBox(height: 20),

            if (offer != null)
              Screenshot(
                controller: screenshotController,
                child: OfferLetterTemplate(offer: offer!),
              ),

            const SizedBox(height: 20),

            if (offer != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await PdfService.generateAndDownloadPdf(
                        companyName: offer!.company,
                        candidateName: offer!.candidate,
                        jobRole: offer!.role,
                        salary: offer!.salary,
                        joiningDate: offer!.joiningDate,
                      );
                    },
                    child: const Text('Download PDF'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final image =
                          await screenshotController.capture();
                      if (image != null) {
                        ImageService.downloadImageWeb(image);
                      }
                    },
                    child: const Text('Download Image'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
