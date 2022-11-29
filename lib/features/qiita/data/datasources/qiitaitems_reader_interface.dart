abstract class QiitaItemsReaderInterface {
  Future<List> read(int page);
  Future<String> getImage(Uri url);
}
