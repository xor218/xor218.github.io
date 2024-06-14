---
layout: post
author: "大西瓜"
title: "Structures And Classes 结构和类"
date:   2024-06-11 13:19:00 +0800
categories: [update,Swift] 
---





## 结构和类

对封装数据的自定义类型进行建模。

结构和类是通用的灵活构造，它们成为程序代码的构建块。您可以定义属性和方法，以使用用于定义常量、变量和函数的相同语法向结构和类添加功能。

与其他编程语言不同，Swift 不需要你为自定义结构和类创建单独的接口和实现文件。在 Swift 中，您可以在单个文件中定义一个结构或类，并且该类或结构的外部接口会自动提供给其他代码使用。

> 
>
> **Note**:
>
> **编译的时候，自动链接** 不需要提供头文件,Swift 通过将接口和实现放在一个文件中，简化了开发过程，同时保持了代码的可读性和可维护性。这种设计使得 Swift 更加现代化和易用，特别适合当前的快速开发环境。这意味着你不需要像在 C++ 中那样显式地分离声明和定义



### 1.比较结构和类

结构和枚举赋值的时候是拷贝，类赋值的时候是引用，引用原来的内存地址

**相同点**：

- 定义属性以存储值
- 定义提供功能的方法
- 定义下标以使用下标语法提供对其值的访问
- 定义初始值设定项以设置其初始状态
- 扩展以将其功能扩展到默认实现之外
- 符合协议以提供某种标准功能



**类具有结构所不具备的其他功能：**

- 继承使一个类能够继承另一个类的特征。(**结构不能继承**)
- 类型转换使您能够在运行时检查和解释类实例的类型。
- 反初始化程序使类的实例能够释放它已分配的任何资源。
- 引用计数允许对一个类实例进行多个引用。(**类是引用,枚举和结构是拷贝**)



类支持的附加功能是以增加复杂性为代价的。作为一般准则，更喜欢结构，因为它们更容易推理，并在适当或必要时使用类。在实践中，这意味着您定义的大多数自定义类型将是结构和枚举。有关更详细的比较，请参阅在结构和类之间进行选择。



> **Note**:
>
> 结构和类具有类似的定义语法。使用 `struct` 关键字引入结构，使用 `class` 关键字引入类。两者都将其整个定义放在一对大括号中：







### 2.定义语法

结构和类具有类似的定义语法。使用 `struct` 关键字引入结构，使用 `class` 关键字引入类。两者都将其整个定义放在一对大括号中：

```swift
struct SomeStructure {
    // structure definition goes here
}
class SomeClass {
    // class definition goes here
}
```



> **Note**:
>
> 每当定义新的结构或类时，都会定义新的 Swift 类型。为类型 `UpperCamelCase` 命名（如 `SomeStructure` 和 `SomeClass` here）以匹配标准 Swift 类型（如 `String` 、 `Int` 和 `Bool` ）的大写。为属性和方法 `lowerCamelCase` 命名（如 `frameRate` 和 `incrementCount` ），以将它们与类型名称区分开来。



下面是结构定义和类定义的示例：

```swift
struct Resolution {
    var width = 0  //默认值
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?  //default value:nil 
}
```



上面的示例定义了一个名为 `Resolution` 的新结构，用于描述基于像素的显示分辨率。此结构有两个存储属性，分别称为 `width` 和 `height` 。存储属性是捆绑在一起并存储为结构或类的一部分的常量或变量。通过将这两个属性设置为初始整数值 `0` 来推断它们的类型 `Int` 。

上面的示例还定义了一个名为 `VideoMode` 的新类，用于描述视频显示的特定视频模式。此类具有四个变量存储属性。第一个 `resolution` ，使用新的 `Resolution` 结构实例进行初始化，该实例推断出 的属性类型为 `Resolution` 。对于其他三个属性，将 `VideoMode` 使用 `interlaced` 设置 `false` （表示“非隔行扫描视频”）、播放帧速率 `0.0` 和 称为 `name` 的可选 `String` 值 来初始化新实例。该 `name` 属性会自动指定默认值 `nil` ，或“无 `name` 值”，因为它是可选类型。





### 3. 实例化类和结构

`Resolution` 结构定义和 `VideoMode` 类定义仅描述 a `Resolution` 或 `VideoMode` 将是什么样子。它们本身没有描述特定的分辨率或视频模式。为此，您需要创建结构或类的实例。

对于结构和类，创建实例的语法非常相似：

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

