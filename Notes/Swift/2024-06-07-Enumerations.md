---
layout: post
author: "大西瓜"
title: "Enumerations"
date:   2024-06-07 08:30:26 +0800
categories: [update,Swift] 
---

## Enumeration 枚举

枚举为一组相关值定义通用类型，并使您能够在代码中以类型安全的方式处理这些值。

如果您熟悉 C，您就会知道 C 枚举将相关名称分配给一组整数值。Swift 中的枚举更加灵活，不必为枚举的每个情况提供值。如果为每个枚举事例提供值（称为原始值），则该值可以是字符串、字符或任何整数或浮点类型的值。

或者，枚举事例可以指定要与每个不同事例值一起存储的任何类型的关联值，就像其他语言中的联合或变体一样。可以将一组常见的相关事例定义为一个枚举的一部分，每个枚举都有一组与之关联的相应类型的不同值。

Swift 中的枚举本身就是一流的类型。它们采用许多传统上仅由类支持的功能，例如计算属性，以提供有关枚举当前值的其他信息，以及实例方法，以提供与枚举所表示的值相关的功能。枚举还可以定义初始值设定项以提供初始大小写值;可以扩展以扩展其功能，使其超出其原始实现;并且可以符合协议以提供标准功能。





### 1.枚举语法

使用enum关键字引入枚举，并将其整个定义放在一对大括号中

```swift
enum SomeEnumeration{
	//erations definetion goes here	
}
```



以下是指南针的四个要点的示例：

```siwft
enum CompassPoint{
	case north
	case south
	case east
	case west	
}	
```



枚举中定义的值（如 `north` 、 `south` 、 `east` 和 `west` ）是其枚举事例。使用关键 `case` 字引入新的枚举事例。



> **Note**:默认情况下，Swift 枚举案例不设置整数值，这与 C 和 Objective-C 等语言不同。在上面的 `CompassPoint` 示例中， `north` 、 `south` `east` 和 `west` 不隐式等于 `0` 、 `1` 和 `2` `3` 。相反，不同的枚举事例本身就是值，其显式定义的类型为 `CompassPoint` 。



多个案例可以出现在一行中，用逗号分隔：

```
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```



每个枚举定义都定义一个新类型。与 Swift 中的其他类型一样，它们的名称（如 CompassPoint 和 Planet ）以大写字母开头。为枚举类型提供单数名称而不是复数名称，以便它们读起来不言而喻：

```swift
var directionToHead = CompassPoint.west
```

 `directionToHead` 类型是已知的，因此您可以在设置其值时删除该类型。这使得在使用显式类型化的枚举值时代码具有高度可读性。

```swift
directionToHead = .east
```

`directionToHead` 类型是已知的，因此您可以在设置其值时删除该类型。这使得在使用显式类型化的枚举值时代码具有高度可读性。



### 2.使用Switch语句匹配枚举值

可以使用Switch匹配单个枚举值

```swift
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins"
```

您可以将此代码读取为：

“考虑 `directionToHead` .在等 `.north` 于 的情况下，打印 `"Lots of planets have a north"` 。在等于的情况下 `.south` ，打印 `"Watch out for penguins"` .”

如控制流中所述，在考虑枚举的情况时， `switch` 语句必须详尽无遗。如果省略 `case` for `.west` ，则不会编译此代码，因为它不考虑 `CompassPoint` 完整的事例列表。要求详尽可确保枚举案例不会被意外遗漏。

**必须每个值都匹配**

如果不适合为每个枚举案例提供 a `case` ，则可以提供一个 `default` 案例来涵盖未显式解决的任何案例：

```swift
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless"
```







### 3.遍历枚举事例

对于某些枚举，收集该枚举的所有事例很有用。您可以通过在枚举名称后写入 `: CaseIterable` 来启用此功能。Swift 将所有事例的集合公开为枚举类型的 `allCases` 属性。下面是一个示例：

```swift
enum Beverage: CaseIterable {  //CaseIterable是协议
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"
```



在上面的示例中，您写入 `Beverage.allCases` 以访问包含枚举的所有事例 `Beverage` 的集合。可以像使用任何其他集合一样使用 `allCases` 集合 - 集合的元素是枚举类型的实例，因此在本例中它们是 `Beverage` 值。上面的示例计算了有多少个案例，下面的示例使用 `for` - `in` 循环遍历所有案例。

