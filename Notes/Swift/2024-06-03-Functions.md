---
layout: post
author: "大西瓜"
title: "Functions 函数"
date:   2024-06-03 16:42:43 +0800
categories: [update,Swift] 
---





## 1. 函数

函数是执行特定任务的独立代码块。您可以为函数指定一个名称，用于标识它的作用，并且此名称用于在需要时“调用”该函数以执行其任务。

Swift 的统一函数语法足够灵活，可以表达任何内容，从没有参数名称的简单 C 样式函数到每个参数都有名称和参数标签的复杂 Objective-C 样式方法。

参数可以提供默认值以简化函数调用，并且可以作为输入输出参数传递，一旦函数完成执行，这些参数就会修改传递的变量。

Swift 中的每个函数都有一个类型，由函数的参数类型和返回类型组成。您可以像在 Swift 中使用任何其他类型一样使用此类型，这样可以轻松地将函数作为参数传递给其他函数，并从函数返回函数。

还可以在其他函数中编写函数，以将有用的功能封装在嵌套函数作用域中。



### 1.1 定义和调用函数

定义函数时，可以选择定义一个或多个命名的类型化值，函数将这些值作为输入，称为参数。还可以选择定义函数在完成后将作为输出传回的值类型，称为其返回类型。

每个函数都有一个函数名称，用于描述函数执行的任务。若要使用函数，请使用该函数的名称“调用”该函数，并向其传递与函数参数类型匹配的输入值（称为参数）。函数的参数必须始终按照与函数的参数列表相同的顺序提供。

下面示例中的函数称为 `greet(person:)` ，因为它就是这样做的——它以一个人的名字作为输入，并返回对该人的问候语。为此，您可以定义一个输入参数（称为 `String` `person` 值）和返回类型 `String` ，该类型将包含对该人的问候语：

```swift
func freeting(label 参数名:类型) ->返回值 {
	...
}
```

```swift
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
```



所有这些信息都汇总到函数的定义中，该定义以 `func` 关键字为前缀。使用返回箭头 `->` （连字符后跟直尖括号）指示函数的返回类型，后跟要返回的类型的名称。

该定义描述了函数的作用、期望接收的内容以及完成后返回的内容。该定义使函数易于从代码中的其他位置明确调用：

您可以通过在 `person` 参数标签后向函数传递一个 `String` 值来调用 `greet(person:)` 函数，例如 `greet(person: "Anna")` 。由于函数返回一个 `String` 值， `greet(person:)` 因此可以包装在对 `print(_:separator:terminator:)` 函数的调用中以打印该字符串并查看其返回值，如上所示。





> **Note**:该 `print(_:separator:terminator:)` 函数的第一个参数没有标签，其其他参数是可选的，因为它们具有默认值。函数语法的这些变体将在下面的函数参数标签和参数名称以及默认参数值中讨论。
>
> 

`greet(person:)` 函数的主体首先定义一个调用 `greeting` 的新 `String` 常量，并将其设置为简单的问候语。然后，使用 `return` 关键字将此问候语传回函数。在代码 `return greeting` 行中，函数完成其执行并返回当前值 `greeting` 。

您可以使用不同的输入值多次调用该 `greet(person:)` 函数。上面的示例显示了如果使用 `"Anna"` 输入值 和 输入值 来 `"Brian"` 调用它，会发生什么情况。在每种情况下，该函数都会返回定制的问候语。

若要使此函数的正文更短，可以将消息创建和 return 语句合并为一行：

```swift
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// Prints "Hello again, Anna!"
```





### 1.2 函数参数和返回值

函数参数和返回值在 Swift 中非常灵活。您可以定义任何内容，从具有单个未命名参数的简单实用程序函数到具有富有表现力的参数名称和不同参数选项的复杂函数。







#### 1.2.1 不带参数的函数

定义输入参数不需要函数。下面是一个没有输入参数的函数，每当调用它时，它总是返回相同的 `String` 消息：

```swift
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// Prints "hello, world"
```

函数定义仍然需要在函数名称后面加上括号，即使它不采用任何参数。调用函数时，函数名称后面还跟一对空括号。







#### 1.2.3 具有多个参数的函数

函数可以有多个输入参数，这些参数写在函数的括号内，用逗号分隔。

此函数将一个人的姓名以及他们是否已经收到过问候作为输入，并为该人返回适当的问候语：

