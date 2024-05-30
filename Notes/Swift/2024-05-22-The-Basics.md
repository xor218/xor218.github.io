---
layout: post
author: "大西瓜"
title: "The Basics"
date:   2024-05-22 12:30:07 +0800
categories: [update,Swift] 
---

## 1.基础知识

Swift提供了许多基本的数据类型，包括用于整数的 Int ，用于浮点值的 Double ，用于布尔值的 Bool 和用于文本的 String 。Swift还提供了三种主要集合类型的强大版本： Array 、 Set 和 Dictionary ，如集合类型中所述。



### 1.1 基础数据类型

    -   Int
    -   Double
    -   Bool
    -   String
    -   Array
    -   Set
    -   Dictionary 


#### 1.1.1 可选类型

在声明变量的时候，后面跟一个❓代表是可选类型

```swift
var optionalInt: Int? = 10
var optionalString: String? = "Hello, Swift"
var optionalDouble: Double? = nil

//强制解包 先判断 然后在后面加上!号
if optionalInt != nil {
    print("Value is \(optionalInt!)")
}


//可选绑定（Optional Binding）：
//使用 if let 或 guard let 语句来安全地解包可选值。
if let value = optionalInt {
    print("Value is \(value)")
} else {
    print("Value is nil")
}

//合并运算符
let value = optionalInt ?? 0
print("Value is \(value)")
```



### 1.2 声明常量和变量

常量和变量必须在使用前声明。使用 `let` 关键字声明常量，使用 `var` 关键字声明变量。下面是一个示例，说明如何使用常量和变量来跟踪用户尝试登录的次数：

```swift
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
```



### 1.3 声明变量需要指定其类型
```swift
let env="development"
let maxValue:Int
if env=="development1"{
    maxValue=100}
else{
    maxValue=10
}
print("value maxValue = \(maxValue)")
//output:value maxValue = 10
```




### 1.4 声明多个变量

声明多个变量用逗号分隔

```swift
var x=1.0,y=2.3,z=0.1
```


### 1.5 类型注解

在声明常量或变量时，可以提供类型批注，以明确常量或变量可以存储的值的类型。在常量或变量名后加一个冒号，后跟一个空格，然后是要使用的类型名，这样就可以编写一个类型注释。

```swift
var welcomeMessage:String
WelcomeMessage="Hello"
print(WelcomeMessage)
```

### 1.6 常量和变量名

常量和变量名几乎可以包含任何字符，包括Unicode字符：
```swift
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dog——cow"
let 密码="password Error"
```

常量和变量名称不能包含空格字符、数学符号、箭头、专用Unicode标量值或线条和方框绘制字符。它们也不能以数字开始，尽管数字可能包含在名称的其他地方。

一旦你声明了一个特定类型的常量或变量，你就不能用同样的名字再次声明它，或者改变它来存储不同类型的值。你也不能把一个常数变成一个变量，或者把一个变量变成一个常数。


```swift
let languageName = "Swift"
languageName = "Swift++"  //error 常量 can't 改变
```

### 1.7 打印常量和变量
变量放括号内，并且使用"\\"进行转义
```swift
var value="Xigua"
print("my name is \(value)")
```


### 1.8 注释
注释和C一样

```swift
//我是单行注释
/* 我是多行注释
* 我是多行注释
*/
```

```swift
/* This is the start of the first multiline comment.
    /* 内嵌注释也ok的This is the second, nested multiline comment. */
This is the end of the first multiline comment. */
```
### 1.9 分号
与许多其他语言不同，Swift不要求你在代码中的每个语句后面写一个标记（ ; ），尽管你可以这样做，如果你愿意的话。但是，如果要在一行中编写多个单独的语句，则需要使用通配符：

```swift
let cat = "🐱"; print(cat)
// Prints "🐱"
```




### 1.10 整数

整数是没有小数部分的整数，例如 42 和 -23 。整数可以是有符号的（正、零或负）或无符号的（正或零）。

Swift提供8、16、32和64位形式的有符号和无符号整数。这些整数遵循类似于C的命名约定，8位无符号整数的类型为 UInt8 ，32位有符号整数的类型为 Int32 。像Swift中的所有类型一样，这些整数类型的名称都大写。




#### 1.10.1 边界

