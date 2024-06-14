---
layout: post
author: "大西瓜"
title: "Structures And Classes Properties 结构和类的性能"
date:   2024-06-11 16:22:15 +0800
categories: [update,Swift] 
---





## Properties 性能,属性

访问属于实例或类型的存储和计算值。



属性将值与特定类、结构或枚举相关联。存储属性将常量和变量值存储为实例的一部分，而计算属性计算（而不是存储）值。计算属性由类、结构和枚举提供。存储属性仅由类和结构提供。

存储和计算的属性通常与特定类型的实例相关联。但是，属性也可以与类型本身相关联。此类属性称为类型属性。



此外，还可以定义属性观察器来监视属性值的更改，您可以使用自定义操作来响应这些更改。可以将属性观察器添加到您自己定义的存储属性中，也可以添加到子类从其超类继承的属性中。

还可以使用属性包装器在多个属性的 getter 和 setter 中重用代码。



### 1.存储属性

在最简单的形式中，存储属性是存储为特定类或结构实例的一部分的常量或变量。存储属性可以是变量存储属性（由 `var`关键字引入）或常量存储属性（由 `let` 关键字引入）。

您可以为存储的属性提供默认值作为其定义的一部分，如默认属性值中所述。还可以在初始化期间设置和修改存储属性的初始值。即使对于常量存储的属性也是如此，如在初始化期间分配常量属性中所述。

下面的示例定义了一个名为 `FixedLengthRange` 的结构，该结构描述了一个整数范围，其范围长度在创建后无法更改：

```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int   
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8
```



 `FixedLengthRange` 实例具有一个名为 `firstValue` 的变量存储属性和一个名为 `length` 的常量存储属性。在上面的示例中， `length` 在创建新范围时初始化，此后无法更改，因为它是一个常量属性。



### 2.常量结构实例的存储属性



如果创建结构的实例并将该实例分配给常量，则无法修改实例的属性，即使它们被声明为变量属性：

```swift
//声明为常量 不
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3
rangeOfFourItems.firstValue = 6
// this will report an error, even though firstValue is a variable property
```

由于 `rangeOfFourItems` 声明为常量（使用 `let` 关键字），因此无法更改其 `firstValue` 属性，即使 `firstValue` 它是变量属性也是如此。

此行为是由于结构是值类型。当值类型的实例被标记为常量时，其所有属性也会被标记为常量。

对于作为引用类型的类来说，情况并非如此。如果将引用类型的实例分配给常量，则仍可以更改该实例的变量属性。





### 3.延迟存储属性

如果在一个class 里面，变量变量前面使用关键字Lazy

延迟存储属性是其初始值在首次使用之前不会计算的属性。通过在声明之前写 `lazy` 入修饰符来指示延迟存储属性。

> 
>
> **Note**:
>
> **必须始终将惰性属性声明为变量（使用 `var` 关键字）**，因为在实例初始化完成之前可能无法检索其初始值。在初始化完成之前，常量属性必须始终具有一个值，因此不能声明为延迟属性。



当属性的初始值依赖于外部因素时，惰性属性非常有用，这些外部因素的值在实例初始化完成之前是未知的。当属性的初始值需要复杂或计算成本高昂的设置时，惰性属性也很有用，除非需要，否则不应执行。

下面的示例使用惰性存储属性来避免对复杂类进行不必要的初始化。此示例定义了两个名为 `DataImporter` 和 `DataManager` 的类，这两个类都没有完整显示：



```swift
class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}


class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}


let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property hasn't yet been created
```



该 `DataManager` 类具有一个名为 `data` 的存储属性，该属性使用新的空值数 `String` 组进行初始化。尽管未显示其其余功能，但此类 `DataManager` 的目的是管理和提供对此 `String` 数据数组的访问。

该 `DataManager` 类的部分功能是从文件导入数据的能力。此功能由 `DataImporter` 类提供，假定该类需要大量时间来初始化。这可能是因为在 `DataImporter` 初始化 `DataImporter` 实例时，实例需要打开文件并将其内容读入内存。

由于 `DataManager` 实例可以在不从文件导入数据的情况下管理其数据， `DataManager` 因此在创建 `DataManager` 自身时不会创建新 `DataImporter` 实例。相反，在首次使用 `DataImporter` 实例时创建实例更有意义。

