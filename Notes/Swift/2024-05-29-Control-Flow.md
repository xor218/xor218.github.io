---
layout: post
author: "大西瓜"
title: "Control Flow 控制流"
date:   2024-05-29 21:08:35 +0800
categories: [update,Swift] 
---



## 1 控制流



Swift 提供了多种控制流语句。其中包括多次执行任务的 `while` 循环； `if` 、 `guard` 和 `switch` 语句根据特定条件执行不同的代码分支；以及诸如 `break` 和 `continue` 之类的语句，将执行流转移到代码中的另一个点。 Swift 提供了 `for` - `in` 循环，可以轻松迭代数组、字典、范围、字符串和其他序列。 Swift 还提供了 `defer` 语句，这些语句包装了离开当前作用域时要执行的代码。



Swift 的 `switch` 语句比许多类 C 语言中的对应语句强大得多。案例可以匹配许多不同的模式，包括区间匹配、元组和特定类型的转换。 `switch` case 中的匹配值可以绑定到临时常量或变量以在 case 主体中使用，并且可以使用每个 case 的 `where` 子句来表达复杂的匹配条件。





### 1.1 For-In 循环

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



在某些情况下，您可能不想使用包含两个端点的封闭范围。考虑在表盘上画出每分钟的刻度线。您想要从 `0` 分钟开始绘制 `60` 刻度线。使用半开范围运算符 ( `..<` ) 来包含下限，但不包含上限。有关范围的更多信息，请参阅范围运算符。



某些用户可能希望用户界面中的刻度线更少。他们可能更喜欢每 `5` 分钟得一分。使用 `stride(from:to:by:)` 函数跳过不需要的标记。

```swift
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
```



通过使用 `stride(from:through:by:)` 也可以使用封闭范围：

```swift
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
}
```





上面的示例使用 `for` - `in` 循环来迭代范围、数组、字典和字符串。但是，您可以使用此语法来迭代任何集合，包括您自己的类和集合类型，只要这些类型符合 `Sequence` 协议即可。





### 2.1 while循环

`while` 循环执行一组语句，直到条件变为 `false` 。当第一次迭代开始之前迭代次数未知时，最好使用此类循环。 Swift 提供了两种 `while` 循环：

- `while` evaluates its condition at the start of each pass through the loop.
  `while` 在每次循环开始时评估其条件。
- `repeat`-`while` evaluates its condition at the end of each pass through the loop.
  `repeat` - `while` 在每次循环结束时评估其条件。



### 2.1.1 While

`while` 循环首先评估单个条件。如果条件为 `true` ，则重复一组语句，直到条件变为 `false` 。

这是 `while` 循环的一般形式：

```swift
while <#condition#> {
   <#statements#>
}
```

```swift
var square = 0
var diceRoll = 0
while square < finalSquare {
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        square += board[square]
    }
}
print("Game over!")
```





### 3.1 Repect-while

类似 C/C++ 里面的do-while

```swift
var tmp:Int = 0

repeat {
    print("Hello Kitty")
}while tmp != 0

```





## 2. 条件语句 

根据某些条件执行不同的代码通常很有用。您可能希望在发生错误时运行一段额外的代码，或者在值变得过高或过低时显示一条消息。为此，您需要将部分代码设置为有条件的。

Swift 提供了两种向代码添加条件分支的方法： `if` 语句和 `switch` 语句。通常，您使用 `if` 语句来评估只有几种可能结果的简单条件。 `switch` 语句更适合具有多种可能排列的更复杂的条件，并且在模式匹配可以帮助选择要执行的适当代码分支的情况下很有用。



### 2.1 if语句

在最简单的形式中， `if` 语句只有一个 `if` 条件。仅当条件为 `true` 时，它才会执行一组语句。

```swift
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// Prints "It's very cold. Consider wearing a scarf."
```

上面的示例检查温度是否小于或等于 32 华氏度（水的冰点）。如果是，则会打印一条消息。否则，不会打印任何消息，并且代码在 `if` 语句的右大括号之后继续执行。

对于 `if` 条件为 `false` 的情况， `if` 语句可以提供一组替代语句，称为 else 子句。这些语句由 `else` 关键字指示。

```swift
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a T-shirt.")
}
// Prints "It's not that cold. Wear a T-shirt."
```