您可以使用其 min 和 max 属性访问每个整数类型的最小值和最大值：
```swift
let val1 = UInt8.min  // val1 is equal to 0, and is of type UInt8
let val2 = UInt8.max  // val2 is equal to 255, and is of type UInt8
print("MinValue = \(val1)")   //output:0
print("MaxValue = \(val2)")   //output:255
```




#### 1.10.2 Int

在大多数情况下，你不需要选择一个特定大小的整数在你的代码中使用。Swift提供了一个额外的整数类型， Int ，它的大小与当前平台的原生单词大小相同：

在32位平台上， Int 与 Int32 大小相同。
在64位平台上， Int 与 Int64 大小相同。

除非你需要处理一个特定大小的整数，否则在你的代码中总是使用 Int 来表示整数值。这有助于代码的一致性和互操作性。即使在32位平台上， Int 也可以存储 -2,147,483,648 和 2,147,483,647 之间的任何值，并且对于许多整数范围来说足够大。






#### 1.10.3 UInt

Swift还提供了一个无符号整数类型， UInt ，它的大小与当前平台的原生字大小相同：

在32位平台上， UInt 与 UInt32 大小相同。
在64位平台上， UInt 与 UInt64 大小相同。






### 1.11 浮点数

浮点类型可以表示比整数类型更大范围的值，并且可以存储比 Int 中存储的数字大得多或小得多的数字。Swift提供了两种有符号浮点数类型：

Double 表示64位浮点数。
Float 表示32位浮点数。










### 1.12 类型安全和类型推断

Swift是类型安全的语言。类型安全语言鼓励您清楚地了解代码可以使用的值的类型。如果你的部分代码需要一个 String ，你不能错误地传递一个 Int 。

因为Swift是类型安全的，它在编译代码时执行类型检查，并将任何不匹配的类型标记为错误。这使您能够在开发过程中尽早捕获和修复错误。


类型检查可以帮助您在处理不同类型的值时避免错误。然而，这并不意味着你必须指定你声明的每个常量和变量的类型。如果你没有指定你需要的值的类型，Swift会使用类型推断来计算出合适的类型。类型推断使编译器能够在编译代码时自动推断特定表达式的类型，只需检查您提供的值即可。


由于类型推断，Swift需要的类型声明远少于C或J2EE—C等语言。常量和变量仍然是显式类型的，但是指定它们类型的大部分工作都是为您完成的。

类型推断在声明具有初始值的常量或变量时特别有用。这通常是通过在声明常量或变量时为其分配一个文字值（或文字）来实现的。（文字值是直接出现在源代码中的值，例如下面示例中的 42 和 3.14159 。）

例如，如果你给一个新的常量赋值为 42 ，而没有说明它是什么类型，Swift会推断你希望这个常量是 Int ，因为你已经用一个看起来像整数的数字初始化了它：

```swift
let meaningOfLife = 42
```
同样地，如果你没有为浮点文字指定类型，Swift会推断你想要创建一个 Double ：
```swift
let pi = 3.14159
```

如果你在一个表达式中组合了联合收割机整数和浮点文字，那么将从上下文中推断出一个类型 Double ：
```swift
let anotherPi = 3 + 0.14159
```
**Error**
```swift
var val3:Int
val3=3.16
print("val3 = \(val3)")
//output:error: cannot assign value of type 'Double' to type 'Int'
```









### 1.13 数字表示法

#### 1.13.1 整数
可以这样写：

十进制数，没有前缀
二进制数，带 0b 前缀
一个八进制数，带有 0o 前缀
十六进制数，带 0x 前缀

```swift
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 in binary notation
let octalInteger = 0o21           // 17 in octal notation
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation

//负数
let SignedbinaryInteger:Int8 = -0b1000000      // 17 in binary notation

```

#### 1.13.2 浮点数

浮点字面值可以是十进制（无前缀）或十六进制（带 0x 前缀）。它们必须始终在小数点的两边都有一个数字（或十六进制数）。十进制浮点数也可以有一个可选的指数，由一个浮点数或一个浮点数 e 表示;十六进制浮点数必须有一个指数，由一个浮点数或一个浮点数 p 表示。

**对于指数为 x 的十进制数，基数乘以10：**
1.25e2 表示1.25 x 10²，或 125.0 。
1.25e-2 表示1.25 x 10 ²，或 0.0125 。

