---
layout: page
title: C/C++
listedInHeader: true
---


<div style="width: 50%; float: left;">

<h2>C NoteBook List:</h2>

<ul>
{% for page in site.pages %}
    {% if page.path contains 'CLanguage' %}
        <!-- not include self -->
        {% unless page.listedInHeader %}  
            <li>
                <a href="{{ page.url }}">{{ page.title }}</a>
            </li>
        {% endunless %}
    {% endif %}
{% endfor %}
</ul>

</div>

<div style="width: 50%; float: left;">

<h2>Cpp NoteBook List:</h2>
<ul>
{% for page in site.pages %}
    {% if page.path contains 'CPP' %}
        <!-- not include self -->
        {% unless page.listedInHeader %}  
            <li>
                <a href="{{ page.url }}">{{ page.title }}</a>
            </li>
        {% endunless %}
    {% endif %}
{% endfor %}
</ul>

</div>

<div style="clear: both;"></div>