结构和类都对新实例使用初始值设定项语法。初始值设定项语法的最简单形式使用类或结构的类型名称，后跟空括号，例如 `Resolution()` 或 `VideoMode()` 。这将创建类或结构的新实例，并将所有属性初始化为其默认值。类和结构初始化在初始化中进行了更详细的描述。





### 4.访问属性

您可以使用点语法访问实例的属性。在点语法中，将属性名称紧跟在实例名称之后，用句点 （ `.` ） 分隔，不带任何空格：

```swift
print("The width of someResolution is \(someResolution.width)")
// Prints "The width of someResolution is 0"
```

在此示例中，引用 的 `width` `someResolution` 属性， `someResolution.width` 并返回其默认初始值 `0` 。

您可以向下钻取到子属性，例如 `width` `resolution` ： `VideoMode`

```swift
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is 0"
```

还可以使用点语法为变量属性分配新值：

```swift
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is now 1280"
```





### 5. 结构类型的成员初始值的设定

所有结构都有一个自动生成的成员初始值设定项，您可以使用该初始值设定项初始化新结构实例的成员属性。可以按名称将新实例属性的初始值传递给成员初始值设定项：

```swift
let vga = Resolution(height: 1080, width: 1920)
let vga2 = Resolution(width: 1920,height: 1080) //Error 按照顺序
let vga4 = Resolution(height: 20)  //ok width will be set to default value
```

与结构不同，类实例不会接收默认的成员初始值设定项。初始化中更详细地介绍了初始值设定项。



### 6.结构和枚举是值类型

**赋值的时候是拷贝**

值类型是一种类型，当其值被分配给变量或者常量的时候，活着当他被传递给函数的时候，其值会被复制

实际上，在前面的章节中，您一直在广泛使用值类型。事实上，Swift 中的所有基本类型——整数、浮点数、布尔值、字符串、数组和字典——都是值类型，并且在幕后作为结构实现。

所有结构和枚举都是 Swift 中的值类型。这意味着，当您创建的任何结构和枚举实例（以及它们作为属性具有的任何值类型）在代码中传递时，始终会复制它们。

>
>
>**Note**:
>
>Swift 标准库定义的集合（如数组、字典和字符串）使用优化来降低复制的性能成本。这些集合不会立即创建副本，而是在原始实例和任何副本之间共享存储元素的内存。如果修改了集合的其中一个副本，则会在修改之前复制元素。您在代码中看到的行为始终就像立即发生了复制一样。



请考虑此示例，它使用上一示例中的 `Resolution` 结构：

```swift
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
```

此示例声明一个调用 `hd` 的常量，并将其设置为使用全高清视频的宽度和高度（1920 像素宽 x 1080 像素高）初始化的 `Resolution` 实例。

然后，它声明一个 调用 `cinema` 的变量，并将其设置为当前值 `hd` 。因为 `Resolution` 是一个结构，所以会创建现有实例的副本，并将此新副本分配给 `cinema` 。尽管 `hd` 现在 `cinema`具有相同的宽度和高度，但它们在幕后是两个完全不同的实例。



接下来，将 `width` 的 `cinema` 属性修改为用于数字电影放映的稍宽的 2K 标准的宽度（2048 像素宽和 1080 像素高）：

```swift
cinema.width = 2048
```

检查 `width` 属性 `cinema` 表明它确实已更改为 `2048` ：

```swift
print("cinema is now \(cinema.width) pixels wide")
// Prints "cinema is now 2048 pixels wide"
```

但是，原始 `hd` 实例的 `width` 属性仍具有以下 `1920` 旧值：

```swift
print("hd is still \(hd.width) pixels wide")
// Prints "hd is still 1920 pixels wide"
```

当 `cinema` 给定当前值 时 `hd` ，存储在 `hd` 中的值被复制到新 `cinema` 实例中。最终结果是两个完全独立的实例，它们包含相同的数值。但是，由于它们是单独的实例，因此设置 `cinema`to `2048` 的宽度不会影响存储在 `hd` 中的宽度，如下图所示：

<img src= "https://docs.swift.org/swift-book/images/org.swift.tspl/sharedStateStruct@2x.png" style="width:100%">

相同的行为也适用于枚举：

```swift
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {  //mutating标记自己的值会被改变
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()


print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// Prints "The current direction is north"
// Prints "The remembered direction is west"
```

当 `rememberedDirection` 被赋值 `currentDirection` 时，它实际上被设置为该值的副本。 `currentDirection` 更改 thereafter 的值不会影响存储在 `rememberedDirection` 中的原始值的副本。