始终执行这两个分支之一。由于温度已升至 `40` 华氏度，不再冷到建议戴围巾，因此会触发 `else` 分支。

您可以将多个 `if` 语句链接在一起以考虑其他子句。

```swift
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a T-shirt.")
}
// Prints "It's really warm. Don't forget to wear sunscreen."
```

此处添加了额外的 `if` 语句以响应特别温暖的温度。最后的 `else` 子句仍然存在，它会打印对任何不太热或太冷的温度的响应。

不过，最后的 `else` 子句是可选的，如果不需要完整的条件集，则可以将其排除。

```swift
temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}
```

由于温度不足以触发 `if` 条件，也不足以触发 `else if` 条件，因此不会打印任何消息。

Swift 提供了 `if` 的简写形式，您可以在设置值时使用。例如，考虑以下代码：

```swift
let temperatureInCelsius = 25
let weatherAdvice: String


if temperatureInCelsius <= 0 {
    weatherAdvice = "It's very cold. Consider wearing a scarf."
} else if temperatureInCelsius >= 30 {
    weatherAdvice = "It's really warm. Don't forget to wear sunscreen."
} else {
    weatherAdvice = "It's not that cold. Wear a T-shirt."
}


print(weatherAdvice)
// Prints "It's not that cold. Wear a T-shirt."
```

在此 `if` 表达式版本中，每个分支包含一个值。如果分支的条件为 true，则该分支的值将用作 `weatherAdvice` 赋值中整个 `if` 表达式的值。每个 `if` 分支都有一个对应的 `else if` 分支或 `else` 分支，确保其中一个分支始终匹配，并且 `if` 表达式始终匹配无论哪些条件成立，都会产生一个值。

由于赋值语法从 `if` 表达式外部开始，因此无需在每个分支内重复 `weatherAdvice =` 。相反， `if` 表达式的每个分支都会为 `weatherAdvice` 生成三个可能值之一，并且赋值将使用该值。

`if` 表达式的所有分支都需要包含相同类型的值。由于 Swift 分别检查每个分支的类型，因此像 `nil` 这样可与多种类型一起使用的值会阻止 Swift 自动确定 `if` 表达式的类型。相反，您需要显式指定类型 - 例如：

```swift
let freezeWarning: String? = if temperatureInCelsius <= 0 {
    "It's below freezing. Watch for ice!"
} else {
    nil
}
```

在上面的代码中， `if` 表达式的一个分支具有字符串值，另一个分支具有 `nil` 值。 `nil` 值可以用作任何可选类型的值，因此您必须明确编写 `freezeWarning` 是可选字符串，如类型注释中所述。



提供此类型信息的另一种方法是为 `nil` 提供显式类型，而不是为 `freezeWarning` 提供显式类型：

```swift
let freezeWarning = if temperatureInCelsius <= 0 {
    "It's below freezing. Watch for ice!"
} else {
    nil as String?
}
```

在上面的代码中， `if` 表达式的一个分支具有字符串值，另一个分支具有 `nil` 值。 `nil` 值可以用作任何可选类型的值，因此您必须明确编写 `freezeWarning` 是可选字符串，如类型注释中所述。

提供此类型信息的另一种方法是为 `nil` 提供显式类型，而不是为 `freezeWarning` 提供显式类型：

```swift
let freezeWarning = if temperatureInCelsius <= 0 {
    "It's below freezing. Watch for ice!"
} else {
    nil as String?
}
```

`if` 表达式可以通过抛出错误或调用像 `fatalError(_:file:line:)` 这样永不返回的函数来响应意外失败。例如：

```swift
let weatherAdvice = if temperatureInCelsius > 100 {
    throw TemperatureError.boiling  //自己定义的类型 
} else {
    "It's a reasonable temperature."
}


//定义错误类型
enum TemperatureError:Error{
  case boiling
  case otherErrorType
}
```

在此示例中， `if` 表达式检查预测温度是否高于 100° C（水的沸点）。如此高的温度会导致 `if` 表达式抛出 `.boiling` 错误，而不是返回文本摘要。尽管此 `if` 表达式可能会引发错误，但您不要在其前面写入 `try` 。有关处理错误的信息，请参阅错误处理。

















## 3. switch