由于它标有 `lazy` 修饰符，因此仅在首次访问 `importer` 该属性时（例如在查询其 `filename` 属性时）创建 `importer` 该属性的 `DataImporter` 实例：



> 
>
> **Note**
>
> 如果多个线程同时访问标有修饰符的 `lazy` 属性，并且该属性尚未初始化，则无法保证该属性仅初始化一次。



#### 3.1 ChapGpt

lazy 属性的变量,class 实例化的时候不会立刻计算值是吗 还有别的作用吗

是的，**`lazy` 属性的变量在类实例化时不会立即计算其值**，只有在第一次访问该变量时才会进行计算和初始化。这种机制除了延迟初始化外，还有其他一些重要作用和应用场景。

**延迟初始化**

`lazy` 属性只有在第一次访问时才会初始化，这对于一些需要延迟加载的属性非常有用，特别是在初始化过程昂贵或者需要大量资源时。例如：

```swift
class ExpensiveObject {
    init() {
        print("ExpensiveObject initialized")
    }
}

class MyClass {
    lazy var expensive = ExpensiveObject()

    init() {
        print("MyClass initialized")
    }
}

let instance = MyClass()
// 此时不会初始化 ExpensiveObject
print("Accessing expensive property")
let _ = instance.expensive // 只有在第一次访问时才会初始化 ExpensiveObject
```

**其他作用和应用场景**

1. 性能优化

对于那些初始化过程昂贵且未必会使用的属性，使用 `lazy` 可以显著提升性能。例如，大型数据结构或复杂计算结果可以延迟到真正需要时再进行初始化，从而减少不必要的开销。

2. **依赖其他属性**

有时候，一个属性的初始化依赖于其他必须先初始化的属性。使用 `lazy` 可以确保这些依赖项在使用之前已经被正确初始化。例如：

```swift
class Config {
    var settings: [String: String] = ["Mode": "Production"]
}

class App {
    var config = Config()
    lazy var mode: String = {
        return config.settings["Mode"] ?? "Default"
    }()
}
```

在这个例子中，`mode` 属性依赖于 `config` 的初始化，并在 `config` 初始化完成后才会计算。

3. **避免循环依赖**

在某些情况下，`lazy` 可以帮助避免循环依赖。因为 `lazy` 属性只有在访问时才会初始化，这可以打破某些复杂对象图中的循环依赖。

**注意事项**

- **线程安全**：`lazy` 属性默认不是线程安全的。如果在多线程环境中可能会同时访问 `lazy` 属性，需要确保对其进行适当的同步处理。
- **只能用于存储属性**：`lazy` 只能用于类和结构体的存储属性，不能用于全局变量或计算属性。





### 4.存储属性和实力变量

如果您有使用 Objective-C 的经验，您可能知道它提供了两种将值和引用存储为类实例的一部分的方法。除了属性之外，还可以将实例变量用作属性中存储的值的后备存储。

Swift 将这些概念统一到一个属性声明中。Swift 属性没有相应的实例变量，并且不会直接访问属性的后备存储。这种方法避免了在不同上下文中如何访问值的混淆，并将属性的声明简化为单一的确定性语句。有关属性的所有信息（包括其名称、类型和内存管理特征）都作为类型定义的一部分在单个位置进行定义。



### 5.计算属性

除了存储的属性之外，类、结构和枚举还可以定义计算属性，这些属性实际上并不存储值。相反，它们提供了一个 getter 和一个可选的 setter 来间接检索和设置其他属性和值。



```swift
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
    size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
// initialSquareCenter is at (5.0, 5.0)
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"

```

此示例定义了三种用于处理几何形状的结构：

- `Point` 封装点的 x 和 y 坐标。
- `Size` 封装 a `width` 和 a `height` .
- `Rect` 通过原点和大小定义矩形。

该 `Rect` 结构还提供一个名为 `center` 的计算属性。a `Rect` 的当前中心位置始终可以从其 `origin` 和 `size` 确定，因此无需将中心点存储为显式 `Point` 值。相反， `Rect` 为名为 `center` 的计算变量定义自定义 getter 和 setter，使您能够 `center` 像使用实际存储属性一样处理矩形。

上面的示例创建了一个名为 `square` 的新 `Rect` 变量。 `square` 变量的初始化原点为 `(0, 0)` ，宽度和高度为 `10` 。这个正方形由下图中的浅绿色正方形表示。

