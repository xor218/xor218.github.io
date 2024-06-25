---
layout: post
author: "大西瓜"
title: "Classes Initialization 初始化"
date:   2024-06-18 11:17:01 +0800
categories: [update,Swift] 
---



## class initialization  初始化

设置类型的存储属性的初始值并执行一次性设置。



初始化是准备类、结构或枚举的实例以供使用的过程。此过程涉及为该实例上的每个存储属性设置初始值，并执行新实例可供使用之前所需的任何其他设置或初始化。

您可以通过定义初始化程序来实现此初始化过程，初始化程序就像可以调用以创建特定类型的新实例的特殊方法。与 Objective-C 初始化器不同，Swift 初始化器不返回值。它们的主要作用是确保类型的新实例在首次使用之前正确初始化。

类类型的实例还可以实现析构器，它在该类的实例被释放之前执行任何自定义清理。有关反初始化器的更多信息，请参阅反初始化。



#### **内存布局**

一个没有任何成员变量的类实例在内存中的大小至少包含一个指向元数据（metadata）的指针。这是因为每个类的实例都需要有一个指针指向其元数据，以便支持动态派发、类型检查和反射等功能。

```swift
class Parent {
    func method() {
        print("Parent method")
    }
}

class Child: Parent {
    override func method() {
        print("Child method")
    }
}
```

当你创建一个 Child 类的实例时，内存布局可能如下所示：

```
Child instance (在堆上分配)
+--------------------------+
| 指向元数据的指针 (metadata) |----> Child 类的元数据
| property3                |       +------------------+
| property4                |       | 虚表 (vtable)      |
+--------------------------+       | 其他元数据          |
                                    +------------------+
```



如果有成员变量

```
Child instance (在堆上分配)
+-----------------------------+
| 指向元数据的指针 (metadata)    |----> Child 类的元数据
| property1 (继承自 Parent)    |       +---------------------+
| property2 (继承自 Parent)    |       | 虚表 (vtable)         |
| property3                   |       | 类型信息               |
| property4                   |       | 继承链信息             |
+-----------------------------+       | 其他元数据             |
                                      +---------------------+
```



#### **便利初始化起和指定初始器**



> **指定初始化器（Designated Initializers）**:
>
> ​	•	**作用**：是类的主要初始化器，用于初始化所有属性并确保类的完整初始化。(可以独立完成类的初始化)
>
> ​	•	**调用规则**：必须直接调用其父类的一个指定初始化器。
>
> ​	•	**继承规则**：
>
> ​	•	**如果子类没有定义任何指定初始化器，则会自动继承父类的所有指定初始化器。**



>**便利初始化器（Convenience Initializers）**
>
>
>
>​	•	**作用**：提供额外的便捷功能，可以通过不同的参数组合来创建实例，但必须最终调用一个指定初始化器。
>
>​	•	**调用规则**：必须调用同一个类中的另一个初始化器（无论是指定的还是便利的）。
>
>​	•	**继承规则**：
>
>​	•	**通常不被子类自动继承，子类必须显式重写这些初始化器。**
>
>



**便利初始化器的使用**

便利初始化器可以帮助简化对象的创建过程，提供更多的初始化选项，而不需要在每个便利初始化器中重复初始化代码。例如：

```swift
class Food {
    var name: String
    
    // 指定初始化器
    init(name: String) {
        self.name = name
    }
    
    // 便利初始化器
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    
    // 子类的指定初始化器
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    // 子类显式重写父类的便利初始化器
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
```

在这个示例中，Food 类有一个指定初始化器和一个便利初始化器。子类 RecipeIngredient 提供了自己的指定初始化器，并重写了父类的便利初始化器。



> **总结**
>
> ​	•	**便利初始化器不是主要的构造函数**：它们主要用于提供便捷功能，简化对象的创建过程。
>
> ​	•	**便利初始化器必须调用指定初始化器**：这确保了所有属性都被正确初始化。
>
> ​	•	**显式重写**：**便利初始化器通常不被自动继承**，子类必须显式重写这些初始化器。



### 1.设置存储属性的初始化值

类和结构必须在创建该类或结构的实例时将其所有存储的属性设置为适当的初始值。存储的属性不能处于不确定状态。

**类和结构必须有初值**

您可以在初始化程序中为存储的属性设置初始值，或者通过分配默认属性值作为属性定义的一部分。以下各节描述了这些操作。



> **Note**:当您为存储的属性分配默认值或在初始值设定项中设置其初始值时，将直接设置该属性的值，而不调用任何属性观察器。





#### 1.1初始化器

调用初始化程序来创建特定类型的新实例。在最简单的形式中，初始化程序就像一个不带参数的实例方法，使用 `init` 关键字编写：

```swift
init(){
  //perform Some initialization here
}
```

下面的示例定义了一个名为 `Fahrenheit` 的新结构来存储以华氏温标表示的温度。 `Fahrenheit` 结构有一个存储属性 `temperature` ，其类型为 `Double` ：

```swift
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit"
```

该结构定义了一个不带参数的初始化程序 `init` ，它用值 `32.0` （水的冰点，以华氏度为单位）初始化存储的温度。





#### 1.2.默认属性值

您可以从初始值设定项内设置存储属性的初始值，如上所示。或者，指定默认属性值作为属性声明的一部分。您可以通过在定义属性时为其分配初始值来指定默认属性值。



> **Note**:如果属性始终采用相同的初始值，请提供默认值，而不是在初始值设定项内设置值。最终结果是相同的，但默认值将属性的初始化与其声明更紧密地联系在一起。它使初始值设定项更短、更清晰，并使您能够从属性的默认值推断出属性的类型。默认值还使您可以更轻松地利用默认初始值设定项和初始值设定项继承，如本章后面所述。



您可以通过在声明属性时为其 `temperature` 属性提供默认值，以更简单的形式编写上面的 `Fahrenheit` 结构：

```swift
struct Fahrenheit {
    var temperature = 32.0
}
```





###  2.自定义初始化参数

您可以提供初始化参数作为初始化程序定义的一部分，以定义自定义初始化过程的值的类型和名称。初始化参数与函数和方法参数具有相同的功能和语法。

以下示例定义了一个名为 `Celsius` 的结构，它存储以摄氏度表示的温度。 `Celsius` 结构实现了两个名为 `init(fromFahrenheit:)` 和 `init(fromKelvin:)` 的自定义初始化程序，它们使用不同温标的值初始化该结构的新实例：



```swift
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) { 
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {  //开尔文
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius is 0.0
```



第一个初始化器有一个初始化参数，参数标签为 `fromFahrenheit` ，参数名称为 `fahrenheit` 。第二个初始化器有一个初始化参数，参数标签为 `fromKelvin` ，参数名称为 `kelvin` 。两个初始化器都将其单个参数转换为相应的摄氏度值，并将该值存储在名为 `temperatureInCelsius` 的属性中。





#### 2.1 参数名称和参数标签

