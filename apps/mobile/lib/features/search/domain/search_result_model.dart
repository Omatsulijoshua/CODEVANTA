enum SearchResultType { file, content, symbol }

class SearchMatch {
  final String filePath;
  final String fileName;
  final SearchResultType type;
  final int lineNumber;
  final String snippet;
  final String? symbolName;

  const SearchMatch({
    required this.filePath,
    required this.fileName,
    required this.type,
    this.lineNumber = 1,
    required this.snippet,
    this.symbolName,
  });
}

class SymbolItem {
  final String name;
  final String kind; // class, function, variable, import
  final String filePath;
  final int lineNumber;

  const SymbolItem({
    required this.name,
    required this.kind,
    required this.filePath,
    required this.lineNumber,
  });
}
