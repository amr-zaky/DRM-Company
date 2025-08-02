import 'package:base_project_repo/core/constants/keys/icon_path.dart';
import 'package:base_project_repo/core/helpers/extensions/format_date_time_to_time_only.dart';
import 'package:base_project_repo/core/helpers/shared.dart';
import 'package:base_project_repo/core/presentation/routes/route_argument.dart';
import 'package:base_project_repo/core/presentation/routes/route_names.dart';
import 'package:base_project_repo/core/presentation/widgets/common_asset_svg_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_cached_image_widget.dart';
import 'package:base_project_repo/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/core/constants/app_constants.dart';

import '/features/order_feature/domain/order_model.dart';

class OfferItem extends StatelessWidget {
  const OfferItem({super.key, required this.offerModel});

  final OrderModel offerModel;

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
      child: Padding(
        padding: const EdgeInsets.all(
          AppConstants.padding8,
        ),
        child: InkWell(
          onTap: () {
            context.pushNamed(RouteNames.offerDetailsPageRoute,
                extra: RouteArgument(orderModel: offerModel));
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
                    imageUrl: offerModel.productModel.image ?? "",
                    width: 88,
                    height: 65),
              ),
              getSpaceWidth(AppConstants.padding8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CommonTitleText(
                          textKey: offerModel.productModel.name ?? "---",
                        ),
                        CommonTitleText(
                          textKey: "  #${offerModel.id}",
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
                          textKey: DateTime.parse(offerModel.date)
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
                          imageString: IconPath.locationPinIcon,
                          height: 16,
                          width: 16,
                        ),
                        getSpaceWidth(AppConstants.padding8),
                        Expanded(
                          child: CommonTitleText(
                            textKey: offerModel.addressModel.name ?? "---",
                            textColor: AppConstants.lightGrayOffColor,
                            textFontSize: AppConstants.fontSize12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
