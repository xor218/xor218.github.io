---
layout: post
author: "大西瓜"
title: "Extensions 扩展"
date:   2024-07-04 13:57:19 +0800
categories: [update,Swift] 
---





## extensions 扩展

**向现又类型添加功能**

扩展向现有的类、结构、枚举或协议类型添加新功能。这包括扩展您无权访问原始源代码的类型的能力（称为追溯建模）。扩展类似于 Objective-C 中的类别。 （与 Objective-C 类别不同，Swift 扩展没有名称。）



> **Note**:**不可以扩展存储属性，因为存储属性真实的在内存中，扩展函数只是让对象有该函数的使用权.**



1. 添加计算实例属性和计算类型属性 
2. 定义实例方法和类型方法
3. 提供新的初始化器
4. 定义下标
5. 定义和使用新的嵌套类型
6. 使现有类型符合协议



>**Note**:**扩展可以向类型添加心功能，但是不能覆盖现有功能**
>
>扩展和C++的机制不一样，并不是像虚表里面添加函数，是编译器编译的时候 添加的特殊功能



### 1. extension syntax 扩展语法

使用`extension`关键字声明扩展

```swift
extension someType{
  //new functionality to add to sometype goes here
}
```



扩展可以扩展现有类型以使其采用一种或多种协议。要添加协议一致性，您可以像为类或结构编写协议名称一样编写协议名称：

```swift
extension someType:SomeProtocol,AnotherProtocol{
	// implementation of protocol requirements goes here
}
```

通过扩展添加协议一致性中描述了以这种方式添加协议一致性。

扩展可用于扩展现有的泛型类型，如扩展泛型类型中所述。您还可以扩展泛型类型以有条件地添加功能，如使用泛型Where子句的扩展中所述。



>**Note**:如果您定义扩展以向现有类型添加新功能，则新功能将在该类型的所有现有实例上可用，即使它们是在定义扩展之前创建的。





### 2 .扩展计算属性

扩展可以将计算实例属性和计算类型属性添加到现有类型。此示例向 Swift 的内置 `Double` 类型添加了五个计算实例属性，为使用距离单位提供基本支持：

```swift
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"
```

这些计算属性表示 `Double` 值应被视为特定的长度单位。尽管它们是作为计算属性实现的，但这些属性的名称可以使用点语法附加到浮点文字值，作为使用该文字值执行距离转换的一种方式。

在此示例中， `1.0` 的 `Double` 值被视为表示“一米”。这就是 `m` 计算属性返回 `self` 的原因 - 表达式 `1.m` 被认为计算 `1.0`

其他单位需要进行一些转换才能表示为以米为单位的测量值。一公里等于 1,000 米，因此 `km` 计算属性将该值乘以 `1_000.00` 以转换为以米表示的数字。同样，一米等于 3.28084 英尺，因此 `ft` 计算属性将基础 `Double` 值除以 `3.28084` ，将其从英尺转换为米。

这些属性是只读计算属性，因此为简洁起见，它们在表达时不使用 `get` 关键字。它们的返回值是 `Double` 类型，并且可以在接受 `Double` 的数学计算中使用：

```swift
extension Double{
    var km:Double {return self * 1000.00}
    var m:Double  {return self }
    var cm:Double {return self/1000 }
    var mm:Double {return self/10000}
    var ft:Double {return self/3.248084}
}


let oneInch = 25.4.mm  //声明计算属性
print("One Inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"

let oneMil = 1.0.km
print("oneMil is \(oneMil) ")

```

这些计算属性表示 `Double` 值应被视为特定的长度单位。尽管它们是作为计算属性实现的，但这些属性的名称可以使用点语法附加到浮点文字值，作为使用该文字值执行距离转换的一种方式。

在此示例中， `1.0` 的 `Double` 值被视为表示“一米”。这就是 `m` 计算属性返回 `self` 的原因 - 表达式 `1.m` 被认为计算 `1.0`

其他单位需要进行一些转换才能表示为以米为单位的测量值。一公里等于 1,000 米，因此 `km` 计算属性将该值乘以 `1_000.00` 以转换为以米表示的数字。同样，一米等于 3.28084 英尺，因此 `ft` 计算属性将基础 `Double` 值除以 `3.28084` ，将其从英尺转换为米。

这些属性是只读计算属性，因此为简洁起见，它们在表达时不使用 `get` 关键字。它们的返回值是 `Double` 类型，并且可以在接受 `Double` 的数学计算中使用：

```swift
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// Prints "A marathon is 42195.0 meters long"
```

> **Note:**扩展可以添加新的计算属性，但不能添加存储的属性，或向现有属性添加属性观察器。 

.
### 3.扩展初始化器