`switch` 语句考虑一个值并将其与几种可能的匹配模式进行比较。然后，它根据第一个成功匹配的模式执行适当的代码块。 `switch` 语句提供了 `if` 语句的替代方案，用于响应多个潜在状态。

在最简单的形式中， `switch` 语句将一个值与一个或多个相同类型的值进行比较。

```swift
switch <#some value to consider#> {
case <#value 1#>:
    <#respond to value 1#>
case <#value 2#>,
    <#value 3#>:
    <#respond to value 2 or 3#>
default:
    <#otherwise, do something else#>
}
```

每个 `switch` 语句都包含多个可能的情况，每个情况都以 `case` 关键字开头。除了与特定值进行比较之外，Swift 还为每种情况提供了多种方法来指定更复杂的匹配模式。这些选项将在本章后面描述。

与 `if` 语句的主体一样，每个 `case` 都是一个单独的代码执行分支。 `switch` 语句确定应选择哪个分支。此过程称为打开正在考虑的值。

每个 `switch` 语句必须详尽无遗。也就是说，所考虑的类型的每个可能值都必须与 `switch` 情况之一匹配。如果不适合为每个可能的值提供一个案例，您可以定义一个默认案例来覆盖任何未明确解决的值。此默认情况由 `default` 关键字指示，并且必须始终出现在最后。

此示例使用 `switch` 语句来考虑名为 `someCharacter` 的单个小写字符：

```swift
let someCharacter: Character = "z"
switch someCharacter {
case "a","b":
    print("The first letter of the Latin alphabet")
case "z":
    print("The last letter of the Latin alphabet")
default:
    print("Some other character")
}
```

`switch` 语句的第一个大小写匹配英文字母表的第一个字母 `a` ，第二个大小写匹配最后一个字母 `z` 。由于 `switch` 必须为每个可能的字符（而不仅仅是每个字母字符）区分大小写，因此此 `switch` 语句使用 `default` 大小写来匹配除 < 之外的所有字符b6> 和 `z` 。此规定确保 `switch` 声明是详尽无遗的。

与 `if` 语句一样， `switch` 语句也有表达式形式：

```swift
let anotherCharacter: Character = "a"
let message = switch anotherCharacter {
case "a":
    "The first letter of the Latin alphabet"
case "z":
    "The last letter of the Latin alphabet"
default:
    "Some other character"
}


print(message)
// Prints "The first letter of the Latin alphabet"
```


在此示例中， switch 表达式中的每个 case 都包含当该 case 与 anotherCharacter 匹配时要使用的 message 值。因为 switch 总是详尽的，所以总是有一个值要分配。
与 if 表达式一样，您可以抛出错误或调用类似 fatalError(_:file:line:) 的函数，该函数永远不会返回，而不是为给定情况提供值。您可以在赋值的右侧使用 switch 表达式，如上例所示，并将其作为函数或闭包返回的值。







### 3.1 不需要break

与 C 和 Objective-C 中的 `switch` 语句相比，Swift 中的 `switch` 语句默认不会落入每个 case 的底部并进入下一个 case。相反，一旦第一个匹配的 `switch` 案例完成，整个 `switch` 语句就会完成执行，而不需要显式的 `break` 语句。这使得 `switch` 语句比 C 语言中的语句更安全、更易于使用，并避免错误执行多个 `switch` 情况。

> **Note:**尽管 Swift 中不需要 `break` ，但您可以使用 `break` 语句来匹配并忽略特定情况，或者在该情况完成执行之前打破匹配的情况。有关详细信息，请参阅 Switch 语句中的 Break。





每个案例的主体必须至少包含一个可执行语句。编写以下代码是无效的，因为第一个 case 是空的：

```swift
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a": // Invalid, the case has an empty body
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// This will report a compile-time error.
```



与 C 中的 `switch` 语句不同，此 `switch` 语句不匹配 `"a"` 和 `"A"` 。相反，它报告一个编译时错误，即 `case "a":` 不包含任何可执行语句。这种方法可以避免从一种情况意外转移到另一种情况，并使代码更安全、意图更清晰。



要使用与 `"a"` 和 `"A"` 匹配的单一大小写创建 `switch` ，请将两个值组合成一个复合大小写，并用逗号分隔这些值。

```swift
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// Prints "The letter A"
```



### 3.2  区间拼配

可以检查 `switch` 情况下的值是否包含在某个区间中。此示例使用数字间隔为任意大小的数字提供自然语言计数：

