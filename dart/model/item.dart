import 'dart:convert';

import 'msg_index.dart';

List<Item> itemsFromMap(String str) =>
    List<Item>.from(json.decode(str).map((x) => Item.fromMap(x)));

String itemsToMap(List<Item> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  Item({
    this.basePrice,
    this.canBeJettisoned,
    this.capacity,
    this.descSpecial,
    this.factionId,
    this.iconId,
    this.isOmega,
    this.mainCalCode,
    this.mass,
    this.onlineCalCode,
    this.prefabId,
    this.radius,
    this.soundId,
    this.volume,
    this.sourceDesc,
    this.sourceName,
    this.nameKey,
    this.descKey,
    this.id,
    this.dropRate,
    this.marketGroupId,
    this.activeCalCode,
    this.graphicId,
    this.raceId,
    this.sofFactionName,
    this.lockSkin,
    this.npcCalCodes,
    this.lockWreck,
    this.product,
    this.skinId,
    this.corporationId,
    this.portraitPath,
    this.cloneLv,
    this.effectGroup,
    this.exp,
    this.initLv,
    this.published,
    this.techLv,
    this.preSkill,
    this.corpCamera,
    this.wreckId,
    this.museumCredit,
    this.museumPosition1,
    this.museumPosition2,
    this.wikiId,
    this.bigIconPath,
    this.boxDropId,
    this.funParam,
    this.isObtainable,
    this.medalSourceText,
    this.abilityList,
    this.baseDropRate,
    this.normalDebris,
    this.shipBonusCodeList,
    this.shipBonusSkillList,
    this.isRookieInsurance,
  });

  final int basePrice;
  final bool canBeJettisoned;
  final int capacity;
  final List<int> descSpecial;
  final int factionId;
  final int iconId;
  final int isOmega;
  final String mainCalCode;
  final double mass;
  final String onlineCalCode;
  final int prefabId;
  final int radius;
  final int soundId;
  final double volume;
  final String sourceDesc;
  final String sourceName;
  final int nameKey;
  final int descKey;
  final int id;
  final double dropRate;
  final int marketGroupId;
  final String activeCalCode;
  final int graphicId;
  final int raceId;
  final String sofFactionName;
  final List<LockSkin> lockSkin;
  final List<NpcCalCode> npcCalCodes;
  final int lockWreck;
  final int product;
  final int skinId;
  final int corporationId;
  final String portraitPath;
  final int cloneLv;
  final String effectGroup;
  final double exp;
  final int initLv;
  final int published;
  final int techLv;
  final List<String> preSkill;
  final List<double> corpCamera;
  final int wreckId;
  final int museumCredit;
  final int museumPosition1;
  final int museumPosition2;
  final String wikiId;
  final String bigIconPath;
  final int boxDropId;
  final String funParam;
  final int isObtainable;
  final int medalSourceText;
  final List<int> abilityList;
  final double baseDropRate;
  final List<int> normalDebris;
  final List<String> shipBonusCodeList;
  final List<int> shipBonusSkillList;
  final int isRookieInsurance;

  factory Item.fromMap(Map<String, dynamic> json) {
    var nameLocaleDetails = MsgIndex.lookupLocalisation(json["zh_name"] ?? '0');
    var name = json["sourceName"] ?? nameLocaleDetails.sourceName;
    var descLocaleDetails = MsgIndex.lookupLocalisation(json["zh_desc"] ?? '0');
    var desc = json["sourceName"] ?? descLocaleDetails.sourceName;
    return Item(
      basePrice: json["base_price"] == null ? null : json["base_price"],
      canBeJettisoned:
          json["can_be_jettisoned"] == null ? null : json["can_be_jettisoned"],
      capacity: json["capacity"] == null ? null : json["capacity"],
      descSpecial: json["desc_special"] == null
          ? null
          : List<int>.from(json["desc_special"].map((x) => x)),
      factionId: json["faction_id"] == null ? null : json["faction_id"],
      iconId: json["icon_id"] == null ? null : json["icon_id"],
      isOmega: json["is_omega"] == null ? null : json["is_omega"],
      mainCalCode: json["main_cal_code"] == null ? null : json["main_cal_code"],
      mass: json["mass"] == null ? null : json["mass"].toDouble(),
      onlineCalCode:
          json["online_cal_code"] == null ? null : json["online_cal_code"],
      prefabId: json["prefab_id"] == null ? null : json["prefab_id"],
      radius: json["radius"] == null ? null : json["radius"],
      soundId: json["sound_id"] == null ? null : json["sound_id"],
      volume: json["volume"] == null ? null : json["volume"].toDouble(),
      sourceDesc: desc,
      sourceName: name,
      nameKey: json["name_key"] ?? descLocaleDetails.localisationIndex,
      descKey: json["desc_key"] ?? descLocaleDetails.localisationIndex,
      id: json["id"] == null ? null : json["id"],
      dropRate: json["drop_rate"] == null ? null : json["drop_rate"],
      marketGroupId:
          json["market_group_id"] == null ? null : json["market_group_id"],
      activeCalCode:
          json["active_cal_code"] == null ? null : json["active_cal_code"],
      graphicId: json["graphic_id"] == null ? null : json["graphic_id"],
      raceId: json["race_id"] == null ? null : json["race_id"],
      sofFactionName:
          json["sof_faction_name"] == null ? null : json["sof_faction_name"],
      lockSkin: json["lock_skin"] == null
          ? null
          : List<LockSkin>.from(
              json["lock_skin"].map((x) => lockSkinValues.map[x])),
      npcCalCodes: json["npc_cal_codes"] == null
          ? null
          : List<NpcCalCode>.from(
              json["npc_cal_codes"].map((x) => npcCalCodeValues.map[x])),
      lockWreck: json["lock_wreck"] == null ? null : json["lock_wreck"],
      product: json["product"] == null ? null : json["product"],
      skinId: json["skin_id"] == null ? null : json["skin_id"],
      corporationId:
          json["corporation_id"] == null ? null : json["corporation_id"],
      portraitPath:
          json["portrait_path"] == null ? null : json["portrait_path"],
      cloneLv: json["clone_lv"] == null ? null : json["clone_lv"],
      effectGroup: json["effect_group"] == null ? null : json["effect_group"],
      exp: json["exp"] == null ? null : json["exp"],
      initLv: json["init_lv"] == null ? null : json["init_lv"],
      published: json["published"] == null ? null : json["published"],
      techLv: json["tech_lv"] == null ? null : json["tech_lv"],
      preSkill: json["pre_skill"] == null
          ? null
          : List<String>.from(json["pre_skill"].map((x) => x)),
      corpCamera: json["corp_camera"] == null
          ? null
          : List<double>.from(json["corp_camera"].map((x) => x.toDouble())),
      wreckId: json["wreck_id"] == null ? null : json["wreck_id"],
      museumCredit:
          json["museum_credit"] == null ? null : json["museum_credit"],
      museumPosition1:
          json["museum_position_1"] == null ? null : json["museum_position_1"],
      museumPosition2:
          json["museum_position_2"] == null ? null : json["museum_position_2"],
      wikiId: json["wiki_id"] == null ? null : json["wiki_id"],
      bigIconPath: json["big_icon_path"] == null ? null : json["big_icon_path"],
      boxDropId: json["box_drop_id"] == null ? null : json["box_drop_id"],
      funParam: json["fun_param"] == null ? null : json["fun_param"],
      isObtainable:
          json["is_obtainable"] == null ? null : json["is_obtainable"],
      medalSourceText:
          json["medal_source_text"] == null ? null : json["medal_source_text"],
      abilityList: json["ability_list"] == null
          ? null
          : List<int>.from(json["ability_list"].map((x) => x)),
      baseDropRate: json["base_drop_rate"] == null
          ? null
          : json["base_drop_rate"].toDouble(),
      normalDebris: json["normal_debris"] == null
          ? null
          : List<int>.from(json["normal_debris"].map((x) => x)),
      shipBonusCodeList: json["ship_bonus_code_list"] == null
          ? null
          : List<String>.from(json["ship_bonus_code_list"].map((x) => x)),
      shipBonusSkillList: json["ship_bonus_skill_list"] == null
          ? null
          : List<int>.from(json["ship_bonus_skill_list"].map((x) => x)),
      isRookieInsurance: json["is_rookie_insurance"] == null
          ? null
          : json["is_rookie_insurance"],
    );
  }

  Map<String, dynamic> toJson() => {
        "base_price": basePrice == null ? null : basePrice,
        "can_be_jettisoned": canBeJettisoned == null ? null : canBeJettisoned,
        "capacity": capacity == null ? null : capacity,
        "desc_special": descSpecial == null
            ? null
            : List<dynamic>.from(descSpecial.map((x) => x)),
        "faction_id": factionId == null ? null : factionId,
        "icon_id": iconId == null ? null : iconId,
        "is_omega": isOmega == null ? null : isOmega,
        "main_cal_code": mainCalCode == null ? null : mainCalCode,
        "mass": mass == null ? null : mass,
        "online_cal_code": onlineCalCode == null ? null : onlineCalCode,
        "prefab_id": prefabId == null ? null : prefabId,
        "radius": radius == null ? null : radius,
        "sound_id": soundId == null ? null : soundId,
        "volume": volume == null ? null : volume,
        "sourceDesc": sourceDesc,
        "sourceName": sourceName,
        "name_key": nameKey == null ? null : nameKey,
        "desc_key": descKey == null ? null : descKey,
        "id": id == null ? null : id,
        "drop_rate": dropRate == null ? null : dropRate,
        "market_group_id": marketGroupId == null ? null : marketGroupId,
        "active_cal_code": activeCalCode == null ? null : activeCalCode,
        "graphic_id": graphicId == null ? null : graphicId,
        "race_id": raceId == null ? null : raceId,
        "sof_faction_name": sofFactionName == null ? null : sofFactionName,
        "lock_skin": lockSkin == null
            ? null
            : List<dynamic>.from(
                lockSkin.map((x) => lockSkinValues.reverse[x])),
        "npc_cal_codes": npcCalCodes == null
            ? null
            : List<dynamic>.from(
                npcCalCodes.map((x) => npcCalCodeValues.reverse[x])),
        "lock_wreck": lockWreck == null ? null : lockWreck,
        "product": product == null ? null : product,
        "skin_id": skinId == null ? null : skinId,
        "corporation_id": corporationId == null ? null : corporationId,
        "portrait_path": portraitPath == null ? null : portraitPath,
        "clone_lv": cloneLv == null ? null : cloneLv,
        "effect_group": effectGroup == null ? null : effectGroup,
        "exp": exp == null ? null : exp,
        "init_lv": initLv == null ? null : initLv,
        "published": published == null ? null : published,
        "tech_lv": techLv == null ? null : techLv,
        "pre_skill": preSkill == null
            ? null
            : List<dynamic>.from(preSkill.map((x) => x)),
        "corp_camera": corpCamera == null
            ? null
            : List<dynamic>.from(corpCamera.map((x) => x)),
        "wreck_id": wreckId == null ? null : wreckId,
        "museum_credit": museumCredit == null ? null : museumCredit,
        "museum_position_1": museumPosition1 == null ? null : museumPosition1,
        "museum_position_2": museumPosition2 == null ? null : museumPosition2,
        "wiki_id": wikiId == null ? null : wikiId,
        "big_icon_path": bigIconPath == null ? null : bigIconPath,
        "box_drop_id": boxDropId == null ? null : boxDropId,
        "fun_param": funParam == null ? null : funParam,
        "is_obtainable": isObtainable == null ? null : isObtainable,
        "medal_source_text": medalSourceText == null ? null : medalSourceText,
        "ability_list": abilityList == null
            ? null
            : List<dynamic>.from(abilityList.map((x) => x)),
        "base_drop_rate": baseDropRate == null ? null : baseDropRate,
        "normal_debris": normalDebris == null
            ? null
            : List<dynamic>.from(normalDebris.map((x) => x)),
        "ship_bonus_code_list": shipBonusCodeList == null
            ? null
            : List<dynamic>.from(shipBonusCodeList.map((x) => x)),
        "ship_bonus_skill_list": shipBonusSkillList == null
            ? null
            : List<dynamic>.from(shipBonusSkillList.map((x) => x)),
        "is_rookie_insurance":
            isRookieInsurance == null ? null : isRookieInsurance,
      };
}

