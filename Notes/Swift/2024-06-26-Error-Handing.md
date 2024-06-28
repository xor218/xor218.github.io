---
layout: post
author: "大西瓜"
title: "Error Handing 错误处理"
date:   2024-06-26 13:54:59 +0800
categories: [update,Swift] 
---



## Error Handing 错误处理

**响应错误并从错误中恢复。**

错误处理是响应程序中的错误情况并从中恢复的过程。 Swift 为运行时抛出、捕获、传播和操作可恢复错误提供一流的支持。



某些操作不能保证始终完成执行或产生有用的输出。可选值用于表示值的缺失，但是当操作失败时，了解导致失败的原因通常很有用，以便您的代码可以做出相应的响应。

例如，考虑从磁盘上的文件读取和处理数据的任务。此任务可能因多种原因失败，包括指定路径中不存在文件、文件不具有读取权限或文件未以兼容格式编码。区分这些不同的情况允许程序解决一些错误并向用户传达它无法解决的任何错误。



> **Note**:Swift 中的错误处理与 Cocoa 和 Objective-C 中使用 `NSError` 类的错误处理模式进行互操作。有关此类的更多信息，请参阅处理 Swift 中的 Cocoa 错误。



>
>
>**Note:** 从汇编的角度看错误,throw 函数 return 出来 出变量，只不是这个变量是Error
>
>函数使用 throws 是告诉编译器 会返回一个错误
>
>在代码中使用try，只是提前布局好，处理错误的各种jump指针，方便函数抛出错误的时候 继续执行
>
>
>
>**ChatGpt**：
>
>​	1.	**错误抛出和返回值**：
>
>​	•	当函数使用 throws 声明时，这告诉编译器该函数可能会抛出错误而不是正常返回值。
>
>​	•	在抛出错误的情况下，函数并不会返回通常的结果值，而是返回一个错误对象。这个错误对象会沿着调用栈传递，直到被捕获和处理。
>
>​	2.	**使用** **try** **关键字**：
>
>​	•	在代码中使用 try 关键字是为了显式表明该函数调用可能会抛出错误。
>
>​	•	try 不仅仅是语法上的要求，它告诉编译器需要设置必要的跳转指针（jump pointers）和堆栈框架，以便在错误抛出时能够正确地进行堆栈展开和错误处理。(可能swift 有别的机制)
>
>​	3.	**堆栈展开和错误处理**：
>
>​	•	当错误被抛出时，程序会开始从抛出错误的函数逐级返回到调用栈的上一级函数，移除每个函数的栈帧，直到找到一个可以处理该错误的 catch 块。
>
>​	•	这涉及保存当前的执行状态，恢复上一级函数的上下文，并跳转到合适的错误处理代码。



### 1.错误的定义和抛错

在 Swift 中，错误由符合 `Error` 协议的类型值表示。这个空协议表明一个类型可用于错误处理。

Swift 枚举特别适合对一组相关的错误条件进行建模，关联值允许提供有关要传达的错误性质的附加信息。例如，以下是在游戏中表示操作自动售货机的错误条件的方式：

```swift
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
```

抛出错误可以让您表明发生了意外情况并且正常的执行流程无法继续。您使用 `throw` 语句引发错误。例如，以下代码会抛出错误，指示自动售货机需要另外 5 个硬币：

```swift
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
```





### 2.处理错误



抛出错误时，周围的一些代码必须负责处理错误 - 例如，通过纠正问题、尝试替代方法或通知用户失败。

Swift 中有四种处理错误的方法。您可以将错误从函数传播到调用该函数的代码，使用 `do` - `catch` 语句处理错误，将错误作为可选值处理，或者断言不会发生错误。下面的部分描述了每种方法。

当函数抛出错误时，它会改变程序的流程，因此快速识别代码中可能抛出错误的位置非常重要。要识别代码中的这些位置，请在调用函数、方法、或可能引发错误的初始化程序。这些关键字在下面的部分中进行了描述。