然后通过点语法 （ `square.center` ） 访问 `square` 变量 `center` 的属性，这会导致调用 getter `center` for 以检索当前属性值。getter 实际上不是返回现有值，而是计算并返回一个新 `Point` 值来表示正方形的中心。如上图所示，吸气器正确地返回中心点 `(5, 5)` 。

然后，将 `center` 该属性设置为新值 `(15, 15)` ，这会将正方形向上和向右移动到下图中深绿色正方形所示的新位置。设置 `center` 属性会调用 的 `center` setter ，这将修改存储 `origin` 属性的 `x` 和 `y` 值，并将正方形移动到其新位置。

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/computedProperties@2x.png" style="width:70%">



### 6. set声明

你可以不显式地声明 newValue。在 Swift 中，计算属性的 set 方法默认会提供一个名为 **newValue** 的隐式参数。你可以直接使用这个隐式参数

```swift
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set { //swift 提供一个隐式的新值:newValue
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
      //隐式的 newValue
      //相当于下面这样
        set(newValue) {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
```



### 7. 速记get声明

如果 getter 的整个主体是单个表达式，则 getter 隐式返回该表达式。下面是利用此速记表示法和二传手速记表示法的 `Rect`结构的另一个版本：

```swift
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
          //单个 表达式，省略return
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}
```

省略 `return` from a getter 遵循与 `return` 省略函数相同的规则，如具有隐式返回的函数中所述。





### 8.只读计算属性

具有 getter 但没有 setter 的计算属性称为只读计算属性。只读计算属性始终返回一个值，可以通过点语法访问，但不能设置为其他值。



> 
>
> **Note**:
>
> 您必须使用 `var` 关键字将计算属性（包括只读计算属性）声明为变量属性，因为它们的值不是固定的。该 `let` 关键字仅用于常量属性，以指示在实例初始化过程中将其设置为实例初始化的一部分后无法更改其值。
>
> 

```swift
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0"
```

此示例定义了一个名为 `Cuboid` 的新结构，该结构表示具有 `width` 、 `height` 和 `depth` 属性的 3D 矩形框。此结构还具有一个名为 `volume` 的只读计算属性，用于计算并返回长方体的当前体积。可设置是没有意义的 `volume` ，因为对于哪些值 `width` 、 `height` 和 `depth` 应该用于特定 `volume` 值是模棱两可的。尽管如此，提供只读计算属性以使外部用户能够发现其当前计算量还是很有用的 `Cuboid` 。



###	9.属性观察器 willset oldset

🐶关键字 **willset** and **oldset**



财产观察者观察并响应财产价值的变化。每次设置属性的值时，都会调用属性观察器，即使新值与属性的当前值相同也是如此。

您可以在以下位置添加属性观察器：

- **您定义的存储属性**
- **您继承的存储属性**
- **您继承的计算属性**

对于继承的属性，可以通过在子类中重写该属性来添加属性观察器。对于您定义的计算属性，请使用该属性的 **setter** 来观察和响应值更改，而不是尝试创建观察者。重写属性在重写中进行了介绍。

您可以选择在属性上定义其中一个或两个观察点：

- **`willSet` 在存储值之前调用。**
- **`didSet` 在存储新值后立即调用。**

同样，如果实现观察 `didSet` 器，则会传递一个包含旧属性值的常量参数。您可以命名参数，也可以使用默认参数名称 `oldValue` 。如果在属性自己的 `didSet` 观察器中为其赋值，则赋值的新值将替换刚刚设置的值。

>
>
>**Note**:
>
>在调用超类初始值设定项之后，在子类初始值设定项中设置属性时，将调用超类属性 `willSet` 的 和 `didSet` 观察者。在调用超类初始值设定项之前，类设置自己的属性时，不会调用它们。

```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)") //显示的新值，其实也提供了newValue
        }
      
      //didset 会提供一个旧值 是之前的值oldValue
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps
```

该 `StepCounter` 类声明 `Int` 类型的 `totalSteps` 属性。这是具有 `willSet` 和 `didSet` 观察者的存储属性。

每当为属性分配新值时，都会调用 `willSet` 和 `didSet` 观察 `totalSteps` 器。即使新值与当前值相同，也是如此。

