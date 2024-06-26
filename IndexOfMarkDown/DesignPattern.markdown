---
layout: page
title: DesignPattern
listedInHeader: true
---

<h2>Design Pattren设计模式:</h2>

**创建型模式** 
1.	**单例模式（Singleton Pattern）**```确保一个类只有一个实例，并提供一个全局访问点。```   ```适用场景：需要唯一实例，如配置管理器、日志类等。```
2.	**工厂方法模式（Factory Method Pattern**```定义一个创建对象的接口，但让子类决定实例化哪一个类。```
3.	**抽象工厂模式（Abstract Factory Pattern）**```提供一个创建一系列相关或相互依赖对象的接口，而无需指定它们具体的类。``````适用场景：需要创建一组相关的对象且不需要知道具体类时。```
4.	**建造者模式（Builder Pattern）**```将一个复杂对象的构建过程与其表示分离，使得同样的构建过程可以创建不同的表示。``````适用场景：构建复杂对象时，通过步骤逐步创建对象。```
5.	**原型模式（Prototype Pattern）**```用原型实例指定创建对象的种类，并通过复制这些原型创建新的对象。``````适用场景：需要大量相似对象时，通过克隆创建新实例。```

**结构型模式**
6.	**适配器模式（Adapter Pattern）**```将一个类的接口转换成客户希望的另一个接口，使得原本由于接口不兼容而不能一起工作的类可以一起工作。``````适用场景：需要使用现有的类但接口不符合需求时。```
7.	**桥接模式（Bridge Pattern）**```将抽象部分与它的实现部分分离，使它们可以独立变化。``````适用场景：需要跨多个维度进行变化时。```
8.	**组合模式（Composite Pattern）**```将对象组合成树形结构以表示“部分-整体”的层次结构，使得客户可以统一地处理单个对象和组合对象。``````适用场景：需要表示对象的层次结构时，如文件系统。```
9.	**装饰模式（Decorator Pattern）**```动态地给一个对象添加一些额外的职责，装饰模式提供了比继承更有弹性的替代方案。``````适用场景：需要动态添加功能且不影响其他对象时。```
10.	**外观模式（Facade Pattern）**```为子系统中的一组接口提供一个一致的界面，使得子系统更容易使用。``````适用场景：为复杂的子系统提供简化的接口。```
11.	**享元模式（Flyweight Pattern）**```运用共享技术有效地支持大量细粒度的对象。``````适用场景：需要大量相似对象时，通过共享减少内存消耗。```
12.	**代理模式（Proxy Pattern）**```为其他对象提供一种代理以控制对这个对象的访问。``````适用场景：需要控制对对象的访问时，如虚代理、远程代理等。```

**行为型模式**
13.	**责任链模式（Chain of Responsibility Pattern）**```使多个对象都有机会处理请求，从而避免请求的发送者和接收者之间的耦合。将这些对象连成一条链，并沿着这条链传递请求，直到有对象处理它为止。``````适用场景：多个对象可以处理请求时，动态指定处理顺序。```
14.	**命令模式（Command Pattern）**```将请求封装成对象，从而使你可用不同的请求对客户进行参数化，队列或日志请求，以及支持可撤销操作。``````适用场景：需要对请求排队、记录日志和撤销操作时。```
15.	**解释器模式（Interpreter Pattern）**```给定一个语言，定义它的文法的一种表示，并定义一个解释器，该解释器使用该表示来解释语言中的句子。``````适用场景：需要解释执行特定语言的表达式时。```
16.	**迭代器模式（Iterator Pattern）**```提供一种方法顺序访问一个聚合对象中的各个元素，而又不需要暴露该对象的内部表示。``````适用场景：需要顺序访问聚合对象中的元素时。```
17.	**中介者模式（Mediator Pattern）**```用一个中介对象来封装一系列对象的交互。中介者使各对象不需要显式地相互引用，从而使其耦合松散，并可以独立地改变它们之间的交互。``````适用场景：对象之间的交互复杂，需通过中介者减少耦合。```
18.	**备忘录模式（Memento Pattern）**```在不破坏封装性的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态，以便以后恢复对象到保存的状态。``````适用场景：需要保存和恢复对象的状态时。```
19.	**观察者模式（Observer Pattern）**```定义对象间的一种一对多的依赖关系，当一个对象的状态发生改变时，所有依赖于它的对象都得到通知并被自动更新。``````适用场景：对象状态改变需要通知其他对象时。```
20.	**状态模式（State Pattern）**```允许对象在内部状态改变时改变它的行为，对象看起来好像修改了它的类。``````适用场景：对象的行为依赖于状态，并且可以根据状态改变行为时。```
21.	**策略模式（Strategy Pattern）**```定义一系列的算法，把它们一个个封装起来，并且使它们可相互替换。本模式使得算法可独立于使用它的客户而变化。``````适用场景：需要动态选择算法时。```
22.	**模板方法模式（Template Method Pattern）**```定义一个操作中的算法的骨架，而将一些步骤延迟到子类中。模板方法使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。``````适用场景：算法的整体结构固定，但某些步骤可以由子类实现时。```
23.	**访问者模式（Visitor Pattern）**```表示一个作用于某对象结构中的各元素的操作。它使你可以在不改变各元素的类的前提下定义作用于这些元素的新操作。``````适用场景：需要对对象结构中的元素执行多种不同操作，并且不希望这些操作影响元素的类定义时。```



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
    {% if page.path contains 'DesignPattern' %}
        <!-- not include self -->
        {% unless page.listedInHeader %}  
            <li>
                <a href="{{ page.url }}">{{ page.title }}</a>
            </li>
        {% endunless %}
    {% endif %}
{% endfor %}
</ul>