>**Note**:Swift 中的错误处理类似于其他语言中的异常处理，使用 `try` 、 `catch` 和 `throw` 关键字。与许多语言（包括 Objective-C）中的异常处理不同，Swift 中的错误处理不涉及展开调用堆栈，这一过程的计算成本可能很高。因此， **`throw` 语句的性能特征与 `return` 语句的性能特征相当**。
>
>





### 3.使用函数抛出错误

> **Note:** **抛出错误写在括号之后 ，返回值之前**

要指示函数、方法或初始值设定项可以引发错误，请在函数声明中的参数后面写入 `throws` 关键字。带有 `throws` 标记的函数称为抛出函数。如果函数指定返回类型，请在返回箭头 ( `->` ) 之前写入 `throws` 关键字。

```swift
func canThrowErrors() throws -> String

func cannotThrowErrors() -> String
```

抛出函数将其内部抛出的错误传播到调用它的范围。



> **Note:** 只有抛出函数才能传播错误。在**非抛出函数内抛出的任何错误都必须在该函数内部进行处理**。



在下面的示例中， `VendingMachine` 类有一个 `vend(itemNamed:)` 方法，如果请求的商品不可用、缺货或费用超过当前存入金额：

```swift
struct Item {
    var price: Int
    var count: Int
}


class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0


    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {   //guard let的变量在整个函数中都可以使用
            throw VendingMachineError.invalidSelection 
        }


        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        } 


        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }


        coinsDeposited -= item.price


        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem


        print("Dispensing \(name)")
    }
}
```

`vend(itemNamed:)` 方法的实现使用 `guard` 语句提前退出该方法，并在不满足购买零食的任何要求时抛出适当的错误。由于 `throw` 语句会立即转移程序控制，因此只有满足所有这些要求时才会出售商品。

由于 `vend(itemNamed:)` 方法会传播它引发的任何错误，因此调用此方法的任何代码都必须处理错误 - 使用 `do` - `catch` 语句、 `try?` 或 `try!` — 或继续传播它们。例如，下面示例中的 `buyFavoriteSnack(person:vendingMachine:)` 也是一个抛出函数， `vend(itemNamed:)` 方法抛出的任何错误都会传播到 `buyFavoriteSnack(person:vendingMachine:)` 的位置。函数被调用。



```swift
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}
```



在此示例中， `buyFavoriteSnack(person: vendingMachine:)` 函数查找给定人员最喜欢的零食，并尝试通过调用 `vend(itemNamed:)` 方法为他们购买。由于 `vend(itemNamed:)` 方法可能会引发错误，因此在调用该方法时会在其前面添加 `try` 关键字。



```swift
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
```





### 4. 使用do-catch捕获处理错误

您可以使用 `do` - `catch` 语句通过运行代码块来处理错误。如果 `do` 子句中的代码引发错误，则会将其与 `catch` 子句进行匹配，以确定其中哪一个可以处理该错误。

```swift
do {
    try <#expression#>
    <#statements#>
} catch <#pattern 1#> {
    <#statements#>
} catch <#pattern 2#> where <#condition#> {
    <#statements#>
} catch <#pattern 3#>, <#pattern 4#> where <#condition#> {
    <#statements#>
} catch {
    <#statements#>
}
```



您可以在 `catch` 之后编写一个模式来指示该子句可以处理哪些错误。**如果 `catch` 子句没有模式，则该子句会匹配任何错误并将错误绑定到名为 `error` 的本地常量**。有关模式匹配的更多信息，请参阅模式。



例如，以下代码与 `VendingMachineError` 枚举的所有三种情况匹配。



```swift
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) where coinsNeeded <= 5 {
  	print("也可以不用where，这个case的错误都可以捕获")
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) where coinsNeeded > 5 {
  	print("where 指定附加条件,如果满足条件才跳转到这里")
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")  //捕获未知的错误，并且绑定到error常量中
}
// Prints "Insufficient funds. Please insert an additional 2 coins."
```