```swift
for beverage in Beverage.allCases {
    print(beverage)
}
// coffee
// tea
// juice
```

上面示例中使用的语法将枚举标记为符合 `CaseIterable` 协议。有关协议的信息，请参阅协议。



###  4.Associated Value 相关值

上一节中的示例演示枚举的大小写本身如何成为定义（和类型化）值。您可以将常量或变量设置为 `Planet.earth` ，稍后检查此值。但是，有时能够将其他类型的值与这些事例值一起存储很有用。此附加信息称为关联值，每次在代码中使用该大小写作为值时，它都会有所不同。

您可以定义 Swift 枚举来存储任何给定类型的关联值，如果需要，枚举的每种情况的值类型都可以不同。与这些类似的枚举在其他编程语言中称为有区别的联合、标记的联合或变体。

例如，假设库存跟踪系统需要通过两种不同类型的条形码跟踪产品。某些产品标有 UPC 格式的一维条形码，该条形码使用数字 `0` `9` .每个条形码都有一个数字系统数字，后跟五个制造商代码数字和五个产品代码数字。这些后面跟着一个校验位，以验证代码是否已正确扫描：

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/barcode_UPC@2x.png" style="width:50%">

其他产品标有二维码格式的二维条码，可以使用任何 ISO 8859-1 字符，并且可以编码长达 2,953 个字符的字符串：

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/barcode_QR@2x.png" style="width:20%">



在 Swift 中，用于定义任一类型的产品条形码的枚举可能如下所示：

```
enum BarCode{
	case upc(Int,Int,Int,Int)
	case qrCode(String)
}
```

这可以理解为：

“定义一个名为 `Barcode` 的枚举类型，该类型可以采用具有 `upc` 类型 （ `Int` ， `Int` ， `Int` ， `Int` ） 的关联值的值，也可以采用具有类型 `String` 的关联值的值 `qrCode` 。”



此定义不提供任何实际 `Int` 值或 `String` 值，它只是定义 `Barcode` 常量和变量等于 `Barcode.upc` 或 `Barcode.qrCode` 时可以存储的关联值的类型。



然后，您可以使用以下任一类型创建新条形码：

```swift
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
```



此时，原始 `Barcode.upc` 值及其整数值将替换为 new `Barcode.qrCode` 及其字符串值。类型的 `Barcode` 常量和变量可以存储 a `.upc` 或 a `.qrCode` （及其关联值），但它们在任何给定时间只能存储其中一个。



您可以使用 switch 语句检查不同的条形码类型，类似于使用 switch 语句匹配枚举值中的示例。但是，这一次，关联的值将作为 switch 语句的一部分提取。将每个关联值提取为常量（带 `let` 前缀）或变量（带 `var` 前缀），以便在 `switch` 事例正文中使用：



```swift
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```



如果枚举事例的所有关联值都提取为常量，或者如果所有值都提取为变量，则为简洁起见，可以在事例名称之前放置单个 `let` 值或 `var` 批注：

```swift
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```





### 5.枚举的原始值

关联值中的条形码示例显示了枚举的大小写如何声明它们存储不同类型的关联值。作为关联值的替代方法，枚举事例可以预填充默认值（称为原始值），这些值都属于同一类型。

下面是一个将原始 ASCII 值与命名枚举事例一起存储的示例：

```swift
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
```

在这里，调用 `ASCIIControlCharacter` 的枚举的原始值被定义为 类型 `Character` 为 ，并设置为一些更常见的 ASCII 控制字符。 `Character` 值在字符串和字符中进行了描述。

原始值可以是字符串、字符或任何整数或浮点数类型。每个原始值在其枚举声明中必须是唯一的。

>
>
> **Note**:
>
>原始值与关联值不同。首次在代码中定义枚举时，原始值将设置为预填充的值，如上面的三个 ASCII 代码。特定枚举事例的原始值始终相同。关联值是在基于枚举的事例之一创建新常量或变量时设置的，并且每次执行此操作时都可能不同。





### 6. 隐式分配的原始值