**对于指数为 x 的十六进制数，基数乘以2：**
0xFp2 表示15 x 2 ²或 60.0 。
0xFp-2 表示15 x 2 -²，或 3.75 。

所有这些浮点文字都有一个十进制值 12.1875 ：


#### 1.13.3 额外补充

数字文本可以包含额外的格式以使其更容易阅读。整数和浮点数都可以用额外的零填充，并且可以包含下划线以帮助可读性。这两种格式都不会影响文本的基础值：

```swift
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```


### 1.14 数字类型转换

在你的代码中，对所有通用的整型常量和变量使用 Int 类型，即使它们是非负的。

在日常情况下使用默认整数类型意味着整数常量和变量在代码中可以立即互操作，并且将匹配整数文字值的推断类型。

只有当手头的任务特别需要时，才使用其他整数类型，因为来自外部源的显式大小的数据，或者为了性能，内存使用或其他必要的优化。

在这些情况下使用显式调整大小的类型有助于捕获任何意外的值溢出，并隐式记录所使用的数据的性质。


#### 1.14.1 整数转换

```swift
let cannotBeNegative: UInt8 = -1  //UInt 不能存储负数
let tooBig: Int8 = Int8.max + 1   //Error 
let tooBig:Int = Int( Int8.max) + 1  //先进行类型转换
```


```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)  //先进行类型转换
```

SomeType(ofInitialValue) 是默认的调用Swift类型的初始化器并传入初始值的方式。在幕后， UInt16 有一个接受 UInt8 值的初始化器，因此这个初始化器用于从现有的 UInt8 生成新的 UInt16 。但是，你不能在这里传入任何类型-它必须是 UInt16 提供初始化器的类型。扩展现有类型以提供接受新类型（包括您自己的类型定义）的初始值设定项将在扩展中介绍。



#### 1.14.1 整数浮点数转换

整数和浮点数类型之间的转换必须显式进行：

```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi 的值为3.14159并且编译器会推断类型为double

let integerPi = Int(pi)   //3
// integerPi equals 3, and is inferred to be of type Int
```




### 1.15 类型别名

类型别名定义现有类型的替代名词 可以使用`typealias` 关键字定义类型别名

一旦定义了类型别名，就可以在任何可能使用原始名称的地方使用别名：
```swift
typealias AudioSample = UInt16

var value1 :AudioSample
value1 = AudioSample.min 
```
AudioSample 被定义为 UInt16 的别名。因为它是一个别名，所以对 AudioSample.min 的调用实际上调用了 UInt16.min ，它为 maxAmplitudeFound 变量提供了一个初始值 0 。




### 1.16 布尔值

Swift有一个基本的布尔类型，叫做 Bool 。布尔值被称为逻辑值，因为它们只能是真或假。Swift提供了两个布尔常量值， true 和 false ：
```swift
let orangesAreOrange = true
let turnipsAreDelicious = false
```
orangesAreOrange 和 turnipsAreDelicious 的类型被推断为 Bool ，因为它们是用布尔值初始化的。与上面的 Int 和 Double 一样，如果在创建常量或变量时将它们设置为 true 或 false ，则不需要将它们声明为 Bool 。类型推断有助于使Swift代码更加简洁和可读，当它将常量或变量与其他类型已知的值相关联时。

布尔值在使用条件语句（如 if 语句）时特别有用：
```swift
if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}
// Prints "Eww, turnips are horrible."
```

Swift的类型安全防止非布尔值被替换为 Bool 。下面的示例报告编译时错误：
```swift
let i=1
if i {
    //不会编译成功，会报错
}

let n=2
if n == 2{
    // n == 2 的结果是Bool 所以可以通过编译
}

```


### 1.17 Tuple 元祖

元组将多个值分组为单个复合值。元组中的值可以是任何类型，并且不必彼此具有相同的类型。


在这个例子中， (404, "Not Found") 是一个描述HTTP状态码的元组。HTTP状态码是当您请求网页时由Web服务器返回的特殊值。如果您请求的网页不存在，则返回状态代码 404 Not Found 。

```swift
let http404Error = (404, "Not Found")
// http404Error is of type (Int, String), and equals (404, "Not Found")
```
(404, "Not Found") 元组将 Int 和 String 组合在一起，给予HTTP状态码两个独立的值：一个数字和一个人类可读的描述。它可以被描述为“类型 (Int, String) 的元组”。