在上面的示例中，在 `try` 表达式中调用 `buyFavoriteSnack(person:vendingMachine:)` 函数，因为它可能会引发错误。如果抛出错误，执行立即转移到 `catch` 子句，该子句决定是否允许继续传播。如果没有模式匹配，错误将被最后的 `catch` 子句捕获，并绑定到本地 `error` 常量。如果没有抛出错误，则执行 `do` 语句中的其余语句。



`catch` 子句不必处理 `do` 子句中的代码可能引发的所有可能错误。如果没有 `catch` 子句处理错误，则错误将传播到周围范围。然而，传播的错误必须由一些周围的范围来处理。在非抛出函数中，封闭的 `do` - `catch` 语句必须处理错误。在抛出函数中，封闭的 `do` - `catch` 语句或调用者必须处理错误。如果错误传播到顶级范围而没有得到处理，您将收到运行时错误。

例如，可以编写上面的示例，以便调用函数捕获任何不是 `VendingMachineError` 的错误：

```swift
func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {    //捕获 VendingMachineError类型的所有错误
        print("Couldn't buy that from the vending machine.")
    }
}


do {
    try nourish(with: "Beet-Flavored Chips")
} catch {                              //捕获其他错误
    print("Unexpected non-vending-machine-related error: \(error)")
}
// Prints "Couldn't buy that from the vending machine."
```

在 `nourish(with:)` 函数中，如果 `vend(itemNamed:)` 引发属于 `VendingMachineError` 枚举情况之一的错误，则 `nourish(with:)` 通过打印来处理该错误一个消息。否则， `nourish(with:)` 会将错误传播到其调用站点。然后，该错误将被常规 `catch` 子句捕获。



**捕获多个相关错误的另一种方法是将它们列在 `catch` 之后，并用逗号分隔**。例如：

```swift
func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
        print("Invalid selection, out of stock, or not enough money.")
    }
}
```



`eat(item:)` 函数列出了要捕获的自动售货机错误，其错误文本对应于该列表中的项目。如果抛出列出的三个错误中的任何一个，此 `catch` 子句将通过打印消息来处理它们。任何其他错误都会传播到周围范围，包括以后可能添加的任何自动售货机错误。





### 5. 把错误转换成可选值

您可以使用 `try?` 将错误转换为可选值来处理错误。如果在计算 `try?` 表达式时抛出错误，则表达式的值为 `nil` 。例如，在以下代码中 `x` 和 `y` 具有相同的值和行为：

> **Note**： `try?`中间没有空格，比如`try ?`是错误的
>
> ​	•	**try?** **的用法**：try? 用于捕获错误并返回 nil，而不是抛出错误。它简化了错误处理，但不会提供错误的具体信息。

```swift
func someThrowingFunction() throws -> Int {
    // ...
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
```

如果 `someThrowingFunction()` 抛出错误，则 `x` 和 `y` 的值为 `nil` 。否则， `x` 和 `y` 的值是函数返回的值。请注意， `x` 和 `y` 是 `someThrowingFunction()` 返回的任何类型的可选类型。这里函数返回一个整数，因此 `x` 和 `y` 是可选整数。

当您想以相同的方式处理所有错误时，使用 `try?` 可以让您编写简洁的错误处理代码。例如，以下代码使用多种方法来获取数据，如果所有方法都失败，则返回 `nil` 。

```swift
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
```



### 6.禁用错误传播

有时您知道抛出函数或方法实际上不会在运行时抛出错误。在这些情况下，您可以在表达式之前编写 `try!` 以禁用错误传播，并将调用包装在运行时断言中，不会引发任何错误。如果确实抛出错误，您将收到运行时错误。

例如，以下代码使用 `loadImage(atPath:)` 函数，该函数在给定路径加载图像资源，如果无法加载图像，则抛出错误。在这种情况下，由于图像是随应用程序一起提供的，因此在运行时不会抛出错误，因此禁用错误传播是适当的。

```swift
let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
```

