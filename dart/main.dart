import 'dart:convert';
import 'dart:io';
import 'dart:core';

import 'model/category.dart';
import 'model/group.dart';
import 'model/item.dart';
import 'model/localised_string.dart';
import 'model/market_group_data.dart';
import 'model/msg_index.dart';
import 'util/file_extensions.dart';

const staticDataBase = 'data-dump/staticdata';
const pyStaticDataBase = 'data-dump/py_data/data_common/static';

Map<String, List<LocalisedString>> languageStrings = {};

List<Item> items = [];
List<Group> groups = [];
List<Category> categories = [];

void main(List<String> args) {
  const marketNamePluralToRemove = '-复数';
  String json;

  // Load
  // - MsgIndex
  msgIndexLookup = loadMsgIndex();
  print('Loaded ${msgIndexLookup.length} localisation lookups');

  // - Language Strings
  languageStrings = loadLanguages();
  print('Loaded ${languageStrings.length} languages');
  languageStrings.forEach((key, value) {
    print('  Lang $key contains ${value.length} strings');
  });
  json = jsonEncode(languageStrings);
  new File('languageStrings.json').writeAsStringSync(json);

  // - Items
  items = loadItems();
  print('Loaded ${items.length} items');
  json = jsonEncode(items);
  new File('items.json').writeAsStringSync(json);
  // - Groups
  groups = loadGroups();
  print('Loaded ${groups.length} groups');
  json = jsonEncode(groups);
  new File('groups.json').writeAsStringSync(json);
  // - Categories
  categories = loadCategories();
  print('Loaded ${categories.length} categories');
  json = jsonEncode(categories);
  new File('categories.json').writeAsStringSync(json);

  // - Market Groups
  loadMarketGroups();
}

void loadMarketGroups() {
  var marketGroupsFile = new File('$pyStaticDataBase/market_sell_items.json');
  var str = marketGroupsFile.readAsStringSync();
  var marketGroupData = marketGroupDataFromJson(str);
  print('Market Groups = ${marketGroupData.marketGroupId.length}');
}

Map<int, int> loadMsgIndex() {
  Map<int, int> map = {};
  var msgIdxFile = new File('$staticDataBase/gettext/msg_index/index.json');
  var str = msgIdxFile.readAsStringSync();
  // This can surely be done better..
  jsonDecode(str).forEach((key, value) {
    int k = int.tryParse(key);
    int v = value as int;

    if (k != null && v != null) {
      map[k] = v;
    }
  });
  return map;
}

Map<String, List<LocalisedString>> loadLanguages() {
  Map<String, List<LocalisedString>> map = {};
  var langFolders = new Directory('$staticDataBase/gettext');

  if (!langFolders.existsSync()) {
    return map;
  }

  langFolders
      .listSync()
      .where((element) => element is Directory && element.name != 'msg_index')
      .map((e) => e as Directory)
      .toList()
      .forEach((language) {
    map[language.name] = loadLanguage(language);
  });

  return map;
}

List<LocalisedString> loadLanguage(Directory langDirectory) {
  List<LocalisedString> list = [];
  var langFiles = langDirectory
      .listSync()
      .where((element) =>
          element is File && int.tryParse(element.nameWithoutExtension) != null)
      .map((element) => element as File)
      .toList();

  langFiles.forEach((langFile) {
    var str = langFile.readAsStringSync();
    jsonDecode(str).forEach((key, value) {
      int k = int.tryParse(key);
      var v = value as String;

      if (k != null && v != null) {
        list.add(LocalisedString(index: k, localisedString: v));
      }
    });
  });

  return list;
}

List<Item> loadItems() {
  var itemsFiles = new Directory('$staticDataBase/items')
      .listSync()
      .where((element) =>
          element is File && int.tryParse(element.nameWithoutExtension) != null)
      .map((e) => e as File)
      .toList();

  List<Item> items = itemsFiles
      .map((itemsFile) {
        var str = itemsFile.readAsStringSync();
        return Map<String, Item>.from(jsonDecode(str).map((k, data) {
          Map<String, dynamic> map = {'id': int.tryParse(k) ?? 0};
          map.addAll(data);
          return MapEntry<String, Item>(k, Item.fromMap(map));
        })).entries.map((e) => e.value).toList();
      })
      .expand((i) => i)
      .toList();

  return items;
}

List<Group> loadGroups() {
  List<Group> list = [];
  var itemGroupFile =
      new File('$staticDataBase/items/item_types_by_group.json');
  var groupFile = new File('$staticDataBase/items/group.json');

  var str = itemGroupFile.readAsStringSync();
  var itemGroups = Map<int, List<int>>.from(jsonDecode(str).map((k, itemsList) {
    var items = itemsList.map((i) => i as int).toList().cast<int>();
    return MapEntry<int, List<int>>(int.tryParse(k) ?? 0, items);
  })).map((key, value) {
    var groupItems = items.where((item) => value.contains(item.id)).toList();
    return MapEntry(key, groupItems);
  });

  str = groupFile.readAsStringSync();
  list = Map<String, Group>.from(jsonDecode(str).map((k, data) {
    var id = int.tryParse(k) ?? 0;
    Map<String, dynamic> map = {'id': id};
    map.addAll(data);

    return MapEntry<String, Group>(
        k, Group.fromMap(map: map, items: itemGroups[id] ?? []));
  })).entries.map((e) => e.value).toList();

  return list;
}

List<Category> loadCategories() {
  List<Category> list = [];
  var msgIdxFile = new File('$staticDataBase/items/category.json');
  var str = msgIdxFile.readAsStringSync();
  list = Map<String, Category>.from(jsonDecode(str).map((k, data) {
    var id = int.tryParse(k) ?? 0;
    Map<String, dynamic> map = {'id': id};
    map.addAll(data);
    var groupIds = data['groups'].map((i) => i as int).toList().cast<int>();
    var categoryGroups = groups.where((g) => groupIds.contains(g.id)).toList();

    return MapEntry<String, Category>(
        k, Category.fromMap(map: map, groups: categoryGroups));
  })).entries.map((e) => e.value).toList();
  return list;
}