此示例 `willSet` 的观察程序使用即将到来的新值的自定义参数名称。 `newTotalSteps` 在此示例中，它只是打印出将要设置的值。

在更新 的 `totalSteps` 值后调用 `didSet` 观察器。它将新 `totalSteps` 值与旧值进行比较。如果总步骤数增加，则会打印一条消息，指示已执行多少个新步骤。 `didSet` 观察程序不为旧值提供自定义参数名称，而是使用默认 `oldValue` 名称 。

>
>
>**Note**:不懂
>
>如果将具有观察器的属性作为 in-out 参数传递给函数，则始终调用 `willSet` 和 `didSet` observers。这是因为 in-out 参数的 copy-in-out 内存模型：该值始终在函数末尾写回属性。有关 in-out 参数行为的详细讨论，请参阅 In-Out 参数。





### 10.属性包装 propertyWrapper

> **keywords**: 
>
> **propertyWrapper** ,**wrappedValue**



属性包装器在管理属性存储方式的代码和定义属性的代码之间添加一个分隔层。例如，如果具有提供线程安全检查或将其基础数据存储在数据库中的属性，则必须在每个属性上编写该代码。使用属性包装器时，在定义包装器时编写一次管理代码，然后通过将该管理代码应用于多个属性来重用该管理代码。



若要定义属性包装器，请创建定义 `wrappedValue` 属性的结构、枚举或类。在下面的代码中，该 `TwelveOrLess` 结构确保它包装的值始终包含小于或等于 12 的数字。如果您要求它存储更大的数字，它会存储 12 个。



```swift
@propertyWrapper
struct TwelveOrLess {
    private var number = 0  //原来的属性 private
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

```

setter 确保新值小于或等于 12，并且 getter 返回存储的值。

> **Note**
>
> 上面示例中的声明 `number` 将变量标记为 `private` ，这确保 `number` 了仅用于 `TwelveOrLess` 的实现。在其他任何地方编写的代码使用 get 和 setter for `wrappedValue` 访问值，但不能直接使用 `number` 。有关 `private` 的信息，请参阅访问控制。



通过将包装器的名称写在属性之前，可以将包装器应用于属性。下面是一个结构，它存储一个矩形，该矩形使用 `TwelveOrLess` 属性包装器来确保其尺寸始终为 12 或更小：

```swift

struct SmallRectangle {
  	//@类
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}


var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"


rectangle.height = 10
print(rectangle.height)
// Prints "10"


rectangle.height = 24  //超过12 会被包装器设置为10
print(rectangle.height)
// Prints "12"
```

`height` 和 `width` 属性从 `TwelveOrLess` 的定义中获取其初始值，该定义设置为 `TwelveOrLess.number` 零。二传手将 `TwelveOrLess` 10 视为有效值，因此将数字 10 存储在所写收益中 `rectangle.height` 。但是，24 大于 `TwelveOrLess` 允许值，因此尝试存储 24 最终会设置为 `rectangle.height` 12，这是允许的最大值。



将包装器应用于属性时，编译器会合成为包装器提供存储的代码和通过包装器提供对属性的访问的代码。（属性包装器负责存储包装值，因此没有用于此的合成代码。可以编写使用属性包装器行为的代码，而无需利用特殊的属性语法。例如，下面是上一个代码列表中的一个 `SmallRectangle` 版本，它显式地将其属性包装在 `TwelveOrLess` 结构中，而不是写 `@TwelveOrLess` 为属性：

```swift
struct SmallRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}
```

`_height` 和 `_width` 属性存储属性包装器 . `TwelveOrLess` 对 `wrappedValue` 属性的 getter 和 setter `height` 以及 `width` 对属性的包装访问



### 11.设置包装属性的初始值

上面示例中的代码通过在 的定义 `TwelveOrLess` 中提供 `number` 初始值来设置包装属性的初始值。使用此属性包装器的代码不能为包装方式 `TwelveOrLess` 的属性指定不同的初始值，例如， `SmallRectangle` 不能给出 `height` 或 `width`初始值的定义。若要支持设置初始值或其他自定义项，属性包装器需要添加初始值设定项。下面是 `TwelveOrLess` called `SmallNumber` 的扩展版本，它定义了设置包装值和最大值的初始值设定项：