>**Note:** 知道函数或者方法不回抛出错误的时候，可以使用`try!` ,但是如果还是会报错。那就会报错
>
>

```swift
enum SomeError:Error{
    case DIV(_ errno:Int)
}

func someFunctionError(_ x:Int,_ y:Int)throws ->Int{
    if y == 0 {
        throw SomeError.DIV(y)
    }
    return Int(x/y)
}

var value = try! someFunctionError(5, 0)
print("\(value)")
```



### 7. 指定错误:无法编译

**指定错误在xcode中无法编译成功，可能是在特殊的设备下才可以用，本段落代码无法通过xcode编译**

上面的所有示例都使用最常见的错误处理类型，其中代码引发的错误可以是符合 `Error` 协议的任何类型的值。这种方法符合这样的现实：您无法提前知道代码运行时可能发生的每个错误，尤其是在传播在其他地方抛出的错误时。它还反映了错误会随着时间而改变的事实。库的新版本（包括依赖项使用的库）可能会引发新错误，而现实世界用户配置的丰富复杂性可能会暴露在开发或测试期间不可见的故障模式。上面示例中的错误处理代码始终包含默认情况来处理没有特定 `catch` 子句的错误。

大多数 Swift 代码并没有指定它抛出的错误的类型。但是，在以下特殊情况下，您可以将代码限制为仅抛出一种特定类型的错误：

- 在不支持动态内存分配的嵌入式系统上运行代码时。抛出 `any Error` 或其他盒装协议类型的实例需要在运行时分配内存来存储错误。相反，抛出特定类型的错误可以让 Swift 避免错误的堆分配。

- 当错误是某些代码单元（例如库）的实现细节，并且不是该代码的接口的一部分时。由于错误仅来自库，而不来自其他依赖项或库的客户端，因此您可以列出所有可能的故障的详尽列表。因为这些错误是库的实现细节，所以它们总是在该库中处理。

- 在仅传播泛型参数描述的错误的代码中，例如采用闭包参数并传播该闭包中的任何错误的函数。有关传播特定错误类型和使用 `rethrows` 之间的比较，请参阅 doc:Declarations:Rethroing-Functions-and-Methods。

例如，考虑总结评级并使用以下错误类型的代码：

```swift
enum StatisticsError: Error {
    case noRatings
    case invalidRating(Int)
}
```

要指定函数仅抛出 `StatisticsError` 值作为其错误，请在声明函数时编写 `throws(StatisticsError)`而不是仅 `throws` 。此语法也称为类型化抛出，因为您在声明中的 `throws` 之后写入错误类型。例如，下面的函数抛出 `StatisticsError` 值作为其错误。



```swift
func summarize(_ ratings: [Int]) throws(StatisticsError) {
    guard !ratings.isEmpty else { throw .noRatings }


    var counts = [1: 0, 2: 0, 3: 0]
    for rating in ratings {
        guard rating > 0 && rating <= 3 else { throw .invalidRating(rating) }
        counts[rating]! += 1
    }


    print("*", counts[1]!, "-- **", counts[2]!, "-- ***", counts[3]!)
}
```

在上面的代码中， `summarize(_:)` 函数总结了以 1 到 3 的等级表示的评级列表。如果输入无效，该函数将抛出 `StatisticsError` 的实例。上面代码中抛出错误的两个地方都忽略了错误的类型，因为函数的错误类型已经定义了。在这样的函数中抛出错误时，您可以使用缩写形式 `throw .noRatings` ，而不是编写 `throw StatisticsError.noRatings` 。

当您在函数开头编写特定的错误类型时，Swift 会检查您是否不会抛出任何其他错误。例如，如果您尝试在上面的 `summarize(_:)` 函数中使用本章前面示例中的 `VendingMachineError` ，则该代码将在编译时产生错误。

您可以在常规抛出函数中调用使用类型化抛出的函数：

```swift
func someThrowingFunction() -> throws {
    let ratings = [1, 2, 3, 2, 2, 1]
    try summarize(ratings)
}
```