与函数和方法参数一样，初始化参数可以具有在初始化器主体中使用的参数名称和在调用初始化器时使用的参数标签。

但是，初始化程序在括号前没有像函数和方法那样具有标识函数名称。因此，初始化器参数的名称和类型在确定应该调用哪个初始化器方面起着特别重要的作用。因此，如果您不提供参数标签，Swift 会为初始化程序中的每个参数提供一个自动参数标签。



以下示例定义了一个名为 `Color` 的结构，具有三个名为 `red` 、 `green` 和 `blue` 的常量属性。这些属性存储 `0.0` 和 `1.0` 之间的值，以指示颜色中红色、绿色和蓝色的数量。

`Color` 为其红色、绿色和蓝色组件提供了一个带有三个适当命名的 `Double` 类型参数的初始值设定项。 `Color` 还提供了带有单个 `white` 参数的第二个初始值设定项，该参数用于为所有三个颜色分量提供相同的值。



```swift
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}
```



通过为每个初始化器参数提供命名值，两个初始化器都可用于创建新的 `Color` 实例：

```swfit
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
```

请注意，如果不使用参数标签就无法调用这些初始值设定项。如果定义了参数标签，则必须始终在初始值设定项中使用它们，省略它们会导致编译时错误：

```swift
let veryGreen = Color(0.0, 1.0, 0.0)
// this reports a compile-time error - argument labels are required
```





#### 2.2 没有参数标签的初始化参数

**最默认的构造函数使用参数标签 _**

如果您不想对初始化参数使用参数标签，请为该参数编写下划线 ( `_` ) 而不是显式参数标签，以覆盖默认行为。

下面是上面初始化参数中的 `Celsius` 示例的扩展版本，其中包含一个附加的初始化程序，用于根据已采用摄氏度的 `Double` 值创建新的 `Celsius` 实例规模：



```swift
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius(37.0)
// bodyTemperature.temperatureInCelsius is 37.0
```



初始化程序调用 `Celsius(37.0)` 的意图很明确，不需要参数标签。因此，将此初始值设定项编写为 `init(_ celsius: Double)` 是合适的，以便可以通过提供未命名的 `Double` 值来调用它。



### 3.可选类型属性

**可选类型初始化会被设置为nil**

如果您的自定义类型具有逻辑上允许具有“无值”的存储属性（可能是因为在初始化期间无法设置其值，或者因为允许在稍后的某个时刻具有“无值”），请使用可选类型。可选类型的属性会自动使用 `nil` 值进行初始化，表明该属性在初始化期间故意“尚无值”。



以下示例定义了一个名为 `SurveyQuestion` 的类，并具有一个名为 `response` 的可选 `String` 属性：

```swift
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// Prints "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."
```

在询问之前，无法知道对调查问题的答复，因此 `response` 属性声明为 `String?` 类型，或“可选 `String` ” ”。当初始化 `SurveyQuestion` 的新实例时，它会自动分配默认值 `nil` ，表示“还没有字符串”。



### 4.在初始化期间分配常量属性

您可以在初始化过程中随时为常量属性赋值，只要在初始化完成时将其设置为确定值即可。**一旦给常量属性赋值，就不能再对其进行修改**。

您可以修改上面的 `SurveyQuestion` 示例，为问题的 `text` 属性使用常量属性而不是变量属性，以指示问题一旦实例就不会更改 `SurveyQuestion` 已创建。尽管 `text` 属性现在是常量，但仍然可以在类的初始值设定项中设置：

```swift
class SurveyQuestion {
    let text: String  //只是被声明为常量，可以被赋值一次，赋值之后不能呗修改
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"
```





### 5. 默认初始化器

Swift 为任何为其所有属性提供默认值的结构或类提供默认初始值设定项，并且本身不提供至少一个初始值设定项。默认初始化程序只是创建一个新实例，并将其所有属性设置为其默认值。

此示例定义了一个名为 `ShoppingListItem` 的类，它封装了购物清单中商品的名称、数量和购买状态：

```swift
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem() 
//编译器提供的默认构造函数，但是所有的成员变量都应该有初始值，可选类型默认会被设置为nil
```

因为 `ShoppingListItem` 类的所有属性都有默认值，并且因为它是没有超类的基类，所以 `ShoppingListItem` 自动获得一个默认的初始化器实现，该实现会创建一个具有其所有属性的新实例设置为默认值。 （ `name` 属性是可选的 `String` 属性，因此它会自动接收默认值 `nil` ，即使该值未写入代码中。）上面的示例使用 `ShoppingListItem` 类的默认初始化程序来使用初始化程序语法创建该类的新实例，编写为 `ShoppingListItem()` ，并将这个新实例分配给名为的变量 `item` 。





### 6.结构类型的成员初始化器

如果结构类型没有定义任何自己的自定义初始值设定项，则结构类型会自动接收成员初始值设定项。与默认初始值设定项不同，该**结构接收成员初始值设定项，即使它存储了没有默认值的属性。**

成员初始化器是初始化新结构实例的成员属性的简写方法。新实例的属性的初始值可以按名称传递给成员初始化程序。

下面的示例定义了一个名为 `Size` 的结构，它具有两个名为 `width` 和 `height` 的属性。通过分配默认值 `0.0` ，这两个属性都被推断为 `Double` 类型。

`Size` 结构自动接收 `init(width:height:)` 成员初始化程序，您可以使用它来初始化新的 `Size` 实例：

```swift
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

//Error:需要显示的声明成员是哪一个
//let twoByTwo = Size(2.0,2.0)
```

当您调用成员初始化程序时，您可以省略任何具有默认值的属性的值。在上面的示例中， `Size` 结构的 `height` 和 `width` 属性都有默认值。您可以省略其中一个属性或两个属性，并且初始化程序将使用您省略的任何内容的默认值。例如：

```swift
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// Prints "0.0 2.0"


let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// Prints "0.0 0.0"
```





### 7.值类型的初始化委托

构造函数委托其他构造函数 

值类型是指**structure,Enum**

初始化程序可以调用其他初始化程序来执行实例初始化的一部分。此过程称为初始化程序委托，可避免在多个初始化程序之间重复代码。

对于值类型和类类型，初始化器委派如何工作以及允许何种形式的委派的规则是不同的。值类型（结构体和枚举）不支持继承，因此它们的初始化器委托过程相对简单，因为它们只能委托给它们自己提供的另一个初始化器。然而，类可以从其他类继承，如继承中所述。这意味着类有额外的责任来确保它们继承的所有存储属性在初始化期间都分配了合适的值。这些职责在下面的类继承和初始化中描述。

对于值类型，在编写自己的自定义初始值设定项时，可以使用 `self.init` 引用同一值类型的其他初始值设定项。您只能从初始值设定项内调用 `self.init` 。