enum LockSkin {
  CONCORD,
  SERPENTIS,
  GURISTAS,
  ANGELBASE,
  INNERZONE,
  SANSHABASE,
  BLOODRAIDER,
  OREBASE,
  SLEEPERBASE
}

final lockSkinValues = EnumValues({
  "angelbase": LockSkin.ANGELBASE,
  "bloodraider": LockSkin.BLOODRAIDER,
  "concord": LockSkin.CONCORD,
  "guristas": LockSkin.GURISTAS,
  "innerzone": LockSkin.INNERZONE,
  "orebase": LockSkin.OREBASE,
  "sanshabase": LockSkin.SANSHABASE,
  "serpentis": LockSkin.SERPENTIS,
  "sleeperbase": LockSkin.SLEEPERBASE
});

enum NpcCalCode {
  NPC_NPC_BONUS_CONCORD_NPC_NAVY,
  NPC_NPC_BONUS_CONCORD_NPC_CONCORD,
  NPC_DAMAGE_X0_3,
  NPC_SPEED_X0_5,
  NPC_HP_X0_5,
  NPC_REPAIR_X0_2,
  NPC_SIGNATURE_X1_5,
  NPC_CAPACITOR_X5_0,
  NPC_PRECISION_X1_0,
  NPC_RANGE_X1_0,
  NPC_DAMAGE_X0_4,
  NPC_SPEED_X0_6,
  NPC_HP_X0_7,
  NPC_REPAIR_X0_3,
  NPC_DAMAGE_X0_5,
  NPC_HP_X0_8,
  NPC_HP_X0_9,
  NPC_REPAIR_X0_4,
  NPC_DAMAGE_X0_6,
  NPC_DAMAGE_X0_7,
  NPC_HP_X1_0,
  NPC_REPAIR_X0_5,
  NPC_HP_X0_4,
  NPC_REPAIR_X0_0,
  NPC_HP_X0_6,
  NPC_DAMAGE_X1_0,
  NPC_SPEED_X1_6,
  NPC_HP_X1_5,
  NPC_SIGNATURE_X1_0,
  NPC_PRECISION_X1_5,
  NPC_RANGE_X1_5,
  NPC_REPAIR_X0_6,
  NPC_HP_X1_8,
  NPC_REPAIR_X0_7,
  NPC_REPAIR_X0_8,
  NPC_DAMAGE_X2_0,
  NPC_SPEED_X3_0,
  NPC_HP_X2_0,
  NPC_REPAIR_X1_6,
  NPC_SIGNATURE_X0_8,
  NPC_RANGE_X2_0,
  NPC_DAMAGE_X0_1,
  NPC_SPEED_X1_5,
  NPC_HP_X0_3,
  NPC_SPEED_X0_3,
  NPC_HP_X0_2,
  NPC_SIGNATURE_X2_0,
  NPC_PRECISION_X2_0,
  NPC_DAMAGE_X0_2
}

