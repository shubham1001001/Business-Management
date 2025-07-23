import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SvgPictureWidgets extends StatelessWidget {
  final String svgString;
  final Color? color;
  final size;
  final type;

  const SvgPictureWidgets({Key? key, required this.svgString, this.color, this.size, this.type = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type
        ? color != null
              ? SvgPicture.asset(height: size, svgString, colorFilter: ColorFilter.mode(color!, BlendMode.srcIn), semanticsLabel: 'Red dash paths')
              : SvgPicture.asset(height: size, svgString, semanticsLabel: 'Red dash paths')
        : SvgPicture.string(svgString, height: size);
    //   SvgPicture.string(
    //   svgString,
    //   color: color, // this works only if SVG uses currentColor
    // );
  }
}
