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
import '../../../../../generated/app_localizations.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.orderModel});

  final OrderModel orderModel;

  bool get _isArabic => SharedText.currentLocale == "ar";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      child: Stack(
        children: <Widget>[
          _buildTappableContent(context),
          _buildStatusBadge(),
        ],
      ),
    );
  }


  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppConstants.lightWhiteColor,
      borderRadius: BorderRadius.circular(8),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: AppConstants.shadowColor, blurRadius: 4),
      ],
    );
  }

  Widget _buildProductImage() {
    return Container(
      decoration: _cardDecoration(),
      child: CommonCachedImageWidget(
        imageUrl: orderModel.productModel.image ?? "",
        width: 88,
        height: 65,
      ),
    );
  }



  String get _formattedDate =>
      DateTime.parse(orderModel.date).formatDateTimeToShowDayName();


  Widget _buildStatusBadge() {
    return Align(
      alignment: _isArabic ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        width: getWidgetWidth(60),
        height: getWidgetHeight(24),
        decoration: _badgeDecoration(),
        child: Center(
          child: CommonTitleText(
            textKey: orderModel.status,
            textColor: AppConstants.lightWhiteColor,
            textFontSize: AppConstants.fontSize12,
            textWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  BoxDecoration _badgeDecoration() {
    return BoxDecoration(
      color: AppConstants.mainTextColor,
      borderRadius: _isArabic
          ? const BorderRadius.only(
        topLeft: Radius.circular(AppConstants.borderRadius8),
        bottomRight: Radius.circular(AppConstants.borderRadius8),
      )
          : const BorderRadius.only(
        topRight: Radius.circular(AppConstants.borderRadius8),
        bottomLeft: Radius.circular(AppConstants.borderRadius8),
      ),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: AppConstants.shadowColor, blurRadius: 4),
      ],
    );
  }

  Widget _buildTappableContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding8),
      child: InkWell(
        onTap: () => context.pushNamed(
          RouteNames.orderDetailsPageRoute,
          extra: RouteArgument(orderModel: orderModel),
        ),
        child: Row(
          children: <Widget>[
            _buildProductImage(),
            getSpaceWidth(AppConstants.padding8),
            Expanded(child: _buildOrderDetails()), // ← Expanded here
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildNameAndId(),
        getSpaceHeight(AppConstants.padding4),
        _buildIconRow(IconPath.calenderIcon, _formattedDate),
        getSpaceHeight(AppConstants.padding4),
        _buildIconRow(IconPath.locationIcon, orderModel.addressModel.name ?? "---"),
      ],
    );
  }

  Widget _buildNameAndId() {
    return Row(
      children: <Widget>[
        Flexible(
          child: CommonTitleText(
            textKey: orderModel.productModel.name ?? "---",
            textColor: AppConstants.mainTextColor,
            textFontSize: AppConstants.fontSize14,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
        CommonTitleText(
          textKey: "  #${orderModel.id}",
          textFontSize: AppConstants.fontSize12,
          textColor: AppConstants.lightGrayOffColor,
        ),
      ],
    );
  }

  Widget _buildIconRow(String iconPath, String label) {
    return Row(
      children: <Widget>[
        CommonAssetSvgImageWidget(imageString: iconPath, height: 16, width: 16),
        getSpaceWidth(AppConstants.padding8),
        Flexible(
          child: CommonTitleText(
            textKey: label,
            textColor: AppConstants.lightGrayOffColor,
            textFontSize: AppConstants.fontSize12,
            textOverflow: TextOverflow.ellipsis,
            minTextFontSize: AppConstants.fontSize12,
          ),
        ),
      ],
    );
  }
}