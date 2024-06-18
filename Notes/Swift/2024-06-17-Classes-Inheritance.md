---
layout: post
author: "大西瓜"
title: "Classes Inheritance 继承"
date:   2024-06-17 16:12:18 +0800
categories: [update,Swift] 
---



## Inheritance 继承

一个类可以从另一个类继承方法、属性和其他特征。当一个类继承另一个类时，继承的类称为子类，而它继承的类称为其超类。继承是 Swift 中将类与其他类型区分开来的基本行为。

Swift 中的类可以调用和访问属于其超类的方法、属性和下标，并且可以提供这些方法、属性和下标自己的重写版本，以细化或修改其行为。 Swift 通过检查覆盖定义是否具有匹配的超类定义来帮助确保您的覆盖正确。

类还可以向继承的属性添加属性观察器，以便在属性值更改时收到通知。属性观察器可以添加到任何属性，无论它最初是定义为存储属性还是计算属性。



**swift的初始化过程**

和C++不一样，子类C++要求先初始化基类，然后再初始化子类的成员属性。**Swift要求先初始化子类。然后再初始化基类**

**Swift 初始化顺序**

**1. 初始化子类的所有存储属性**

子类的所有存储属性必须在调用基类初始化方法之前被初始化。这确保了在调用基类初始化方法时，子类实例已经是部分有效的。

**2. 调用基类的初始化方法**

在子类的存储属性初始化之后，必须调用基类的初始化方法 (super.init())。这是因为基类的初始化方法负责初始化基类的存储属性，并确保基类部分的状态有效。

**3. 完成子类的任何进一步初始化**

在调用 super.init() 之后，如果子类有进一步的初始化代码，它们会在这一步执行。





### 1.定义基类

任何不从另一个类继承的类都称为基类。



> **Note**:不能继承基本类型，swift中的Int 等
>
> Swift 类不继承自通用基类。您在未指定超类的情况下定义的类会自动成为供您构建的基类。



下面的示例定义了一个名为 `Vehicle` 的基类。该基类定义了一个名为 `currentSpeed` 的存储属性，默认值为 `0.0` （推断属性类型为 `Double` ）。 `currentSpeed` 属性的值由名为 `description` 的只读计算 `String` 属性使用来创建车辆的描述。



`Vehicle` 基类还定义了一个名为 `makeNoise` 的方法。该方法实际上并不对基本 `Vehicle`实例执行任何操作，但稍后将由 `Vehicle` 的子类进行自定义：

```swift
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}
```

您使用初始值设定项语法创建 `Vehicle` 的新实例，该实例被编写为类型名称后跟空括号：

```
let someVehicle = Vehicle()
```

创建新的 `Vehicle` 实例后，您可以访问其 `description` 属性来打印车辆当前速度的人类可读描述：

```swift
print("Vehicle: \(someVehicle.description)")
// Vehicle: traveling at 0.0 miles per hour
```

`Vehicle` 类定义了任意车辆的共同特征，但其本身并没有多大用处。为了使其更有用，您需要对其进行改进以描述更具体的车辆类型。





### 2.子类化

子类化是在现有类的基础上创建新类的行为。子类继承了现有类的特征，然后您可以对其进行细化。您还可以向子类添加新特征。

要指示子类有超类，请将子类名称写在超类名称之前，并用冒号分隔：

```swift
class SomeSubclass: SomeSuperclass {
    // subclass definition goes here
}
```

以下示例定义了一个名为 `Bicycle` 的子类，其超类为 `Vehicle` ：

```swift
class Bicycle: Vehicle {
    var hasBasket = false
}
```

新的 `Bicycle` 类自动获得 `Vehicle` 的所有特征，例如它的 `currentSpeed` 和 `description` 属性及其 `makeNoise()`

除了继承的特征之外， `Bicycle` 类还定义了一个新的存储属性 `hasBasket` ，其默认值为 `false` （推断类型为 `Bool` 属性）。

默认情况下，您创建的任何新 `Bicycle` 实例都不会有购物篮。您可以在创建特定 `Bicycle`实例后将其 `hasBasket` 属性设置为 `true` ：

```swift
let bicycle = Bicycle()
bicycle.hasBasket = true
```

您还可以修改 `Bicycle` 实例继承的 `currentSpeed` 属性，并查询该实例继承的 `description` 属性：

```swift
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
// Bicycle: traveling at 15.0 miles per hour
```

子类本身可以被子类化。下一个示例为称为“tandem”的两座自行车创建 `Bicycle` 的子类：

