import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/helpers/extensions/format_date_time_to_time_only.dart';
import 'package:base_project_repo/core/helpers/shared.dart';
import 'package:base_project_repo/core/helpers/shared_texts.dart';
import 'package:base_project_repo/core/presentation/routes/route_argument.dart';
import 'package:base_project_repo/core/presentation/routes/route_names.dart';
import 'package:base_project_repo/core/presentation/widgets/common_asset_svg_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_cached_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/constants/app_constants.dart';

import '/features/order_feature/domain/order_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.lightWhiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppConstants.shadowColor,
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(
              AppConstants.padding8,
            ),
            child: InkWell(
              onTap: () {
                context.pushNamed(RouteNames.orderDetailsPageRoute,
                    extra: RouteArgument(orderModel: orderModel));
              },
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: AppConstants.lightWhiteColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: AppConstants.shadowColor,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: CommonCachedImageWidget(
                        imageUrl: orderModel.productModel.image ?? "",
                        width: 88,
                        height: 65),
                  ),
                  getSpaceWidth(AppConstants.padding8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CommonTitleText(
                            textKey: orderModel.productModel.name ?? "---",
                          ),
                          CommonTitleText(
                            textKey: "  #${orderModel.id}",
                            textFontSize: AppConstants.fontSize12,
                            textColor: AppConstants.lightGrayOffColor,
                          ),
                        ],
                      ),
                      getSpaceHeight(AppConstants.padding4),
                      Row(
                        children: <Widget>[
                          const CommonAssetSvgImageWidget(
                              imageString: IconPath.calenderIcon,
                              height: 16,
                              width: 16),
                          getSpaceWidth(AppConstants.padding8),
                          CommonTitleText(
                            textKey: DateTime.parse(orderModel.date)
                                .formatDateTimeToShowDayName(),
                            textColor: AppConstants.lightGrayOffColor,
                            textFontSize: AppConstants.fontSize12,
                          ),
                        ],
                      ),
                      getSpaceHeight(AppConstants.padding4),
                      Row(
                        children: <Widget>[
                          const CommonAssetSvgImageWidget(
                            imageString: IconPath.locationIcon,
                            height: 16,
                            width: 16,
                          ),
                          getSpaceWidth(AppConstants.padding8),
                          CommonTitleText(
                            textKey: orderModel.addressModel.name ?? "---",
                            textColor: AppConstants.lightGrayOffColor,
                            textFontSize: AppConstants.fontSize12,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: SharedText.currentLocale == "ar"
                ? Alignment.topLeft
                : Alignment.topRight,
            child: Container(
              width: getWidgetWidth(60),
              height: getWidgetHeight(24),
              decoration: BoxDecoration(
                color: AppConstants.mainTextColor,
                borderRadius: SharedText.currentLocale == "ar"
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(AppConstants.borderRadius8),
                        bottomRight:
                            Radius.circular(AppConstants.borderRadius8),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(AppConstants.borderRadius8),
                        bottomLeft: Radius.circular(AppConstants.borderRadius8),
                      ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: AppConstants.shadowColor,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: CommonTitleText(
                  textKey: orderModel.status,
                  textColor: AppConstants.lightWhiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