```swift
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// Prints "There are dozens of moons orbiting Saturn."
```

在上面的示例中， `approximateCount` 在 `switch` 语句中进行计算。每个 `case` 将该值与数字或间隔进行比较。由于 `approximateCount` 的值介于 12 和 100 之间，因此 `naturalCount` 被赋予值 `"dozens of"` ，并且执行转移出 `switch` 陈述。



###  3.3 元祖(Tuple)

您可以使用元组来测试同一 `switch` 语句中的多个值。可以针对不同的值或值区间来测试元组的每个元素。或者，使用下划线字符 ( `_` )（也称为通配符模式）来匹配任何可能的值。

下面的示例采用 (x, y) 点，表示为 `(Int, Int)` 类型的简单元组，并将其在示例后面的图表上进行分类。



```swift
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// Prints "(1, 1) is inside the box"
```







![](https://docs.swift.org/swift-book/images/coordinateGraphSimple@2x.png)



`switch` 语句确定该点是否位于原点 (0, 0)、红色 x 轴、绿色 y 轴、以原点为中心的蓝色 4×4 框内，或在盒子外面。



> **Note**与 C 不同，Swift 允许多个 `switch` 情况考虑相同的值。事实上，点 (0, 0) 可以匹配本例中的所有四种情况。但是，如果可以进行多个匹配，则始终使用第一个匹配情况。点 (0, 0) 将首先匹配 `case (0, 0)` ，因此所有其他匹配情况将被忽略。





### 3.4 值绑定



`switch` 案例可以命名与临时常量或变量匹配的一个或多个值，以便在案例主体中使用。这种行为称为值绑定，因为值绑定到案例主体内的临时常量或变量。

下面的示例采用 (x, y) 点，表示为 `(Int, Int)` 类型的元组，并将其在下面的图表中进行分类：

```swift
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):  //没有default:匹配默认值
    print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with an x value of 2"
```





<img src="https://docs.swift.org/swift-book/images/coordinateGraphMedium@2x.png" width="500">





`switch` 语句确定该点是否位于红色 x 轴、绿色 y 轴或其他位置（两个轴上）。

三种 `switch` 情况声明占位符常量 `x` 和 `y` ，它们临时采用 `anotherPoint` 中的一个或两个元组值。第一种情况 `case (let x, 0)` 匹配任何 `y` 值为 `0` 的点，并将该点的 `x` 值分配给临时常量 < b8> 。类似地，第二种情况 `case (0, let y)` 匹配任何 `x` 值为 `0` 的点，并将该点的 `y` 值分配给临时对象。常量 `y` 。



声明临时常量后，可以在 case 的代码块中使用它们。在这里，它们用于打印点的分类。

此 `switch` 语句没有 `default` 大小写。最后一种情况 `case let (x, y)` 声明一个由两个可以匹配任何值的占位符常量组成的元组。由于 `anotherPoint` 始终是两个值的元组，因此这种情况会匹配所有可能的剩余值，并且不需要 `default` 情况来使 `switch` 语句详尽无遗。





### 3.5 sitch中的where

`switch` 案例可以使用 `where` 子句来检查附加条件。

下面的示例对下图上的 (x, y) 点进行分类：`

```swift
let yetAntherPointe = (1,-1)
switch yetAntherPointe{
case let(x,y) where x == y:  ///替代if
    print("\(x),\(y) on the line x == y")
    
case let(x,y) where x == -y:
    print("\(x) \(y) on the line x == -y")

case let(x,y): /// 匹配默认的 //使用default不可以用x y
    print("\(x) \(y) is just some arbitary point")

}

```



<img src="https://docs.swift.org/swift-book/images/coordinateGraphComplex@2x.png" width="500">

该 `switch` 语句确定该点是否位于绿色对角线上，其中 `x == y` ，在紫色对角线上， `x == -y` 或两者都不是。

这三种 `switch` 情况声明占 `x` 位符常量 和 `y` ，它们暂时采用 中 `yetAnotherPoint` 的两个元组值。这些常量用作 `where` 子句的一部分，以创建动态筛选器。仅当 `where` 子句的条件计算结果 `true` 为该值时， `switch` 大小写才与当前 `point` 值匹配。





## 4. 控制转移表达式

控件传输语句通过将控制从一段代码转移到另一段代码来更改代码的执行顺序。Swift 有五种控制权转移语句：

- `continue`
- `break`
- `fallthrough`
- `return`
- `throw`

`continue` 下面介绍了 、 `break` 和 `fallthrough` 语句。该 `return` 语句在函数中描述，该 `throw` 语句在使用抛出函数传播错误中描述。

### 4.1 Continue

该 `continue` 语句告诉循环停止它正在做的事情，并在循环的下一次迭代开始时重新开始。它说“我已经完成了当前的循环迭代”，而没有完全离开循环。

以下示例从小写字符串中删除所有元音和空格，以创建一个神秘的拼图短语：

```swift
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)
// Prints "grtmndsthnklk"
```

上面的代码在关键字与元音或空格匹配时调用该 `continue` 关键字，导致循环的当前迭代立即结束并直接跳转到下一个迭代的开始。



### 4.2 break

该 `break` 语句立即结束整个控制流语句的执行。当您希望提前终止 `switch` or loop 语句的执行时，可以在 `switch` or 循环语句中使用该 `break` 语句。



#### 4.2.1 break in switch 

在 `switch` 语句中使用时，使 `switch` 语句立即结束其执行， `break` 并在 `switch` 语句的右大括号 （ `}` ） 之后将控制权转移给代码。

此行为可用于匹配和忽略 `switch` 语句中的一个或多个事例。因为 Swift `switch` 的声明是详尽的，不允许空案例，所以有时有必要故意匹配和忽略案例，以明确你的意图。为此，您将语 `break` 句编写为要忽略的案例的整个正文。当该案例与 `switch` 语句匹配时，案例中的 `break` 语句将立即结束 `switch` 该语句的执行。

下面的示例打开一个 `Character` 值，并确定它是否表示四种语言之一的数字符号。为简洁起见，在单个 `switch` 案例中涵盖多个值。

```swift
let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue { //可选绑定
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value couldn't be found for \(numberSymbol).")
}
// Prints "The integer value of 三 is 3."
```



本示例检查 `numberSymbol` 数字 `1` 是 `4` 拉丁文、阿拉伯文、中文符号还是泰文符号。如果找到匹配项，则语 `switch` 句的其中一个用例将调用 `possibleIntegerValue` 的可选 `Int?` 变量设置为适当的整数值。



语 `switch` 句完成执行后，该示例使用可选绑定来确定是否找到了值。由于 `possibleIntegerValue` 该变量是可选类型，因此该变量具有隐 `nil` 式初始值，因此仅当 `switch` 语句的前四种情况之一设置为实际值时 `possibleIntegerValue` ，可选绑定才会成功。



由于在上面的示例中列出每个可能的 `Character` 值是不切实际的 `default` ，因此事例会处理任何不匹配的字符。此 `default` 案例不需要执行任何操作，因此它是以单个 `break` 语句作为其正文编写的。匹配 `default` 大小写后， `break` 语句将结束 `switch` 语句的执行，并且代码从语 `if let` 句继续执行。





### 4.2.2 Fallthrough

**switch中跳入下一个case** 

在 Swift 中， `switch` 语句不会从每个案例的底部落入下一个案例。也就是说，一旦第一个匹配案例完成，整个 `switch` 语句就会完成其执行。相比之下，C 要求您在每个 `switch` 事例的末尾插入一个显 `break` 式语句，以防止失败。避免默认失败意味着 Swift `switch` 语句比 C 语言中的对应语句更加简洁和可预测，因此它们避免了错误地执行多个 `switch` 案例。

如果需要 C 样式的下降行为，则可以使用 `fallthrough` 关键字根据具体情况选择加入此行为。下面的示例用于 `fallthrough` 创建数字的文本描述。

```swift
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// Prints "The number 5 is a prime number, and also an integer."
```

此示例声明一个名为的新 `String` `description` 变量，并为其分配一个初始值。然后，该函数考虑使用 `switch` 语句的 `integerToDescribe` 值。如果 的 `integerToDescribe` 值是列表中的质数之一，则该函数会将文本附加到 `description` 的末尾，以表示该数字是质数。然后，它使用 `fallthrough` 关键字也“陷入” `default` 案例。案例 `default` 在描述的末尾添加了一些额外的文本， `switch` 并且语句就完成了。

非 的 `integerToDescribe` 值在已知素数列表中，否则它与第一种 `switch` 情况根本不匹配。因为没有其他具体案例， `integerToDescribe` 所以是案例 `default` 匹配的。

`separator:terminator:)` function. In this example, the number `5` is correctly identified as a prime number.

`switch` 语句执行完毕后，将使用该 `print(_:separator:terminator:)` 函数打印数字的描述。在此示例中，该数字 `5` 被正确标识为质数。



> **Note**
>
> `separator:terminator:)` function. In this example, the number `5` is correctly identified as a prime number.
> `switch` 语句执行完毕后，将使用该 `print(_:separator:terminator:)` 函数打印数字的描述。在此示例中，该数字 `5` 被正确标识为质数。 

在 Swift 中，`fallthrough` 关键字用于在 `switch` 语句的一个 case 执行完毕后，继续执行下一个 case 的代码，而不进行条件检查。这与其他语言中的 `switch` 语句有些不同，例如在 C 和 C++ 中，case 之间的代码会自动落入（fallthrough），而在 Swift 中默认情况下每个 case 是独立的，需要显式使用 `fallthrough` 来继续执行下一个 case。

**示例代码**

以下是一个简单的示例，展示了如何使用 `fallthrough`：

```swift
let number = 2