您可以从任何类型的排列中创建元组，它们可以包含任意多的不同类型。没有什么可以阻止你拥有一个类型为 (Int, Int, Int) 或 (String, Bool) 的元组，或者你需要的任何其他排列。

```swift
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"
```

如果你只需要元组中的某些值，那么在分解元组时，用下划线（ _ ）忽略元组中的某些部分：

```swift
let (justTheStatusCode,_) = http400Err
print("The status code is \(justTheStatusCode)")
```

或者，使用从零开始的索引号访问元组中的各个元素值：
```swift
print("index 0 of Http400Err = \(http400Err.0)")
print("index 1 of Http400Err = \(http400Err.1)")
```




#### 1.17.1 元祖命名

如果你在元组中命名元素，你可以使用元素名来访问这些元素的值：
```swift

let Http200Status = (statusCode:20, description: "Ok")              //元祖命名
print("http200status.statusCode = \(Http200Status.statusCode) ")    //使用命名
print("http200Status.description = \(Http200Status.description)")
```

**Note**:元组作为函数的返回值特别有用。尝试检索网页的函数可能会返回 (Int, String) 元组类型来描述页面检索的成功或失败。通过返回一个具有两个不同类型的值的元组，该函数提供了更多关于其结果的有用信息，而不是只返回单个类型的单个值。










### 1.18 Optional

在值可能不存在的情况下使用可选值。optional表示两种可能性：或者存在指定类型的值，您可以打开optional以访问该值，或者根本没有值。

作为一个可能丢失值的例子，Swift的 Int 类型有一个初始化器，试图将 String 值转换为 Int 值。但是，只有某些字符串可以转换为整数。字符串 "123" 可以转换为数值 123 ，但是字符串 "hello, world" 没有对应的数值。下面的例子使用初始化器尝试将 String 转换为 Int ：

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
print("convertedNumber = \(convertedNumber)")
//output:convertednumber = Optional(123)
print("convertedNumber = \(convertedNumber!)")

```



**字符串转换成Int类型，结果为nil 无**

```swift
let possibleNumber = "Hello"
let convertedNumber = Int(possibleNumber)
print("convertednumber = \(convertedNumber)")
//output:convertednumber = nil
```

#### 1.18.1 可选类型的作用

在 Swift 中，Int? 后面的问号（?）表示这是一个可选类型（Optional）。可选类型允许变量存储一个值或者存储 nil，表示变量可能没有值。

可选类型在 Swift 中是一种非常重要的特性，用于处理值可能缺失的情况。比如，一个网络请求的响应码可能会成功返回一个整数，也可能会因为网络问题而没有返回任何值。在这种情况下，使用可选类型可以更安全地处理这些情况，避免程序因为访问不存在的值而崩溃。

```swift
var serverResponseCode: Int? = 404
//serverResponseCode 是一个可选的 Int 类型，声明时使用了 Int?
//serverResponseCode 被赋值为 404，但也可以被赋值为 nil，表示没有值。
```

当你使用可选类型时，Swift 强制你安全地处理这些值，以防止错误。例如，要从可选类型中取值，你可以使用以下几种方式：

1.	强制解包（Forced Unwrapping）：
直接在可选值后面加一个感叹号（!），表示你确定这个可选值不是 nil：
```swift
if serverResponseCode != nil {
    print("Server response code: \(serverResponseCode!)")
}
```

2.	可选绑定（Optional Binding）：
使用 if let 或 guard let 语句来安全地解包可选值：
```swift
if let responseCode = serverResponseCode {
    print("Server response code: \(responseCode)")
} else {
    print("No response code received.")
}
```

3.	空合并运算符（Nil Coalescing Operator）：
提供一个默认值，当可选值为 nil 时使用这个默认值：
```swift
let responseCode = serverResponseCode ?? 0
print("Server response code: \(responseCode)")
```



### 1.19 nil

在 Swift 中，nil 用于表示可选类型的变量没有值。可选类型可以包含两种情况：有一个具体的值，或者没有值（nil）。这是通过在类型后面加上一个问号（?）来实现的。

```swift
var optionalInt: Int? = 10  // 有值
optionalInt = nil           // 没有值

