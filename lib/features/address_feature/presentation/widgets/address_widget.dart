import 'package:base_project_repo/core/model/address_model.dart';

import '/core/constants/app_constants.dart';
import '/core/constants/keys/icon_path.dart';
import '/core/helpers/shared.dart';
import '/core/presentation/widgets/common_asset_svg_image_widget.dart';
import '/core/presentation/widgets/common_title_text.dart';
import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  final AddressModel addressModel;

  const AddressWidget({
    super.key,
    required this.addressModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.padding8),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _buildAddressName(),
          getSpaceHeight(AppConstants.padding8),
          _buildAddressLocation(),
        ],
      ),
    );
  }


  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppConstants.lightWhiteColor,
      borderRadius: BorderRadius.circular(AppConstants.borderRadius8),
      boxShadow: const <BoxShadow>[
        BoxShadow(color: AppConstants.shadowColor, blurRadius: 4),
      ],
    );
  }


  Widget _buildAddressName() {
    return Row(
      children: [
        Flexible(
          child: CommonTitleText(
            textKey: addressModel.name ?? "---",
            textColor: AppConstants.greenColor,
            textFontSize: AppConstants.fontSize14,
            minTextFontSize: AppConstants.fontSize14,
            textOverflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }


  Widget _buildAddressLocation() {
    return Row(
      children: [
        const CommonAssetSvgImageWidget(
          imageString: IconPath.locationIcon,
          height: 16,
          width: 16,
        ),
        getSpaceWidth(AppConstants.padding4),
        Flexible(
          child: CommonTitleText(
            textKey: addressModel.location ?? "---",
            textColor: AppConstants.lightGrayOffColor,
            textFontSize: AppConstants.fontSize10,
            textOverflow: TextOverflow.ellipsis,
            minTextFontSize: AppConstants.fontSize10,
          ),
        ),
      ],
    );
  }
}