switch number {
case 1:
    print("One")
case 2:
    print("Two")
    fallthrough
case 3:
    print("Three")
default:
    print("Other")
}
```

**输出结果**

运行上述代码会输出：

```
Two
Three
```

 **解释**

1. 当 `number` 等于 2 时，进入 `case 2`，打印 "Two"。
2. 使用 `fallthrough`，所以会继续执行下一个 `case`，即 `case 3`，打印 "Three"。
3. 不会跳到 `default` 部分，因为 `fallthrough` 只会继续执行下一个 `case`，而不会跳到 `default`，除非下一个 `case` 正好是 `default`。

**`fallthrough` 不跳到 `default`**

值得注意的是，`fallthrough` 关键字只是单纯地继续执行下一个 `case` 的代码块，并不会跳到 `default` 除非它紧接在下一个 `case` 之后。例如：

```swift
let number = 3

switch number {
case 1:
    print("One")
case 2:
    print("Two")
    fallthrough
case 3:
    print("Three")
    fallthrough
default:
    print("Other")
}
```

**输出结果**

运行上述代码会输出：

```
Three
Other
```





## 5. 标记语句

在 Swift 中，您可以将循环和条件语句嵌套在其他循环和条件语句中，以创建复杂的控制流结构。但是，循环和条件语句都可以使用语 `break` 句过早结束其执行。因此，有时明确说明您希望语 `break` 句终止哪个循环或条件语句会很有用。同样，如果有多个嵌套循环，则明确 `continue` 语句应影响哪个循环会很有用。

要实现这些目标，可以使用语句标签标记循环语句或条件语句。对于条件语句，可以将语句标签与 `break` 语句一起使用，以结束标记语句的执行。使用循环语句时，可以使用带有 `break` or `continue` 语句的语句标签来结束或继续执行带标签的语句。

标记语句的指示方式是将标签放在语句的介绍人关键字的同一行上，后跟冒号。下面是 `while` 循环的这种语法的示例，尽管所有循环和 `switch` 语句的原理都是相同的：

```swift
<#label name#>: while <#condition#> {
   <#statements#>
}
```

以下示例使用带有标记 `while` 循环的 `break` and `continue` 语句，用于您在本章前面看到的 Snakes and Ladders 游戏的改编版本。这一次，游戏有一个额外的规则：

要获胜，您必须正好降落在 25 号方格上。

如果一个特定的骰子掷出会让你超过25格，你必须再次掷骰子，直到你掷出落在25格所需的确切数字。

游戏板和以前一样。

<img src="https://docs.swift.org/swift-book/images/snakesAndLadders@2x.png" width="600">

`board` 、 `square` 、 和 `diceRoll` 的 `finalSquare` 值的初始化方式与之前相同：

这个版本的游戏使用循环 `while` 和 `switch` 语句来实现游戏的逻辑。该 `while` 循环有一个声明 `gameLoop` 标签，用于指示它是 Snakes and Ladders 游戏的主要游戏循环。

循环 `while` 的条件是 `while square != finalSquare` ，以反映您必须正好落在方格 25 上。

```swift
gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")
```

骰子在每个循环开始时掷骰子。循环不是立即移动玩家，而是使用语 `switch` 句来考虑移动的结果并确定是否允许移动：

如果掷骰子将玩家移动到最后一个方格，则游戏结束。该 `break gameLoop` 语句将控制权转移到 `while` 循环外的第一行代码，从而结束游戏。

如果掷骰子会使玩家超出最后一个方格，则该移动无效，玩家需要再次掷骰子。该 `continue gameLoop` 语句结束当前 `while` 循环迭代并开始循环的下一次迭代。

所有其他情况下，掷骰子都是有效的举动。玩家按 `diceRoll` 方格向前移动，游戏逻辑检查是否有任何蛇和梯子。然后循环结束，控制返回到 `while` 条件以决定是否需要再转一圈。

> **Note** :如果上面的 `break` 语句没有使用标签， `gameLoop` 它将从 `switch` 语句中分离出来，而不是 `while` 从语句中分离出来。使用标签 `gameLoop` 可以清楚地说明应终止哪个控制语句。
>
> 在调用 `continue gameLoop` 以跳转到循环的下一次迭代时，严格来说没有必要使用标签 `gameLoop` 。游戏中只有一个循环，因此对于该 `continue` 语句将影响哪个循环没有歧义。但是，将 `gameLoop` 标签与 `continue` 语句一起使用并没有什么坏处。这样做与 `break` 标签在声明旁边的使用是一致的，并有助于使游戏的逻辑更清晰易读和理解。





## 6. guard语句

在 Swift 中，guard 语句用于提前退出代码块，它的主要目的是提高代码的可读性和简洁性。guard 语句必须确保在条件为 false 时通过某种方式退出当前的代码块。这通常通过 return、break、continue 或 throw 来实现。

**1. 基本用法**

guard 语句必须伴随一个控制转移语句，以确保在条件不满足时，代码能够退出当前作用域：

```swift
func someFunction() {
    guard someCondition else {
        return
    }
    // 这里是 someCondition 为 true 时的代码
}
```

**2. 控制转移语句**

guard 语句中可以使用的控制转移语句包括：

​	**•	return：用于函数或方法中，退出当前函数。**

​	**•	break：用于循环或 switch 语句中，退出循环或 switch。**

​	**•	continue：用于循环中，跳过当前迭代，继续下一次循环。**

​	**•	throw：用于抛出错误。**

**示例代码**

**使用 return 退出函数**

```swift
func checkAge(_ age: Int) {
    guard age >= 18 else {
        print("You must be at least 18 years old.")
        return
    }
    print("You are allowed to enter.")
}
```

**使用 break 退出循环**

```swift
for number in 1...5 {
    guard number != 3 else {
        print("Number is 3, breaking the loop.")
        break
    }
    print("Number is \(number)")
}
```

**使用 continue 跳过循环迭代**

```swfit
for number in 1...5 {
    guard number % 2 == 0 else {
        continue
    }
    print("\(number) is even")
}
```

**使用 throw 抛出错误**

```swfit
enum LoginError: Error {
    case invalidCredentials
}

