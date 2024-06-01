import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberWidget extends StatefulWidget {
  const PhoneNumberWidget({
    super.key,
    required this.phoneController,
  });

  final TextEditingController phoneController;

  @override
  State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  var phonenumber;
  String phnNumber = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black54),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffeeeeee),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          InternationalPhoneNumberInput(
            // countries: ["LK"],
            onInputChanged: (PhoneNumber number) {
              // print(number.phoneNumber);
              phonenumber = number.phoneNumber!;
              setState(() {
                phnNumber = number.phoneNumber!;
              });
            },
            onInputValidated: (bool value) {
              print(value);
              setState(() {
                // isValid = value;
              });
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
              useEmoji: true,
              // trailingSpace: true,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            textFieldController: widget.phoneController,
            formatInput: true,
            maxLength: 11,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            cursorColor: Colors.black,
            inputDecoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 15, left: 0),
              border: InputBorder.none,
              hintText: 'Phone Number',
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            ),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
          Positioned(
            left: 90,
            top: 8,
            bottom: 8,
            child: Container(
              height: 40,
              width: 1,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
    ;
  }
}
