---
layout: page
title: Linux&Command
listedInHeader: true
---


<div style="width: 50%; float: left;">

<h2>Linux Base:</h2>

<ul>
{% for page in site.pages %}
    {% if page.path contains 'LinuxBase' %}
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

<h2>Linux Command List:</h2>
<ul>
{% for page in site.pages %}
    {% if page.path contains 'LinuxCommand' %}
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
