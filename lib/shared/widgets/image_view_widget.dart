import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:malf/shared/network/token.dart';

void imageNetworkListViewer({
  required List<String> imageUrls,
  required BuildContext context,
}) {
  context.push(
    "/imageViewer",
    extra: imageUrls,
  );
}

class ImageViewerScreen extends StatefulWidget {
  const ImageViewerScreen({super.key, required this.imageUrlList});
  final List<String> imageUrlList;

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _ImageViewerScreenState extends State<ImageViewerScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.imageUrlList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (mounted) {
                context.pop();
              }
            },
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: List<Widget>.generate(
          widget.imageUrlList.length,
          (index) {
            final GlobalKey<ExtendedImageGestureState> gestureKey =
                GlobalKey<ExtendedImageGestureState>();
            return Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 150,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ExtendedImage.network(
                        widget.imageUrlList[index],
                        fit: BoxFit.contain,
                        headers: {"Authorization": Token().refreshToken},
                        mode: ExtendedImageMode.gesture,
                        extendedImageGestureKey: gestureKey,
                        initGestureConfigHandler: (state) {
                          return GestureConfig(
                            minScale: 0.9,
                            animationMinScale: 0.7,
                            maxScale: 3.0,
                            animationMaxScale: 3.5,
                            speed: 1.0,
                            inertialSpeed: 100.0,
                            initialScale: 1.0,
                            inPageView: false,
                            initialAlignment: InitialAlignment.center,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        //
      ),
      bottomSheet: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (_tabController.index > 0) {
                    _tabController.animateTo(_tabController.index - 1);
                  }
                },
                child: const Icon(Icons.arrow_back_ios)),
            ElevatedButton(
                onPressed: () {
                  if (_tabController.index < widget.imageUrlList.length - 1) {
                    _tabController.animateTo(_tabController.index + 1);
                  }
                },
                child: const Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ),
    );
  }
}
