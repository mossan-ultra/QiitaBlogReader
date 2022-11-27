import 'package:flutter/material.dart';
import 'package:qiita_reader/features/qiita/domain/entities/page.dart';
import 'package:url_launcher/url_launcher.dart';

class QiitaPageWidget extends StatelessWidget {
  late BlogPage _page;
  late Widget title;
  late Widget? image;
  late Widget? description;
  QiitaPageWidget({super.key, required BlogPage page}) {
    _page = page;
  }
  void _createPageView() {
    title = Text(
      _page.title,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(fontSize: 13),
    );
    description = Text(
      _page.title ?? '',
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: const TextStyle(fontSize: 12),
    );
    image = ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        child: Image.network(
          _page.image,
          // width: 120,
          height: 120,
          // fit: BoxFit.contain,
          alignment: Alignment.center,
        ));

    // // HTMLパッケージでHTMLタグとして認識
    // var document = parse(response.body);
    // var metas = document.head!.getElementsByTagName('meta');
    // for (var meta in metas) {
    //   // metaタグの中からname属性がdescriptionであるものを探す
    //   if (meta.attributes['name'] == 'description') {
    //     description = Text(
    //       _page.title ?? '',
    //       overflow: TextOverflow.ellipsis,
    //       maxLines: 3,
    //       style: const TextStyle(fontSize: 12),
    //     );
    //     // metaタグの中からproperty属性がog:imageであるものを探す
    //   } else if (meta.attributes['property'] == 'og:image') {
    //     image = ClipRRect(
    //       borderRadius: const BorderRadius.only(
    //           topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
    //       child: Image.network(
    //         _page.image,
    //         width: 120,
    //         height: 120,
    //         fit: BoxFit.cover,
    //         alignment: Alignment.center,
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    _createPageView();

    return ([image, title, description].every((element) => element != null))
        ? InkWell(
            onTap: () async {
              if (await canLaunch(_page.url.value.path)) {
                launch(_page.url.value.path);
              }
            },
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: image!,
            ),
          )
        : const SizedBox();
  }
}
