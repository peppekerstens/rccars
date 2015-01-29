---
layout: page
title: Articles
permalink: /articles/
---

  <ul class="post-list">
    {% for article in site.articles %}
      <li>
        <h2>
          <a class="post-link" href="{{ article.url | prepend: site.baseurl }}">{{ article.title }}</a>
        </h2>
	{% if article.summary %}{{ article.summary | markdownify }}{% endif %}
      </li>
    {% endfor %}
  </ul>

