import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/generated/assets.dart';
import 'package:starter_app/src/base/enums/vehicle_registration_action.dart';
import 'package:starter_app/src/base/utils/utils.dart';
import 'package:starter_app/src/models/cost_category.dart';
import 'package:starter_app/src/models/operating_cost.dart';
import 'package:starter_app/src/models/vehicle.dart';
import 'package:starter_app/src/shared/custom_app_bar.dart';
import 'package:starter_app/src/shared/custom_datepicker_dialog.dart';
import 'package:starter_app/src/shared/main_button.dart';
import 'package:starter_app/src/shared/spacing.dart';
import 'package:starter_app/src/shared/vehicle_registration_field.dart';
import 'package:starter_app/src/shared/vehicle_registration_select_widget.dart';
import 'package:starter_app/src/shared/vehicle_registration_textfield.dart';
import 'package:starter_app/src/styles/app_colors.dart';
import 'package:starter_app/src/styles/text_theme.dart';
import 'package:starter_app/src/views/bottomsheets/vehicle_bottomsheet/vehicle_bottomsheet_view.dart';
import 'package:starter_app/src/views/dialogs/cost_category_dialog/cost_category_dialog_view.dart';
import 'package:starter_app/src/views/vehicle_registration/operational_cost_detail/operational_cost_detail_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OperationalCostDetailView
    extends StackedView<OperationalCostDetailViewModel> {
  final VehicleRegistrationAction action;
  final OperatingCost? operatingCost;

  OperationalCostDetailView({required this.action, this.operatingCost});

  @override
  Widget builder(
    BuildContext context,
    OperationalCostDetailViewModel model,
    Widget? child,
  ) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 27.w,
          vertical: 10.h,
        ),
        child: MainButton(
          buttonText:
              action == VehicleRegistrationAction.edit ? 'Save' : 'Add Cost',
          onPressed: model.updateOrInsertAccesssory,
          isLoading: model.isBusy,
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
              titleText: 'Cost Details',
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
                    VehicleRegistrationField(
                      svgIconPath: AssetIcons.tfAttachment,
                      labelText: 'Add Attachment',
                      child: Container(
                        // height: 150.h,
                        width: double.infinity,
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (operatingCost?.attachment != null &&
                                model.attachment == null) ...[
                              GestureDetector(
                                onTap: () async {
                                  final isPdf = await UtilFunctions.isPDF(
                                      operatingCost!.attachment!);

                                  print(isPdf);

                                  if (isPdf) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AttachmentViewer(
                                          attachmentUrl:
                                              'https://docs.google.com/viewer?url=' +
                                                  operatingCost!.attachment!,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AttachmentViewer(
                                          attachmentUrl:
                                              operatingCost!.attachment!,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(
                                      color: AppColors.appSkyBlue,
                                    ),
                                    color: AppColors.white.withOpacity(0.2),
                                  ),
                                  padding: EdgeInsets.all(3.h),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          operatingCost?.attachment ?? '',
                                          style: TextStyling.medium.copyWith(
                                            color: AppColors.appSkyBlue,
                                            fontSize: 12.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      HorizontalSpacing(5.w),
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient:
                                              AppColors.mainButtonGradient,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        height: 20.w,
                                        width: 20.w,
                                        child: Center(
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            color: AppColors.white,
                                            size: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              VerticalSpacing(20.h),
                            ],
                            if (model.attachment != null) ...[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  border: Border.all(
                                    color: AppColors.appSkyBlue,
                                  ),
                                  color: AppColors.white.withOpacity(0.2),
                                ),
                                padding: EdgeInsets.all(3.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        model.attachment!.path.split('/').last,
                                        style: TextStyling.medium.copyWith(
                                          color: AppColors.appSkyBlue,
                                          fontSize: 12.sp,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    HorizontalSpacing(5.w),
                                    GestureDetector(
                                      onTap: model.onClickRemoveAttachment,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient:
                                              AppColors.logoutButtonGradient,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        height: 20.w,
                                        width: 20.w,
                                        child: Center(
                                          // child: SvgPicture.asset(
                                          //   AssetIcons.rem,
                                          // ),
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
                              ),
                              VerticalSpacing(20.h),
                            ],
                            if (model.attachment == null) ...[
                              Icon(
                                Icons.file_copy,
                                color: AppColors.appSkyBlue,
                              ),
                              VerticalSpacing(10.h),
                              Text(
                                'Upload an attachment here',
                                style: TextStyling.regular.copyWith(
                                  fontSize: 12.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              VerticalSpacing(10.h),
                            ],
                            MainButton(
                              buttonText: 'Browse File',
                              onPressed: () {
                                //TODO: open file picker with restriction options
                                model.onClickAddAttachment();
                              },
                              isLoading: false,
                              height: 30.sp,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              fullWidth: false,
                              fontSize: 14.sp,
                            )
                          ],
                        ),
                      ),
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationField(
                      svgIconPath: AssetIcons.tfCategory,
                      labelText: 'Category',
                      child: VehicleRegistrationSelectWidget(
                        hintText: 'Category',
                        isLoading: model.isCategoriesLoading,
                        onTap: () async {
                          final CostCategory? v = await showDialog(
                              context: context,
                              builder: (context) {
                                return CostCategoryDialogView(
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
                        onTap: () async {
                          final Vehicle? v = await showModalBottomSheet(
                            constraints: BoxConstraints(
                              minHeight: context.screenSize().height * 0.8,
                            ),
                            context: context,
                            builder: (context) => VehicleBottomSheetView(),
                          );
                          print(v?.model?.model);
                          model.onChangeVehicle(v);
                        },
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
                      labelText: 'Purchase Price',
                      controller: model.purchasePriceController,
                      onchangeAction: (p0) {
                        model.calculateTotalPrice(p0);
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
                    ),
                    VerticalSpacing(20.h),
                    VehicleRegistrationTextField(
                      svgIconPath: AssetIcons.tfPriceHand,
                      labelText: 'Price',
                      controller: model.priceController,
                      inputType: TextInputType.number,
                      textInputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,5}'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  OperationalCostDetailViewModel viewModelBuilder(BuildContext context) =>
      OperationalCostDetailViewModel();

  @override
  void onViewModelReady(OperationalCostDetailViewModel model) =>
      model.init(action, operatingCost);
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
            titleText: 'Operational Cost Attachment',
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