使用存储整数或字符串原始值的枚举时，不必为每个事例显式分配原始值。如果你不这样做，Swift 会自动为你分配值。

例如，当整数用于原始值时，每个事例的隐式值都比前一个事例多一个。如果第一种情况没有设置值，则其值为 `0` 。

下面的枚举是对早期 `Planet` 枚举的改进，使用整数原始值表示每个行星从太阳到太阳的顺序：

```swift
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

let oneOfPlanet:Planet = .venus
print("planet.venus  = \(oneOfPlanet)")   
//planet.venus  = venus
print("planet.venus.rawValue  = \(oneOfPlanet.rawValue)")
//planet.venus.rawValue  = 2
```

在上面的示例中， `Planet.mercury` 具有显 `1` 式原始值 ， `Planet.venus` 具有隐 `2` 式原始值 ，依此类推。



当字符串用于原始值时，每个事例的隐式值是该事例名称的文本。

```swift
enum CompassPoint: String {
    case north, south, east, west
}

```

在上面的示例中， `CompassPoint.south` 具有隐 `"south"` 式原始值 ，依此类推。

您可以使用枚举事例的属性访问其 `rawValue` 原始值：

```swift
let earthsOrder = Planet.earth.rawValue
// earthsOrder is 3


let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection is "west"
```



>
>
>**Note**: rawValue 必须是enum类型有默认类型才可以 比如Int or String

```swift
enum Etype{ //不可以使用.rawValue属性
... 
}

enum Etype2:Int{ //可以使用.rawValue属性
...
}
```





### 7. 从原始值初始化

如果使用原始值类型定义枚举，则枚举会自动接收一个初始值设定项，该初始值设定项采用原始值类型的值（作为称为 `rawValue` 的参数），并返回枚举事例或 `nil` .可以使用此初始值设定项尝试创建枚举的新实例。

这个例子从天王星的原始值来 `7` 识别天王星：

```swift
let possiblePlanet = Planet(rawValue: 7)  //可选类型
// possiblePlanet is of type Planet? and equals Planet.uranus
```

然而，并非所有可能的 `Int` 值都会找到匹配的行星。因此，原始值初始值设定项始终返回可选的枚举事例。在上面的示例中， `possiblePlanet` 是 类型 `Planet?` ，或“可选 `Planet` ”。



>
>
>**Note**:
>
>原始值初始值设定项是可失败的初始值设定项，因为并非每个原始值都会返回枚举事例。有关更多信息，请参见可失败的初始值设定项。



如果您尝试查找位置为 `11` 的行星，则原始值初始值设定项返回的可选 `Planet` 值将是 `nil` ：

```swift
let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// Prints "There isn't a planet at position 11"
```



此示例使用可选绑定来尝试访问原始值为 的 `11` 行星。该语句 `if let somePlanet = Planet(rawValue: 11)` 创建一个可选的 `Planet` ，并设置为 `somePlanet` 该可选的 `Planet` 值（如果可以检索）。在这种情况下，无法检索位置为 `11` 的行星，因此将执行 `else` 分支。





### 8.递归枚举 ❕TODO:不太懂

递归枚举是一种枚举，它具有枚举的另一个实例作为一个或多个枚举事例的关联值。您可以通过在枚举事例之前写入 `indirect` 来指示枚举事例是递归的，这告诉编译器插入必要的间接层。

例如，下面是一个存储简单算术表达式的枚举：

```swift
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

还可以在枚举开始之前编写 `indirect` ，以便为枚举中具有关联值的所有事例启用间接操作：

```swift
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

此枚举可以存储三种算术表达式：纯数、两个表达式的相加和两个表达式的乘法。 `addition` 和 `multiplication` 事例具有关联的值，这些值也是算术表达式 — 这些关联值使嵌套表达式成为可能。例如，表达 `(5 + 4) * 2` 式在乘法的右侧有一个数字，在乘法的左侧有另一个表达式。由于数据是嵌套的，因此用于存储数据的枚举也需要支持嵌套，这意味着枚举需要是递归的。下面的代码显示了正在为以下 `(5 + 4) * 2` 对象创建 `ArithmeticExpression` 的递归枚举：

