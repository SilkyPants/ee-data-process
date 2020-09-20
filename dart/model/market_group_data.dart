// To parse this JSON data, do
//
//     final marketGroupData = marketGroupDataFromJson(jsonString);

import 'dart:convert';

MarketGroupData marketGroupDataFromJson(String str) =>
    MarketGroupData.fromJson(json.decode(str));

String marketGroupDataToJson(MarketGroupData data) =>
    json.encode(data.toJson());

class MarketGroupData {
  MarketGroupData({
    this.marketGroupId,
  });

  Map<String, MarketGroupId> marketGroupId;

  factory MarketGroupData.fromJson(Map<String, dynamic> json) =>
      MarketGroupData(
        marketGroupId: Map.from(json["market_group_id"]).map((k, v) =>
            MapEntry<String, MarketGroupId>(k, MarketGroupId.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "market_group_id": Map.from(marketGroupId)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class MarketGroupId {
  MarketGroupId({
    this.marketGroupName1St,
    this.marketGroupName3Rd,
    this.marketGroupIcon2Nd,
    this.marketGroupId1St,
    this.marketGroupIcon1St,
    this.marketGroupId2Nd,
    this.hasTypes3Rd,
    this.marketGroupName2Nd,
  });

  String marketGroupName1St;
  String marketGroupName3Rd;
  int marketGroupIcon2Nd;
  int marketGroupId1St;
  String marketGroupIcon1St;
  int marketGroupId2Nd;
  bool hasTypes3Rd;
  String marketGroupName2Nd;

  factory MarketGroupId.fromJson(Map<String, dynamic> json) => MarketGroupId(
        marketGroupName1St: json["market_group_name_1st"],
        marketGroupName3Rd: json["market_group_name_3rd"],
        marketGroupIcon2Nd: json["market_group_icon_2nd"],
        marketGroupId1St: json["market_group_ID_1st"],
        marketGroupIcon1St: json["market_group_icon_1st"],
        marketGroupId2Nd: json["market_group_ID_2nd"],
        hasTypes3Rd: json["has_types_3rd"] == 1 ?? false,
        marketGroupName2Nd: json["market_group_name_2nd"],
      );

  Map<String, dynamic> toJson() => {
        "market_group_name_1st": marketGroupName1St,
        "market_group_name_3rd": marketGroupName3Rd,
        "market_group_icon_2nd": marketGroupIcon2Nd,
        "market_group_ID_1st": marketGroupId1St,
        "market_group_icon_1st": marketGroupIcon1St,
        "market_group_ID_2nd": marketGroupId2Nd,
        "has_types_3rd": hasTypes3Rd,
        "market_group_name_2nd": marketGroupName2Nd,
      };
}
