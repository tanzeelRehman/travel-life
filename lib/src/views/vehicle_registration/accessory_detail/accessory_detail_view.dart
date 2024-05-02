import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/accessory.dart';
import 'package:starter_app/src/models/accessory_category.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_confirmation_dialog.dart';
import 'package:starter_app/src/shared/custom_datepicker_dialog.dart';
import 'package:starter_app/src/shared/full_screen_loading_indicator.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/vehicle_registration_field.dart';
import 'package:starter_app/src/shared/vehicle_registration_select_widget.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/bottomsheets/vehicle_bottomsheet/vehicle_bottomsheet_view.dart';
import 'package:starter_app/src/views/dialogs/accessory_category_dialog/accessory_category_dialog_view.dart';
import 'package:starter_app/src/views/vehicle_registration/accessory_detail/accessory_detail_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AccessoryDetailView extends StackedView<AccessoryDetailViewModel> {
  final VehicleRegistrationAction action;
  final Accessory? accessory;
  final Vehicle? vehicle;

  AccessoryDetailView({
    required this.action,
    this.accessory,
    this.vehicle,
  });

  @override
  Widget builder(
    BuildContext context,
    AccessoryDetailViewModel model,
    Widget? child,
  ) {
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 27.w,
              vertical: 10.h,
            ),
            child: MainButton(
              buttonText: action == VehicleRegistrationAction.edit
                  ? 'Save'
                  : 'Add Accessory',
              onPressed: model.updateOrInsertAccesssory,
              isLoading: model.isBusy,
              gradient: model.isAttachmentsLimitExceeded()
                  ? AppColors.secondaryButtonGradient
                  : AppColors.mainButtonGradient,
            ),
          ),
          body: Container(
            width: context.screenSize().width,
            height: context.screenSize().height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(
                  AssetImages.vehicleRegistrationBg,
                  height: context.screenSize().height,
                  width: context.screenSize().width,
                ).image,
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomAppBar(
                  titleText: 'Accessorry Details',
                ),
                VerticalSpacing(10.h),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 27.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 260.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              25.r,
                            ),
                            color: AppColors.white.withOpacity(0.1),
                            image: action == VehicleRegistrationAction.edit
                                ? accessory?.accessoryImageAttachment != null &&
                                        model.selectedImage == null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          accessory!.accessoryImageAttachment!,
                                        ),
                                        fit: BoxFit.cover,
                                        opacity: 0.5,
                                      )
                                    : model.selectedImage != null
                                        ? DecorationImage(
                                            image:
                                                Image.file(model.selectedImage!)
                                                    .image,
                                            fit: BoxFit.cover,
                                            opacity: 0.5,
                                          )
                                        : null
                                : model.selectedImage != null
                                    ? DecorationImage(
                                        image: Image.file(model.selectedImage!)
                                            .image,
                                        fit: BoxFit.cover,
                                        opacity: 0.5,
                                      )
                                    : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  model.onClickAddImage();
                                },
                                child: Container(
                                  height: 60.sp,
                                  width: 60.sp,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.mainButtonGradient,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                    size: 40.sp,
                                  ),
                                ),
                              ),
                              VerticalSpacing(10.h),
                              Text(
                                'Add Image',
                                style: TextStyling.regular.copyWith(
                                  fontSize: 12.sp,
                                ),
                              )
                            ],
                          ),
                        ),
                        VerticalSpacing(25.h),
                        VehicleRegistrationField(
                          svgIconPath: AssetIcons.tfCategory,
                          labelText: 'Category',
                          child: VehicleRegistrationSelectWidget(
                            hintText: 'Category',
                            isLoading: model.isCategoriesLoading,
                            onTap: () async {
                              final AccessoryCategory? v = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AccessoryCategoryDialogView(
                                      // initialAccessoryCategory: model.category,
                                      initialSelectedCategory: model.category,
                                    );
                                  });

                              print(v?.name);
                              model.onChangeCategory(v);
                            },
                            value: model.category?.name,
                          ),
                        ),
                        VerticalSpacing(20.h),
                        VehicleRegistrationField(
                          svgIconPath: AssetIcons.tfModel,
                          labelText: 'Vehicle',
                          child: VehicleRegistrationSelectWidget(
                            hintText: 'Vehicle',
                            isLoading: false,
                            onTap: action == VehicleRegistrationAction.edit
                                ? () async {
                                    final Vehicle? v =
                                        await showModalBottomSheet(
                                      constraints: BoxConstraints(
                                        minHeight:
                                            context.screenSize().height * 0.8,
                                      ),
                                      context: context,
                                      builder: (context) =>
                                          VehicleBottomSheetView(),
                                    );
                                    print(v?.model?.model);
                                    model.onChangeVehicle(v);
                                  }
                                : () {},
                            value: model.selectedVehicle?.model?.model,
                          ),
                        ),
                        VerticalSpacing(20.h),
                        VehicleRegistrationTextField(
                          svgIconPath: AssetIcons.tfDescription,
                          labelText: 'Description',
                          multiline: true,
                          controller: model.descriptionController,
                        ),
                        VerticalSpacing(20.h),
                        VehicleRegistrationField(
                          svgIconPath: AssetIcons.tfDate,
                          labelText: 'Purchase Date',
                          child: VehicleRegistrationSelectWidget(
                            hintText: 'Purchase Date',
                            isLoading: false,
                            showDropdownIcon: false,
                            onTap: () async {
                              final v = await showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDatePickerDialog();
                                },
                              );
                              model.onChangePurchaseDate(v);
                            },
                            value: model.purchaseDate != null
                                ? DateFormat('dd/MM/yyyy')
                                    .format(model.purchaseDate!)
                                : null,
                          ),
                        ),
                        VerticalSpacing(20.h),
                        VehicleRegistrationTextField(
                          svgIconPath: AssetIcons.tfPrice,
                          labelText: 'Purchas Price',
                          controller: model.purchasePriceController,
                          onchangeAction: (p0) {
                            model.calculateTax(model.vatController.text);
                          },
                          inputType: TextInputType.number,
                          textInputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,5}'),
                            )
                          ],
                        ),
                        VerticalSpacing(20.h),
                        VehicleRegistrationTextField(
                          svgIconPath: AssetIcons.tfVat,
                          labelText: 'TAX/VAT',
                          controller: model.vatController,
                          onchangeAction: (p0) {
                            model.calculateTax(p0);
                          },
                          inputType: TextInputType.number,
                          textInputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,5}'),
                            )
                          ],
                          readOnly: true,
                        ),
                        VerticalSpacing(20.h),
                        VehicleRegistrationTextField(
                          svgIconPath: AssetIcons.tfPriceHand,
                          labelText: 'Total Price',
                          controller: model.priceController,
                          inputType: TextInputType.number,
                          textInputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,5}'),
                            )
                          ],
                          readOnly: true,
                        ),
                        VerticalSpacing(20.h),
                        VehicleRegistrationField(
                          svgIconPath: AssetIcons.tfAttachment,
                          labelText: 'Add Attachment',
                          child: Container(
                            // height: 150.h,
                            width: double.infinity,
                            padding: EdgeInsets.all(10.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (model.editAccessory?.attachments != null &&
                                    model.editAccessory!.attachments!
                                        .isNotEmpty) ...[
                                  Column(
                                    children: List.generate(
                                        model.editAccessory?.attachments
                                                ?.length ??
                                            0, (index) {
                                      final attachment = model
                                          .editAccessory!.attachments![index];

                                      final attachementUrl = model
                                          .databaseService
                                          .getAccessoryAttachmentUrl(
                                              attachment);
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 20.h),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  final isPdf =
                                                      await UtilFunctions.isPDF(
                                                          attachementUrl);

                                                  print(isPdf);

                                                  if (isPdf) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AttachmentViewer(
                                                          attachmentUrl:
                                                              'https://docs.google.com/viewer?url=' +
                                                                  attachementUrl,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AttachmentViewer(
                                                          attachmentUrl:
                                                              attachementUrl,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    border: Border.all(
                                                      color:
                                                          AppColors.appSkyBlue,
                                                    ),
                                                    color: AppColors.white
                                                        .withOpacity(0.2),
                                                  ),
                                                  padding: EdgeInsets.all(3.h),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          attachementUrl,
                                                          style: TextStyling
                                                              .medium
                                                              .copyWith(
                                                            color: AppColors
                                                                .appSkyBlue,
                                                            fontSize: 12.sp,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      HorizontalSpacing(5.w),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient: AppColors
                                                              .mainButtonGradient,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.r),
                                                        ),
                                                        height: 20.w,
                                                        width: 20.w,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            color:
                                                                AppColors.white,
                                                            size: 15.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            HorizontalSpacing(8.w),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return CustomConfirmationDialog(
                                                      title:
                                                          'Delete Attachment',
                                                      description:
                                                          'Are you sure you want to delete the attachment?',
                                                      onClickYes: () {
                                                        model
                                                            .onClickRemoveAttachment(
                                                                index);
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                height: 25.w,
                                                width: 22.w,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: AppColors.white,
                                                    size: 15.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  )
                                ],
                                if (model.localAttachments != null) ...[
                                  Column(
                                    children: List.generate(
                                      model.localAttachments?.length ?? 0,
                                      (index) {
                                        final localFile =
                                            model.localAttachments![index];

                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            border: Border.all(
                                              color: AppColors.appSkyBlue,
                                            ),
                                            color: AppColors.white
                                                .withOpacity(0.2),
                                          ),
                                          margin: EdgeInsets.only(bottom: 20.h),
                                          padding: EdgeInsets.all(3.h),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  localFile.path
                                                      .split('/')
                                                      .last,
                                                  style: TextStyling.medium
                                                      .copyWith(
                                                    color: AppColors.appSkyBlue,
                                                    fontSize: 12.sp,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              HorizontalSpacing(5.w),
                                              GestureDetector(
                                                onTap: () {
                                                  model
                                                      .onClickRemoveAttachmentFromLocalAttachment(
                                                          index);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: AppColors
                                                        .logoutButtonGradient,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                  ),
                                                  height: 20.w,
                                                  width: 20.w,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.close,
                                                      color: AppColors.red,
                                                      size: 15.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                                if ((model.localAttachments == null ||
                                        model.localAttachments!.isEmpty) &&
                                    (model.editAccessory?.attachments == null ||
                                        model.editAccessory!.attachments!
                                            .isEmpty)) ...[
                                  Icon(
                                    Icons.file_copy,
                                    color: AppColors.appSkyBlue,
                                  ),
                                  VerticalSpacing(10.h),
                                  Text(
                                    'Upload attachments here',
                                    style: TextStyling.regular.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  VerticalSpacing(2.h),
                                  Text(
                                    'you can add upto ${model.maxFilesAllowed} attachments',
                                    style: TextStyling.regular.copyWith(
                                      fontSize: 10.sp,
                                      color:
                                          AppColors.appSkyBlue.withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  VerticalSpacing(10.h),
                                ],
                                MainButton(
                                  buttonText: 'Browse Files',
                                  onPressed: () {
                                    model.onClickAddAttachments();
                                  },
                                  isLoading: false,
                                  height: 30.sp,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  fullWidth: false,
                                  fontSize: 14.sp,
                                  gradient: model.isAttachmentsLimitReached()
                                      ? AppColors.secondaryButtonGradient
                                      : AppColors.mainButtonGradient,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (model.isRemoveAttachmentLoading) FullScreenLoadingIndicator(),
      ],
    );
  }

  @override
  AccessoryDetailViewModel viewModelBuilder(BuildContext context) =>
      AccessoryDetailViewModel();

  @override
  void onViewModelReady(AccessoryDetailViewModel model) =>
      model.init(action, accessory, vehicle);
}

class AttachmentViewer extends StatefulWidget {
  final String? attachmentUrl;

  AttachmentViewer({this.attachmentUrl});

  @override
  State<AttachmentViewer> createState() => _AttachmentViewerState();
}

class _AttachmentViewerState extends State<AttachmentViewer> {
  late final WebViewController _controller;

  @override
  void initState() {
    if (widget.attachmentUrl != null) {
      _controller = WebViewController()
        ..loadRequest(
          Uri.parse(widget.attachmentUrl!),
        );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.attachmentUrl == null) {
      return Center(
        child: Text('No attachment available'),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            titleText: 'Accessory Attachment',
          ),
          Expanded(
            child: WebViewWidget(
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}