```swift
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int


    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }


    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}
```



 `SmallNumber` 包括三个初始值设定项 — `init()` 、 `init(wrappedValue:)` 和 `init(wrappedValue:maximum:)` — 下面的示例使用它们来设置包装值和最大值。有关初始化和初始值设定项语法的信息，请参阅初始化。

当您将包装器应用于属性并且未指定初始值时，Swift 会使用 `init()` 初始值设定项来设置包装器。例如：

```swift
struct ZeroRectangle {
  
    @SmallNumber var height: Int   //调用属性包装器SmallNumber()默认 创建
    @SmallNumber var width: Int
}


var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)
// Prints "0 0"
```

`SmallNumber` 该换行 `height` 和 `width` 的实例是通过调用 `SmallNumber()` 创建的。该初始值设定项中的代码使用默认值 0 和 12 设置初始换行值和初始最大值。属性包装器仍提供所有初始值，如 `TwelveOrLess` 前面在 中使用的 `SmallRectangle` 示例。与该示例不同， `SmallNumber` 还支持在声明属性时写入这些初始值。



当您使用包装器在属性上写入 `= 1` 时，这将转换为对 `init(wrappedValue:)` 初始值设定项的调用。 `SmallNumber` 该换行 `height` 和 `width` 的实例是通过调用 `SmallNumber(wrappedValue: 1)` 创建的。初始值设定项使用此处指定的包装值，并使用默认的最大值 12。



当您在自定义属性后面的括号中编写参数时，Swift 会使用接受这些参数的初始值设定项来设置包装器。例如，如果您提供初始值和最大值，则 Swift 将使用 `init(wrappedValue:maximum:)` 初始值设定项：

```swift
struct NarrowRectangle {
//装饰器的另外一种构造函数 init(wrappedValue:, maximum:) 
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}


var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Prints "2 3"


narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Prints "5 4"
```

`SmallNumber` 该包装的实例 `height` 是通过调用 `SmallNumber(wrappedValue: 2, maximum: 5)` 创建的，而包装的实例 `width` 是通过调用 `SmallNumber(wrappedValue: 3, maximum: 4)` 创建的。

通过包含属性包装器的参数，可以在包装器中设置初始状态，或者在创建包装器时将其他选项传递给包装器。此语法是使用属性包装器的最常规方法。您可以为属性提供所需的任何参数，这些参数将传递给初始值设定项。

包含属性包装器参数时，还可以使用赋值指定初始值。Swift 将赋值视为参数 `wrappedValue` ，并使用接受您包含的参数的初始值设定项。例如：

```swift
struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}


var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Prints "1"


mixedRectangle.height = 20
print(mixedRectangle.height)
// Prints "12"
```

`SmallNumber` 该换行的实例 `height` 是通过调用 创建的，该调用 `SmallNumber(wrappedValue: 1)` 使用默认的最大值 12。通过调用 `SmallNumber(wrappedValue: 2, maximum: 9)` 创建换 `width` 行的实例。 



###  12.从属性包装器投射值(预测值) projectedValue

**投影值的变量名称必须为projectedValue** 类型不限制

**用美元符号($)取投影值**

除了包装值之外，属性包装器还可以通过定义投影值来公开其他功能，例如，管理对数据库的访问的属性包装器可以公开其投影值的方法 `flushDatabaseConnection()` 。投影值的名称与包装值的名称相同，只是它以美元符号 （ ） 开头 `$` 。由于代码无法定义以 `$` 投影值开头的属性，因此永远不会干扰您定义的属性。

```swift
@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool


    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }


    init() {
        self.number = 0
        self.projectedValue = false
    }
}
struct SomeStructure {
    @SmallNumber var someNumber: Int
}
var someStructure = SomeStructure()


someStructure.someNumber = 4
print(someStructure.$someNumber)  //取投影值
// Prints "false"


someStructure.someNumber = 55
print(someStructure.$someNumber)
// Prints "true"

```

写入 `someStructure.$someNumber` 访问包装器的投影值。存储像 4 这样的小数字后，的 `someStructure.$someNumber` 值为 `false` 。但是，预计值是在 `true` 尝试存储太大的数字（如 55）之后。

属性包装器可以返回任何类型的值作为其投影值。在此示例中，属性包装器仅公开一条信息（是否调整了数字），因此它将该布尔值公开为其投影值。需要公开更多信息的包装器可以返回某种其他类型的实例，也可以返回 `self` 以将包装器的实例公开为其投影值。