var opString:String   //如果设置值 会默认设置为nil
```

当一个变量被定义为可选类型时，它可以是某个类型的值，也可以是 nil。这使得代码更加安全，因为 Swift 强制开发者处理可能的 nil 情况，从而避免运行时错误。

如果一个optional有一个值，它被认为是“不等于” nil ：


```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
// Prints "convertedNumber contains some integer value."
```

您**不能将 nil 用于非可选的常量或变量**。如果代码中的常量或变量需要在某些条件下不存在值的情况下工作，请将其声明为适当类型的可选值。

声明为非可选值的常量或变量保证永远不会包含 nil 值。如果你试图将 nil 赋给一个非可选的值，你会得到一个编译时错误。

这种可选值和非可选值的分离使您可以显式地标记可能丢失的信息，并使编写处理丢失值的代码变得更容易。

你不能意外地把可选的当作非可选的，因为这个错误会在编译时产生一个错误。打开值后，使用该值的其他代码都不需要检查 nil ，因此不需要在代码的不同部分重复检查相同的值。

当你访问一个可选值时，你的代码总是同时处理 nil 和非 nil 的情况。当值丢失时，您可以执行以下几项操作，如以下部分所述：
- 当值为 nil 时，跳过对该值进行操作的代码。 `if someVar ==nil{...}`
- 通过返回 nil 或使用可选链接中描述的 ?. 运算符来验证 nil 值。
- 使用 ?? 操作符提供一个回退值。
- 使用 ! 操作符停止程序执行。




### 1.20 可选绑定

使用可选绑定来确定可选对象是否包含值，如果包含，则使该值作为临时常量或变量可用。可选绑定可以与 if 、 guard 和 while 语句一起使用，以检查可选语句中的值，并将该值提取到常量或变量中，作为单个操作的一部分。有关 if 、 guard 和 while 语句的更多信息，请参见控制流。

为 if 语句编写一个可选绑定，如下所示：
```swift
if let <#constantName#> = <#someOptional#> {
   <#statements#>
}
```

您可以重写Optionals部分的 possibleNumber 示例，以使用可选绑定而不是强制解包：

如果你不需要在访问它包含的值后引用原始的可选常量或变量，你可以对新的常量或变量使用相同的名称：
```swift
let myNumber = Int(possibleNumber)
// Here, myNumber is an optional integer
if let myNumber = myNumber {
    // Here, myNumber is a non-optional integer
    print("My number is \(myNumber)")
}
// Prints "My number is 123"
```


由于这类代码非常常见，您可以使用更短的拼写来解包可选值：只写要解包的常量或变量的名称。新的、未包装的常量或变量隐式地使用与可选值相同的名称。
```swift
if let myNumber {
    print("My number is \(myNumber)")
}
// Prints "My number is 123"
```
您可以通过可选绑定使用常量和变量。如果你想在 if 语句的第一个分支中操作 myNumber 的值，你可以写 if var myNumber ，并且包含在可选语句中的值将作为变量而不是常量。您在 if 语句体中对 myNumber 所做的更改仅适用于该局部变量，而不适用于您解包的原始可选常量或变量。

您可以根据需要在单个 if 语句中包含任意多个可选绑定和布尔条件，并以逗号分隔。如果可选绑定中的任何值为 nil 或任何布尔条件的计算结果为 false ，则整个 if 语句的条件被认为是 false 。下面的 if 语句是等价的：

```swift
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"


