import 'package:flutter/material.dart';

class EditorController extends ChangeNotifier {
  String _content;
  final List<String> _undoStack = [];
  final List<String> _redoStack = [];
  bool _isDirty = false;
  int _cursorLine = 1;
  int _cursorColumn = 1;
  String _searchQuery = '';

  EditorController({String initialContent = ''}) : _content = initialContent {
    _undoStack.add(initialContent);
  }

  String get content => _content;
  bool get isDirty => _isDirty;
  int get cursorLine => _cursorLine;
  int get cursorColumn => _cursorColumn;
  String get searchQuery => _searchQuery;

  int get lineCount {
    if (_content.isEmpty) return 1;
    return _content.split('\n').length;
  }

  void updateContent(String newContent) {
    if (newContent != _content) {
      _undoStack.add(_content);
      _redoStack.clear();
      _content = newContent;
      _isDirty = true;
      notifyListeners();
    }
  }

  void updateCursorPosition(int line, int col) {
    _cursorLine = line;
    _cursorColumn = col;
    notifyListeners();
  }

  bool canUndo() => _undoStack.length > 1;
  bool canRedo() => _redoStack.isNotEmpty;

  void undo() {
    if (canUndo()) {
      _redoStack.add(_content);
      _content = _undoStack.removeLast();
      notifyListeners();
    }
  }

  void redo() {
    if (canRedo()) {
      _undoStack.add(_content);
      _content = _redoStack.removeLast();
      notifyListeners();
    }
  }

  void markClean() {
    _isDirty = false;
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void replaceAll(String query, String replacement) {
    if (query.isNotEmpty) {
      updateContent(_content.replaceAll(query, replacement));
    }
  }
}
