using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ee_data_process
{
    class Program
    {
        static Dictionary <string, Int64> msgIndex;
        static Dictionary <string, string> enStrings;

        static (Int64 index, string enString) DecodeNameToLocIndex(string source) {
                /*
                    if boot.node.is_client() and config.SHIPPING and source == 'g85tr':
                        localized_obj = LocalizedStr(source, '')
                */
                if (source.Equals("g85tr"))
                    return(0, "");

                // Decode from ZH name through Murmur3 to get index into Message_Index table
                var mm32 = Murmur.MurmurHash.Create32(2538058380);
                var keyArray = Encoding.UTF8.GetBytes(source);
                var res32 = mm32.ComputeHash(keyArray);
                var msgKey = BitConverter.ToUInt32(res32, 0);

                if (!msgIndex.ContainsKey(msgKey.ToString())) {
                    Console.WriteLine("msgIndex missing key {0}. Source was {1}", msgKey, source);
                    return(0, source);
                }

                var enKey = msgIndex[msgKey.ToString()];
                string enName;
                
                if (enStrings.ContainsKey(enKey.ToString())) {
                    enName = enStrings[enKey.ToString()];
                } else {
                    Console.WriteLine("Unknown name for key {0}", enKey);
                    enName = "Unknown Name";
                }

                return (enKey, enName);
        }

        static void Main(string[] args)
        {
            var itemFiles = Directory.EnumerateFiles("data-dump/staticdata/items", "*.*", SearchOption.AllDirectories)
            .Where(s => s.EndsWith(".json") && !s.EndsWith(".schema.json") && int.TryParse(Path.GetFileNameWithoutExtension(s), out int i));

            var enStringFiles = Directory.EnumerateFiles("data-dump/staticdata/gettext/en", "*.*", SearchOption.AllDirectories)
            .Where(s => s.EndsWith(".json") && !s.EndsWith(".schema.json") && int.TryParse(Path.GetFileNameWithoutExtension(s), out int i));

            msgIndex = JsonConvert.DeserializeObject<Dictionary<string, Int64>>(File.ReadAllText("data-dump/staticdata/gettext/msg_index/index.json"));

            var temp = new List<Dictionary<string, string>>();
            foreach (var file in enStringFiles) {
                var des = JsonConvert.DeserializeObject<Dictionary<string, string>>(File.ReadAllText(file));
                temp.Add(des);
            }
            enStrings = temp.SelectMany(dict => dict).ToDictionary(pair => pair.Key, pair => pair.Value);

            Console.WriteLine("Processed {0} EN strings", enStrings.Values.Count);

            #region Items
            var dictionaries = new List<Dictionary<string, object>>();
            foreach (var item in itemFiles)
            {
                var des = JsonConvert.DeserializeObject<Dictionary<string, object>>(File.ReadAllText(item));
                dictionaries.Add(des);
            }

            var result = dictionaries.SelectMany(dict => dict)
                         .ToDictionary(pair => pair.Key, pair => pair.Value);

            Console.WriteLine("Processed {0} items", result.Count);

            foreach (var item in result)
            {
                var itemDict = item.Value as JObject;

                if (itemDict == null) {
                    Console.WriteLine("Item is not a JSON Object");
                    continue;
                }

                if (!itemDict.ContainsKey("zh_name"))  {
                    Console.WriteLine("Item dictionary does not have zh_name");
                    continue;
                }

                var zhNameKey = itemDict.Value<string>("zh_name") ?? "";
                var locData = DecodeNameToLocIndex(zhNameKey);

                itemDict["name_key"] = locData.index;
                itemDict["en_name"] = locData.enString;

                zhNameKey = itemDict.Value<string>("zh_desc") ?? "";
                locData = DecodeNameToLocIndex(zhNameKey);
                itemDict["desc_key"] = locData.index;
                itemDict["en_desc"] = locData.enString;
                itemDict["id"] = item.Key;
            }  

            var flattened = result.Select(x => x.Value).ToList();
            var json = JsonConvert.SerializeObject(flattened);
            File.WriteAllText("items.json", json);
            #endregion

            #region Categories

            var categories = JsonConvert.DeserializeObject<Dictionary<string, Category>>(File.ReadAllText("data-dump/staticdata/items/category.json"));
            foreach(var categoryKvp in categories) {
                var category = categoryKvp.Value;

                category.Id = Int64.Parse(categoryKvp.Key);
                var zhNameKey = category.ZhName ?? "UNKNOWN";
                var locData = DecodeNameToLocIndex(zhNameKey);

                category.EnName = locData.enString;
                category.NameId = locData.index;
            }

            var flatCategories = categories.Select(x => x.Value).ToList();
            json = JsonConvert.SerializeObject(flatCategories);
            File.WriteAllText("categories.json", json);

            #endregion

            #region Groups
            var groupItems = JsonConvert.DeserializeObject<Dictionary<string, List<Int64>>>(File.ReadAllText("data-dump/staticdata/items/item_types_by_group.json"));
            var groups = JsonConvert.DeserializeObject<Dictionary<string, Group>>(File.ReadAllText("data-dump/staticdata/items/group.json"));
            foreach(var groupKvp in groups) {
                var group = groupKvp.Value;

                group.Id = Int64.Parse(groupKvp.Key);
                var zhNameKey = group.ZhName ?? "UNKNOWN";
                var locData = DecodeNameToLocIndex(zhNameKey);
                
                group.EnName = locData.enString;
                group.NameId = locData.index;

                if (groupItems.ContainsKey(groupKvp.Key)) {
                    group.ItemIds = groupItems[groupKvp.Key];
                } else {
                    group.ItemIds = new List<Int64>();
                }
            }

            var flatGroups = groups.Select(x => x.Value).ToList();
            json = JsonConvert.SerializeObject(flatGroups);
            File.WriteAllText("groups.json", json);
            
            #endregion
        }
    }
}

public class Category {
    [JsonProperty("groups")]
    public List<Int64> GroupIds { get; set; }
    [JsonProperty("zh_name")]
    public String ZhName { get; set; }
    [JsonProperty("en_name")]
    public String EnName { get; set; }
    [JsonProperty("name_id")]
    public Int64 NameId { get; set; }
    [JsonProperty("id")]
    public Int64 Id { get; set; }
}

public class Group {
    [JsonProperty("anchorable")]    
    public bool Anchorable { get; set; }
    [JsonProperty("anchored")]
    public bool Anchored { get; set; }
    [JsonProperty("fittable_non_singleton")]
    public bool FittableNonSingleton { get; set; }
    [JsonProperty("icon_path")]
    public string IconPath { get; set; }
    [JsonProperty("use_base_price")]
    public bool UseBasePrice { get; set; }
    [JsonProperty("zh_name")]
    public string ZhName { get; set; }
    [JsonProperty("en_name")]
    public String EnName { get; set; }
    [JsonProperty("name_id")]
    public Int64 NameId { get; set; }
    [JsonProperty("id")]
    public Int64 Id { get; set; }
    [JsonProperty("item_ids")]
    public List<Int64> ItemIds { get; set; }
}