if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// Prints "4 < 42 < 100"
```



### 1.21 回退值

处理缺失值的另一种方法是使用nil-coalescing运算符（ ?? ）提供默认值。如果 ?? 左边的可选值不是 nil ，则该值将被解包并使用。否则，使用 ?? 右侧的值。例如，下面的代码通过名字来问候某人（如果指定了一个名字），而当名字是 nil 时则使用通用的问候语。

```swift
var yourName:String?  //默认值为nil
print("hello, " + (yourName ?? "My Friend" ) + "!")
yourName = "idiot"   //not nil now
print("hello, " + (yourName ?? "My Friend" ) + "!")
```



### 1.22 强制展开

当 nil 表示不可恢复的失败时，例如程序员错误或损坏的状态，您可以通过在可选名称的末尾添加感叹号（ ! ）来访问基础值。这被称为强制展开可选的值。当你强制展开一个非 nil 值时，结果是它的展开值。强制展开 nil 值会触发运行时错误。

! 实际上是 fatalError(_:file:line:) 的一个更短的拼写。例如，下面的代码显示了两种等效的方法：
```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
let number = convertedNumber!
guard let number = convertedNumber else {
    fatalError("The number was invalid")
}
```

上面代码的两个版本都依赖于总是包含值的 convertedNumber 。使用上面的任何一种方法，将该需求作为代码的一部分编写，可以让代码在运行时检查该需求是否为真。


### 1.23 隐式展开

如上所述，选项表示允许常量或变量具有“无值”。可以使用 if 语句检查Optional以查看值是否存在，并且可以使用Optional绑定有条件地展开以访问Optional的值（如果它确实存在）。

这些类型的选项被定义为隐式展开的选项。通过在要设置为可选的类型之后放置感叹号（ String! ）而不是问号（ String? ），可以编写隐式展开的可选类型。在声明可选类型时，将感叹号放在可选类型之后，而不是在使用可选类型时在其名称之后放置感叹号。


当一个optional的值在第一次定义后立即被确认存在，并且可以肯定地假设在此后的每一点都存在时，隐式展开的optional是有用的。

在Swift中隐式展开的可选项的主要用途是在类初始化期间，如Unowned References和Implemented Unwrapped Optional Properties中所述。

当变量有可能在以后变成 nil 时，不要使用隐式展开的可选。如果需要在变量的生命周期内检查 nil 值，请始终使用普通的可选类型。

隐式展开的可选值在后台是一个普通的可选值，但也可以像非可选值一样使用，而不需要在每次访问时展开可选值。
```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // Requires explicit unwrapping


let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // Unwrapped automatically
```
您可以将隐式展开的可选对象看作是在需要时允许强制展开可选对象。

当你使用一个隐式解包的可选值时，Swift首先会尝试将它作为一个普通的可选值使用;如果它不能作为一个可选值使用，Swift会强制解包该值。在上面的代码中，可选值 assumedString 在将其值赋给 implicitString 之前被强制展开，因为 implicitString 具有显式的非可选类型 String 。在下面的代码中， optionalString 没有显式类型，所以它是一个普通的可选类型。
```swift
let optionalString = assumedString
```

如果一个隐式展开的可选值是 nil ，而你试图访问它的包装值，你将触发一个运行时错误。其结果与您写一个感叹号来强制展开一个不包含值的普通可选项完全相同。


你可以检查一个隐式展开的optional是否是 nil ，就像你检查一个普通的optional一样：


```swift
if assumedString != nil {
    print(assumedString!)
}
// Prints "An implicitly unwrapped optional string."
```

你也可以使用一个隐式的unwrapped optional和optional binding，在一个语句中检查和解包它的值：

```swift
if let definiteString = assumedString {
    print(definiteString)
}
// Prints "An implicitly unwrapped optional string."
```

## 2.错误处理

### 2.1 抛错
使用错误处理来响应程序在执行过程中可能遇到的错误条件。

与optional相反，optional可以使用值的存在或不存在来传达函数的成功或失败，错误处理允许您确定失败的根本原因，并且如果需要，将错误传播到程序的另一部分。


当函数遇到错误条件时，它会抛出错误。然后，该函数的调用者可以捕获错误并做出适当的响应。

```swift
func canThrowAnError() throws {
    // this function may or may not throw an error
}

