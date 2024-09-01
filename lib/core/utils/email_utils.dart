
import 'package:campusleave/models/warden_model.dart';

String generateEmailTemplate(String name) {
  return '''
Dear [Recipient's Name],

I hope this message finds you well. I am writing to request permission to leave campus from [Start Date] to [End Date]. The reason for my departure is [Reason for Leave].

During my absence, I assure you that I will [mention any responsibilities or arrangements you'll make, if applicable]. 


Thank you for considering my request. I look forward to your favorable response.

Sincerely,

$name
[Your Student Roll no.]
[Your Department/Year]

IIT Jodhpur
  ''';
}
String generateEmailTemplateWarden(String name, String email, WardenModel warden) {
  // final branch = getBranchFromEmail(email);
  // final year = getYearFromEmail(email);

  return '''
Dear [Recipient's Name],

I hope this message finds you well. I am writing to request permission to leave campus from [Start Date] to [End Date]. The reason for my departure is [Reason for Leave].

During my absence, I assure you that I will [mention any responsibilities or arrangements you'll make, if applicable]. 


Thank you for considering my request. I look forward to your favorable response.

Sincerely,

$name
[Your Student Roll no.]
[Your Department/Year]

IIT Jodhpur
  ''';
}
