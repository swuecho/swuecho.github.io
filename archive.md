---
title: Archive
layout: page
---

<ul class="listing">
{% for post in site.posts %}
  {% capture y %}{{post.date | date:"%Y"}}{% endcapture %}
  {% if year != y %}
    {% assign year = y %}
    <li class="listing-seperator">{{ y }}</li>
  {% endif %}
  <li class="listing-item">
    <time datetime="{{ post.date | date:"%Y-%m-%d" }}">{{ post.date | date:"%Y-%m-%d" }}</time>
    <div class='post-info'>
      <a href="{{ post.url }}" title="{{ post.title }}">{{ post.title }}</a>
     <!-- Display post categories as tags -->
      <div class="post-tags">
          {% for category in post.categories %}
          <span class="tag">{{ category }}</span>
          {% endfor %}
      </div>
    </div>
  </li>
{% endfor %}
</ul>
