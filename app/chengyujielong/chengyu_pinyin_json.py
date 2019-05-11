# read chengyu file and output a json
# with pinyin of first char in chengyu as key
import csv
import pandas as pd
from pypinyin import pinyin, lazy_pinyin
from pprint import pprint
csv_file = '/Users/hwu/dev/chengyujielong/THUOCL_chengyu.txt'

# read csv, not used in the result
with open(csv_file, encoding='utf-8') as csvfile:
    spamreader = csv.reader(csvfile, delimiter='\t')
    for row in spamreader:
        chengyu = row[0].rstrip(' ')
        # print(chengyu)

chengyu_df = pd.read_csv(csv_file, sep="\t", header=None)
first_chengyu = chengyu_df[0].str.rstrip(' ')[0]
print(pinyin('中心')[0])
print(chengyu_df)
chengyu_df[2] = chengyu_df[0].map(lambda x: lazy_pinyin(x)[0])
print(chengyu_df)
# group by the third column
grouped = chengyu_df.groupby([2])
pprint(grouped)
pinyin_chengyu_dict = {}
# better way to sum?
for name, group in grouped:
    pinyin_chengyu_dict[name] = group[0].tolist()

print(pinyin_chengyu_dict)

import json
with open('result.json', 'w') as fp:
    json.dump(pinyin_chengyu_dict, fp, ensure_ascii=False)