上面的代码没有指定 `someThrowingFunction()` 的错误类型，因此它抛出 `any Error` 。您还可以将错误类型显式编写为 `throws(any Error)` ；下面的代码与上面的代码等效：

```swift
func someThrowingFunction() -> throws(any Error) {
    let ratings = [1, 2, 3, 2, 2, 1]
    try summarize(ratings)
}
```



在此代码中， `someThrowingFunction()` 传播 `summarize(_:)` 引发的任何错误。 `summarize(_:)` 中的错误始终是 `StatisticsError` 值，这也是 `someThrowingFunction()` 抛出的有效错误。



就像您可以编写一个永远不会返回且返回类型为 `Never` 的函数一样，您也可以编写一个永远不会抛出 `throws(Never)` 的函数：

```swift
func nonThrowingFunction() throws(Never) {
  // ...
}
```



此函数无法抛出异常，因为不可能创建要抛出的 `Never` 类型的值。

除了指定函数的错误类型之外，您还可以为 `do` - `catch` 语句编写特定的错误类型。例如：

```swift
let ratings = []
do throws(StatisticsError) {
    try summarize(ratings)
} catch {
    switch error {
    case .noRatings:
        print("No ratings available")
    case .invalidRating(let rating):
        print("Invalid rating: \(rating)")
    }
}
// Prints "No ratings available"
```

在此代码中，编写 `do throws(StatisticsError)` 表示 `do` - `catch` 语句抛出 `StatisticsError` 值作为其错误。与其他 `do` - `catch` 语句一样， `catch` 子句可以处理每个可能的错误，也可以传播未处理的错误以供某些周围范围处理。此代码使用 `switch` 语句处理所有错误，每个枚举值都有一种情况。与其他没有模式的 `catch` 子句一样，该子句匹配任何错误并将错误绑定到名为 `error` 的本地常量。由于 `do` - `catch` 语句抛出 `StatisticsError` 值，因此 `error` 是 `StatisticsError` 类型的值。

上面的 `catch` 子句使用 `switch` 语句来匹配和处理每个可能的错误。如果您尝试向 `StatisticsError` 添加新的 case 而不更新错误处理代码，Swift 会给您一个错误，因为 `switch` 语句不再详尽。对于捕获其自身所有错误的库，您可以使用此方法来确保任何新错误都获得相应的新代码来处理它们。

如果函数或 `do` 块仅抛出单一类型的错误，Swift 会推断此代码正在使用类型化抛出。使用这种较短的语法，您可以将上面的 `do` - `catch` 示例编写如下：

```swift
let ratings = []
do {
    try summarize(ratings)
} catch {
    switch error {
    case .noRatings:
        print("No ratings available")
    case .invalidRating(let rating):
        print("Invalid rating: \(rating)")
    }
}
// Prints "No ratings available"
```

尽管上面的 `do` - `catch` 块没有指定它抛出什么类型的错误，但 Swift 推断它会抛出 `StatisticsError` 。您可以显式编写 `throws(any Error)` 以避免让 Swift 推断类型化抛出。



###  8.指定错误 

**本selection可以通过编译**



```swift
enum StatisticsError: Error {
    case noRatings
    case invalidRating(Int)
}


func summarize(_ ratings:[Int]) throws ->Int{
    guard !ratings.isEmpty else {throw StatisticsError.noRatings}
    var total:Int = 0
    
    for rate in ratings{
        guard rate > 0 ,rate < 5 else {
            throw  StatisticsError.invalidRating(rate)
        }
        total += rate
    }
    return total
}

var value:Int? 

do{
    value = try summarize([0,1,5])
}catch let error as StatisticsError  {   //catch 一个类型的错误
    switch error {											//switch 这个类型的错误
    case .noRatings:								
        print("Error: NoRatings")
    case .invalidRating(let x):
        print("Error:Invalid value \(x)")
    }
}catch{
    print("unkonw Error is occurred")
}

```

or