final npcCalCodeValues = EnumValues({
  "/NPC/capacitor/x5.0/": NpcCalCode.NPC_CAPACITOR_X5_0,
  "/NPC/Damage/x0.1/": NpcCalCode.NPC_DAMAGE_X0_1,
  "/NPC/Damage/x0.2/": NpcCalCode.NPC_DAMAGE_X0_2,
  "/NPC/Damage/x0.3/": NpcCalCode.NPC_DAMAGE_X0_3,
  "/NPC/Damage/x0.4/": NpcCalCode.NPC_DAMAGE_X0_4,
  "/NPC/Damage/x0.5/": NpcCalCode.NPC_DAMAGE_X0_5,
  "/NPC/Damage/x0.6/": NpcCalCode.NPC_DAMAGE_X0_6,
  "/NPC/Damage/x0.7/": NpcCalCode.NPC_DAMAGE_X0_7,
  "/NPC/Damage/x1.0/": NpcCalCode.NPC_DAMAGE_X1_0,
  "/NPC/Damage/x2.0/": NpcCalCode.NPC_DAMAGE_X2_0,
  "/NPC/HP/x0.2/": NpcCalCode.NPC_HP_X0_2,
  "/NPC/HP/x0.3/": NpcCalCode.NPC_HP_X0_3,
  "/NPC/HP/x0.4/": NpcCalCode.NPC_HP_X0_4,
  "/NPC/HP/x0.5/": NpcCalCode.NPC_HP_X0_5,
  "/NPC/HP/x0.6/": NpcCalCode.NPC_HP_X0_6,
  "/NPC/HP/x0.7/": NpcCalCode.NPC_HP_X0_7,
  "/NPC/HP/x0.8/": NpcCalCode.NPC_HP_X0_8,
  "/NPC/HP/x0.9/": NpcCalCode.NPC_HP_X0_9,
  "/NPC/HP/x1.0/": NpcCalCode.NPC_HP_X1_0,
  "/NPC/HP/x1.5/": NpcCalCode.NPC_HP_X1_5,
  "/NPC/HP/x1.8/": NpcCalCode.NPC_HP_X1_8,
  "/NPC/HP/x2.0/": NpcCalCode.NPC_HP_X2_0,
  "/NPC/NPCBonusConcord/NPCConcord/":
      NpcCalCode.NPC_NPC_BONUS_CONCORD_NPC_CONCORD,
  "/NPC/NPCBonusConcord/NPCNavy/": NpcCalCode.NPC_NPC_BONUS_CONCORD_NPC_NAVY,
  "/NPC/precision/x1.0/": NpcCalCode.NPC_PRECISION_X1_0,
  "/NPC/precision/x1.5/": NpcCalCode.NPC_PRECISION_X1_5,
  "/NPC/precision/x2.0/": NpcCalCode.NPC_PRECISION_X2_0,
  "/NPC/range/x1.0/": NpcCalCode.NPC_RANGE_X1_0,
  "/NPC/range/x1.5/": NpcCalCode.NPC_RANGE_X1_5,
  "/NPC/range/x2.0/": NpcCalCode.NPC_RANGE_X2_0,
  "/NPC/Repair/x0.0/": NpcCalCode.NPC_REPAIR_X0_0,
  "/NPC/Repair/x0.2/": NpcCalCode.NPC_REPAIR_X0_2,
  "/NPC/Repair/x0.3/": NpcCalCode.NPC_REPAIR_X0_3,
  "/NPC/Repair/x0.4/": NpcCalCode.NPC_REPAIR_X0_4,
  "/NPC/Repair/x0.5/": NpcCalCode.NPC_REPAIR_X0_5,
  "/NPC/Repair/x0.6/": NpcCalCode.NPC_REPAIR_X0_6,
  "/NPC/Repair/x0.7/": NpcCalCode.NPC_REPAIR_X0_7,
  "/NPC/Repair/x0.8/": NpcCalCode.NPC_REPAIR_X0_8,
  "/NPC/Repair/x1.6/": NpcCalCode.NPC_REPAIR_X1_6,
  "/NPC/Signature/x0.8/": NpcCalCode.NPC_SIGNATURE_X0_8,
  "/NPC/Signature/x1.0/": NpcCalCode.NPC_SIGNATURE_X1_0,
  "/NPC/Signature/x1.5/": NpcCalCode.NPC_SIGNATURE_X1_5,
  "/NPC/Signature/x2.0/": NpcCalCode.NPC_SIGNATURE_X2_0,
  "/NPC/Speed/x0.3/": NpcCalCode.NPC_SPEED_X0_3,
  "/NPC/Speed/x0.5/": NpcCalCode.NPC_SPEED_X0_5,
  "/NPC/Speed/x0.6/": NpcCalCode.NPC_SPEED_X0_6,
  "/NPC/Speed/x1.5/": NpcCalCode.NPC_SPEED_X1_5,
  "/NPC/Speed/x1.6/": NpcCalCode.NPC_SPEED_X1_6,
  "/NPC/Speed/x3.0/": NpcCalCode.NPC_SPEED_X3_0
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
