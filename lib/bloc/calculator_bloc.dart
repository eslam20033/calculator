import 'package:flutter_bloc/flutter_bloc.dart';

import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState()) {
    on<SelectOperationEvent>((event, emit) {
      emit(
        state.copyWith(
          selectedOperation: event.operation,
          resultText: state.resultText,
          formulaText: state.formulaText,
        ),
      );
    });

    on<CalculateResultEvent>((event, emit) {
      final num1 = double.tryParse(event.firstNumber.trim());
      final num2 = double.tryParse(event.secondNumber.trim());

      if (num1 == null || num2 == null) {
        emit(state.copyWith(errorMessage: 'يرجى إدخال أرقام صحيحة'));
        return;
      }

      double result = 0;
      final op = state.selectedOperation;

      if (op == '+') {
        result = num1 + num2;
      } else if (op == '-') {
        result = num1 - num2;
      } else if (op == '×') {
        result = num1 * num2;
      } else if (op == '÷') {
        if (num2 == 0) {
          emit(state.copyWith(errorMessage: 'لا يمكن القسمة على صفر'));
          return;
        }
        result = num1 / num2;
      }

      String formattedResult = result.toStringAsFixed(2);
      if (formattedResult.endsWith('.00')) {
        formattedResult = result.toInt().toString();
      }

      String num1Str = num1.toString().endsWith('.0')
          ? num1.toInt().toString()
          : num1.toString();
      String num2Str = num2.toString().endsWith('.0')
          ? num2.toInt().toString()
          : num2.toString();

      emit(
        CalculatorState(
          selectedOperation: op,
          resultText: formattedResult,
          formulaText: '$num1Str $op $num2Str = $formattedResult',
          errorMessage: null,
        ),
      );
    });
  }
}