```swift
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
```

`Tandem` 继承了 `Bicycle` 的所有属性和方法，而 `Bicycle` 又继承了 `Vehicle` 的所有属性和方法。 `Tandem` 子类还添加了一个名为 `currentNumberOfPassengers` 的新存储属性，其默认值为 `0` 。





如果您创建 `Tandem` 的实例，则可以使用其任何新的和继承的属性，并查询它从 `Vehicle` 继承的只读 `description` 属性:

```swift
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// Tandem: traveling at 22.0 miles per hour
```



### 3.Overriding 覆盖

**关键字 override声明重写基类方法，要不然报错**

子类可以提供其自己的实例方法、类型方法、实例属性、类型属性或下标的自定义实现，否则它将从超类继承。这称为覆盖。

要覆盖否则会继承的特征，请在覆盖定义前添加 `override` 关键字。这样做可以澄清您打算提供覆盖，并且没有错误地提供匹配的定义。意外覆盖可能会导致意外行为，并且在编译代码时，任何不带 `override` 关键字的覆盖都会被诊断为错误。

`override` 关键字还会提示 Swift 编译器检查您的重写类的超类（或其父类之一）是否具有与您为重写提供的声明相匹配的声明。此检查可确保您的重写定义是正确的。

```swift
class FatherClass{
    func SomeFunction(){
        print("Nothing")
    }
}

class SonClass:FatherClass{
    override func SomeFunction() {
        print("重写基类的方法要一定要加上关键字\"override\"要不然报错")
    }
}

let son = SonClass()
son.SomeFunction()

```



### 4.访问超类方法，属性和下标

**superclass 超类 是基类**

当您为子类提供方法、属性或下标重写时，使用现有超类实现作为重写的一部分有时很有用。例如，您可以优化现有实现的行为，或者将修改后的值存储在现有的继承变量中。



- 名为 `someMethod()` 的重写方法可以通过在重写方法实现中调用 `super.someMethod()`来调用 `someMethod()` 的超类版本。

- 名为 `someProperty` 的重写属性可以在重写 getter 或 setter 实现中以 `super.someProperty` 的形式访问 `someProperty` 的超类版本。

- `someIndex` 的重写下标可以从重写下标实现中访问与 `super[someIndex]` 相同下标的超类版本。

```swift

class Vehicle{
    var years:Int
    var pinPai:String
    
    init(years:Int,pinPai:String){
        self.years = years
        self.pinPai = pinPai
    }
    
    func display(){
        print("Infomation:");
        print("pinPai:\(self.pinPai)")
        print("years:\(self.years)")
    }
    
    subscript(typeInfo:String) ->String{
        switch(typeInfo){
        case "pinPai":
            return self.pinPai
        case "years","Years":
            return String(self.years)
        default:
            return "Unknow property"
        }
    }
}

class Car:Vehicle{
    var doors:Int
    
    init(year:Int,pinpai:String,door:Int){
        self.doors = door										//初始化顺序是先初始化子类，然后在初始化父类
        super.init(years:year,pinPai: pinpai) 	 //初始化父类
    }
    
    override func display(){                    //重写父类方法
        super.display()                         //调用父类方法
        print("Get super.years = \(super.years)")    //获取父类存储属性
        print("doors:\(self.doors)")
    }
    
    override subscript(typeInfo: String) -> String {    //重写父类的operator[]
        return super[typeInfo] + " + child SubScript"       //访问父亲类下表
    }
    
}

var car = Car(year: 1989, pinpai: "宝马", door: 4)
car.display()
print(car["hello"])
  
```

  







### 5.重写方法[Overriding Methods](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/inheritance/#Overriding-Methods)

您可以重写继承的实例或类型方法，以在子类中提供该方法的定制或替代实现。

以下示例定义了 `Vehicle` 的一个名为 `Train` 的新子类，它重写了 `Train` 继承自 `Vehicle`

```swift
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
```

如果您创建 `Train` 的新实例并调用其 `makeNoise()` 方法，您可以看到调用了该方法的 `Train` 子类版本：

```swift
let train = Train()
train.makeNoise()
// Prints "Choo Choo"
```









### 6.重写属性

您可以重写继承的实例或类型属性，以为该属性提供您自己的自定义 getter 和 setter，或者添加属性观察器以使重写属性能够在基础属性值更改时进行观察。



#### 6.1 重写属性Getter和Setter

