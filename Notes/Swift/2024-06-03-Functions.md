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



#### 1.1.1参数标签和参数名

Swift 允许为每个参数指定一个参数标签和参数名：

- **参数标签（argument label）**：在函数调用时使用，帮助提高调用的可读性。
- **参数名（parameter name）**：在函数实现中使用，表示函数内部的参数变量名。

以下是一个示例函数定义和调用：

```swift
func greeting(for person: String) -> String {
    return "Hello, \(person)!"
}

let message = greeting(for: "Alice")
print(message)

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





#### 1.2.6可选元祖返回类型

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



#### 1.2.6 具有隐式返回的函数

如果函数的整个主体是单个表达式，则该函数隐式返回该表达式。例如，以下两个函数具有相同的行为：

```swift
func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}
print(greeting(for: "Dave"))
// Prints "Hello, Dave!"


func anotherGreeting(for person: String) -> String {
    return "Hello, " + person + "!"
}
print(anotherGreeting(for: "Dave"))
// Prints "Hello, Dave!"
```

该 `greeting(for:)` 函数的整个定义是它返回的问候语，这意味着它可以使用这种较短的形式。该 `anotherGreeting(for:)` 函数返回相同的问候语，使用 `return` 关键字，例如更长的函数。您仅作为一 `return` 行编写的任何函数都可以省略 `return` .

> **Note**:作为隐式返回值编写的代码需要返回一些值。例如，不能用作 `print(13)` 隐式返回值。但是，您可以使用永远不会返回 like `fatalError("Oh no!")` 的函数作为隐式返回值，因为 Swift 知道隐式返回不会发生。









## 2. 函数参数标签和参数名称

每个函数参数都有一个**参数标签**和一个**参数名称**。**调用函数时使用参数标签;**每个参数都写在函数调用中，前面有其参数标签。**参数名称用于函数的实现**。**默认情况下，参数使用其参数名称作为其参数标签。**

```swift
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(firstParameterName: 1, secondParameterName: 2)
```

所有参数必须具有唯一的名称。尽管多个参数可能具有相同的参数标签，但唯一的参数标签有助于提高代码的可读性。



### 2.1指定参数标签

在参数名称之前编写一个参数标签，用空格分隔：

```swift
func someFunction(argumentLabel parameterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}
```

以下是该 `greet(person:)` 函数的变体，该函数采用一个人的姓名和家乡并返回问候语：

```swift
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
// Prints "Hello Bill!  Glad you could visit from Cupertino."

```

使用参数标签可以允许以富有表现力的类似句子的方式调用函数，同时仍然提供可读且意图清晰的函数体。





### 2.1 省略参数标签

如果布需要参数的参数标签，请为该参数编写下划线(_),而不是显式参数标签

```swift
func someFunction(_ firstParameterName:Int,secondParameterName:Int){
	    // 在函数体中，firstParameterName 和 secondParameterName
    // 参考第一个和第二个参数的参数值。
}
```

**如果参数具有参数标签，则在调用函数时必须标记该参数。**



### 2.2 默认参数值

您可以通过在函数类型之后为参数赋值来定义函数中任何参数的默认值。如果定义了默认值，则可以在调用函数时省略该参数。

```swift
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12
```



将没有默认值的参数放在函数参数列表的开头，放在具有默认值的参数之前。



## 3. 可变参数

###  3.1 参数为固定类型

可变参数接受零个或多个指定类型的值。您可以使用可变参数指定在调用函数时可以传递不同数量的输入值。通过在参数的类型名称后插入三个句点字符 （ `...` ） 来写入可变参数。



传递给可变参数的值在函数的主体中作为相应类型的数组提供。例如，名称 `numbers` 为 和 类型的 `Double...` 可变参数在函数主体中作为称为 `numbers` 类型的 `[Double]` 常量数组提供。



下面的示例计算任意长度的数字列表的算术平均值（也称为平均值）：

```swift
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
// returns 10.0, which is the arithmetic mean of these three numbers
```



### 3.2 参数为混合类型

**使用 Any 类型实现混合参数**

如果你确实需要传递不同类型的参数，可以使用 Any 类型，但这会失去类型安全性：

```swift
func stdCout(_ items:Any...){
    for item in items{
        print("\(item)")
    }
}

stdCout(_:1,"Hello","fuckyou",2.3)

