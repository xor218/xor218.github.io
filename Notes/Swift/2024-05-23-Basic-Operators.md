---
layout: post
author: "大西瓜"
title: "Basic Operators"
date:   2024-05-23 15:50:02 +0800
categories: [update,Swift] 
---


## 1.基本操作

运算符是用于检查、更改或联合收割机值的特殊符号或短语。例如，加法运算符（ + ）将两个数字相加，如 let i = 1 + 2 中所示，而逻辑AND运算符（ && ）将两个布尔值合并，如 if enteredDoorCode && passedRetinaScan 中所示。


Swift支持您可能已经从C等语言中了解到的运算符，并改进了几个功能以消除常见的编码错误。赋值运算符（ = ）不返回值，以防止在打算使用等于运算符（ == ）时错误地使用它。算术运算符（ + 、 - 、 * 、 / 、 % 等）检测并禁止值溢出，以避免在处理大于或小于存储它们的类型的允许值范围的数字时出现意外结果。

您可以通过使用Swift的溢出运算符来选择值溢出行为，如溢出运算符中所述。


Swift还提供了C中没有的范围运算符，例如 a..<b 和 a...b ，作为表达值范围的快捷方式。


本章介绍Swift中的常用运算符。高级运算符涵盖了Swift的高级运算符，并描述了如何定义自己的自定义运算符以及为自己的自定义类型实现标准运算符。

## 1.2 术语i

运算符可以是一元、二元或三元：

一元运算符对单个目标进行操作（例如 -a ）。一元前缀运算符出现在目标之前（如 !b ），一元后缀运算符出现在目标之后（如 c! ）。
二元运算符作用于两个目标（例如 2 + 3 ），并且是中缀，因为它们出现在两个目标之间。
三进制运算符对三个目标进行运算。和C一样，Swift只有一个三元运算符，即三元条件运算符（ a ? b : c ）。

运算符影响的值是操作数。在表达式 1 + 2 中， + 符号是中缀运算符，其两个操作数是值 1 和 2 。



## 1.3 赋值运算符

赋值运算符（ a = b ）使用 b 的值更新 a 的值：
```swift
let b = 10
var a = 5
a = b
// a is now equal to 10
```

如果赋值的右边是一个有多个值的元组，它的元素可以一次分解为多个常量或变量：
```swift
let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2
```

与C和JavaScript-C中的赋值运算符不同，Swift中的赋值运算符本身并不返回值。以下语句无效：

```swift
if x = y {
    // This isn't valid, because x = y doesn't return a value.
    //表达式返回无效
}
```
此功能可防止赋值运算符（ = ）在实际使用等于运算符（ == ）时意外使用。通过使 if x = y 无效，Swift可以帮助您避免代码中的此类错误。


## 1.4 算数运算符

Swift支持所有数字类型的四个标准算术运算符：

```swift
1 + 2       // equals 3
5 - 3       // equals 2
2 * 3       // equals 6
10.0 / 2.5  // equals 4.0
```

与 C 和 Objective-C 中的算术运算符不同，Swift 算术运算符默认不允许值溢出。您可以选择使用 **Swift 的溢出运算符（例如 a &+ b ）**来评估溢出行为。请参阅溢出运算符。


String 连接也支持加法运算符：
```swift
"hello, " + "world"  // equals "hello, world"
```


## 1.4 余数运算符
余数运算符 ( a % b ) 计算出 b 的倍数可以容纳在 a 中，并返回剩下的值（称为余数）。