func login(username: String, password: String) throws {
    guard username == "admin" && password == "1234" else {
        throw LoginError.invalidCredentials
    }
    print("Login successful")
}
```

**3. 不带控制转移语句的 guard 是无效的**

如果 guard 语句中没有控制转移语句，编译器会报错。例如，以下代码是无效的：

```swift
func invalidGuard() {
    guard someCondition else {
        // 没有控制转移语句，这将导致编译错误
    }
    // 这里是 someCondition 为 true 时的代码
}
```

**总结**

在 Swift 中，guard 语句必须包含一个控制转移语句，以确保在条件不满足时能够退出当前作用域。这样可以提高代码的可读性和可维护性，使得代码逻辑更加清晰。





## 7. defer延期操作

与控制流构造（如 `if` 和 `while` ）不同，它允许您控制是否执行部分代码或执行多少次代码， `defer` 它控制一段代码的执行时间。您可以使用块 `defer` 编写代码，当程序到达当前作用域的末尾时，这些代码将在稍后执行。例如：

```swift
var score = 1
if score < 10 {
    defer {
        print(score)
    }
    score += 5
}
// Prints "6"
```

在上面的示例中，块内部 `defer` 的代码在退出 `if` 语句主体之前执行。首先， `if` 语句中的代码运行，该代码以 5 递增 `score` 。然后，在退出 `if` 语句的作用域之前，运行延迟代码，该代码将 `score` 打印 .

无论程序如何退出该范围，始终运行 其中的 `defer` 代码。这包括提前退出函数、中断 `for` 循环或抛出错误等代码。此行为对于需要保证一对操作发生的操作（如手动分配和释放内存、打开和关闭低级文件描述符以及在数据库中开始和结束事务）非常 `defer` 有用，因为您可以在代码中将这两个操作并排编写。

例如，以下代码通过在代码块中加减 100 来临时奖励分数：

```swift
var score = 3
if score < 100 {
    score += 100
    defer {
        score -= 100
    }
    // Other code that uses the score with its bonus goes here.
    print(score)
}
// Prints "103"
```

如果在同一作用域中写入多个 `defer` 块，则指定的第一个块是要运行的最后一个块。

```swift
if score < 10 {
    defer {
        print(score)
    }
    defer {
        print("The score is:")
    }
    score += 5
}
// Prints "The score is:"
// Prints "6"
```

如果程序停止运行（例如，由于运行时错误或崩溃），则延迟代码不会执行。但是，延迟代码在引发错误后会执行;有关使用 `defer` 错误处理的信息，请参阅指定清理操作。





## 8. 检查API的可用性

Swift 内置了对检查 API 可用性的支持，可确保你不会意外地使用在给定部署目标上不可用的 API。

编译器使用 SDK 中的可用性信息来验证代码中使用的所有 API 是否在项目指定的部署目标上可用。如果您尝试使用不可用的 API，Swift 会在编译时报告错误。

您可以在 `if` or `guard` 语句中使用可用性条件有条件地执行代码块，具体取决于要使用的 API 在运行时是否可用。编译器在验证该代码块中的 API 是否可用时，使用可用性条件中的信息。

```swift
if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}
```



**guard**

```swift
guard #available(iOS 14 , *) else{
    print("unavailbale on this platfrom")
}