扩展可以向现有类型添加新的初始值设定项。这使您能够扩展其他类型以接受您自己的自定义类型作为初始值设定项参数，或者提供未包含在该类型的原始实现中的其他初始化选项。

**扩展可以向类添加新的便利初始化器**，**但不能向类添加新的指定初始化器或deinit取消初始化器**。指定的初始化器和取消初始化器必须始终由原始类实现提供。

​	1.	**结构体（Structs）和枚举（Enums）**：可以在扩展中添加任何类型的初始化器。

	2.	**类（Classes）**：只能在扩展中添加便利初始化器（convenience initializers），不能添加指定初始化器（designated initializers）或必要初始化器（required initializers）。



> **Note**: 引用类型的比如：class 扩展(extension)只能**convenience**便利初始化器 不能使用指定初始化器，enum和struct 因为是值类型的，所以可以有



如果您使用扩展将初始值设定项添加到值类型，该值类型为其所有存储的属性提供默认值并且未定义任何自定义初始值设定项，则您可以从扩展的初始值设定项中调用该值类型的默认初始值设定项和成员初始值设定项。如果您将初始化程序编写为值类型原始实现的一部分，则情况不会如此，如值类型的初始化程序委托中所述。

如果您使用扩展将初始值设定项添加到在另一个模块中声明的结构中，则新的初始值设定项无法访问 `self` ，直到它从定义模块调用初始值设定项。（不同模块里面不能访问self）

下面的示例定义了一个自定义 `Rect` 结构来表示几何矩形。该示例还定义了两个名为 `Size` 和 `Point` 的支持结构，它们都为其所有属性提供默认值 `0.0` ：



```swift
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
```

由于 `Rect` 结构为其所有属性提供默认值，因此它会自动接收默认初始值设定项和成员初始值设定项，如默认初始值设定项中所述。这些初始化器可用于创建新的 `Rect` 实例：

```swift
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))
```

您可以扩展 `Rect` 结构以提供采用特定中心点和大小的附加初始值设定项：

```swift
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
```

这个新的初始化程序首先根据提供的 `center` 点和 `size` 值计算适当的原点。然后，初始化程序调用结构的自动成员初始化程序 `init(origin:size:)` ，它将新的原点和大小值存储在适当的属性中：

```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
```



> **Note**:如果您提供带有扩展的新初始化程序，您仍然有责任确保初始化程序完成后每个实例都完全初始化。



### 4.扩展方法

扩展可以向现有类型添加新的实例方法和类型方法。以下示例将一个名为 `repetitions` 的新实例方法添加到 `Int` 类型：

```swift
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}
```

`repetitions(task:)` 方法采用 `() -> Void` 类型的单个参数，这表示一个没有参数且不返回值的函数。

```swift
3.repetitions {
    print("Hello!")
}
// Hello!
// Hello!
// Hello!
```





### 4.改变实例方法

添加扩展的实例方法还可以修改（或变异）实例本身。修改 `self` 或其属性的结构和枚举方法必须将实例方法标记为 `mutating` ，就像从原始实现中改变方法一样。

>**Note**:修改结构体的实例需要在前面添加**mutating**关键字

下面的示例向 Swift 的 `Int` 类型添加了一个名为 `square` 的新变异方法，该方法对原始值进行平方：

```swift
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
// someInt is now 9
```



### 5.扩展下标

扩展可以向现有类型添加新的下标。此示例向 Swift 的内置 `Int` 类型添加一个整数下标。此下标 `[n]` 返回 `n` 从数字右侧放入的十进制数字：

```swift
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]
// returns 7
```

```swift
746381295[9]
// returns 0, as if you had requested:
0746381295[9]
```



### 6.嵌套类型

扩展可以向现有的类、结构和枚举添加新的嵌套类型：

一下代码是拓展属性，然后函数调用也只是使用属性

```swift
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}
```

此示例向 `Int` 添加一个新的嵌套枚举。该枚举称为 `Kind` ，表示特定整数表示的数字类型。具体来说，它表示数字是负数、零还是正数。

此示例还向 `Int` 添加了一个新的计算实例属性，称为 `kind` ，它返回该整数的适当的 `Kind` 枚举情况。

嵌套枚举现在可以与任何 `Int` 值一起使用：

```swift
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// Prints "+ + - 0 - 0 + "
```

此函数 `printIntegerKinds(_:)` 接受 `Int` 值的输入数组，并依次迭代这些值。对于数组中的每个整数，该函数会考虑该整数的 `kind` 计算属性，并打印适当的描述。

> **Note**:`number.kind` 已知为 `Int.Kind` 类型。因此，所有 `Int.Kind` 大小写值都可以在 `switch` 语句中以简写形式编写，例如 `.negative` 而不是 `Int.Kind.negative` .
