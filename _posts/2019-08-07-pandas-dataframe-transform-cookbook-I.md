---
layout: post
title:  pandas dataframe transform cookbook I 
date:   2019-08-07 11:20 
categories: tech 
---

## Question: given a dataframe, transform the data in each rid to a json 

sample input:

```
>>> df 
     id  rid       qid  value  text
0    1  CVNAzUPDVR  Q1  None   q1_text
1    2  CVNAzUPDVR  Q2  None   q2_text 
2    3  CVNAzUPDVR  Q3  None   q3_text 
3    4  CVNAzUPDVR  Q4   4   None 
4    5  CVNAzUPDVR  Q5   6   None 
5    6  CVNAzUPDVR  Q6   6   None 
6    7  driTu9jHtf  Q1  None   q1_text 
7    8  driTu9jHtf  Q2  None   q2_text 
8    9  driTu9jHtf  Q3  None   test
9   10  driTu9jHtf  Q4   [3]   None
10  11  driTu9jHtf  Q5   [3]   None
11  12  driTu9jHtf  Q6   [1]   None
12  13  FmAmkBQMiA  Q1  None  test2
13  14  FmAmkBQMiA  Q2  None  test2
14  15  FmAmkBQMiA  Q3  None  test2
15  16  FmAmkBQMiA  Q4   [1]   None
16  17  FmAmkBQMiA  Q5   [1]   None
17  18  FmAmkBQMiA  Q6   [1]   None
18  19  WHwvfkFaOO  Q1  None    sas
19  20  WHwvfkFaOO  Q2  None    dad
```

output:

```
{
'CVNAzUPDVR': {'Q1': 'q1_text', 'Q2': 'q2_text', 'Q3': 'q3_text', 'Q4': 4, 'Q5': 5, 'Q6': 6 }
'driTu9jHtf': ... 
}
```

## approach 1


```
## long to wide
>>> df_value = answer_df.pivot(index='rid', columns='qid', values='value')
>>> df_text = answer_df.pivot(index='rid', columns='qid', values='text')
>>> text_json = df_text.to_json(orient="index", force_ascii=False)
>>> value_json = df_value.to_json(orient="index", force_ascii=False)
>>> values = json.loads(value_json)
>>> texts= json.loads(text_json)
>>> merged = [ {rid: {**values[rid], ** texts[rid]}} for rid in values]
>>> merged[0]
{'CVNAzUPDVR': {'Q1': 'q1_text', 'Q2': 'q2_text', 'Q3': 'q3_text', 'Q4': 4, 'Q5': 5, 'Q6': 6 }}
```

