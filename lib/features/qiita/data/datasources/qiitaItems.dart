import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:qiita_reader/features/qiita/data/datasources/qiitaitems_reader_interface.dart';

//参考 https://zenn.dev/mukkun69n/articles/c9980d3298cf9e

class QiitaItemsReader implements QiitaItemsReaderInterface {
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        // 400 Bad Request : 一般的なクライアントエラー
        throw Exception('一般的なクライアントエラーです');
      case 401:
        // 401 Unauthorized : アクセス権がない、または認証に失敗
        throw Exception('アクセス権限がない、または認証に失敗しました');
      case 403:
        // 403 Forbidden ： 閲覧権限がないファイルやフォルダ
        throw Exception('閲覧権限がないファイルやフォルダです');
      case 500:
        // 500 何らかのサーバー内で起きたエラー
        throw Exception('何らかのサーバー内で起きたエラーです');
      default:
        // それ以外の場合
        throw Exception('何かしらの問題が発生しています');
    }
  }

  @override
  Future<List> read(int page, List<String> filterKeywords) async {
    try {
      final query = 'tag:${filterKeywords.join(",")}';
      String url =
          'https://qiita.com/api/v2/items?per_page=20&query=$query&page=$page';
      final uri = Uri.encodeFull(url);
      var response = await http.get(Uri.parse(uri));
      var jsonResponse = _response(response);
      return Future<List>.value(jsonResponse);
    } on SocketException catch (socketException) {
      // ソケット操作が失敗した時にスローされる例外
      throw Exception("netowrk error $socketException");
    } on Exception catch (exception) {
      // statusCode: 200以外の場合
      throw Exception('http error $exception');
    } catch (e) {
      throw Exception('undefined error $e');
    }
  }

  @override
  Future<String> getImage(Uri url) async {
    try {
      // URLにアクセスして情報をすべて取得
      http.Response response = await http.get(url);

      // HTMLパッケージでHTMLタグとして認識
      var document = parse(response.body);
      var metas = document.head!.getElementsByTagName('meta');
      for (var meta in metas) {
        // metaタグの中からname属性がdescriptionであるものを探す
        if (meta.attributes['property'] == 'og:image') {
          return Future<String>.value(meta.attributes['content']!);
        }
      }
      throw Exception('Imageが取得できません');
    } on SocketException catch (socketException) {
      // ソケット操作が失敗した時にスローされる例外
      throw Exception("netowrk error $socketException");
    } on Exception catch (exception) {
      // statusCode: 200以外の場合
      throw Exception('http error $exception');
    } catch (e) {
      throw Exception('undefined error $e');
    }
  }
}
