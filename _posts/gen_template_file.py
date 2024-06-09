import argparse
import datetime


def generate_template_file(title):
    title_escape = title.replace(" ", "-")
    date = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%d")
    time = (datetime.datetime.now(datetime.timezone.utc) - datetime.timedelta(minutes=5)).strftime("%Y-%m-%d %H:%M")
    template =  f"""
---
layout: post
title:  {title}
date:   {time}
categories: tech 
---

```
```
""".strip()

    file_path = f"{date}-{title_escape}.md"
    with open(file_path, 'w+') as fh_file:
        fh_file.write(template)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate template markdown file')
    parser.add_argument('title', help='Title of the post')
    args = parser.parse_args()

    generate_template_file(args.title)