请注意，如果为值类型定义自定义初始值设定项，您将无法再访问该类型的默认初始值设定项（或成员初始值设定项，如果它是结构体）。此约束防止出现以下情况：使用自动初始化程序之一的人意外地规避了更复杂的初始化程序中提供的附加基本设置。

**init 构造函数会覆盖默认值**



> **Note**:如果您希望使用默认初始化程序和成员初始化程序以及您自己的自定义初始化程序来初始化自定义值类型，请在扩展中编写自定义初始化程序，而不是作为值类型原始实现的一部分。有关更多信息，请参阅扩展。



以下示例定义了一个自定义 `Rect` 结构来表示几何矩形。该示例需要两个名为 `Size` 和 `Point`的支持结构，它们都为其所有属性提供默认值 `0.0` ：



```swift
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
```

您可以通过以下三种方式之一初始化下面的 `Rect` 结构 - 通过使用其默认的零初始化 `origin`和 `size` 属性值，通过提供特定的原点和尺寸，或者通过提供特定的中心点和尺寸。这些初始化选项由三个自定义初始值设定项表示，它们是 `Rect` 结构定义的一部分：

```swift
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
      //self.init 调用其他构造函数
    } 
}
```

第一个 `Rect` 初始值设定项 `init()` 的功能与结构在没有自己的自定义初始值设定项时收到的默认初始值设定项相同。该初始化器有一个空的主体，由一对空的花括号 `{}` 表示。调用此初始化程序会返回一个 `Rect` 实例，其 `origin` 和 `size` 属性均使用 `Point(x: 0.0, y: 0.0)` 和 `Size(width: 0.0, height: 0.0)`

```swift
let basicRect = Rect()
// basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)
```

第二个 `Rect` 初始值设定项 `init(origin:size:)` 的功能与结构在没有自己的自定义初始值设定项时收到的成员初始值设定项相同。此初始化程序只是将 `origin` 和 `size` 参数值分配给适当的存储属性：

```swift
let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0))
```

第三个 `Rect` 初始化器 `init(center:size:)` 稍微复杂一些。它首先根据 `center` 点和 `size` 值计算适当的原点。然后，它调用（或委托） `init(origin:size:)` 初始值设定项，该初始值设定项将新的原点和大小值存储在适当的属性中：

```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
```

`init(center:size:)` 初始化程序可以将 `origin` 和 `size` 的新值分配给适当的属性本身。然而，对于 `init(center:size:)` 初始化器来说，利用已经提供了该功能的现有初始化器会更方便（并且意图更清晰）。



### 8.类的继承和初始化

**class使用之前，成员变量必须有初始化值**

类的所有存储属性（包括该类从其超类继承的任何属性）都必须在初始化期间分配一个初始值。

Swift 为类类型定义了两种初始值设定项，以帮助确保所有存储的属性都接收初始值。这些被称为指定初始化器和便利初始化器。

**和C++不同之处**：

1. C++要求先初始化父类，然后再初始化子类
2. swift 要求先初始化自己，再初始化父类

**Example：**

```swift

class FatherClass{
    var value:Int
    init(fVar value:Int){
        self.value = value
    }
}

class SonClass:FatherClass{
    var value2:Int
    init(sVar value2:Int,fVal fval:Int){
        self.value2 = value2   //1.先init 子类的成员变量
        super.init(fVar:fval)   //2.构造父类 顺序错了,编译器会报错
    }
}

```





### 9. 指定初始化器和便利初始化器

类的指定初始值设定项的编写方式与值类型的简单初始值设定项的编写方式相同：

```swift
init(<#parameters#>) {
   <#statements#>
}
```

便捷初始化程序以相同的风格编写，但将 `convenience` 修饰符放置在 `init` 关键字之前，并用空格分隔：

```swift
convenience init(<#parameters#>) {
   <#statements#>
}
```

**显式委托构造函数Example:**

```swift
class Mynumber{
    var Number:Double
    
    //Double构造
    init(doubleValue numberD:Double){
        self.Number = numberD
    }
    //class使用Int类型构造，但是需要委托其他构造函数构造 init(doubleValue:)
    convenience init(_ numberOfInt:Int){
        self.init(doubleValue:Double(numberOfInt))
    }
    
}
```



### 10. 类类型的初始化委托

> **Note**: 便利初始化器不能被继承

为了简化指定初始化器和便利初始化器之间的关系，Swift 对初始化器之间的委托调用应用以下三个规则：

