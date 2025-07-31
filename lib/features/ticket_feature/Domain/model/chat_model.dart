import 'package:flutter/foundation.dart';

import '/core/constants/enums/exception_enums.dart';
import '/core/constants/enums/massage_type.dart';
import '/core/error_handling/custom_exception.dart';
import '/core/helpers/extensions/format_date_time_to_time_only.dart';

List<ChatMassageModel> chatMassageListFromJson(List<dynamic> str) =>
    List<ChatMassageModel>.from(
      str.map(
        (dynamic x) => ChatMassageModel.fromJson(x),
      ),
    );

class ChatMassageModel {
  ChatMassageModel({
    this.receiverId,
    this.massageContent,
    this.massageType,
    this.isLocal,
    this.attachment,
    this.massageId,
    this.senderID,
    this.isSeen = false,
    this.dateOfCreation,
  });

  factory ChatMassageModel.fromJson(Map<String, dynamic> json) {
    try {
      debugPrint("here is message content$json");
      String? getMassageTypeFromBody(String body) {
        if (body == "") {
          return null;
        }
        if (body.contains("https://maps.google.com/")) {
          return "location";
        }
        return null;
      }

      return ChatMassageModel(
          massageId: json["id"],
          receiverId: json["to_id"],
          senderID: json["from_id"],
          massageContent: json["body"],
          attachment: json["attachment"] ?? "",
          massageType: MassageType.values.byName(
            getMassageTypeFromBody(json["body"]) ??
                json["attachment_type"] ??
                "text",
          ),
          isSeen: json["seen"] == 1,
          isLocal: false,
          dateOfCreation:
              DateTime.parse(json["created_at"]).formatDateTimeToChat());
    } catch (e) {
      throw CustomException(
        CustomStatusCodeErrorType.parsing,
      );
    }
  }

  int? receiverId;
  int? senderID;
  int? massageId;
  String? massageContent;
  String? attachment;
  MassageType? massageType;
  bool? isLocal;
  bool? isSeen;
  String? dateOfCreation;

  @override
  String toString() {
    return ''' chat massage -> massageId $massageId, receiverId $receiverId
     senderID $senderID, massageContent $massageContent''';
  }
}
