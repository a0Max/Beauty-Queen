import 'package:easy_localization/easy_localization.dart';

class Validator {
  String? validatorRequired(String? val) {
    return (val == null || val.length <= 4) ? tr('field_required') : null;
  }

  String? validatorPhoneNumber(String val) {
    return RegExp(
              r'^[0-9]',
            ).hasMatch(val) ==
            false
        ? tr('must_add_phone_number')
        : null;
  }

  String? validatorName(String val) {
    return (val.length <= 4) ? tr('must_add_full_name') : null;
  }

  String? validatorPassword(val) {
    return val!.isEmpty
        ? tr('must_add_password')
        : val.length < 8
            ? tr('password_8_digits')
            // : RegExp(r'[a-z]').hasMatch(val) == false
            // ? tr('password_lower_letter')
            // : RegExp(r'[A-Z]').hasMatch(val) == false
            // ? tr('password_upper_letter')
            // : RegExp(r'[0-9]').hasMatch(val) == false
            // ? tr('password_number_letter')
            // : RegExp(r'[!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]')
            // .hasMatch(val) ==
            // false
            // ? tr('password_special_char_letter')
            : null;
  }

  String? validatorRePassword(val, val2) {
    return val!.isEmpty
        ? tr('must_add_password')
        : val != val2
            ? tr('not_same')
            : val.length < 8
                ? tr('password_8_digits')
                // : RegExp(r'[a-z]').hasMatch(val) == false
                // ? tr('password_lower_letter')
                // : RegExp(r'[A-Z]').hasMatch(val) == false
                // ? tr('password_upper_letter')
                // : RegExp(r'[0-9]').hasMatch(val) == false
                // ? tr('password_number_letter')
                // : RegExp(r'[!@#\$%^&*()_+{}\[\]:;<>,.?~\\-]')
                // .hasMatch(val) ==
                // false
                // ? tr('password_special_char_letter')
                : null;
  }
}