```swift
//标记一种东西,还有一些方法
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
```



递归函数是处理具有递归结构的数据的一种简单方法。例如，下面是一个计算算术表达式的函数：

**递归函数,要求计算枚举类型的返回值，并且实现enum里面的方法**

```swift
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}


print(evaluate(product))
// Prints "18"
```

此函数通过简单地返回关联值来计算纯数字。它通过计算左侧的表达式，计算右侧的表达式，然后将它们相加或相乘来计算加法或乘法。



以上例子可以理解为

```swift
indirect enum MyEnumType{
		case value(值)										//值
		case 方法1(MyenumType,myEnumType)	//只是标记一个方法，可以用具体函数来实现
		case 方法2(MyenumType,myEnumType) //标记第二种方法
}

func 递归函数(_ 参数:MyEnumType ) -> Int(or otherType) {
  switch MyEnumType{
    case let .value(值):
    	return 值
   	case let .adddition(left,right):
    	return 递归函数(left) + 递归函数(right)  //要具体的返回类型 或者递归
    case let .mutiExpress(left,right):
    	return 递归函数(left) operator 递归函数(right)
  }
}


```



### 9. Enum里面的static

**By chatgpt:**

在 Swift 中，`enum` 是一种值类型，用于定义一组相关的值或状态。尽管枚举不能被继承，它们可以包含 `static` 属性和方法。使用 `static` 属性和方法可以为枚举类型提供与具体实例无关的共享数据或行为。

**为什么 `enum` 可以使用 `static` 变量**

`static` 属性和方法在类型本身上定义，而不是在类型的实例上定义。这对于枚举来说是有意义的，因为枚举实例是值类型，每个实例都是独立的。但有时我们需要一些与实例无关的共享数据或方法，例如计数、通用的实用方法或常量。`static` 属性和方法正好满足了这种需求。

**如何在 `enum` 中使用 `static` 变量和方法**

以下是一些示例，展示了如何在枚举中使用 `static` 属性和方法：

**示例 1：静态属性**

```swift
enum Direction {
    case north
    case south
    case east
    case west

    // 静态属性，用于存储一些与实例无关的共享数据
    static var allDirections: [Direction] {
        return [.north, .south, .east, .west]
    }
}

// 访问静态属性
let directions = Direction.allDirections
print(directions)  // 输出: [Direction.north, Direction.south, Direction.east, Direction.west]
```

**示例 2：静态方法**

```swift
enum Math {
    case add
    case subtract
    case multiply
    case divide

    // 静态方法，用于一些与实例无关的操作
    static func calculate(_ operation: Math, _ a: Double, _ b: Double) -> Double {
        switch operation {
        case .add:
            return a + b
        case .subtract:
            return a - b
        case .multiply:
            return a * b
        case .divide:
            return a / b
        }
    }
}

// 使用静态方法
let result = Math.calculate(.add, 10, 20)
print(result)  // 输出: 30.0
```

 **示例 3：静态常量**

```swift
enum AppConfig {
    static let apiEndpoint = "https://api.example.com"
    static let apiKey = "ABC123"

    case someCase
}

// 访问静态常量
let endpoint = AppConfig.apiEndpoint
print(endpoint)  // 输出: https://api.example.com
```

**解释**

1. **静态属性**：`static var allDirections: [Direction]` 定义了一个静态属性，返回所有可能的方向。这些数据与任何实例无关，因此定义为静态属性。
2. **静态方法**：`static func calculate(_ operation: Math, _ a: Double, _ b: Double) -> Double` 定义了一个静态方法，根据枚举值执行数学计算。这种方法在不需要实例的情况下提供实用功能。
3. **静态常量**：`static let apiEndpoint = "https://api.example.com"` 定义了一个静态常量，存储 API 端点地址，这在整个应用程序中都是共享的，不依赖于任何实例。

**总结**

- **`static` 关键字**：在枚举中使用 `static` 关键字，可以定义与实例无关的共享属性和方法。
- **用途**：用于定义常量、实用方法或其他与实例无关的共享数据。

通过这些示例和解释，可以更好地理解如何在 Swift 中的枚举中使用 `static` 属性和方法，以实现与实例无关的共享数据或行为。