1. **指定的初始值设定项必须从其直接超类调用指定的初始值设定项。(必须初始化基类)**
2. **便利初始化程序必须调用同一类中的另一个初始化程序。(使用convience之后必须调用其他的init**
3. **便利初始值设定项最终必须调用指定的初始值设定项。**

记住这一点的一个简单方法是：

1. **指定的初始化器必须始终向上委托。(初始化自己的变量之后，再初始化基类)**
2. **便利初始化器必须始终进行委托。**

这些规则如下图所示：



​	**子类不能使用父类的便利初始化器(convience修饰的构造函数)**

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/initializerDelegation01@2x.png" style="zoom: 100%">



​	这里，超类有一个指定的初始值设定项和两个便利初始值设定项。一个便利初始值设定项调用另一个便利初始值设定项，后者又调用单个指定的初始值设定项。这满足上面的规则 2 和 3。超类本身没有进一步的超类，因此规则 1 不适用。





该图中的子类有两个指定的初始值设定项和一个便利初始值设定项。便利初始化器必须调用两个指定初始化器之一，因为它只能调用同一类中的另一个初始化器。这满足上面的规则 2 和 3。两个指定初始值设定项必须调用超类中的单个指定初始值设定项，以满足上面的规则 1。



> **Note**:
>
> 这些规则不会影响类的用户创建每个类的实例的方式。上图中的任何初始化器都可用于创建它们所属类的完全初始化的实例。这些规则仅影响您如何编写类初始化器的实现。



下图显示了四个类的更复杂的类层次结构。它说明了该层次结构中的指定初始化程序如何充当类初始化的“漏斗”点，从而简化了链中类之间的相互关系：



**继承初始化的时候,不能使用便利初始化器**

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/initializerDelegation02@2x.png" style="zoomm:50% align-self: auto">



### 11. 两阶段初始化

Swift 中的类初始化是一个两阶段的过程。在第一阶段，每个存储的属性都由引入它的类分配一个初始值。一旦确定了每个存储属性的初始状态，第二阶段就开始，并且每个类都有机会在新实例被认为可供使用之前进一步自定义其存储属性。

使用两阶段初始化过程可以使初始化安全，同时仍然为类层次结构中的每个类提供完全的灵活性。两阶段初始化可防止属性值在初始化之前被访问，并防止属性值被另一个初始化程序意外设置为不同的值。



> **Note:**
>
> Swift 的两阶段初始化过程与 Objective-C 中的初始化类似。主要区别在于，在第 1 阶段，Objective-C 为每个属性分配零值或空值（例如 `0` 或 `nil` ）。 Swift 的初始化流程更加灵活，因为它允许您设置自定义初始值，并且可以处理 `0` 或 `nil` 不是有效默认值的类型。
>
> **第一阶段: 初始化自己 + 构造父类**
>
> **第二阶段:自定义其他的，可以处理构造完的处值，比如nil or 0之类的**



Swift 的编译器执行四项有用的安全检查，以确保两阶段初始化顺利完成：

- **Safety check 1 安全检查1**
  - 在构造父类之前，子类的所有成员变量都应该初始化
- **Safety check2 安全检查2**
  - 在将值分配给继承的属性之前，指定的初始值设定项必须委托给超类初始值设定项。如果没有，指定的初始化器分配的新值将被超类覆盖，作为其自身初始化的一部分。
- **Safety check3 安全检查3**
  - 在将值分配给任何属性（包括由同一类定义的属性）之前，便利初始值设定项必须委托给另一个初始值设定项。如果没有，便利初始化器分配的新值将被其自己类的指定初始化器覆盖。
- **Safety check 4 安全检查4**
  - 在初始化的第一阶段完成之前，初始化程序无法调用任何实例方法、读取任何实例属性的值或将 `self` 引用为值。(构造完自己和父类，才可以用self的方法)

在第一阶段结束之前，类实例并不完全有效。只有在第一阶段结束时知道类实例有效后，才可以访问属性，并且只能调用方法。


以下是基于上述四项安全检查的两阶段初始化的实施方式：

**Phase 1 阶段1**

- 在类上调用指定的或方便的初始值设定项。
- 为该类的新实例分配内存。内存还没有初始化。
- 该类的指定初始值设定项确认该类引入的所有存储属性都有一个值。这些存储属性的内存现已初始化。
- 指定的初始值设定项移交给超类初始值设定项，以对其自己的存储属性执行相同的任务。
- 这沿着类继承链继续向上，直到到达链的顶部。
- 一旦到达链的顶部，并且链中的最终类已确保其所有存储的属性都有值，则认为实例的内存已完全初始化，并且阶段 1 完成。

**Phase 2 阶段2**

- 
  从链的顶部开始，链中的每个指定的初始化程序都可以选择进一步自定义实例。初始化程序现在可以访问 `self` 并可以修改其属性、调用其实例方法等。
- 最后，链中的任何便利初始化程序都可以选择自定义实例并使用 `self` 。


以下是第一阶段如何查找假设的子类和超类的初始化调用：

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/twoPhaseInitialization01@2x.png" style="zoom:75%">

在此示例中，初始化从调用子类上的便利初始值设定项开始。这个便利的初始化程序还不能修改任何属性。它委托给同一类中指定的初始值设定项。

根据安全检查 1，指定的初始值设定项确保子类的所有属性都有一个值。然后，它在其超类上调用指定的初始值设定项，以继续沿链向上进行初始化。

超类的指定初始值设定项确保所有超类属性都有一个值。没有更多的超类需要初始化，因此不需要进一步的委派。

**一旦超类的所有属性都有初始值，它的内存就被认为已完全初始化，阶段 1 就完成了。**

以下是第 2 阶段如何查找相同的初始化调用：

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/twoPhaseInitialization02@2x.png" style="zoom:75%">



超类的指定初始化程序现在有机会进一步自定义实例（尽管不是必须的）。

一旦超类的指定初始值设定项完成，子类的指定初始值设定项就可以执行额外的自定义（尽管这并不是必须的）。

最后，一旦子类的指定初始化器完成，最初调用的便利初始化器就可以执行额外的定制。





### 12.初始化器的继承和重写



> **Note：**子类初始化的参数标签和父类是一样的时候，需要加上override关键字，告诉编译器  这个构造方法是重写**
>
>  func method(参数标签 参数:参数类型) ;



与 Objective-C 中的子类不同，Swift 子类默认不继承其超类初始值设定项。 Swift 的方法可以防止出现以下情况：来自超类的简单初始化器被更专门的子类继承，并用于创建未完全或正确初始化的子类的新实例。



> **Note**：超类初始值设定项在某些情况下会被继承，但前提是这样做是安全且适当的。有关详细信息，请参阅下面的自动初始化程序继承。

如果您希望自定义子类呈现一个或多个与其超类相同的初始值设定项，您可以在子类中提供这些初始值设定项的自定义实现。

当您编写与超类指定初始值设定项匹配的子类初始值设定项时，您实际上提供了该指定初始值设定项的重写。因此，必须在子类的初始化器定义之前编写 `override` 修饰符。即使您要覆盖自动提供的默认初始值设定项，也是如此，如默认初始值设定项中所述。

与重写的属性、方法或下标一样， `override` 修饰符的存在会提示 Swift 检查超类是否具有要重写的匹配指定初始值设定项，并验证是否已指定重写初始值设定项的参数如预期。



>**Note**:在重写超类指定的初始值设定项时，您始终会编写 **`override`** 修饰符，即使您的子类的初始值设定项实现是便利初始值设定项。

相反，如果您编写与超类便利初始值设定项相匹配的子类初始值设定项，则该超类便利初始值设定项永远不能由您的子类直接调用，按照类类型的初始值设定项委托中所述的规则。因此，您的子类（严格来说）并未提供超类初始值设定项的重写。因此，在提供超类便利初始值设定项的匹配实现时，您不需要编写 `override` 修饰符。

下面的示例定义了一个名为 `Vehicle` 的基类。该基类声明一个名为 `numberOfWheels` 的存储属性，默认 `Int` 值为 `0` 。 `numberOfWheels` 属性由名为 `description` 的计算属性用来创建车辆特征的 `String` 描述：

```swift
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
  
  //有一个隐藏的 init(){}
}
```

`Vehicle` 类为其唯一存储的属性提供默认值，并且本身不提供任何自定义初始值设定项。因此，它会自动接收默认初始化程序，如默认初始化程序中所述。默认初始值设定项（如果可用）始终是类的指定初始值设定项，可用于创建 `numberOfWheels` 为 `0` 的新 `Vehicle` 实例：

```swift
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")
// Vehicle: 0 wheel(s)
```



下一个示例定义了 `Vehicle` 的子类 `Bicycle` ：

```swift
class Bicycle: Vehicle {
    override init() {
        super.init()  //先初始化自己，再构造,然后再修改成员变量 比较合理
        numberOfWheels = 2
    }
}
```



`Bicycle` 子类定义了自定义指定的初始值设定项 `init()` 。此指定初始值设定项与 `Bicycle` 超类中的指定初始值设定项匹配，因此此初始值设定项的 `Bicycle` 版本用 `override` 修饰符标记。

`Bicycle` 的 `init()` 初始化器首先调用 `super.init()` ，它调用 `Bicycle` 类的超类 `Vehicle` 继承的属性在 `Bicycle` 有机会修改该属性之前由 `Vehicle` 初始化。调用 `super.init()` 后， `numberOfWheels` 的原始值将替换为新值 `2` 。





如果您创建 `Bicycle` 的实例，则可以调用其继承的 `description` 计算属性来查看其 `numberOfWheels` 属性如何更新：



如果子类初始值设定项在初始化过程的第 2 阶段不执行任何自定义，并且超类具有同步的零参数指定初始值设定项，则可以在为子类的所有存储的值赋值后省略对 `super.init()` 的调用。特性。如果超类的初始化器是异步的，则需要显式编写 `await super.init()` 。



此示例定义 `Vehicle` 的另一个子类，称为 `Hoverboard` 。在其初始值设定项中， `Hoverboard` 类仅设置其 `color` 属性。该初始化器不是显式调用 `super.init()` ，而是依赖对其超类的初始化器的隐式调用来完成该过程。

```swift
class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() implicitly called here
        // 隐式的调用 super.init() 
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}
```

`Hoverboard` 的实例使用 `Vehicle` 初始值设定项提供的默认轮子数量。

```swift
let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")
// Hoverboard: 0 wheel(s) in a beautiful silver
```



>**Note**:子类可以在初始化期间修改继承的变量属性，但不能修改继承的常量属性。





### 13.自动初始化器的继承 

如上所述，默认情况下子类不会继承其超类初始值设定项。但是，如果满足某些条件，超类初始值设定项会自动继承。实际上，这意味着您不需要在许多常见场景中编写初始值设定项重写，并且可以在安全的情况下以最小的努力继承超类初始值设定项。

假设您为在子类中引入的任何新属性提供默认值，则适用以下两条规则：

- **Rule 1 规则1**

  如果您的子类没有定义任何指定初始值设定项，它将自动继承其超类的所有指定初始值设定项。

- **Rule 2 规则2**

   如果您的子类提供了其所有超类指定初始值设定项的实现（通过按照规则 1 继承它们，或者通过提供自定义实现作为其定义的一部分），那么它会自动继承所有超类便利初始值设定项。


即使您的子类添加了更多方便的初始值设定项，这些规则也适用。

> **Note:**作为满足规则 2 的一部分，子类可以将超类指定的初始值设定项实现为子类便利初始值设定项。



1. **子类没有init构造函数的时候，会自动继承父类的init 和 便利初始化器(convenience)**
2. **如果子类有自己的init，所有的父类的init 和convenience init都不会自动继承，超类的init都需要显式的写明白，写清楚**

Example:

```swift
class Parent {
    var name: String
    
    // 指定初始化器
    init(name: String) {
        self.name = name
    }
    
    // 便利初始化器
    convenience init() {
        self.init(name: "Default Name")
    }
}

class Child: Parent {
    // 子类没有定义任何指定初始化器
    // 因此会自动继承父类的所有指定初始化器和便利初始化器
}


//没有init构造函数的子类，自动继承父类的
let child1 = Child(name: "John")
print(child1.name)  // 输出：John

//子类没有init构造函数，自动继承父类的便利构造器
let child2 = Child()
print(child2.name)  // 输出：Default Name


```






### 14.指定初始化器和便利初始化器的实际应用 TODO::多看两遍

以下示例显示了指定初始值设定项、便利初始值设定项和自动初始值设定项继承的实际效果。此示例定义了名为 `Food` 、 `RecipeIngredient` 和 `ShoppingListItem` 的三个类的层次结构，并演示了它们的初始值设定项如何交互。

层次结构中的基类称为 `Food` ，它是一个封装食品名称的简单类。 `Food` 类引入了一个名为 `name` 的 `String`属性，并提供了两个用于创建 `Food` 实例的初始值设定项：

```swift
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
```

下图显示了 `Food` 类的初始化链：

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/initializersExample01@2x.png">

类没有默认的成员初始值设定项，因此 `Food` 类提供了一个指定的初始值设定项，该初始值设定项采用名为 `name` 的单个参数。此初始值设定项可用于创建具有特定名称的新 `Food` 实例：

```swift
let namedMeat = Food(name: "Bacon")
// namedMeat's name is "Bacon"
```

`Food` 类中的 `init(name: String)` 初始值设定项作为指定初始值设定项提供，因为它确保新 `Food` 实例的所有存储属性均已完全初始化。 `Food` 类没有超类，因此 `init(name: String)` 初始化器不需要调用 `super.init()` 来完成其初始化。



`Food` 类还提供了一个方便的初始化器 `init()` ，不带参数。 `init()` 初始值设定项通过将 `name` 值委托给 `Food` 类的 `init(name: String)` 来为新食物提供默认占位符名称。 b6>：



层次结构中的第二个类是 `Food` 的子类，称为 `RecipeIngredient` 。 `RecipeIngredient` 类对烹饪食谱中的成分进行建模。它引入了一个名为 `quantity` 的 `Int` 属性（除了它继承自 `Food` 的 `name` 属性），并定义了两个初始化器来创建 < b7> 实例：



```swift
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) { //重写便利构造器 两个关键字 override convenience
        self.init(name: name, quantity: 1) 
    }
}
```

下图显示了 `RecipeIngredient` 类的初始化链：

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/initializersExample02@2x.png" style="zoom:80%">

`RecipeIngredient` 类有一个指定的初始值设定项 `init(name: String, quantity: Int)` ，可用于填充新 `RecipeIngredient` 实例的所有属性。此初始值设定项首先将传递的 `quantity` 参数分配给 `quantity` 属性，这是 `RecipeIngredient` 引入的唯一新属性。执行此操作后，初始化程序将委托给 `Food`类的 `init(name: String)` 初始化程序。该过程满足上述两阶段初始化中的安全检查 1。



`RecipeIngredient` 还定义了一个方便的初始值设定项 `init(name: String)` ，它用于仅通过名称创建 `RecipeIngredient` 实例。对于在没有明确数量的情况下创建的任何 `RecipeIngredient` 实例，此便利初始值设定项假定数量为 `1` 。这种便利初始化器的定义使 `RecipeIngredient` 实例的创建更加快捷、方便，并避免了创建多个单数量 `RecipeIngredient` 实例时的代码重复。这个方便的初始化器只是委托给类的指定初始化器，传入 `quantity` 值 `1` 。

`RecipeIngredient` 提供的 `init(name: String)` 便利初始值设定项采用与 `Food` 中的 `init(name: String)` 指定初始值设定项相同的参数。由于此便利初始值设定项会覆盖其超类中指定的初始值设定项，因此必须使用 `override` 修饰符对其进行标记（如初始值设定项继承和覆盖中所述）。

尽管 `RecipeIngredient` 提供了 `init(name: String)` 初始值设定项作为方便的初始值设定项， `RecipeIngredient` 仍然提供了其超类的所有指定初始值设定项的实现。因此， `RecipeIngredient` 也自动继承其超类的所有便利初始化程序。



在此示例中， `RecipeIngredient` 的超类是 `Food` ，它有一个名为 `init()` 的便利初始化程序。因此，该初始值设定项由 `RecipeIngredient` 继承。 `init()` 的继承版本与 `Food` 版本的功能完全相同，只是它委托给 `init(name: String)` 的 `RecipeIngredient` 版本而不是 `Food` 版本。



所有这三个初始化器都可以用来创建新的 `RecipeIngredient` 实例：



```swfit
let oneMysteryItem = RecipeIngredient() 
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
```



层次结构中的第三个也是最后一个类是 `RecipeIngredient` 的子类，称为 `ShoppingListItem` 。 `ShoppingListItem` 类对出现在购物清单中的配方成分进行建模。

购物清单中的每件商品一开始都是“未购买”的。为了表示这一事实， `ShoppingListItem` 引入了一个名为 `purchased` 的布尔属性，其默认值为 `false` 。 `ShoppingListItem` 还添加了一个计算的 `description`属性，该属性提供 `ShoppingListItem` 实例的文本描述：

```swift
class ShoppingListItem: RecipeIngredient {
    var purchased = false   //有默认初始值,没有的话就需要提供init构造函数
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
```



> **Note**:`ShoppingListItem` 没有定义初始化程序来为 `purchased` 提供初始值，因为购物清单中的商品（如此处建模的）总是在开始时未购买。
>
> 

因为它为它引入的所有属性提供了默认值，并且本身不定义任何初始值设定项，所以 `ShoppingListItem` 自动从其超类继承所有指定的和方便的初始值设定项。

下图显示了所有三个类的总体初始化程序链：

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/initializersExample03@2x.png">



您可以使用所有三个继承的初始值设定项来创建新的 `ShoppingListItem` 实例：

```swift
var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
// 1 x Orange juice ✔
// 1 x Bacon ✘
// 6 x Eggs ✘
```

此处，从包含三个新 `ShoppingListItem` 实例的数组文字创建了一个名为 `breakfastList` 的新数组。数组的类型被推断为 `[ShoppingListItem]` 。数组创建完成后，数组开头的 `ShoppingListItem` 名称由 `"[Unnamed]"` 变为 `"Orange juice"` ，并标记为已购买。打印数组中每个项目的描述表明它们的默认状态已按预期设置。





### 15.失败的初始化器

**参数不满足构造条件，所以不返回类，返回nil**



有时定义初始化可能失败的类、结构或枚举很有用。此失败可能是由无效的初始化参数值、缺少所需的外部资源或阻止初始化成功的某些其他条件触发的。

为了应对可能失败的初始化条件，请将一个或多个可失败的初始化器定义为类、结构或枚举定义的一部分。您可以通过在 `init` 关键字 ( `init?` ) 后面放置问号来编写可失败的初始化程序。



```swift
class Person {
    var name: String
    var age: Int

    init?(name: String, age: Int) {
        // 如果年龄小于0，初始化失败 return nil
        if age < 0 {
            return nil
        }
        self.name = name
        self.age = age
    }
}

```



>**Note**:
>
>您不能使用相同的参数类型和名称定义可失败和不可失败的初始值设定项。

可失败的初始化器会创建其初始化类型的可选值。您可以在可失败的初始化程序中写入 `return nil` 以指示可以触发初始化失败的点。

>
>
>**Note**:严格来说，初始化器不返回值。相反，它们的作用是确保在初始化结束时 `self` 已完全且正确地初始化。虽然您编写 `return nil` 来触发初始化失败，但您不使用 `return` 关键字来指示初始化成功。



例如，为数字类型转换实现了可失败的初始值设定项。为了确保数字类型之间的转换能够准确地维护值，请使用 `init(exactly:)` 初始值设定项。如果类型转换无法维持该值，则初始化程序将失败。

```swift
et wholeNumber: Double = 12345.0
let pi = 3.14159


if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// Prints "12345.0 conversion to Int maintains value of 12345"


let valueChanged = Int(exactly: pi) //可
// valueChanged is of type Int?, not Int


if valueChanged == nil {
    print("\(pi) conversion to Int doesn't maintain value")
}
// Prints "3.14159 conversion to Int doesn't maintain value"
```

下面的示例定义了一个名为 `Animal` 的结构，以及一个名为 `species` 的常量 `String` 属性。 `Animal` 结构还定义了一个带有名为 `species` 的单个参数的可失败初始化程序。此初始值设定项检查传递给初始值设定项的 `species` 值是否为空字符串。如果发现空字符串，则触发初始化失败。否则， `species` 属性的值被设置，并且初始化成功：

```swift
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
```

您可以使用此失败的初始化程序来尝试初始化新的 `Animal` 实例并检查初始化是否成功：

```swift
let someCreature = Animal(species: "Giraffe")
// someCreature is of type Animal?, not Animal


if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// Prints "An animal was initialized with a species of Giraffe"
```

如果将空字符串值传递给可失败初始化程序的 `species` 参数，则初始化程序将触发初始化失败：

```swift
let anonymousCreature = Animal(species: "")
// anonymousCreature is of type Animal?, not Animal


if anonymousCreature == nil {
    print("The anonymous creature couldn't be initialized")
}
// Prints "The anonymous creature couldn't be initialized"
```



> **Note**:
>
> 检查空字符串值（例如 `""` 而不是 `"Giraffe"` ）与检查 `nil` 以指示缺少可选 `String` 值。在上面的示例中，空字符串 ( `""` ) 是有效的、非可选的 `String` 。但是，对于动物来说，将空字符串作为其 `species` 属性的值是不合适的。为了模拟此限制，如果发现空字符串，可失败初始化程序将触发初始化失败。





### 16.枚举的失败初始化器

您可以使用可失败的初始值设定项来根据一个或多个参数选择适当的枚举情况。如果提供的参数与适当的枚举情况不匹配，则初始化程序可能会失败。

下面的示例定义了一个名为 `TemperatureUnit` 的枚举，具有三种可能的状态（ `kelvin` 、 `celsius` 和 `fahrenheit` ）。可失败的初始值设定项用于为表示温度符号的 `Character` 值查找适当的枚举情况：

```swift
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
```

您可以使用此可失败的初始化程序为三种可能的状态选择适当的枚举情况，并在参数与以下状态之一不匹配时导致初始化失败：

```swift
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."


let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}
// Prints "This isn't a defined temperature unit, so initialization failed."
```



### 17. 具有原始值的枚举的失败初始化程序

具有原始值的枚举会自动接收一个可失败的初始值设定项 `init?(rawValue:)` ，它采用适当原始值类型的名为 `rawValue` 的参数，并在找到匹配的枚举情况时选择匹配的枚举情况，或者触发如果不存在匹配值，则初始化失败。

您可以重写上面的 `TemperatureUnit` 示例，以使用 `Character` 类型的原始值并利用 `init?(rawValue:)` 初始值设定项：

```swift
enum TemperatureUnit: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}


let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."


let unknownUnit = TemperatureUnit(rawValue: "X")
if unknownUnit == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}
// Prints "This isn't a defined temperature unit, so initialization failed."
```





### 18.初始化失败的传播

**父类使用init? 返回nil 的时候，子类会实例失败**

类、结构或枚举的可失败初始值设定项可以委托给同一类、结构或枚举中的另一个可失败初始值设定项。类似地，子类可失败初始化器可以委托给超类可失败初始化器。

在任何一种情况下，如果您委托给另一个导致初始化失败的初始化程序，则整个初始化过程会立即失败，并且不会执行进一步的初始化代码。

> **Note**:
>
> 可失败的初始化程序也可以委托给不可失败的初始化程序。如果您需要向现有的初始化过程添加潜在的失败状态（否则不会失败），请使用此方法。



下面的示例定义了 `Product` 的子类 `CartItem` 。 `CartItem` 类对在线购物车中的商品进行建模。 `CartItem` 引入了一个名为 `quantity` 的存储常量属性，并确保该属性的值始终至少为 `1` ：

```swift
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}


class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}
```

`CartItem` 的可失败初始化程序首先验证它是否已收到 `1` 或更大的 `quantity` 值。如果 `quantity` 无效，则整个初始化过程立即失败，不再执行进一步的初始化代码。同样， `Product` 的可失败初始化程序会检查 `name` 值，如果 `name` 是空字符串，则初始化程序进程会立即失败。

如果您创建名称非空且数量为 `1` 或更多的 `CartItem` 实例，则初始化成功：

```swift
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// Prints "Item: sock, quantity: 2"
```

如果您尝试创建 `quantity` 值为 `0` 的 `CartItem` 实例，则 `CartItem` 初始化程序会导致初始化失败：

```swift
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
// Prints "Unable to initialize zero shirts"
```

同样，如果您尝试创建具有空 `name` 值的 `CartItem` 实例，超类 `Product` 初始化程序会导致初始化失败：

**父类使用init? 返回nil 的时候，子类会实例失败**

```swift
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
// Prints "Unable to initialize one unnamed product"

```





### 19. 覆盖失败的初始化程序

您可以在子类中重写超类的可失败初始化程序，就像任何其他初始化程序一样。或者，您可以使用子类不可失败的初始值设定项覆盖超类可失败的初始值设定项。这使您能够定义一个子类，即使超类的初始化允许失败，初始化也不会失败。

请注意，如果使用不可失败的子类初始值设定项重写可失败的超类初始值设定项，则委托给超类初始值设定项的唯一方法是强制解包可失败的超类初始值设定项的结果。

> **Note**:您可以使用不可失败的初始化程序覆盖可失败的初始化程序，但反之则不然。

下面的示例定义了一个名为 `Document` 的类。此类对可以使用 `name` 属性进行初始化的文档进行建模，该属性可以是非空字符串值或 `nil` ，但不能是空字符串：

```swift
class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
```

下一个示例定义 `Document` 的子类，称为 `AutomaticallyNamedDocument` 。 `AutomaticallyNamedDocument` 子类覆盖 `Document` 引入的两个指定初始化器。如果实例在没有名称的情况下初始化，或者将空字符串传递给 `init(name:)` 初始化器：

```swift
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init() //子类构造函数中，必须使用父类的构造函数
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
```

**子类不使用可能会返回nil的init?(name:)的构造函数,而是对两个构造函数重写 **

`AutomaticallyNamedDocument` 使用不可失败的 `init(name:)` 初始值设定项覆盖其超类的可失败 `init?(name:)` 初始值设定项。因为 `AutomaticallyNamedDocument` 处理空字符串情况的方式与其超类不同，所以它的初始化器不需要失败，因此它提供了一个不可失败版本的初始化器。

您可以在初始化程序中使用强制展开来从超类调用可失败初始化程序，作为子类不可失败初始化程序实现的一部分。例如，下面的 `UntitledDocument` 子类始终命名为 `"[Untitled]"` ，并且在初始化期间使用其超类中的可失败的 `init(name:)` 初始值设定项。

```swift
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}
```

在这种情况下，如果使用空字符串作为名称调用超类的 `init(name:)` 初始值设定项，则强制展开操作将导致运行时错误。但是，因为它是使用字符串常量调用的，所以您可以看到初始化程序不会失败，因此在这种情况下不会发生运行时错误。





### 20.初始化，失败的初始化程序

您通常定义一个可失败的初始值设定项，通过在 `init` 关键字 ( `init?` ) 后面放置问号来创建适当类型的可选实例。或者，您可以定义一个可失败的初始值设定项，它创建适当类型的隐式解包可选实例。为此，请在 `init` 关键字 ( `init!` ) 后面放置感叹号而不是问号。

您可以从 `init?` 委托给 `init!` ，反之亦然，并且可以用 `init!` 覆盖 `init?` ，反之亦然。您还可以从 `init`委托给 `init!` ，尽管如果 `init!` 初始化程序导致初始化失败，这样做会触发断言。



**Chatgpt:**

这段文字解释了Swift中不同类型初始化器（构造函数）之间的关系和它们的用法。具体来说，它讨论了可失败初始化器（`init?`）和隐式解包的可失败初始化器（`init!`）之间的相互委托和覆盖规则。我们来详细分解一下这些概念。



**可失败初始化器（`init?`）**

- **定义**：在`init`关键字后面放一个问号（`init?`）来定义一个可失败的初始化器。这种初始化器可能会返回`nil`，表示初始化失败。
- **用法**：

  ```swift
  class Product {
      var name: String
      init?(name: String) {
          if name.isEmpty {
              return nil
          }
          self.name = name
      }
  }
  ```





**隐式解包的可失败初始化器（`init!`）**

- **定义**：在`init`关键字后面放一个感叹号（`init!`）来定义一个隐式解包的可失败初始化器。这种初始化器也可能会返回`nil`，但使用时会自动解包，若解包为`nil`会导致运行时错误。
- **用法**：

  ```swift
  class Product {
      var name: String
      init!(name: String) {
          if name.isEmpty {
              return nil
          }
          self.name = name
      }
  }
  ```





**初始化器委托和覆盖规则**

1. **从`init?`委托到`init!`**，反之亦然：
   - 你可以从一个可失败初始化器（`init?`）委托到一个隐式解包的可失败初始化器（`init!`），反过来也可以。

   ```swift
   class Product {
       var name: String
       init!(name: String) {
           if name.isEmpty {
               return nil
           }
           self.name = name
       }
       
       convenience init?(safeName: String) {
           self.init(name: safeName)  // 从init?委托到init!
       }
   }
   ```

2. **用`init!`覆盖`init?`**，反之亦然：
   - 你可以用一个隐式解包的可失败初始化器（`init!`）覆盖一个可失败初始化器（`init?`），反过来也可以。

   ```swift
   class Product {
       var name: String
       override init?(name: String) {
           if name.isEmpty {
               return nil
           }
           self.name = name
       }
   }
   
   class SpecialProduct: Product {
       override init!(name: String) {
           super.init(name: name)
       }
   }
   ```

3. **从`init`委托到`init!`**：
   - 你可以从一个普通初始化器（`init`）委托到一个隐式解包的可失败初始化器（`init!`），但是如果`init!`初始化失败，这样做会触发断言（程序崩溃）。

   ```swift
   class Product {
       var name: String
       init(name: String) {
           self.name = name
       }
       
       init!(failibleName: String) {
           if failibleName.isEmpty {
               return nil
           }
           self.name = failibleName
       }
   }
   
   class SpecialProduct: Product {
       init(specialName: String) {
           super.init(failibleName: specialName)  // 从init委托到init!
           // 如果failibleName为空，这里会触发断言，程序崩溃
       }
   }
   ```

**总结**

- 可失败初始化器（`init?`）和隐式解包的可失败初始化器（`init!`）可以相互委托。
- 可失败初始化器和隐式解包的可失败初始化器可以相互覆盖。
- 普通初始化器（`init`）可以委托给隐式解包的可失败初始化器（`init!`），但如果隐式解包的可失败初始化器失败，会触发断言，导致程序崩溃。

这些规则使得你在设计类和子类的初始化逻辑时有更大的灵活性，但也需要小心处理初始化失败的情况，以避免运行时错误。







### 21.required initializer 必须要求初始化

在类初始值设定项的定义之前写入 `required` 修饰符，以指示该类的每个子类都必须实现该初始值设定项：

```swift
class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}
```

您还必须在所需初始化程序的每个子类实现之前编写 `required` 修饰符，以指示初始化程序要求适用于链中的其他子类。重写必需的指定初始值设定项时，不要编写 `override` 修饰符：

```swift
class SomeSubclass: SomeClass {
    required init() {
        // subclass implementation of the required initializer goes here
    }
}
```



> **Note** :如果您可以使用继承的初始值设定项满足要求，则不必提供所需初始值设定项的显式实现。



> **ChatGpt:**

在Swift中，`required`初始化器是一种特殊的初始化器，必须在所有子类中实现。无论子类中是否定义了自己的初始化器，`required`初始化器都必须被实现。这是通过编译器强制执行的。

**`required` 初始化器的用法**

1. **定义 `required` 初始化器**：
   - 在基类中使用 `required` 关键字定义初始化器。

2. **继承和实现 `required` 初始化器**：
   - 在子类中必须实现这个初始化器，即使子类不需要自定义的初始化逻辑。

**示例代码**

下面是一个详细的示例：

**基类**

```swift
class Product {
    var name: String
    
    // 定义一个required初始化器
    required init(name: String) {
        self.name = name
    }
}
```

**子类**

```swift
class CartItem: Product {
    var quantity: Int
    
    // 必须实现基类的required初始化器
    required init(name: String) {
        self.quantity = 1
        super.init(name: name)
    }
    
    // 子类自己的初始化器
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
}
```

**解释**

1. **基类 `Product`**：
   - 定义了一个 `required` 初始化器 `init(name: String)`，这意味着所有的子类都必须实现这个初始化器。

2. **子类 `CartItem`**：
   - 必须实现基类的 `required` 初始化器 `init(name: String)`。
   - 可以定义自己的初始化器，例如 `init(name: String, quantity: Int)`。

**为什么使用 `required` 初始化器**

使用 `required` 初始化器的主要原因是确保所有子类都提供一种特定的初始化方法。这在以下情况下很有用：

- 你希望所有的子类都有相同的初始化方式。
- 你希望在工厂方法或泛型代码中，能够确保每个子类都能被正确地初始化。

**示例场景**

假设你有一个产品层次结构，并且你希望所有的产品都可以通过名称进行初始化：

```swift
class Product {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

class CartItem: Product {
    var quantity: Int
    
    required init(name: String) {
        self.quantity = 1
        super.init(name: name)
    }
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
}

class DigitalProduct: Product {
    var downloadLink: String
    
    required init(name: String) {
        self.downloadLink = ""
        super.init(name: name)
    }
    
    init(name: String, downloadLink: String) {
        self.downloadLink = downloadLink
        super.init(name: name)
    }
}
```

在这个示例中，`CartItem`和`DigitalProduct`都必须实现 `required init(name: String)`，确保所有子类都可以通过名称进行初始化。

**总结**

`required` 初始化器确保在所有子类中都能实现特定的初始化方法。通过在基类中定义 `required` 初始化器，你可以强制所有子类都提供一种特定的初始化方式。这在设计一致性和工厂模式中非常有用。






### 22.使用闭包或者函数设置属性值

如果存储属性的默认值需要进行一些自定义或设置，您可以使用闭包或全局函数为该属性提供自定义的默认值。每当初始化属性所属类型的新实例时，都会调用闭包或函数，并将其返回值指定为属性的默认值。

这些类型的闭包或函数通常会创建与属性相同类型的临时值，定制该值以表示所需的初始状态，然后返回该临时值以用作属性的默认值。


以下是如何使用闭包提供默认属性值的框架：
```swift
class SomeClass {
    let someProperty: SomeType = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return someValue
    }()
}
```

**请注意，闭包的末尾花括号后面跟着一对空括号**。这告诉 Swift 立即执行闭包。如果省略这些括号，您将尝试将闭包本身分配给属性，而不是闭包的返回值。

>**Note:**如果您使用闭包来初始化属性，请记住在执行闭包时实例的其余部分尚未初始化。这意味着您无法从闭包中访问任何其他属性值，即使这些属性具有默认值。您也不能使用隐式 self 属性，或调用任何实例的方法。
>

下面的示例定义了一个名为 Chessboard 的结构，它为国际象棋游戏的棋盘建模。国际象棋在 8 x 8 的棋盘上进行，棋盘上有黑白相间的方格。

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/chessBoard@2x.png" style="zoom:50%">




为了表示这个游戏板， Chessboard 结构有一个名为 boardColors 的属性，它是一个包含 64 个 Bool 值的数组。数组中的值 true 表示黑色方块， false 值表示白色方块。数组中的第一项代表棋盘上左上角的方块，数组中的最后一项代表棋盘上右下角的方块。

`boardColors` 数组使用闭包进行初始化以设置其颜色值：

```swift
struct Chessboard {
    let boardColors: [Bool] = {   //常量定义了一个闭包，闭包用{}包裹，并且马上调用使用()号
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()   //马上调用
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}
```

每当创建一个新的 `Chessboard` 实例时，就会执行闭包，并计算并返回 `boardColors` 的默认值。上面示例中的闭包计算并在名为 `temporaryBoard` 的临时数组中为棋盘上的每个方块设置适当的颜色，并在设置完成后返回此临时数组作为闭包的返回值。返回的数组值存储在 `boardColors` 中，可以使用 `squareIsBlackAt(row:column:)` 实用函数进行查询：

```swift
let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
// Prints "true"
print(board.squareIsBlackAt(row: 7, column: 7))
// Prints "false"
```