### 7. 类是引用类型

与值类型不同，当引用类型被分配给变量或常量时，或者当它们被传递给函数时，不会复制它们。使用对同一现有实例的引用，而不是副本。



下面是一个示例，使用上面定义的 `VideoMode` 类：

```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
```



此示例声明一个调用 `tenEighty` 的新常量，并将其设置为引用 `VideoMode` 类的新实例。视频模式被分配了之前的高 `1920` `1080` 清分辨率的副本。它设置为隔行扫描，其名称设置为 `"1080i"` ，其帧速率设置为每秒 `25.0` 帧数。



接下来， `tenEighty` 分配给一个新的常量，称为 `alsoTenEighty` ，并修改 的 `alsoTenEighty` 帧速率：

```swift
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
```



因为类是引用类型， `tenEighty` `alsoTenEighty` 实际上两者都引用同一个 `VideoMode` 实例。实际上，它们只是同一个实例的两个不同名称，如下图所示：

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/sharedStateClass@2x.png">



检查 的 `frameRate` `tenEighty` 属性表明它正确地报告了来自基础 `VideoMode` 实例的新 `30.0` 帧速率：



此示例还演示了引用类型如何更难推理。如果 `tenEighty` 程序代码中 和 `alsoTenEighty`相距甚远，则可能很难找到更改视频模式的所有方式。无论你在哪里使用 `tenEighty` ，你还必须考虑使用 `alsoTenEighty` 的代码，反之亦然。相比之下，值类型更易于推理，因为与相同值交互的所有代码在源文件中都非常接近。



请注意， `tenEighty` 和 `alsoTenEighty` 声明为常量，而不是变量。但是，您仍然可以更改 `tenEighty.frameRate` ， `alsoTenEighty.frameRate` 因为 `tenEighty` 和 `alsoTenEighty` 常量本身的值实际上不会更改。 `tenEighty` 而且 `alsoTenEighty` 它们本身并不“存储” `VideoMode` 实例——相反，它们都指的是幕后的 `VideoMode` 实例。更改的是基础 `frameRate` 的属性，而不是对该 `VideoMode` 基础 `VideoMode` 的常量引用的值。



> 
>
> **Note:**
>
> ```swift
> let tenEighty = VideoMode()
> let alsoTenEighty = tenEighty
> 
> // tenEighty 和 alsoTenEighty 是一个指针,指向内存中的对象 
> // 所以可以修改对象 只是不能让对象指向别的地方
> 
> let obj2 = VideoMode()
> alsoTenEighty = obj2() //Error 试图让alsoTenEighty指向别的地方
> ```
>
> 





### 8. 身份运算符

**身份运算符只能用于class，判断是否是相同的内存地址,结构和Enum都是拷贝,所以不在一个内存地址**

由于类是引用类型，因此多个常量和变量可以在后台引用类的同一单个实例。（结构和枚举并非如此，因为它们在分配给常量或变量或传递给函数时总是被复制。



Swift 提供了两个身份运算符：

1. **===：判断两个引用是否指向同一个实例(相同的内存地址)。**

2. **!==：判断两个引用是否指向不同的实例**

   

```swift
class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let person1 = Person(name: "Alice")
let person2 = Person(name: "Alice")
let person3 = person1

//盘
if person1 !== person2 {
    print("person1 and person2 are different instances.")
} else {
    print("person1 and person2 are the same instance.")
}

if person1 === person3 {
    print("person1 and person3 are the same instance.")
} else {
    print("person1 and person3 are different instances.")
}

```



请注意，相同（由三个等号表示，或 `===` ）并不意味着等于（由两个等号表示，或 `==` ）的意思相同。“相同”表示两个类类型的常量或变量引用完全相同的类实例。等于表示两个实例的值相等或相等，对于类型设计器定义的 equal 的某些适当含义。



当您定义自己的自定义结构和类时，您有责任决定什么符合两个实例相等的条件。定义自己的 `==` and `!=` 运算符实现的过程在等效运算符中进行了描述。



### 9.指针

如果您有 C、C++ 或 Objective-C 的经验，您可能知道这些语言使用指针来引用内存中的地址。引用某种引用类型实例的 Swift 常量或变量类似于 C 语言中的指针，但不是指向内存中地址的直接指针，并且不需要您编写星号 （ `*` ） 来指示您正在创建引用。相反，这些引用的定义与 Swift 中的任何其他常量或变量一样。Swift 标准库提供了指针和缓冲区类型，如果你需要直接与指针交互，你可以使用它们——参见手动内存管理。