```swift
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))
// Prints "Hello again, Tim!"
```





通过向函数传递标记的 `String` 参数值 `person` 和 `alreadyGreeted` 括号中标记的 `Bool` 参数值（用逗号分隔）来调用 `greet(person:alreadyGreeted:)` 函数。请注意，此函数与前面部分中显示的 `greet(person:)` 函数不同。尽管这两个函数的名称都以 `greet` 开头，但 `greet(person:alreadyGreeted:)` 该函数采用两个参数，但 `greet(person:)` 该函数只采用一个参数。









#### 1.2.4 不带返回值的函数

定义函数返回值不需要函数，下面是该greet(person:)函数的一个版本，他打印自己的String值而不是返回他

```swift
//可以省略Void
func greet(name1:String) {
    print("Hello \(name1) Fuck you " )
}


//显示指定为void
func greet(name2:String) -> Void {
    print("Hello \(name2) Fuck you bitch")
}
greet(name1:"David")
greet(name2:"David")

//Hello David Fuck you 
//Hello David Fuck you bitch
```

> **Note 注意**：严格来说，即使未定义返回值，此版本的 `greet(person:)` 函数仍会返回值。没有定义返回类型的函数返回 `Void` 类型的特殊值。这只是一个空元组，写成 `()` .

调用函数时，可以忽略函数的返回值：

```swift
func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// prints "hello, world" and returns a value of 12
printWithoutCounting(string: "hello, world")
// prints "hello, world" but doesn't return a value
```

第一个函数 `printAndCount(string:)` ，打印一个字符串，然后将其字符计数作为 `Int` .第二个函数 `printWithoutCounting(string:)` 调用第一个函数，但忽略其返回值。调用第二个函数时，第一个函数仍会打印消息，但不使用返回的值。



> **Note**:
>
> 可以忽略返回值，但表示将返回值的函数必须始终这样做。
>
> 具有定义的返回类型的函数不允许控件在不返回值的情况下从函数的底部掉出，尝试这样做将导致编译时错误。







#### 1.2.5 具有多个返回值的函数

可以使用元组类型作为函数的返回类型，以将多个值作为一个复合返回值的一部分返回。

下面的示例定义了一个名为 `minMax(array:)` 的函数，该函数查找 `Int` 值数组中的最小和最大数字：

```swift
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
```





该 `minMax(array:)` 函数返回一个包含两个 `Int` 值的元组。这些值已标记 `min` ， `max` 以便在查询函数的返回值时可以按名称访问它们。

`minMax(array:)` 函数的主体首先将两个工作变量 and `currentMin` `currentMax` 设置为数组中第一个整数的值。然后，该函数循环访问数组中的其余值，并检查每个值以查看它是否分别小于 `currentMin` 和 `currentMax` 的值。最后，总体最小值和最大值以两个 `Int` 值的元组形式返回。

由于元组的成员值是作为函数返回类型的一部分命名的，因此可以使用点语法访问它们以检索找到的最小值和最大值：

```swift
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// Prints "min is -6 and max is 109"
```





### 1.2.6可选元祖返回类型

如果要从函数返回的元组类型对于整个元组可能具有“无值”，则可以使用可选的元组返回类型来反映整个元组可以是 `nil` 的事实。通过在元组类型的右括号后放置一个问号（如 `(Int, Int)?` 或 `(String, Int, Bool)?` ）来编写可选的元组返回类型。

> **Note**:可选的元组类型（如 与包含可选类型（如 `(Int?, Int?)` 的 `(Int, Int)?` 元组）不同。对于可选的元组类型，整个元组是可选的，而不仅仅是元组中的每个单独值。

上面的 `minMax(array:)` 函数返回一个包含两个 `Int` 值的元组。但是，该函数不会对它传递的数组执行任何安全检查。如果 `array` 参数包含空数组，则如上所述， `minMax(array:)` 该函数在尝试访问 `array[0]` 时将触发运行时错误。

若要安全地处理空数组，请使用可选的元组返回类型编写 `minMax(array:)` 函数，并在数组为空时返回值 `nil` ：

```swift
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
```

可以使用可选绑定来检查此版本的 `minMax(array:)` 函数是否返回实际元组值或 `nil` ：

```swift
if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
// Prints "min is -6 and max is 109"
```

