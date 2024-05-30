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