当您从属于该类型的代码（如属性获取器或实例方法）访问投影值时，可以在属性名称之前省略， `self.` 就像访问其他属性一样。以下示例中的代码引用了 `height` 和 `width` as `$height` 和 `$width` 的包装器的投影值：

```swift
@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool //投射zhi


    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }


    init() {
        self.number = 0
        self.projectedValue = false
    }
}

struct SizedRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int


    mutating func resize(to size: Size) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $height || $width  //或运算 两个SmallNumber对象的投射值projectedValue 
    }
}
```

写入 `someStructure.$someNumber` 访问包装器的投影值。存储像 4 这样的小数字后，的 `someStructure.$someNumber` 值为 `false` 。但是，预计值是在 `true` 尝试存储太大的数字（如 55）之后。

> **Note**:
>
> 投射的变量名称必须是 **projectedValue**
>
> ```swift
> @propertiesWrapper
> struct WrapName{
>   ...
>   private(set) var projectedValue: Bool 
>   ...
>   var projectedValue:Int{
>     ...
>   }
> }
> struct SomeStructures{
>   @WrapName var number:Int
> }
> 
> 
> print()
> 
> 
> 
> ```
>
> - private(set) 为控制修饰符,表示内部可以读写，class外部只读
> - 投射的变量名称必须是 **projectedValue**
> - 用美元符号取投影值$



### 13.全局变量和局部变量

上述用于计算和观察属性的功能也可用于全局变量和局部变量。全局变量是在任何函数、方法、闭包或类型上下文之外定义的变量。局部变量是在函数、方法或闭包上下文中定义的变量。

您在前几章中遇到的全局变量和局部变量都是存储变量。存储变量（如存储属性）为特定类型的值提供存储，并允许设置和检索该值。

但是，您也可以在全局或局部范围内定义计算变量和存储变量的观察者。计算变量计算其值，而不是存储其值，并且它们的写入方式与计算属性相同。



> **Note**:
>
> 全局常量和变量始终以延迟方式计算，其方式与延迟存储属性类似。与延迟存储属性不同，全局常量和变量不需要用 `lazy` 修饰符进行标记。
>
> 局部常量和变量永远不会延迟计算。



**可以将属性包装应用于局部存储变量，但不能应用于全局变量或计算变量**。例如，在下面的代码中， `myNumber` 用作 `SmallNumber` 属性包装器。



```swift
//Error 属性包装器变量不能用于全局
@SmallNumber var myNumber: Int = 0

/
func someFunction() {
    @SmallNumber var myNumber: Int = 0

    myNumber = 10
    // now myNumber is 10
    myNumber = 24
    // now myNumber is 12
}
```

与应用于 `SmallNumber` 属性时一样，将值 `myNumber` 设置为 10 是有效的。由于属性包装器不允许大于 12 的值，因此它设置为 `myNumber` 12 而不是 24。





### 14.属性的类型

实例属性是属于特定类型的实例的属性。每次创建该类型的新实例时，它都有自己的一组属性值，与任何其他实例分开。



还可以定义属于类型本身的属性，而不是属于该类型的任何一个实例的属性。无论创建多少个该类型的实例，这些属性将只有一个副本。这些类型的属性称为类型属性。

类型属性可用于定义对特定类型的所有实例通用的值，例如所有实例都可以使用的常量属性（如 C 中的静态常量），或存储该类型的所有实例的全局值的变量属性（如 C 中的静态变量）。

存储类型属性可以是变量或常量。计算类型属性始终声明为变量属性，其方式与计算实例属性相同。

