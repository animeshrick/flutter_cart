import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/utils/validator.dart';

import '../const/assets_const.dart';
import '../const/color_const.dart';
import '../const/space_const.dart';
import '../extension/hex_color.dart';
import '../extension/logger_extension.dart';
import '../extension/spacing.dart';
import '../service/context_service.dart';
import '../service/value_handler.dart';
import '../utils/screen_utils.dart';
import '../utils/text_utils.dart';
import '../widget/custom_button.dart';
import '../widget/custom_image.dart';
import '../widget/custom_text.dart';
import '../widget/custom_text_formfield.dart';
import '../widget/custom_ui.dart';

class PopUpItems {
  void showImagePopup(
      {String? networkImageUrl,
      Uint8List? webImageBytes,
      String? pickedImagePath}) {
    showDialog(
      context: CurrentContext().context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (ValueHandler().isTextNotEmptyOrNull(networkImageUrl)) ...[
                CustomNetWorkImageView(
                  url: networkImageUrl ?? "",
                  fit: BoxFit.cover,
                )
              ],
              if (ValueHandler().isTextNotEmptyOrNull(webImageBytes) &&
                  kIsWeb) ...[
                Image.memory(
                  webImageBytes ?? Uint8List(0),
                  fit: BoxFit.cover,
                  height: ScreenUtils.ah() * 0.7,
                )
              ],
              if (ValueHandler().isTextNotEmptyOrNull(pickedImagePath) &&
                  !kIsWeb) ...[
                Image.file(
                  File(pickedImagePath ?? ""),
                  fit: BoxFit.cover,
                )
              ],
              Padding(
                padding: EdgeInsets.only(top: SpaceConst.px12),
                child: CustomGOEButton(
                    borderColor: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: CustomTextEnum(TextUtils.close, color: Colors.red)
                        .textMediumSM()),
              ),
              10.ph,
            ],
          ),
        );
      },
    );
  }

  Future<void> cupertinoPopup({
    String? title,
    required void Function()? cancelBtnPresses,
    required void Function()? okBtnPressed,
    String? content,
    String? cancelBtnText,
    String? okBtnText,
  }) async {
    String? result = await showCupertinoDialog<String>(
      context: CurrentContext().context,
      barrierDismissible: true,
      builder: (BuildContext context) => CupertinoTheme(
        data: const CupertinoThemeData(brightness: Brightness.light),
        child: CupertinoAlertDialog(
          title: title != null
              ? CustomText(title, color: Colors.black, size: 14)
              : null,
          content: content != null
              ? CustomText(content, color: Colors.black, size: 14)
              : null,
          actions: <Widget>[
            if (cancelBtnPresses != null)
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: CustomText(cancelBtnText ?? "Cancel",
                    color: Colors.black, size: 14),
              ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context, "Yes");
              },
              child:
                  CustomText(okBtnText ?? "Ok", color: Colors.black, size: 14),
            ),
          ],
        ),
      ),
    );
    if (result == "Yes") {
      if (okBtnPressed != null) {
        okBtnPressed();
      }
    } else {
      if (cancelBtnPresses != null) {
        cancelBtnPresses();
      }
    }
  }

  Future<void> customMsgDialog(
      {String? title, String? content, DialogType? type}) async {
    IconData? icon;
    Color? iconButtonColor;
    if (type != null) {
      switch (type) {
        case DialogType.success:
          icon = Icons.check_circle;
          iconButtonColor = Colors.green;
          break;
        case DialogType.error:
          icon = Icons.error;
          iconButtonColor = Colors.red;
          break;
        case DialogType.warning:
          icon = Icons.warning;
          iconButtonColor = Colors.amber;
          break;
        case DialogType.info:
          icon = Icons.info;
          iconButtonColor = Colors.blue;
          break;
      }
    }

    await showDialog<String>(
      context: CurrentContext().context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: title != null
            ? CustomText(
                title,
                color: HexColor.fromHex(ColorConst.primaryDark),
                size: 16,
              )
            : null,
        content: content != null || icon != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Icon(icon, color: iconButtonColor, size: 60.0),
                  if (content != null && icon != null) 12.ph,
                  if (content != null)
                    ValueHandler().isHtml(content)
                        ? CustomHtmlText(content,
                            color: HexColor.fromHex(ColorConst.primaryDark),
                            size: 14)
                        : CustomText(content,
                            color: HexColor.fromHex(ColorConst.primaryDark),
                            size: 14,
                            textAlign: TextAlign.start),
                ],
              )
            : null,
        actions: <Widget>[
          CustomGOEButton(
            size: const Size(72, 36),
            radius: 8,
            backGroundColor: iconButtonColor ?? Colors.blueAccent,
            onPressed: () {
              Navigator.pop(context);
            },
            child: CustomText(TextUtils.ok, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }

  void toastMessage(String message, Color color, {int? durationSeconds}) {
    SnackBar snackBar = SnackBar(
      duration: Duration(seconds: durationSeconds ?? 2),
      content: ToastMassage(
        message: message,
        color: color,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(CurrentContext().context).showSnackBar(snackBar);
  }

  Future<DateTime?> buildMaterialDatePicker(
      {DateTime? initDate, DateTime? startDate, DateTime? endDate}) async {
    final DateTime? picked = await showDatePicker(
      context: CurrentContext().context,
      initialDate: initDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime(1900),
      lastDate: endDate ?? DateTime(DateTime.now().year + 20),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    AppLog.i('buildMaterialDatePicker $picked');
    return picked;
  }

  Future<String?> emailPicker() {
    return Navigator.of(CurrentContext().context).push(
      PageRouteBuilder(
          opaque: false, pageBuilder: (_, __, ___) => const EmailPicker()),
    );
  }

  void prescriptionUploadGideLine() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.white,
      context: CurrentContext().context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0), // Top border radius
        ),
      ),
      builder: (BuildContext context) {
        return CustomContainer(
          padding: EdgeInsets.only(
              top: 16,
              bottom: (!kIsWeb && Platform.isIOS)
                  ? ScreenUtils.paddingBottom()
                  : 16),
          width: ScreenUtils.nw(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextEnum(
                      "What is a valid Prescription?",
                      color: HexColor.fromHex(ColorConst.primaryDark),
                    ).textSemiboldMD(),
                    CustomIconButton(
                        padding: EdgeInsets.zero,
                        color: HexColor.fromHex(ColorConst.gray600),
                        icon: const Icon(CupertinoIcons.clear_circled),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
              16.ph,
              CustomContainer(
                width: double.infinity,
                color: const Color(0xFFFFF9EB),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: CustomTextEnum(
                  'A valid prescription must contain below details',
                  textAlign: TextAlign.center,
                  color: HexColor.fromHex(ColorConst.gray600),
                ).textMediumXS(),
              ),
              12.ph,
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    String image = index == 0
                        ? AssetsConst.docDetails
                        : index == 1
                            ? AssetsConst.patientDetails
                            : index == 2
                                ? AssetsConst.signStamp
                                : AssetsConst.medicineDetails;

                    String title = index == 0
                        ? "Doctor Details"
                        : index == 1
                            ? "Patient Details"
                            : index == 2
                                ? "Doctor’s Signature & Stamp"
                                : "Dosage Details";

                    String subtitle = index == 0
                        ? "Should contain Doctor’s Name, Clinic or Hospital Name and Registration No."
                        : index == 1
                            ? "Patient’s Name, Age and Date of Consultation should be available on the prescription"
                            : index == 2
                                ? "Doctor’s signature and stamp should be clearly visible on the prescription"
                                : "Medicine Name, Strength, Duration etc. should be mentioned on the prescription";

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          CustomContainer(
                            borderRadius: BorderRadius.circular(4),
                            borderColor: HexColor.fromHex(ColorConst.lineGrey),
                            padding: const EdgeInsets.all(18),
                            child: CustomAssetImageView(
                                path: image, height: 36, width: 36),
                          ),
                          8.pw,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextEnum(title,
                                        color: HexColor.fromHex(
                                            ColorConst.primaryDark))
                                    .textMediumSM(),
                                CustomTextEnum(subtitle,
                                        color: HexColor.fromHex(
                                            ColorConst.primaryDark))
                                    .textXS(),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                        color: HexColor.fromHex(ColorConst.lineGrey));
                  },
                ),
              ),
              16.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomGOEButton(
                  size: Size(ScreenUtils.nw(), 46),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  radius: 6,
                  backGroundColor: HexColor.fromHex(ColorConst.brand600),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: CustomTextEnum(
                    "Understood",
                    color: Colors.white,
                    // size: 14,
                  ).textSemiboldSM(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

// Enum for dialog types
enum DialogType { success, error, warning, info }

//ignore: must_be_immutable
class ToastMassage extends StatelessWidget {
  ToastMassage({super.key, required this.message, required this.color});

  String message;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        shadowColor: Colors.grey,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child:
                CustomTextEnum(message, color: Colors.white).textSemiboldMD(),
          ),
        ));
  }
}

class EmailPicker extends StatefulWidget {
  const EmailPicker({super.key});

  @override
  State<EmailPicker> createState() => _EmailPickerState();
}

class _EmailPickerState extends State<EmailPicker> {
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          HexColor.fromHex(ColorConst.primaryDark).withOpacity(0.26),
      body: Form(
        key: key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: HexColor.fromHex(ColorConst.baseHexColor),
                    blurRadius: 7,
                    spreadRadius: 3,
                  )
                ],
              ),
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      child: CustomTextFormField(
                          title: TextUtils.email,
                          hintText: TextUtils.enter_email,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validator().emailValidator)),
                  10.ph,
                  CustomElevatedButton(
                      minimumSize: const Size(80, 35),
                      radius: 10,
                      color: Colors.blueAccent,
                      child: CustomText(TextUtils.ok,
                          color: Colors.white, size: 20),
                      onPressed: () {
                        if (key.currentState?.validate() == true) {
                          Navigator.pop(context, emailController.text.trim());
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
