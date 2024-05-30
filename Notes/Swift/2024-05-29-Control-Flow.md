---
layout: post
author: "大西瓜"
title: "Control Flow"
date:   2024-05-29 21:08:35 +0800
categories: [update,Swift] 
---



## 控制流



Swift 提供了多种控制流语句。其中包括多次执行任务的 `while` 循环； `if` 、 `guard` 和 `switch` 语句根据特定条件执行不同的代码分支；以及诸如 `break` 和 `continue` 之类的语句，将执行流转移到代码中的另一个点。 Swift 提供了 `for` - `in` 循环，可以轻松迭代数组、字典、范围、字符串和其他序列。 Swift 还提供了 `defer` 语句，这些语句包装了离开当前作用域时要执行的代码。



Swift 的 `switch` 语句比许多类 C 语言中的对应语句强大得多。案例可以匹配许多不同的模式，包括区间匹配、元组和特定类型的转换。 `switch` case 中的匹配值可以绑定到临时常量或变量以在 case 主体中使用，并且可以使用每个 case 的 `where` 子句来表达复杂的匹配条件。





## 1.1 For-In 循环

您可以使用 `for` - `in` 循环来迭代序列，例如数组中的项目、数字范围或字符串中的字符。

此示例使用 `for` - `in` 循环来迭代数组中的项目：



```swift
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
// Hello, Anna!
// Hello, Alex!
// Hello, Brian!
// Hello, Jack!

```



您还可以迭代字典来访问其键值对。当迭代字典时，字典中的每个项目都作为 `(key, value)` 元组返回，并且您可以将 `(key, value)` 元组的成员分解为显式命名的常量，以便在 `for` - `in` 循环。在下面的代码示例中，字典的键被分解为名为 `animalName` 的常量，字典的值被分解为名为 `legCount` 的常量。



```swift
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// cats have 4 legs
// ants have 6 legs
// spiders have 8 legs
```



`Dictionary` 的内容本质上是无序的，迭代它们并不能保证检索它们的顺序。特别是，将项目插入 `Dictionary` 的顺序并不定义它们的迭代顺序。有关数组和字典的更多信息，请参阅集合类型。

您还可以使用带有数字范围的 `for` - `in` 循环。此示例打印五次表中的前几个条目：

```swift
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25
```





迭代的序列是从 `1` 到 `5` 的数字范围（包含在内），如使用闭范围运算符 ( `...` ) 所示。 `index` 的值设置为范围内的第一个数字 ( `1` )，并执行循环内的语句。在本例中，循环仅包含一个语句，该语句打印五次表中 `index` 当前值的条目。执行该语句后， `index` 的值将更新为包含范围内的第二个值 ( `2` )，并再次调用 `print(_:separator:terminator:)` 函数。此过程持续进行，直到到达范围的末尾。



在上面的示例中， `index` 是一个常量，其值在循环每次迭代开始时自动设置。因此， `index` 在使用之前不必声明。它只需包含在循环声明中即可隐式声明，无需 `let` 声明关键字。

如果不需要序列中的每个值，可以通过使用下划线代替变量名称来忽略这些值。



```swift
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
// Prints "3 to the power of 10 is 59049"
```



上面的示例计算一个数字的值的另一个数字的幂（在本例中为 `3` 的 `10` 次幂）。它将起始值 `1` （即 `3` 的 `0` 次幂）乘以 `3` 十次，使用以 `1` 开头并以 `10` 结尾的封闭范围。对于此计算，每次循环时都不需要单独的计数器值 - 代码只是执行循环正确的次数。使用下划线字符 ( `_` ) 代替循环变量会导致各个值被忽略，并且在循环的每次迭代期间不提供对当前值的访问。



在某些情况下，您可能不想使用包含两个端点的封闭范围。考虑在表盘上画出每分钟的刻度线。您想要从 `0` 分钟开始绘制 `60` 刻度线。使用半开范围运算符 ( `..<` ) 来包含下限，但不包含上限。有关范围的更多信息，请参阅范围运算符。



```swift
let minutes = 60
for tickMark in 0..<minutes {
    // render the tick mark each minute (60 times)
}
```



上面的示例计算一个数字的值的另一个数字的幂（在本例中为 `3` 的 `10` 次幂）。它将起始值 `1` （即 `3` 的 `0` 次幂）乘以 `3` 十次，使用以 `1` 开头并以 `10` 结尾的封闭范围。对于此计算，每次循环时都不需要单独的计数器值 - 代码只是执行循环正确的次数。使用下划线字符 ( `_` ) 代替循环变量会导致各个值被忽略，并且在循环的每次迭代期间不提供对当前值的访问。