```



上面的可用性条件指定在 iOS 中， `if` 语句的主体仅在 iOS 10 及更高版本中执行;在 macOS 中，仅在 macOS 10.12 及更高版本中。最后一个参数 `*` 是必需的，它指定在任何其他平台上，主体在目标指定的最小部署目标上 `if` 执行。



在其一般形式中，可用性条件采用平台名称和版本的列表。您可以使用平台名称，例如 `iOS` 、 `macOS` 、 `watchOS` 和 `tvOS` — 有关完整列表，请参阅声明属性。除了指定 iOS 8 或 macOS 10.10 等主要版本号外，您还可以指定 iOS 11.2.6 和 macOS 10.13.3 等次要版本号。



```swift
if #available(<#platform name#> <#version#>, <#...#>, *) {
    <#statements to execute if the APIs are available#>
} else {
    <#fallback statements to execute if the APIs are unavailable#>
}
```



当您将可用性条件与 `guard` 语句一起使用时，它会优化用于该代码块中其余代码的可用性信息。

```swift

@available(macOS 10.12, *)
struct ColorPreference {
    var bestColor = "blue"
}


func chooseBestColor() -> String {
    guard #available(macOS 10.12, *) else {
       return "gray"
    }
    let colors = ColorPreference()
    return colors.bestColor
}
```

在上面的示例中，该 `ColorPreference` 结构需要 macOS 10.12 或更高版本。该 `chooseBestColor()` 函数从可用性防护开始。如果平台版本太旧而无法使用 `ColorPreference` ，它会回退到始终可用的行为。在 `guard` 语句之后，您可以使用需要 macOS 10.12 或更高版本的 API。

除了 `#available` ，Swift 还支持使用不可用条件的相反检查。例如，以下两个检查执行相同的操作：

```swift
if #available(iOS 10, *) {
} else {
    // Fallback code
}


if #unavailable(iOS 10) {
    // Fallback code
}

//if #unavailable(macOS 17.12){
//    print("Unsuppost on macOS 17.12")
//}

```

当检查仅包含回退代码时，使用表 `#unavailable` 单有助于使代码更具可读性。