```swift
do{
    value = try summarize([0,1,5])
}catch is StatisticsError  {
    print("StaticticError is occurred")
}catch{
    print("unkonw Error is occurred")
}
```





###  9.指定清理操作

**defer 代码块,像是linux中的遗言函数,在离开当前作用域的时候执行,有多个defer代码的时候 会在离开作用于的时候先进后出FIFO**



您可以使用 `defer` 语句在代码执行离开当前代码块之前执行一组语句。该语句允许您执行任何必要的清理操作，无论执行如何离开当前代码块 - 是否由于抛出错误或由于 `return` 或 `break` 语句来确保关闭文件描述符并释放手动分配的内存。

`defer` 语句推迟执行，直到退出当前作用域。该语句由 `defer` 关键字和后面要执行的语句组成。延迟语句不得包含任何将控制权移出语句的代码，例如 `break` 或 `return` 语句，或者抛出错误。延迟操作的执行顺序与源代码中编写的顺序相反。也就是说，第一个 `defer` 语句中的代码最后执行，第二个 `defer` 语句中的代码从倒数第二个执行，依此类推。源代码顺序中的最后一个 `defer` 语句首先执行。

```swift
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
```



上面的示例使用 `defer` 语句来确保 `open(_:)` 函数对 `close(_:)` 进行相应的调用。

即使不涉及错误处理代码，您也可以使用 `defer` 语句。有关详细信息，请参阅延迟操作。







### do-catch 中的where 如何使用

在 Swift 中，`do-catch` 语句用于处理错误，并且可以通过多个 `catch` 块来处理不同类型的错误或条件。`where` 关键字在 `catch` 块中用于进一步细化错误处理条件。

**使用 `where` 关键字**

`where` 关键字用于指定附加条件，以便在某些情况下处理特定的错误。这对于处理特定的错误类型或在特定条件下采取不同的行动非常有用。

**示例代码**

以下是一个示例，展示如何在 `do-catch` 语句中使用 `where` 关键字来细化错误处理：

```swift
enum MyError: Error {
    case fileNotFound(fileName: String)
    case invalidData(reason: String)
    case networkError(code: Int)
}

func performTask() throws {
    // 模拟抛出错误
    throw MyError.networkError(code: 404)
}

do {
    try performTask()
} catch MyError.fileNotFound(let fileName) {
    print("File not found: \(fileName)")
} catch MyError.invalidData(let reason) {
    print("Invalid data: \(reason)")
} catch MyError.networkError(let code) where code == 404 {
    print("Network error: Not Found (404)")
} catch MyError.networkError(let code) where code == 500 {
    print("Network error: Internal Server Error (500)")
} catch {
    print("An unknown error occurred: \(error)")
}
```

**解释**

- **`catch MyError.fileNotFound(let fileName)`**：
  - 捕获 `MyError.fileNotFound` 错误，并提取 `fileName` 变量。
- **`catch MyError.invalidData(let reason)`**：
  - 捕获 `MyError.invalidData` 错误，并提取 `reason` 变量。
- **`catch MyError.networkError(let code) where code == 404`**：
  - 捕获 `MyError.networkError` 错误，并且只有当 `code` 等于 404 时，才会进入这个 `catch` 块。
- **`catch MyError.networkError(let code) where code == 500`**：
  - 捕获 `MyError.networkError` 错误，并且只有当 `code` 等于 500 时，才会进入这个 `catch` 块。
- **`catch`**：
  - 捕获所有未被前面 `catch` 块处理的错误。

**细化错误处理**

使用 `where` 关键字，可以细化错误处理逻辑，根据具体的条件进行不同的处理。这样可以使错误处理代码更加精确和灵活。

**总结**

- `do-catch` 语句用于捕获和处理错误。
- 可以使用多个 `catch` 块来处理不同类型的错误。
- `where` 关键字用于在 `catch` 块中指定附加条件，从而细化错误处理逻辑。

通过这种方式，您可以根据具体的错误类型和条件编写更具针对性的错误处理代码，提高代码的健壮性和可维护性。

