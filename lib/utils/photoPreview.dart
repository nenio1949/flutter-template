import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

typedef PageChanged = void Function(int index);

/// 图片预览
class PhotoPreview extends StatefulWidget {
  final List galleryItems; //图片列表
  final int defaultImage; //默认第几张
  final PageChanged? pageChanged; //切换图片回调
  final Axis direction; //图片查看方向
  final BoxDecoration? decoration; //背景设计

  const PhotoPreview(
      {super.key,
      required this.galleryItems,
      this.defaultImage = 1,
      this.pageChanged,
      this.direction = Axis.horizontal,
      this.decoration});

  @override
  State<PhotoPreview> createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {
  late int tempSelect;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    tempSelect = widget.defaultImage + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.galleryItems[index]),
                );
              },
              scrollDirection: widget.direction,
              itemCount: widget.galleryItems.length,
              backgroundDecoration:
                  widget.decoration ?? const BoxDecoration(color: Colors.white),
              pageController: PageController(initialPage: widget.defaultImage),
              onPageChanged: (index) => setState(() {
                    tempSelect = index + 1;
                    widget.pageChanged!(index);
                  })),
          Positioned(
            ///布局自己换
            right: 20,
            top: 20,
            child: Text(
              '$tempSelect/${widget.galleryItems.length}',
              style: const TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