```

一个函数表明它可以通过在其声明中包含 throws 关键字来抛出错误。当你调用一个可能抛出错误的函数时，你可以在表达式前面加上 try 关键字。


Swift会自动将错误传播到当前作用域之外，直到它们被 catch 子句处理。
```swift
do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}
```

do 语句创建一个新的包含作用域，它允许错误传播到一个或多个 catch 子句。
以下是如何使用错误处理来响应不同错误条件的示例：

```swift
func makeASandwich() throws {
    // ...
}
do {
    try makeASandwich()
    eatASandwich()
} catch SandwichError.outOfCleanDishes {
    washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    buyGroceries(ingredients)
}
```

在这个例子中，如果没有干净的盘子或者缺少任何配料， makeASandwich() 函数将抛出一个错误。因为 makeASandwich() 可能抛出错误，所以函数调用被包装在 try 表达式中。通过将函数调用包装在 do 语句中，任何抛出的错误都将传播到提供的 catch 子句。


如果没有抛出错误，则调用 eatASandwich() 函数。如果抛出一个错误，并且它匹配 SandwichError.outOfCleanDishes case，那么将调用 washDishes() 函数。如果抛出一个错误，并且它与 SandwichError.missingIngredients 的情况相匹配，那么使用由 catch 模式捕获的关联的 [String] 值调用 buyGroceries(_:) 函数。


### 2.2 断言和前提

断言和前置条件是在运行时发生的检查。您可以使用它们来确保在执行任何进一步的代码之前满足基本条件。如果断言或前提条件中的布尔条件的计算结果为 true ，则代码将照常执行。如果条件的计算结果为 false ，则程序的当前状态无效;代码执行结束，您的应用将终止。


您可以使用断言和先决条件来表达您在编码时所做的假设和期望，因此您可以将它们作为代码的一部分。

断言可以帮助您在开发过程中发现错误和不正确的假设，而先决条件可以帮助您检测生产中的问题。

除了在运行时验证您的期望之外，断言和先决条件也成为代码中一种有用的文档形式。与上面的错误处理中讨论的错误条件不同，断言和先决条件不用于可恢复的或预期的错误。因为一个失败的断言或前提条件指示一个无效的程序状态，所以没有办法捕捉一个失败的断言。从无效状态恢复是不可能的。

当断言失败时，程序中至少有一段数据是无效的--但你不知道为什么它是无效的，或者是否有其他状态也是无效的。

使用断言和前置条件并不能替代以不太可能出现无效条件的方式设计代码。

但是，使用它们来强制执行有效的数据和状态会使您的应用在出现无效状态时以更可预测的方式终止，并有助于使问题更易于调试。

如果不检查假设，您可能不会注意到这类问题，直到很久以后，其他地方的代码开始明显失败，并且用户数据已被悄悄损坏。

一旦检测到无效状态就停止执行也有助于限制该无效状态造成的损害。

断言和前提条件之间的区别在于何时检查它们：断言只在调试版本中检查，而前提条件在调试和生产版本中都检查。在生产构建中，断言中的条件不被评估。

这意味着您可以在开发过程中使用尽可能多的断言，而不会影响生产中的性能。


### 2.3 断言


你可以通过调用Swift标准库中的 assert(_:_:file:line:) 函数来编写断言。您向此函数传递一个表达式，该表达式的计算结果为 true 或 false ，并在条件的结果为 false 时显示一条消息。例如：

```swift
let age = -3
assert(age >= 0, "A person's age can't be less than zero.")
// This assertion fails because -3 isn't >= 0.

print("hello")
```

在此示例中，如果 age >= 0 的计算结果为 true （即，如果 age 的值为非负），则代码继续执行。如果 age 的值为负，就像上面的代码一样，那么 age >= 0 的计算结果为 false ，断言失败，终止应用程序。


您可以省略断言消息—例如，当它只是以散文形式重复条件时。
```swift
assert(age >= 0)
```

如果代码已经检查了条件，则使用 assertionFailure(_:file:line:) 函数来指示断言失败。举例来说：
```swift
if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}
```

### 2.4 强制执行先决条件


只要条件有可能为假，但必须为真才能继续执行代码，就可以使用前置条件。例如，使用一个前提条件来检查下标是否越界，或者检查函数是否传递了一个有效的值。

你可以通过调用 **precondition**(_:_:file:line:) 函数来编写一个先决条件。您向此函数传递一个表达式，该表达式的计算结果为 true 或 false ，并在条件的结果为 false 时显示一条消息。举例来说：

```swift
// In the implementation of a subscript...
precondition(index > 0, "Index must be greater than zero.")
```

您还可以调用 preconditionFailure(_:file:line:) 函数来指示发生了故障—例如，如果采用了开关的默认情况，但所有有效的输入数据都应该由开关的其他情况之一处理。


**Notice**:
如果你在unchecked模式下编译（ -Ounchecked ），前置条件不会被检查。编译器假设前置条件总是为真，并相应地优化代码。但是，无论优化设置如何， fatalError(_:file:line:) 函数总是暂停执行。

您可以在原型设计和早期开发期间使用 fatalError(_:file:line:) 函数，通过编写 fatalError("Unimplemented") 作为存根实现来为尚未实现的功能创建存根。因为致命错误永远不会被优化掉，不像断言或先决条件，所以可以确保执行在遇到存根实现时总是会停止。









----

```swift```
ref:https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Type-Safety-and-Type-Inference