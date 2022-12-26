abstract class QiitaItemsReaderInterface {
  Future<List> read(int page, List<String> filterKeywords);
  Future<String> getImage(Uri url);
}
