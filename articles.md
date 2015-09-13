---
layout: page
title: Articles
permalink: /articles/
---

These are a series of article on various subject which are intented to be
occasionally updated, as I gain knowledge, as new products enter the market,
and so on. Let me know if you find any mistake, or have suggestions!

  <ul class="post-list">
    {% for article in site.articles %}{% if article.draft != true %}
      <li>
        <h2>
          <a class="post-link" href="{{ article.url | prepend: site.baseurl }}">{{ article.title }}</a>
        </h2>
	{% if article.summary %}{{ article.summary | markdownify }}{% endif %}
      </li>
    {% endif %}{% endfor %}
  </ul>

