---
layout: page
title: others
listedInHeader: true
---

# Table of Content



<ul>
{% for page in site.pages %}
    {% if page.path contains 'others' %}
        <!-- not include self -->
        {% unless page.listedInHeader %}  
            <li>
                <a href="{{ page.url }}">{{ page.title }}</a>
            </li>
        {% endunless %}
    {% endif %}
{% endfor %}
</ul>