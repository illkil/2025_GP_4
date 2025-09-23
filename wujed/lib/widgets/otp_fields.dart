import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpFields extends StatefulWidget {
  const OtpFields({super.key, this.length = 4, required this.onCompleted});
  final int length;
  final ValueChanged<String> onCompleted;

  @override
  State<OtpFields> createState() => _OtpFieldsState();
}

class _OtpFieldsState extends State<OtpFields> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _nodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final n in _nodes) n.dispose();
    super.dispose();
  }

  void _onChanged(int index, String value) {
    // only keep 1 char
    if (value.length > 1) {
      // handle paste: keep the last char here;
      // optional: distribute pasted digits across fields.
      _controllers[index].text = value.characters.last;
      _controllers[index].selection = TextSelection.collapsed(offset: 1);
    }
    if (value.isNotEmpty) {
      // move to next
      if (index + 1 < widget.length) {
        _nodes[index + 1].requestFocus();
      } else {
        // completed
        final code = _controllers.map((c) => c.text).join();
        widget.onCompleted(code);
        _nodes[index].unfocus();
      }
    }
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _nodes[index - 1].requestFocus();
        _controllers[index - 1].text = '';
      }
    }
    return KeyEventResult.ignored;
  }

  InputDecoration _decoration(BuildContext context) => InputDecoration(
    counterText: '',
    contentPadding: EdgeInsets.zero,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBDBDBD), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color.fromRGBO(46, 23, 21, 1), width: 2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: SizedBox(
            width: 56,
            height: 56,
            child: Focus(
              focusNode: _nodes[i],
              onKeyEvent: (node, event) => _handleKey(node, event, i),
              child: TextField(
                controller: _controllers[i],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                keyboardType: TextInputType.number,
                textInputAction: i == widget.length - 1
                    ? TextInputAction.done
                    : TextInputAction.next,
                maxLength: 1,
                decoration: _decoration(context),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                onChanged: (v) => _onChanged(i, v),
              ),
            ),
          ),
        );
      }),
    );
  }
}
