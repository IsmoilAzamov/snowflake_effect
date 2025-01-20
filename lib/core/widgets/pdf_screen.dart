import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../client/data/datasources/local/token_db_service.dart';

class PDFScreen extends StatefulWidget {
  final String url;
  final String? localFilePath;
  final String? title;

  const PDFScreen({super.key, required this.url, this.localFilePath, this.title});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String? _localFilePath;
  int? _pages;
  int? _currentPage = 0;
  bool _isReady = false;
  bool _isPortrait = true;
  bool _showControls = true;
  late PDFViewController _pdfViewController;

  @override
  void initState() {
    super.initState();
    _downloadAndSavePDF();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> _downloadAndSavePDF() async {
    if (widget.localFilePath != null) {
      setState(() {
        _localFilePath = widget.localFilePath;
      });
      return;
    }
    try {
      final filename = widget.url.substring(widget.url.lastIndexOf("/") + 1);
      final response = await http.get(
        Uri.parse(widget.url),
        headers: {'Authorization': 'Bearer ${TokenService.accessToken}'},
      );
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(response.bodyBytes);
      setState(() {
        _localFilePath = file.path;
      });
    } catch (e) {
      debugPrint('Error downloading PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error_loading_pdf'.tr())),
      );
    }
  }

  void _toggleOrientation() {
    setState(() {
      _isPortrait = !_isPortrait;
      if (_isPortrait) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
    });
  }

  Widget _loadingIndicator() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "${"loading_material".tr()}...",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.title ?? 'view'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(_isPortrait ? Icons.screen_rotation : Icons.screen_lock_portrait),
              onPressed: _toggleOrientation,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return AnimatedOpacity(
      opacity: _showControls ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.first_page),
              onPressed: () => _pdfViewController.setPage(0),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: _currentPage != null && _currentPage! > 0
                  ? () => _pdfViewController.setPage(_currentPage! - 1)
                  : null,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                "${_currentPage! + 1} / ${_pages ?? 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: _currentPage != null && _currentPage! < ((_pages ?? 1) - 1)
                  ? () => _pdfViewController.setPage(_currentPage! + 1)
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.last_page),
              onPressed: () => _pdfViewController.setPage((_pages ?? 1) - 1),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _localFilePath == null
            ? _loadingIndicator()
            : GestureDetector(
          onTap: () => setState(() => _showControls = !_showControls),
          child: Stack(
            children: [
              PDFView(
                filePath: _localFilePath!,
                autoSpacing: true,
                enableSwipe: true,
                swipeHorizontal: !_isPortrait,
                pageSnap: true,
                pageFling: true,
                fitPolicy: _isPortrait ? FitPolicy.WIDTH : FitPolicy.HEIGHT,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                onRender: (pages) {
                  setState(() {
                    _pages = pages;
                    _isReady = true;
                  });
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  setState(() {
                    _pdfViewController = pdfViewController;
                  });
                },
                onPageChanged: (int? page, int? total) {
                  setState(() {
                    _currentPage = page;
                  });
                },
              ),
              if (!_isReady) _loadingIndicator(),
              Positioned(top: 0, left: 0, right: 0, child: _buildAppBar()),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(child: _buildControls()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}