```swift

class SomeClass1{
    static  var Count:Int = 0  //属于Class的变量,所有实例共享。必须初始化,或者声明为可选类型
    var value:Int              //属于 类的实例的变量
    init(for value:Int){        //类的实例也需要初始化
        self.value = value
    }
    func setCount(_ count:Int){     //类对象修改属于类的变量
        SomeClass1.Count = count
    }
    
    static func classStaticFunc(){  //属于类本身的函数,所有实例共享。
        print("calling isStaticFunc.....")
    }
    
    func instanceCallStaticFunc(){  //实例 调用static 函数
        SomeClass1.classStaticFunc()
    }
    
    func getStaticValue() -> Int{
        return SomeClass1.Count
    }
}

var obj1 = SomeClass1(for: 1)
var obj2 = SomeClass1(for: 2)
print("before obj1 Count: \(obj1.getStaticValue())")
print("before obj2 Count: \(obj2.getStaticValue())")
//before obj1 Count: 0
//before obj2 Count: 0
obj1.setCount(45)   //对象设置
print("later obj1 Count: \(obj1.getStaticValue())")
print("later obj2 Count: \(obj2.getStaticValue())")
//later obj1 Count: 45
//later obj2 Count: 45

SomeClass1.Count = 555 //类自己设置值
print("later obj1 Count: \(obj1.getStaticValue())")
print("later obj2 Count: \(obj2.getStaticValue())")
//later obj1 Count: 555
//later obj2 Count: 555
```





> 
>
> **Note**:与存储实例属性不同，必须始终为存储类型属性提供默认值。这是因为类型本身没有可在初始化时为存储类型属性赋值的初始值设定项。
>
> 存储类型属性在首次访问时延迟初始化。它们保证只初始化一次，即使同时由多个线程访问也是如此，并且不需要用 `lazy` 修饰符标记它们。





### 15.属性的语法

在 C 和 Objective-C 中，将与类型关联的静态常量和变量定义为全局静态变量。但是，在 Swift 中，类型属性是作为类型定义的一部分编写的，位于类型的外大括号内，并且每个类型属性都显式地限定为它支持的类型。

使用 `static` 关键字定义类型属性。对于类类型的计算类型属性，可以改用关键 `class` 字来允许子类重写超类的实现。下面的示例显示了存储和计算类型属性的语法：

```swift
//结构
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

//枚举
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

//类
class SomeClass {
  	//静态的,使用static修饰符表示该变量属于类本身
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
  	//动态计算的,使用class修饰符表示该变量可以被子类改写
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

//派生类 
class SomeClassInherit:SomeClass{
// override：关键字用于表明这个属性是重写自基类的。
// class：关键字用于表明这个属性是一个类级别的属性，而不是实例级别的属性，并且它可以被子类重写。
    override class var overrideableComputedTypeProperty: Int {
        return 886
    }
}
```



> **Note**:
>
> 上面的计算类型属性示例适用于只读计算类型属性，但您也可以使用与计算实例属性相同的语法定义读写计算类型属性。



#### 15.1 class和static修饰符的区别

**by chapgpt:**

在 Swift 中，`static` 和 `class` 修饰符都用于定义类型属性和类型方法，但它们有不同的用途和行为。以下是对 `static` 和 `class` 修饰符的详细解释：

**`static` 修饰符**

- **用法**：用于定义类型属性和类型方法。
- **行为**：表示该属性或方法属于类本身，而不是类的实例。它**不能被子类重写**。
- **用途**：常用于定义常量或方法，这些常量或方法对于所有实例是共享的，并且不会被子类重写。

**`class` 修饰符**

- **用法**：用于定义可以被子类重写的计算类型属性和类型方法（仅适用于类）。
- **行为**：表示该属性或方法属于类本身，**可以被子类重写**。
- **用途**：常用于定义计算属性或方法，这些计算属性或方法可以在子类中提供不同的实现。

**示例代码**

```swift
class SomeClass {
    // 存储型类型属性，属于类本身，不能被子类重写
    static var storedTypeProperty = "Some value."
    
    // 计算型类型属性，属于类本身，不能被子类重写
    static var computedTypeProperty: Int {
        return 27
    }
    
    // 计算型类型属性，可以被子类重写 使用关键字class
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

// 子类继承 SomeClass 并重写 overrideableComputedTypeProperty
class SubClass: SomeClass {
    override class var overrideableComputedTypeProperty: Int {
        return 207
    }
}

// 访问父类和子类的属性
print(SomeClass.overrideableComputedTypeProperty)  // 输出: 107
print(SubClass.overrideableComputedTypeProperty)   // 输出: 207
```

**解释**

1. **`static` 修饰符**：
   - **存储型类型属性**：`static var storedTypeProperty` 是一个存储型类型属性，属于类本身，所有实例共享同一个值，不能被子类重写。
   - **计算型类型属性**：`static var computedTypeProperty` 是一个计算型类型属性，返回固定值 `27`，不能被子类重写。

