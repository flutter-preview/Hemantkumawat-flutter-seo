import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:universal_html/html.dart' as html;

class SEOWidget extends StatefulWidget {
  final String pageTitle;
  final String pageDescription;
  final String pageKeywords;
  final String pageUrl;
  final String imageUrl;
  final Widget child;

  const SEOWidget({
    Key? key,
    this.pageTitle = 'MyApp - Your One-Stop Shop for Quick Commerce',
    this.pageDescription =
        'Discover a wide range of products at MyApp. Shop online and enjoy quick and convenient delivery. Start shopping now!',
    this.pageKeywords =
        'quick commerce, online shopping, e-commerce, products, delivery',
    this.pageUrl = 'MyApp.com',
    this.imageUrl = 'https://MyApp.com/favicon.png',
    required this.child,
  }) : super(key: key);

  @override
  _SEOWidgetState createState() => _SEOWidgetState();
}

class _SEOWidgetState extends State<SEOWidget> {
  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      addSEOMetadata();
      addStructuredData();
    }
  }

  void addSEOMetadata() {
    final html.Document document = html.document;
    final html.Element? headElement = document.querySelector('head');
    if (headElement != null) {
      // Set page title
      final titleElement = html.TitleElement()..text = widget.pageTitle;
      headElement.append(titleElement);

      // Set meta description
      final metaDescriptionElement = html.MetaElement()
        ..name = 'description'
        ..content = widget.pageDescription;
      headElement.append(metaDescriptionElement);

      // Set meta keywords
      final metaKeywordsElement = html.MetaElement()
        ..name = 'keywords'
        ..content = widget.pageKeywords;
      headElement.append(metaKeywordsElement);

      // Set canonical URL
      final linkCanonicalElement = html.LinkElement()
        ..rel = 'canonical'
        ..href = widget.pageUrl;
      headElement.append(linkCanonicalElement);
    }
  }

  void addStructuredData() {
    final html.Document document = html.document;
    final html.Element? headElement = document.querySelector('head');
    if (headElement != null) {
      final scriptElement = html.ScriptElement()
        ..type = 'application/ld+json'
        ..text = '''
        {
          "@context": "https://schema.org",
          "@type": "WebPage",
          "name": "${widget.pageTitle}",
          "description": "${widget.pageDescription}",
          "url": "${widget.pageUrl}",
          "image": "${widget.imageUrl}"
        }
        ''';
      headElement.append(scriptElement);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hidden heading
          Html(
            data: '<h1 style="display: none;">Welcome to MyApp</h1>',
          ),
          // Hidden paragraph
          Html(
            data:
                '<p style="display: none;">Discover a wide range of products at MyApp. Shop online and enjoy quick and convenient delivery.</p>',
          ),
          widget.child,
        ],
      ),
    );
  }
}
