import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecipeImageWidget extends StatelessWidget {
  const RecipeImageWidget({
    Key? key,
    this.imageUrl = '',
    this.placeholderColor,
  }) : super(key: key);

  final String? imageUrl;
  final Color? placeholderColor;

  @override
  Widget build(BuildContext context) {
    return imageUrl!.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            imageBuilder: (_, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (_, __) => Image.asset(
              'assets/images/default_recipe.png',
              color: placeholderColor ?? Colors.black12,
              fit: BoxFit.contain,
            ),
            errorWidget: (_, __, ___) => Image.asset(
              'assets/images/broken_image.png',
              fit: BoxFit.contain,
              color: placeholderColor ?? Colors.black12,
            ),
          )
        : Image.asset(
            'assets/images/default_recipe.png',
            color: placeholderColor ?? Colors.black12,
          );
  }
}
