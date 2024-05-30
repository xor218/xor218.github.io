---
layout: page
title: Swift
listedInHeader: true
---

<h2>Note List:</h2>
官方:[点我](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Type-Safety-and-Type-Inference)

<ul>
    {% assign pages = site.pages | where_exp: "page", "page.path contains 'Swift'" | sort: 'date' %}
    {% for page in pages %}
        {% unless page.listedInHeader %}
            <li>
                <a href="{{ page.url }}">{{ page.title }}</a>
            </li>
        {% endunless %}
    {% endfor %}
</ul>