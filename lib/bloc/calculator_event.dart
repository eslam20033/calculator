abstract class CalculatorEvent {}

class SelectOperationEvent extends CalculatorEvent {
  final String operation;
  SelectOperationEvent(this.operation);
}

class CalculateResultEvent extends CalculatorEvent {
  final String firstNumber;
  final String secondNumber;

  CalculateResultEvent({required this.firstNumber, required this.secondNumber});
}
