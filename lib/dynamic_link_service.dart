import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkHandler {
  const DynamicLinkHandler._();

  static Uri dynamicLink = Uri();
  static Future<Uri> createDynamicLink() async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://example.page.link.com/"),
      uriPrefix: "https://example.page.link",
      androidParameters:
          const AndroidParameters(packageName: "com.example.bloc_practice"),
      iosParameters: const IOSParameters(bundleId: "com.example.bloc_practice"),
    );
    dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
    print('--$dynamicLink');
    return dynamicLink;
  }
}
