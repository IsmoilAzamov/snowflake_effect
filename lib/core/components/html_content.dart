import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

Widget buildHtmlContent(String htmlContent) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(navigatorKey.currentContext!).cardColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Theme.of(navigatorKey.currentContext!)
            .dividerColor
            .withValues(alpha: 0.2),
      ),
    ),
    child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Html(
        data: htmlContent,
        style: {
          "body": Style(
            fontSize: FontSize(14.0),
            lineHeight: LineHeight(1.8),
            textAlign: TextAlign.justify,
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            textDecoration: TextDecoration.none, // Added
          ),
          "h1": Style(
            fontSize: FontSize(20.0),
            fontWeight: FontWeight.bold,
            margin: Margins.only(bottom: 16.0, top: 8.0),
            textDecoration: TextDecoration.none, // Added
          ),
          "h2": Style(
            fontSize: FontSize(18.0),
            fontWeight: FontWeight.bold,
            margin: Margins.only(bottom: 12.0, top: 8.0),
            textDecoration: TextDecoration.none, // Added
          ),
          "h3": Style(
            fontSize: FontSize(16.0),
            fontWeight: FontWeight.bold,
            margin: Margins.only(bottom: 10.0, top: 8.0),
            textDecoration: TextDecoration.none, // Added
          ),
          "h4": Style(
            fontSize: FontSize(14.0),
            fontWeight: FontWeight.bold,
            margin: Margins.only(bottom: 8.0, top: 8.0),
            textDecoration: TextDecoration.none, // Added
          ),
          "h5": Style(
            fontSize: FontSize(12.0),
            fontWeight: FontWeight.bold,
            margin: Margins.only(bottom: 6.0, top: 8.0),
            textDecoration: TextDecoration.none, // Added
          ),
          "h6": Style(
            fontSize: FontSize(10.0),
            fontWeight: FontWeight.bold,
            margin: Margins.only(bottom: 4.0, top: 8.0),
            textDecoration: TextDecoration.none, // Added
          ),
          "p": Style(
            fontSize: FontSize(14.0),
            margin: Margins.only(bottom: 12.0),
            lineHeight: LineHeight(1.6),
            textDecoration: TextDecoration.none, // Added
          ),
          "a": Style(
            textDecoration: TextDecoration.none, // Already present
          ),
          "ul": Style(
            margin: Margins.only(left: 20.0, bottom: 16.0),
            textDecoration: TextDecoration.none, // Added
          ),
          "li": Style(
            margin: Margins.only(bottom: 8.0),
            textDecoration: TextDecoration.none,
            color: Theme.of(navigatorKey.currentContext!).brightness ==
                    Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
          "span": Style(
            margin: Margins.only(bottom: 8.0),
            textDecoration: TextDecoration.none,
            backgroundColor: Colors.transparent,
            color: Theme.of(navigatorKey.currentContext!).brightness ==
                    Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
          // Add other tags as needed
        },
        onLinkTap: (url, _, __) {
          if (url?.isNotEmpty ?? false) {
            launchUrl(Uri.parse(url!));
          }
        },
      ),
    ),
  );
}
