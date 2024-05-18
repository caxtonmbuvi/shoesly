/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsDataGen {
  const $AssetsDataGen();

  /// File path: assets/data/progress_loader.json
  String get progressLoader => 'assets/data/progress_loader.json';

  /// List of all assets
  List<String> get values => [progressLoader];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/card.png
  AssetGenImage get card => const AssetGenImage('assets/images/card.png');

  /// File path: assets/images/cart.png
  AssetGenImage get cart => const AssetGenImage('assets/images/cart.png');

  /// File path: assets/images/empty.png
  AssetGenImage get empty => const AssetGenImage('assets/images/empty.png');

  /// File path: assets/images/emptysearch.png
  AssetGenImage get emptysearch =>
      const AssetGenImage('assets/images/emptysearch.png');

  /// File path: assets/images/filter.png
  AssetGenImage get filter => const AssetGenImage('assets/images/filter.png');

  /// File path: assets/images/jordan.png
  AssetGenImage get jordan => const AssetGenImage('assets/images/jordan.png');

  /// File path: assets/images/nike.png
  AssetGenImage get nike => const AssetGenImage('assets/images/nike.png');

  /// File path: assets/images/shoe1.png
  AssetGenImage get shoe1 => const AssetGenImage('assets/images/shoe1.png');

  /// File path: assets/images/shoe2.png
  AssetGenImage get shoe2 => const AssetGenImage('assets/images/shoe2.png');

  /// File path: assets/images/shoe3.png
  AssetGenImage get shoe3 => const AssetGenImage('assets/images/shoe3.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        card,
        cart,
        empty,
        emptysearch,
        filter,
        jordan,
        nike,
        shoe1,
        shoe2,
        shoe3
      ];
}

class Assets {
  Assets._();

  static const $AssetsDataGen data = $AssetsDataGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
