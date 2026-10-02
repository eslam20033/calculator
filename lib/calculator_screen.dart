import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/calculator_bloc.dart';
import 'bloc/calculator_event.dart';
import 'bloc/calculator_state.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 28,
                left: 24,
                right: 24,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF4C5BF7),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.calculate,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Simple Calculator',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Add • Subtract • Multiply • Divide',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('First Number'),
                  _buildInputField(_firstController),
                  const SizedBox(height: 18),

                  _buildLabel('Second Number'),
                  _buildInputField(_secondController),
                  const SizedBox(height: 22),

                  _buildLabel('Choose Operation'),
                  BlocBuilder<CalculatorBloc, CalculatorState>(
                    buildWhen: (prev, curr) =>
                        prev.selectedOperation != curr.selectedOperation,
                    builder: (context, state) {
                      return Row(
                        children: [
                          _buildOperationButton(
                            context,
                            '+',
                            'Add',
                            const Color(0xFFE8F8F0),
                            const Color(0xFF2E8540),
                            state.selectedOperation == '+',
                          ),
                          const SizedBox(width: 10),
                          _buildOperationButton(
                            context,
                            '-',
                            'Subtract',
                            const Color(0xFFFFECEB),
                            const Color(0xFFD34542),
                            state.selectedOperation == '-',
                          ),
                          const SizedBox(width: 10),
                          _buildOperationButton(
                            context,
                            '×',
                            'Multiply',
                            const Color(0xFFFEF6E4),
                            const Color(0xFFC78400),
                            state.selectedOperation == '×',
                          ),
                          const SizedBox(width: 10),
                          _buildOperationButton(
                            context,
                            '÷',
                            'Divide',
                            const Color(0xFFE8F2FF),
                            const Color(0xFF2F7AE5),
                            state.selectedOperation == '÷',
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<CalculatorBloc>().add(
                          CalculateResultEvent(
                            firstNumber: _firstController.text,
                            secondNumber: _secondController.text,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.calculate_outlined,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Calculate',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C5BF7),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  BlocBuilder<CalculatorBloc, CalculatorState>(
                    builder: (context, state) {
                      if (state.errorMessage != null) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Center(
                            child: Text(
                              state.errorMessage!,
                              style: TextStyle(
                                color: Colors.red.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }

                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F4FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Result',
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.celebration,
                                color: Color(0xFF4C5BF7),
                                size: 28,
                              ),
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    state.resultText ?? '0',
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF283995),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    state.formulaText ??
                                        'Enter numbers and press Calculate',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF6B7FD7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, color: Colors.grey, size: 20),
            onPressed: () => controller.clear(),
          ),
        ),
      ),
    );
  }

  Widget _buildOperationButton(
    BuildContext context,
    String symbol,
    String label,
    Color bg,
    Color activeColor,
    bool isSelected,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () {
          context.read<CalculatorBloc>().add(SelectOperationEvent(symbol));
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? activeColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                symbol,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: activeColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: activeColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
