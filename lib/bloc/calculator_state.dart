class CalculatorState {
  final String selectedOperation;
  final String? resultText;
  final String? formulaText;
  final String? errorMessage;

  CalculatorState({
    this.selectedOperation = '+',
    this.resultText,
    this.formulaText,
    this.errorMessage,
  });

  CalculatorState copyWith({
    String? selectedOperation,
    String? resultText,
    String? formulaText,
    String? errorMessage,
  }) {
    return CalculatorState(
      selectedOperation: selectedOperation ?? this.selectedOperation,
      resultText: resultText,
      formulaText: formulaText,
      errorMessage: errorMessage,
    );
  }
}