```

在 Swift 中，可变参数必须是固定类型的。虽然可以使用 Any 类型来实现混合类型的参数传递，但这通常不是最佳实践，因为它会牺牲类型安全性。通常，明确和强类型的参数定义可以帮助提高代码的可读性和安全性。



## 4. In-Out参数 修改值



默认情况下，函数参数是常量。尝试从函数的主体中更改函数参数的值会导致编译时错误。这意味着您不能错误地更改参数的值。

如果希望函数修改参数的值，并且希望这些更改在函数调用结束后仍然存在，请改为将该参数定义为 in-out 参数。

通过将 `inout` 关键字放在参数类型之前来编写 in-out 参数。in-out 参数具有传入函数的值，由函数修改，并传回函数以替换原始值。有关 in-out 参数的行为和相关编译器优化的详细讨论，请参阅 In-Out 参数。

您只能将变量作为 in-out 参数的参数传递。不能将常量或文本值作为参数传递，因为无法修改常量和文本。当您将变量名称作为参数传递给 in-out 参数时，您可以直接在变量名称之前放置一个 & 符号 （ `&` ），以指示该函数可以对其进行修改。



> **Note:**In-out 参数不能具有默认值，并且可变参数不能标记为 `inout` 。
>
> 使用关键字**inout**,调用的时候在参数前面加上**&**,不可以用作默认参数



下面是一个名为 `swapTwoInts(_:_:)` 的函数示例，该函数有两个名为 `a` 和 `b` 的 in-out 整数参数：

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
```

该 `swapTwoInts(_:_:)` 函数只是交换 `b` into `a` 的值和 `a` into `b` 的值。该函数通过将 的 `a` 值存储在一个名为 `temporaryA` 的临时常量中来执行此交换，将 的 `b` 值赋值为 `a` ，然后赋值 `temporaryA` `b` 给 。

您可以使用两个类型的 `Int` 变量调用 `swapTwoInts(_:_:)` 函数来交换它们的值。请注意， `someInt` 当 和 `anotherInt` 的名称传递给 `swapTwoInts(_:_:)` 函数时，它们会以 & 符号为前缀：

```swift
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"
```

上面的示例显示 `someInt` ，函数修改了 和 `anotherInt` `swapTwoInts(_:_:)` 的原始值，即使它们最初是在函数外部定义的。



>**Note:**
>
>In-out 参数与从函数返回值不同。上面 `swapTwoInts` 的示例未定义返回类型或返回值，但仍会修改 `someInt` 和 `anotherInt` 的值。In-out 参数是函数在其函数体范围之外产生影响的另一种方式。



## 5.函数类型

每个函数都有一个特定的函数类型，由函数的参数类型和返回类型组成。

**例如**:

```swift
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
```

此示例定义了两个简单的数学函数，分别称为 `addTwoInts` 和 `multiplyTwoInts` 。这些函数每个取两个 `Int` 值，并返回一个 `Int` 值，该值是执行适当数学运算的结果。

这两个函数的类型都是 `(Int, Int) -> Int` 。这可以理解为：

“一个函数，它有两个参数，都是 类型 `Int` ，并且返回一个 类型的 `Int` 值。”

下面是另一个示例，对于没有参数或返回值的函数：

```swift
func printHelloWorld() {
    print("hello, world")
}
```

此函数的类型是 `() -> Void` ，或“没有参数的函数，并返回 `Void` ”。





### 5.1使用函数类型

您可以使用函数类型，就像 Swift 中的任何其他类型一样。例如，您可以将常量或变量定义为函数类型，并为该变量分配适当的函数：

```swift
var mathFunction: (Int, Int) -> Int = addTwoInts
```

这可以理解为：

“定义一个名为 `mathFunction` 的变量，该变量的类型为'接受两个 `Int` 值并返回一个 `Int` 值的函数'。将此新变量设置为引用名为 `addTwoInts` .“ 的函数。

该 `addTwoInts(_:_:)` 函数与 `mathFunction` 变量具有相同的类型，因此 Swift 的类型检查器允许这种赋值。

您现在可以调用名称 `mathFunction` 为：

```swift
print("Result: \(mathFunction(2, 3))")
// Prints "Result: 5"
```

可以将具有相同匹配类型的不同函数分配给同一变量，其方式与非函数类型相同：

