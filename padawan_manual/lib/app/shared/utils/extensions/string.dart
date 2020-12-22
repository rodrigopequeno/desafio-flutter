/// Extensão da String
extension StringExtension on String {
  /// Retorna a string com primeira letra maiúscula e
  /// todas as subsequentes minúscula
  String toFirstLetterUpperCase() => this[0].toUpperCase() + substring(1);
}
