import 'package:flutter/material.dart';
import 'package:lc_design/lc_design.dart';
import 'package:photo_view/photo_view.dart';

class AppImagePreview extends StatelessWidget {
  const AppImagePreview({
    super.key,
    this.imageProvider,
  });

  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            loadingBuilder: (context, _) {
              return const LCLoading();
            },
            imageProvider: imageProvider,
          ),
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              child: LCInkwell.base(
                child: const Icon(
                  Icons.cancel,
                  color: LCColors.white,
                  size: 24,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