2. **`class` 修饰符**：
   - **计算型类型属性**：`class var overrideableComputedTypeProperty` 是一个计算型类型属性，返回固定值 `107`，可以被子类重写。在子类 `SubClass` 中，`overrideableComputedTypeProperty` 被重写为返回 `207`。

**结论**

- **`static`**：用于定义类型属性和方法，这些属性和方法属于类本身，不能被子类重写。无论是存储属性还是计算属性，只要使用 `static` 修饰，它们都是静态的。
- **`class`**：用于定义可以被子类重写的计算类型属性和方法。这些属性和方法也属于类本身，但可以在子类中提供不同的实现。

因此，虽然 `static` 和 `class` 都用于定义类型属性和方法，它们在继承和重写方面有不同的用途。通过理解它们的区别和用途，可以更好地设计和实现类的层次结构和行为。



#### 15.2	Some Example Code

```swift
class MetalClass{
    static var Value0:Int = -1  //属于class的属性
    var valu1:Int = 0
     
    class var value2:Int {   //属于class的属性 允许子类重写
        return -3
    }
    
    func Value() ->Int{
        return MetalClass.value2
    }
}

class InheritClass:MetalClass{
  //子类重写函数或者变量要写override class表明重写变量
    override class var value2:Int {
        return -4
    }
    func Value(isMetaValue yes:Bool = true) ->Int {
        if yes {
            return super.Value()
        } else {
            return InheritClass.value2
        }
    }
}


print(InheritClass.Value0) // -1

var metalClass = MetalClass()
//print(metalClass.Value0)  Error,not object property,is Class self property
var inheritClass = InheritClass()

print(metalClass.Value()) //

print(inheritClass.Value(isMetaValue: true))  //使用基类的方法



```





### 16.查询和设置类型属性

类型属性使用点语法进行查询和设置，就像实例属性一样。但是，类型属性是在类型上查询和设置的，而不是在该类型的实例上。例如：

**全是enum,struct ,class 的类型名称，非实例名**

```swift
print(SomeStructure.storedTypeProperty)
// Prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"
```



下面的示例使用两个存储类型属性作为结构的一部分，该结构对多个音频通道的音频电平表进行建模。每个通道都有一个介 `0` 于 和 `10` 之间的整数音频电平。

下图说明了如何组合其中两个音频通道来模拟立体声音频电平表。当一个频道的音频电平为 `0` 时，该频道的所有灯都不会亮起。当音频电平为 `10` 时，该通道的所有灯都会亮起。在此图中，左通道的电流电平为 `9` ，右通道的电流电平为 `7` ：

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/staticPropertiesVUMeter@2x.png" style="width:50%">

上述音频通道由 `AudioChannel` 结构的实例表示：

```swift
struct AudioChannel {
  //let 常量不能修改 
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
```

该 `AudioChannel` 结构定义两个存储类型属性来支持其功能。第一个 `thresholdLevel` ，定义音频电平可以采用的最大阈值。这是所有 `AudioChannel` 实例的 `10` 常量值。如果音频信号的值高于 `10` ，则该信号将被限制为此阈值（如下所述）。



第二种类型属性是名为 `maxInputLevelForAllChannels` 的变量存储属性。这将跟踪任何 `AudioChannel` 实例接收到的最大输入值。它从初始值 开始 `0` 。



该 `AudioChannel` 结构还定义了一个名为 `currentLevel` 的存储实例属性，该属性表示通道的当前音频电平，范围 `0` 为 `10` 。

该 `currentLevel` 属性有一个 `didSet` 属性观察器，用于 `currentLevel` 检查设置时的值。此观察者执行两项检查：

- 如果新值 `currentLevel` 大于允许 `thresholdLevel` 值，则属性观察器将大 `currentLevel` 于 `thresholdLevel`。
- 如果新值 `currentLevel` （在任何上限之后）高于任何 `AudioChannel` 实例以前收到的任何值，则属性观察器将新 `currentLevel` 值存储在类型属性中 `maxInputLevelForAllChannels` 。

> 
>
> ** Note**:
>
> 在这两项检查中的第一个检查中， `didSet` 观察者设置为 `currentLevel` 不同的值。但是，这不会导致再次调用观察者。