以下是余数运算符的工作原理。要计算 9 % 4 ，您首先要计算出 9 内可以容纳多少个 4 ：
![图片](https://docs.swift.org/swift-book/images/remainderInteger@2x.png)

您可以在 9 内放入两个 4 ，剩下的就是 1 （以橙色显示）。
在 Swift 中，这可以写成：

```swift
9 % 4    // equals 1
```


计算负值 a 的余数时应用相同的方法： 
会忽略第二的符号 加或者减
```

9 % 4   // 1
-9 % 4  // -1 
9 % -4  // 1 
-9 % -4  // -1

```

## 1.5 一元减运算符

可以使用前缀 - 切换数值的符号，称为一元减运算符：

```swift
let three = 3
let minusThree = -three       // minusThree equals -3
let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
```
一元减号运算符 ( - ) 直接添加到其所操作的值之前，没有任何空格。

## 1.6 一元加运算符
一元加运算符 ( + ) 仅返回其运算的值，不做任何更改：
```swift
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix equals -6
```

尽管一元加运算符实际上不执行任何操作，但在对负数使用一元减运算符时，您可以使用它在代码中为正数提供对称性。



### 1.7 复合赋值运算符

与 C 一样，Swift 提供了复合赋值运算符，将赋值 ( = ) 与另一个操作结合起来。一个例子是加法赋值运算符 ( += )：
```swift
var a = 1
a += 2
```
表达式 a += 2 是 a = a + 2 的简写。实际上，加法和赋值被合并到一个运算符中，同时执行这两项任务。



### 1.8 比较运算符

Swift 支持以下比较运算符：

Equal to (a == b)
Not equal to (a != b)
Greater than (a > b)
Less than (a < b)
Greater than or equal to (a >= b)
Less than or equal to (a <= b)


**Note**:
Swift 还提供了两个标识运算符（ === 和 !== ），您可以使用它们来测试两个对象引用是否都引用同一个对象实例。有关更多信息，请参阅身份运算符。

比较运算符常用于条件语句中，例如 if 语句：
```swift
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// Prints "hello, world", because name is indeed equal to "world".
```


如果两个元组具有相同的类型和相同的值数量，则可以比较它们。元组从左到右进行比较，一次比较一个值，直到比较发现两个不相等的值。
比较这两个值，比较的结果决定元组比较的总体结果。如果所有元素都相等，则元组本身也相等。例如：
```swift
(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" aren't compared
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
```

在上面的示例中，您可以在第一行看到从左到右的比较行为。由于 1 小于 2 ，因此 (1, "zebra") 被视为小于 (2, "apple") ，无论元组中的任何其他值如何。 "zebra" 不小于 "apple" 并不重要，因为比较已经由元组的第一个元素确定。然而，当元组的第一个元素相同时，会比较它们的第二个元素——这就是第二行和第三行发生的情况。


仅当运算符可以应用于相应元组中的每个值时，元组才能与给定运算符进行比较。例如，如下面的代码所示，您可以比较 (String, Int) 类型的两个元组，因为 String 和 Int 值都可以使用 < 运算符。相反， (String, Bool) 类型的两个元组无法与 < 运算符进行比较，因为 < 运算符无法应用于 Bool

```swift
("blue", -1) < ("purple", 1)        // OK, evaluates to true
("blue", false) < ("purple", true)  // Error because < can't compare Boolean values
```





### 1.9 三元条件运算符

三元条件运算符是一个特殊的运算符，由三个部分组成，其形式为 question ? answer1 : answer2 。这是根据 question 是 true 还是 false 来评估两个表达式之一的快捷方式。如果 question 为 true，则计算 answer1 并返回其值；否则，它评估 answer2 并返回其值。

三元条件运算符是以下代码的简写：

```swift
if question {
    answer1
} else {
    answer2
}
```


这是一个计算表格行高度的示例。如果行有标题，则行高应比内容高度高 50 点；如果行没有标题，则行高应高 20 点

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to 90

``` 
上面的例子是下面代码的简写：
```swift
let contentHeight = 40
let hasHeader = true
let rowHeight: Int
if hasHeader {
    rowHeight = contentHeight + 50
} else {
    rowHeight = contentHeight + 20
}
// rowHeight is equal to 90
```
第一个示例使用三元条件运算符意味着可以在一行代码中将 rowHeight 设置为正确的值，这比第二个示例中使用的代码更简洁。
三元条件运算符提供了一种有效的速记方式来决定考虑两个表达式中的哪一个。但是，请谨慎使用三元条件运算符。如果过度使用，它的简洁性可能会导致代码难以阅读。
避免将三元条件运算符的多个实例组合到一个复合语句中。




### 1.10 nil零合并运算符

零合并运算符运算符 ( **a ?? b** ) 如果可选类型 a 包含值，则会解包它；如果 a 则返回默认值 b 是 nil 。表达式 a 始终是可选类型。表达式 b 必须与 a 中存储的类型匹配。

零合并运算符是以下代码的简写：

```swift
a != nil ? a! : b
```
**Note:**如果 a 的值不是 nil ，则不计算 b 的值。这称为短路评估。

下面的示例使用 nil-coalescing 运算符在默认颜色名称和可选的用户定义颜色名称之间进行选择：
```swift
let defaultColorName = "red"            //default type:String
var userDefinedColorName: String?        // defaults to nil 
var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"
```
userDefinedColorName 变量定义为可选 String ，默认值为 nil 。由于 userDefinedColorName 是可选类型，因此可以使用 nil-coalescing 运算符来考虑其值。在上面的示例中，运算符用于确定名为 colorNameToUse 的 String 变量的初始值。因为 userDefinedColorName 是 nil ，所以表达式 userDefinedColorName ?? defaultColorName 返回 defaultColorName 或 "red" 的值。

如果将非 nil 值分配给 userDefinedColorName 并再次执行 nil-coalescing 运算符检查，则使用 userDefinedColorName 中包装的值而不是默认值：

```swift
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName isn't nil, so colorNameToUse is set to "green"
```

### 1.11 范围运算符
Swift 包含多个范围运算符，它们是表达值范围的快捷方式。

#### 1.11.1 封闭范围操作员

*** a...b ***包括b

闭范围运算符 ( a...b ) 定义从 a 到 b 的范围，并包含值 a 和 b 。 a 的值不得大于 b 。
当您希望使用所有值的范围进行迭代时（例如使用 for - in 循环），闭范围运算符非常有用：

```swift
for x in 1...10{
    for y in 1...x{
        print("\(x) * \(y) = \(x * y) ",terminator:" ")
    }
}
```

#### 1.11.2 半开范围的操作

*** a..<b ***不包括b



半开范围运算符 ( **a..<b** ) 定义从 a 到 b 的范围，但不包括 b 。之所以说它是半开的，是因为它包含它的第一个值，但不包含它的最终值。与闭范围运算符一样，** a 的值不得大于 b 。如果 a 的值等于 b ，则结果范围将为空。**

```swift
let name = ["anna","Alex","Brain","Jack"]
let count = name.count
for i in 0..<count{
    print("person \(i+1) is Called \(name[i])")
}
```

### 1.11.3 单边范围
对于在一个方向上尽可能连续的范围，闭范围运算符有一种替代形式 - 例如，包括数组中从索引 2 到数组末尾的所有元素的范围。

在这些情况下，您可以省略范围运算符一侧的值。这种范围称为单侧范围，因为运算符仅在一侧有值。例如：

```swift
let names = ["anna","Alex","Brain","Jack"]
for name in names[2...]{
    print(name)
}

//output:
//Brain
//Jack

for name in names[...2] {
    print(name)
}
//output:
//anna   
//Alex
//Brain
```

半开范围运算符还有一种单边形式，仅用其最终值来编写。就像在两边都包含一个值一样，最终值不属于该范围。例如：

```swift
for name in names[..<2] {
    print(name)
}
// Anna
// Alex
```

单边范围可以在其他上下文中使用，而不仅仅是在下标中。您无法迭代省略第一个值的单边范围，因为不清楚迭代应该从哪里开始。您可以迭代忽略其最终值的单边范围；但是，由于范围无限期地延续，因此请确保为循环添加显式结束条件。您还可以检查单边范围是否包含特定值，如下面的代码所示。

```swift
let range = ...5
range.contains(7)   //false
range.contains(4)   //true
range.contains(-1)  //true
```


## 1.7 逻辑运算符

逻辑运算符修改或组合布尔逻辑值 true 和 false 。 Swift 支持基于 C 的语言中的三种标准逻辑运算符：

- 逻辑非 **!a**
- 逻辑与 **a && b** 
- 逻辑或 **a || b**

### 1.7.1 逻辑非运算符

逻辑 NOT 运算符 ( !a ) 反转布尔值，使 true 变为 false ，并且 false 变为 true .

逻辑 NOT 运算符是前缀运算符，紧邻其运算值之前出现，没有任何空格。它可以读作“not a ”，如下例所示：

```swift
let allowEntry = false
if !allowEntry{
    print("Acess Denied")
}
```

短语 if !allowedEntry 可以理解为“如果不允许进入”。仅当“不允许进入”为 true 时才执行后续行；也就是说，如果 allowedEntry 是 false 。

如本示例所示，仔细选择布尔常量和变量名称有助于保持代码的可读性和简洁性，同时避免双重否定或令人困惑的逻辑语句。

### 1.7.2 逻辑与运算符

逻辑 AND 运算符 ( a && b ) 创建逻辑表达式，其中两个值都必须为 true ，以使整个表达式也为 true 。

如果任一值为 false ，则整体表达式也将为 false 。事实上，如果第一个值是 false ，则甚至不会计算第二个值，因为它不可能使整个表达式等于 true 。这称为短路评估。

此示例考虑两个 Bool 值，并且仅当两个值都是 true 时才允许访问：


```swift
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"
```

### 1.7.3 逻辑或运算符


逻辑 OR 运算符 ( a || b ) 是由两个相邻管道字符组成的中缀运算符。您可以使用它来创建逻辑表达式，其中只有两个值之一必须为 true 才能使整个表达式为 true 。

与上面的逻辑 AND 运算符类似，逻辑 OR 运算符使用短路求值来考虑其表达式。如果逻辑 OR 表达式的左侧是 true ，则不会计算右侧，因为它无法更改整个表达式的结果。

在下面的示例中，第一个 Bool 值 ( hasDoorKey ) 是 false ，但第二个值 ( knowsOverridePassword ) 是 true 。由于一个值​​为 true ，整个表达式的计算结果也为 true ，并且允许访问：
```swift
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

### 1.7.4 组合逻辑运算符

您可以组合多个逻辑运算符来创建更长的复合表达式：

```swift
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

此示例使用多个 && 和 || 运算符来创建更长的复合表达式。但是， && 和 || 运算符仍然只对两个值进行操作，因此这实际上是链接在一起的三个较小的表达式。该示例可以解读为：

如果我们输入了正确的门密码并通过了视网膜扫描，或者如果我们有有效的门钥匙，或者如果我们知道紧急覆盖密码，则允许访问。

根据 enteredDoorCode 、 passedRetinaScan 和 hasDoorKey 的值，前两个子表达式是 false 。但是，紧急覆盖密码已知，因此整个复合表达式的计算结果仍为 true 。


**Note:**
Swift 逻辑运算符 && 和 || 是左关联的，这意味着具有多个逻辑运算符的复合表达式首先计算最左边的子表达式。


### 1.7.5 显式括号

有时，在并非严格需要的情况下包含括号很有用，以使复杂表达式的意图更易于阅读。
在上面的门禁示例中，在复合表达式的第一部分周围添加括号以使其意图明确非常有用：

```swift
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

括号清楚地表明前两个值被视为整体逻辑中单独的可能状态的一部分。复合表达式的输出没有改变，但总体意图对读者来说更加清晰。

可读性始终优先于简洁性；使用括号有助于明确您的意图。



----
```swift```
ref:https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators/#Terminology