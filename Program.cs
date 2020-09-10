using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ee_data_process
{
    class Program
    {
        static void Main(string[] args)
        {
            var itemFiles = Directory.EnumerateFiles("data-dump/staticdata/items", "*.*", SearchOption.AllDirectories)
            .Where(s => s.EndsWith(".json") && !s.EndsWith(".schema.json") && int.TryParse(Path.GetFileNameWithoutExtension(s), out int i));
            
            var zhStringFiles = Directory.EnumerateFiles("data-dump/staticdata/gettext/zh", "*.*", SearchOption.AllDirectories)
            .Where(s => s.EndsWith(".json") && !s.EndsWith(".schema.json") && int.TryParse(Path.GetFileNameWithoutExtension(s), out int i));

            var enStringFiles = Directory.EnumerateFiles("data-dump/staticdata/gettext/en", "*.*", SearchOption.AllDirectories)
            .Where(s => s.EndsWith(".json") && !s.EndsWith(".schema.json") && int.TryParse(Path.GetFileNameWithoutExtension(s), out int i));


            Dictionary <string, string> zhStrings;
            Dictionary <string, string> enStrings;

            var temp = new List<Dictionary<string, string>>();
            foreach (var file in zhStringFiles) {
                var des = JsonConvert.DeserializeObject<Dictionary<string, string>>(File.ReadAllText(file));
                temp.Add(des);
            }
            zhStrings = temp.SelectMany(dict => dict).ToDictionary(pair => pair.Key, pair => pair.Value);

            Console.WriteLine("Processed {0} ZH strings", zhStrings.Values.Count);

            temp = new List<Dictionary<string, string>>();
            foreach (var file in enStringFiles) {
                var des = JsonConvert.DeserializeObject<Dictionary<string, string>>(File.ReadAllText(file));
                temp.Add(des);
            }
            enStrings = temp.SelectMany(dict => dict).ToDictionary(pair => pair.Key, pair => pair.Value);

            Console.WriteLine("Processed {0} EN strings", enStrings.Values.Count);

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

                if (!itemDict.ContainsKey("prefab_id"))  {
                    Console.WriteLine("Item {0} dictionary does not have prefab_id", item.Key);
                }

                var zhNameKey = itemDict.Value<string>("zh_name") ?? "";
                var enKey = zhStrings.ContainsValue(zhNameKey) ? zhStrings.First(x => x.Value == zhNameKey).Key : ""; // We take the first one we find!
                
                var enName = enStrings.ContainsKey(enKey) ? enStrings[enKey] as string ?? "" : "Unknown Name";
                
                Console.WriteLine("Found name {0} for item {1}", enName, item.Key);

                itemDict["name_key"] = enKey;
                itemDict["en_name"] = enName;

                zhNameKey = itemDict.Value<string>("zh_desc") ?? "";
                enKey = zhStrings.ContainsValue(zhNameKey) ? zhStrings.First(x => x.Value == zhNameKey).Key : ""; // We take the first one we find!
                enName = enStrings.ContainsKey(enKey) ? enStrings[enKey] as string ?? "" : "Unknown Desc";
                
                Console.WriteLine("Found desc {0} for item {1}", enName, item.Key);

                itemDict["desc_key"] = enKey;
                itemDict["en_desc"] = enName;
                itemDict["id"] = item.Key;
            }  

            var flattened = result.Select(x => x.Value).ToList();
            var json = JsonConvert.SerializeObject(flattened);
            File.WriteAllText("items.json", json);
        }
    }
}
