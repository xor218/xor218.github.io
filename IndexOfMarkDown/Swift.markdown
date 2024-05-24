---
layout: page
title: Swift
listedInHeader: true
---

<h2>Note List:</h2>


<ul>
{% for page in site.pages %}
    {% if page.path contains 'Swift' %}
        <!-- not include self -->
        {% unless page.listedInHeader %}  
            <li>
                <a href="{{ page.url }}">{{ page.title }}</a>
            </li>
        {% endunless %}
    {% endif %}
{% endfor %}
</ul>