```swift
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
// Prints "Result: 6"
```

与任何其他类型一样，当您将函数分配给常量或变量时，您可以将其留给 Swift 来推断函数类型：

```swift
let anotherMathFunction = addTwoInts
// anotherMathFunction is inferred to be of type (Int, Int) -> Int
```



**testing:**

```swift

func add(_ a:Int, _ b:Int) ->Int{
    return a+b
}

func muti(_ a:Int,_ b:Int) ->Int{
    return a*b
}

let var1:Int = 4
let var2:Int = 8

//定义函数指针 并且指向第一个函数
var IntMethod:(Int,Int)->Int = add
print("IntMethod(\(var1),\(var2)) = \(IntMethod(var1,var2))")
//out:IntMethod(4,8) = 12

IntMethod = muti  //函数指针指向第二个函数
print("IntMethod(\(var1),\(var2)) = \(IntMethod(var1,var2))")
//IntMethod(4,8) = 32


```





### 5.2 函数作为参数类型

您可以使用函数类型（例如 `(Int, Int) -> Int` ）作为另一个函数的参数类型。这使您能够将函数实现的某些方面留给函数的调用者在调用函数时提供。



下面是一个从上面打印数学函数结果的示例：

```swift
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Prints "Result: 8"
```



此示例定义了一个名为 `printMathResult(_:_:_:)` 的函数，该函数具有三个参数。第一个参数称为 `mathFunction` ，类型 `(Int, Int) -> Int` 为 。您可以传递该类型的任何函数作为第一个参数的参数。第二个和第三个参数称为 `a` 和 `b` ，并且都属于 `Int` 类型。这些用作所提供数学函数的两个输入值。

调用时 `printMathResult(_:_:_:)` ，它传递 `addTwoInts(_:_:)` 函数，整数值 `3` 和 `5` .它使用值 `3` 和 `5` 调用提供的函数，并打印 `8` 的结果。

的作用 `printMathResult(_:_:_:)` 是打印对适当类型的数学函数的调用结果。该函数的实现实际执行什么并不重要，重要的是该函数的类型是否正确。这样 `printMathResult(_:_:_:)` 就可以以类型安全的方式将其某些功能移交给函数的调用方。



### 5.3 函数类型作为返回值

可以使用一个函数类型作为另一个函数的返回类型。为此，请在返回函数的返回箭头 （ `->` ） 之后立即编写一个完整的函数类型。



下一个示例定义了两个名为 `stepForward(_:)` 和 `stepBackward(_:)` 的简单函数。该 `stepForward(_:)` 函数返回的值比其输入值多 1， `stepBackward(_:)` 函数返回的值比其输入值少 1。这两个函数的类型为 `(Int) -> Int` ：



```swift
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
```

下面是一个名为 `chooseStepFunction(backward:)` 的函数，其返回类型为 `(Int) -> Int` 。该 `chooseStepFunction(backward:)` 函数返回 `stepForward(_:)` 函数或基于布尔参数的 `stepBackward(_:)` 函数，称为 `backward` ：

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}
```

现在 `chooseStepFunction(backward:)` ，您可以使用该函数来获取将单向或另一个方向步进的函数：

```swift
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the stepBackward() function
```

上面的示例确定是否需要正步长或负步长才能将名为 `currentValue` “逐渐接近零”的变量移动。 `currentValue` 的初始值为 `3` ，这意味着 `currentValue > 0` 返回 `true` ，导致 `chooseStepFunction(backward:)` 返回 `stepBackward(_:)` 函数。对返回函数的引用存储在名为 `moveNearerToZero` 的常量中。



现在指的是 `moveNearerToZero` 正确的函数，它可以用来数到零：



```swift
print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!
```





## 5.4 嵌套函数

到目前为止，您在本章中遇到的所有函数都是全局函数的示例，这些函数是在全局范围内定义的。您还可以在其他函数的主体中定义函数，称为嵌套函数。

默认情况下，嵌套函数对外界是隐藏的，但仍可由其封闭函数调用和使用。封闭函数还可以返回其嵌套函数之一，以允许在另一个作用域中使用嵌套函数。

您可以重写上面的 `chooseStepFunction(backward:)` 示例以使用和返回嵌套函数：

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
  //根据条件返回内嵌的不同函数,外部用let接收并且调用
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!
```

