---
layout: page
title: CMake
listedInHeader: true
---

<h2>Note List:</h2>

<!-- <ul>
{% for page in site.pages %}
    {% if page.path contains 'cmake' %}
        <li>
            <a href="{{ page.url }}">{{ page.title }}</a>
        </li>
    {% endif %}
{% endfor %}
</ul>   -->

<ul>
{% for page in site.pages %}
    {% if page.path contains 'cmake' %}
        <!-- not include self -->
        {% unless page.listedInHeader %}  
            <li>
                <a href="{{ page.url }}">{{ page.title }}</a>
            </li>
        {% endunless %}
    {% endif %}
{% endfor %}
</ul>