您可以提供自定义 getter（以及 setter，如果适用）来覆盖任何继承的属性，无论继承的属性是在源代码中实现为存储属性还是计算属性。子类不知道继承属性的存储或计算性质 - 它只知道继承的属性具有特定的名称和类型。您必须始终声明要重写的属性的名称和类型，以使编译器能够检查您的重写是否与具有相同名称和类型的超类属性匹配。

通过在子类属性重写中提供 getter 和 setter，您可以将继承的只读属性呈现为读写属性。但是，您不能将继承的读写属性呈现为只读属性。

如果基类的属性是只读，可以在子类中用重写属性，并且用属性观察器(get set) 重写为可以读写的属性

但是基类的属性是可以读写，不能在子类中设置为Only read 或者Only Write,读写要全部实现



> **Note**:如果您提供 setter 作为属性重写的一部分，则还必须为该重写提供 getter。如果您不想在重写 getter 中修改继承属性的值，则只需从 getter 返回 `super.someProperty` 即可传递继承的值，其中 `someProperty` 是您正在覆盖的属性。



以下示例定义了一个名为 `Car` 的新类，它是 `Vehicle` 的子类。 `Car` 类引入了一个名为 `gear`的新存储属性，其默认整数值为 `1` 。 `Car` 类还覆盖它从 `Vehicle` 继承的 `description` 属性，以提供包含当前装备的自定义描述：



```swift
class Car: Vehicle {
    var gear = 1
    override var description: String { //重写description：基类是存储属性,或者计算属性都ok 
        return super.description + " in gear \(gear)"
    }
}
```



`description` 属性的重写首先调用 `super.description` ，它返回 `Vehicle` 类的 `description` 属性。 `Car` 类的 `description` 版本会在此描述的末尾添加一些额外的文本，以提供有关当前装备的信息。



#### 6.2 重写属性观察器



您可以使用属性重写将属性观察器添加到继承的属性。这使您能够在继承的属性的值发生更改时收到通知，无论该属性最初是如何实现的。有关属性观察器的更多信息，请参阅属性观察器。

> **Note**您无法将属性观察器添加到继承的常量存储属性或继承的只读计算属性。这些属性的值无法设置，因此不适合提供 `willSet` 或 `didSet` 实现作为覆盖的一部分。:
>
> 另请注意，您不能为同一属性同时提供重写 setter 和重写属性观察器。如果您想观察属性值的更改，并且您已经为该属性提供了自定义 setter，则可以简单地从自定义 setter 中观察任何值更改。



以下示例定义了一个名为 `AutomaticCar` 的新类，它是 `Car` 的子类。 `AutomaticCar` 类代表带有自动变速箱的汽车，它会根据当前速度自动选择合适的档位来使用：



```
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// AutomaticCar: traveling at 35.0 miles per hour in gear 4
```



每当您设置 `AutomaticCar` 实例的 `currentSpeed` 属性时，该属性的 `didSet` 观察者都会将该实例的 `gear` 属性设置为适当的装备选择为了新的速度。具体来说，属性观察者选择的齿轮是新的 `currentSpeed` 值除以 `10` ，向下舍入到最接近的整数，加上 `1` 。速度 `35.0` 产生档位 `4` ：

```swift
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// AutomaticCar: traveling at 35.0 miles per hour in gear 4
```





### 7.防止覆盖

**关键字：final **

您可以通过将方法、属性或下标标记为 Final 来防止其被覆盖。为此，请在方法、属性或下标的引入关键字之前写入 `final` 修饰符（例如 `final var` 、 `final func` 、 `final class func` 、和 `final subscript` ）。



任何重写子类中的最终方法、属性或下标的尝试都会报告为编译时错误。添加到扩展中的类的方法、属性或下标也可以在扩展的定义中标记为 Final。有关更多信息，请参阅扩展。



您可以通过在类定义 ( `final class` ) 中的 `class` 关键字之前写入 `final` 修饰符来将整个类标记为 Final。任何对最终类进行子类化的尝试都会被报告为编译时错误。

```swift

final class Tmp{
   //不允许被继承
}


class A1{
    final var Value:Int = 0   //不允许被重写
}


class OneClass{
    var value:Double = 0
    // 不允许被重写 下标本
    final subscript(for times:Double) -> Double{
        return value * Double(times)
    }
    
    //类的静态函数不允许被重写
    final class func finalEndFunction(){
        print("can't be override by subclass")
    }
    //普通函数不允许被重写
    final func normalFunction(){
        print("normalFunction can't be override")
    }
    
}

```













































