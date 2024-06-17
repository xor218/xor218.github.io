---
layout: post
author: "大西瓜"
title: "Structures And Classes Methods"
date:   2024-06-14 14:54:18 +0800
categories: [update,Swift] 
---

## Methods 方法

定义和调用属于实例或类型的函数。

方法是与特定类型关联的函数。**类**、**结构**和**枚举**都可以定义实例方法，这些方法封装了用于处理给定类型的实例的特定任务和功能。类、结构和枚举还可以定义类型方法，这些方法与类型本身相关联。类型方法类似于 Objective-C 中的类方法。



结构和枚举可以在 Swift 中定义方法，这是与 C 和 Objective-C 的主要区别。在 Objective-C 中，类是唯一可以定义方法的类型。在 Swift 中，你可以选择是定义类、结构还是枚举，并且仍然可以灵活地在你创建的类型上定义方法。



### 1.实例方法

实例方法是属于特定类、结构或枚举的实例的函数。它们通过提供访问和修改实例属性的方法，或通过提供与实例用途相关的功能来支持这些实例的功能。实例方法的语法与函数完全相同，如函数中所述。

您可以在实例方法所属类型的左大括号和右大括号内编写实例方法。实例方法具有对该类型的所有其他实例方法和属性的隐式访问。实例方法只能在其所属类型的特定实例上调用。如果没有现有实例，则无法单独调用它。

下面是一个定义简单 `Counter` 类的示例，该类可用于计算操作发生的次数：



```swift
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
```

该 `Counter` 类定义了三个实例方法：

- `increment()` 将 `1` 计数器递增 。
- `increment(by: Int)` 按指定的整数量递增计数器。
- `reset()` 将计数器重置为零。

该 `Counter` 类还声明一个变量属性 `count` ，以跟踪当前计数器值。

使用与属性相同的点语法调用实例方法：

```swift
let counter = Counter()
// the initial counter value is 0
counter.increment()
// the counter's value is now 1
counter.increment(by: 5)
// the counter's value is now 6
counter.reset()
// the counter's value is now 0
```



函数参数可以同时具有名称（用于在函数主体中使用）和参数标签（用于调用函数时使用），如函数参数标签和参数名称中所述。方法参数也是如此，因为**方法只是与类型关联的函数。**



### 2.隐式self

类型的每个实例都有一个称为 `self` 的隐式属性，该属性与实例本身完全等效。您可以使用该 `self` 属性在其自己的实例方法中引用当前实例。

上面示例中 `increment()` 的方法可以这样写：

```swift
func increment() {
    self.count += 1
}
```



在实践中，您不需要经常编写 `self` 代码。如果您没有显式编写 `self` ，则每当您在方法中使用已知属性或方法名称时，Swift 都会假定您引用的是当前实例的属性或方法。这个假设通过在三个实例方法中使用 `count` （而不是 `self.count` ）来 `Counter` 证明。

当实例方法的参数名称与该实例的属性同名时，会发生此规则的主要例外。在这种情况下，参数名称优先，并且有必要以更限定的方式引用属性。使用该 `self` 属性来区分参数名称和属性名称。

在这里， `self` 消除调用 `x` 的方法参数和也称为实例属性之间的歧义 `x` ：

```swift
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x //如果没有self 编译器会以为两个都是参数
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
// Prints "This point is to the right of the line where x == 1.0"
```

如果没有前 `self` 缀，Swift 会假定 的 `x` 两种用法都引用了名为 `x` 的方法参数。





### 3.从实例方法中修改值的类型 mutating

结构和枚举是值类型。默认情况下，无法从其实例方法中修改值类型的属性。

但是，如果需要在特定方法中修改结构或枚举的属性，则可以选择加入该方法的更改行为。然后，该方法可以从方法内部更改（即更改）其属性，并且在方法结束时，它所做的任何更改都会写回原始结构。该方法还可以为其隐式 `self` 属性分配一个全新的实例，当方法结束时，此新实例将替换现有实例。



enum 和结构修的都是 类中成员变量的拷贝，所以方法不能修改成员变量，就算修改了，修改的只是副本，所以需要将方法标记为mutating，mutating方法允许在enum/struct的内部修改成员。class的结构不需要使用关键字，因为是class是引用类型



- **值类型（结构体和枚举）**：需要使用 mutating 关键字来允许方法内部修改成员变量。
- **引用类型（类）**：不需要 mutating 关键字，可以直接在方法内部修改成员变量。



**结构体中的 mutating 方法**

```swift
struct Point {
    var x: Int
    var y: Int

    mutating func moveBy(x deltaX: Int, y deltaY: Int) {
        x += deltaX
        y += deltaY
    }
}

var point = Point(x: 0, y: 0)
point.moveBy(x: 10, y: 10)
print(point)  // 输出：Point(x: 10, y: 10)
```





**枚举中的mutating方法**

```swift
enum Switch {
    case off, on

    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = Switch.off
lightSwitch.toggle()
print(lightSwitch)  // 输出：on
```





**类的方法**

类是引用类型，因此不需要 mutating 关键字，方法中可以直接修改成员变量。

```swift
class Counter {
    var count = 0

    func increment() {
        count += 1
    }
}

let counter = Counter()
counter.increment()
print(counter.count)  // 输出：1
```





您可以通过将 `mutating` 关键字放在该方法 `func` 的关键字之前来选择加入此行为：

```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// Prints "The point is now at (3.0, 4.0)"
```



上面的 `Point` 结构定义了一个 mutating `moveBy(x:y:)` 方法，该方法将 `Point` 实例移动一定量。此方法实际上不是返回新点，而是修改调用它的点。 `mutating` 关键字将添加到其定义中，以使其能够修改其属性。



请注意，不能对结构类型的常量( **let** 声明的)调用 mutating 方法，因为无法更改其属性，即使它们是变量属性，如常量结构实例的存储属性中所述：



```swift
let fixedPoint = Point(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)
// this will report an error 
```





### 4.在mutating方法中分配给自己



**结构 mutating**

Mutating 方法可以将一个全新的实例分配给 implicit `self` 属性。上面显示的 `Point` 示例可以改为按以下方式编写：

```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

var point = Point()
point.movePos(first: 1.2, second: 3.4)


//以下为错误的:方法返回void，改变自己而已
//var point = Point()
//point.movePos(first: 1.2, second: 3.4)
```

此版本的 mutating `moveBy(x:y:)` 方法创建一个新结构，其 `x` 和 `y` 值设置为目标位置。调用此方法的替代版本的最终结果将与调用早期版本的最终结果完全相同。





**枚举 mutating**

枚举的变异方法可以将隐式 `self` 参数设置为与同一枚举不同的大小写：

```swift
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off
```

此示例定义三态开关的枚举。每次调用其 `next()` 方法时，开关都会在三种不同的电源状态 （ `off` 和 `low` `high` ） 之间循环。





### 5.type Methods 类型方法

**类型:class Struct Enum 等类型的方法**

**相当于C++的静态函数和静态变量**

如上所述，实例方法是在特定类型的实例上调用的方法。还可以定义对类型本身调用的方法。这类方法称为类型方法。通过在方法 `func` 的关键字之前写 `static` 入关键字来指示类型方法。类可以改用关键 `class` 字，以允许子类重写超类对该方法的实现。



> **Note**:在 Objective-C 中，只能为 Objective-C 类定义类型级方法。在 Swift 中，您可以为**所有类**、**结构**和**枚举**定义类型级方法。每个类型方法都显式限定为它支持的类型。



类型方法使用点语法调用，就像实例方法一样。但是，您可以在类型上调用类型方法，而不是在该类型的实例上调用类型方法。下面介绍如何在名为 `SomeClass` 的类上调用类型方法：

```swift
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here 类型方法在此实现
      	// 关键字class 表示，这是一个class类型的方法，不是类实例的方法
    }
}
SomeClass.someTypeMethod()
```



在类型方法的主体中，隐式 `self` 属性引用类型本身，而不是该类型的实例。这意味着您可以使用 `self` 来消除类型属性和类型方法参数之间的歧义，就像对实例属性和实例方法参数所做的那样。



更一般地说，在类型方法的主体中使用的任何非限定方法和属性名称都将引用其他类型级方法和属性。类型方法可以使用另一个方法的名称调用另一个类型方法，而无需使用类型名称作为前缀。同样，结构和枚举上的类型方法可以使用不带类型名称前缀的类型属性名称来访问类型属性。



下面的示例定义了一个名为 `LevelTracker` 的结构，用于跟踪玩家在游戏的不同关卡或阶段的进度。这是一款单人游戏，但可以在一台设备上存储多个玩家的信息。



游戏的所有关卡（第一关除外）在第一次玩游戏时都被锁定。每当玩家完成一个关卡时，该关卡就会为设备上的所有玩家解锁。该 `LevelTracker` 结构使用类型属性和方法来跟踪游戏的哪些关卡已解锁。它还跟踪单个玩家的当前级别。



```swift
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1


    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }


    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }


    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
```



该 `LevelTracker` 结构会跟踪任何玩家已解锁的最高级别。此值存储在名为 `highestUnlockedLevel` 的类型属性中。

`LevelTracker` 还定义了两个类型函数来处理该 `highestUnlockedLevel` 属性。第一个是名为 `unlock(_:)` 的类型函数，每当解锁新关卡时，它就会更新该函数的 `highestUnlockedLevel` 值。第二个是称为 `isUnlocked(_:)` 的便利类型函数，如果特定级别编号已解锁，则返回 `true` 该函数。（请注意，这些类型方法可以访问 type 属性， `highestUnlockedLevel` 而无需将其编写为 `LevelTracker.highestUnlockedLevel` 。



除了其类型属性和类型方法外， `LevelTracker` 还可以跟踪单个玩家在游戏中的进度。它使用调用 `currentLevel` 的实例属性来跟踪玩家当前正在玩的关卡。

为了帮助管理该属性， `currentLevel` `LevelTracker` 请定义一个名为 `advance(to:)` 的实例方法。在更新 `currentLevel` 之前，此方法会检查请求的新级别是否已解锁。该 `advance(to:)` 方法返回一个 Boolean 值，以指示它是否实际能够设置 `currentLevel` 。由于调用 `advance(to:)` 该方法忽略返回值的代码不一定是错误，因此此函数使用 `@discardableResult` 属性进行标记。有关此属性的详细信息，请参阅属性。



该 `LevelTracker` 结构与如下所示的 `Player` 类一起使用，以跟踪和更新单个玩家的进度：

```swift
class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}
```



您可以为新玩家创建 `Player` 该类的实例，并查看该玩家完成第一关时会发生什么：

```swift
var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// Prints "highest unlocked level is now 2"
```



如果您创建了第二个玩家，并且您尝试将其移动到游戏中任何玩家尚未解锁的关卡，则设置玩家当前关卡的尝试将失败：

```swift
player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 hasn't yet been unlocked")
}
// Prints "level 6 hasn't yet been unlocked"
```



### 6. 方法中的static和class修饰符的区别

在 Swift 中，`static` 和 `class` 修饰符用于类方法和类属性，但它们的行为和用途有所不同。具体来说，`static` 和 `class` 都用于定义类型级别的方法或属性，但 `class` 允许子类重写这些方法或属性，而 `static` 则不允许。

**`static` 和 `class` 的区别**

**`static` 修饰符**

- **用法**：用于定义类型方法和属性，这些方法和属性不能被子类重写。
- **行为**：方法或属性属于类本身，而不是类的实例。所有实例共享这些方法和属性。
- **示例**：                                   

  ```swift
  class SomeClass {
      static func myStaticFunc() {
          print("This is a static method.")
      }
  }
  
  SomeClass.myStaticFunc() // 输出: This is a static method.
  ```

**`class` 修饰符**

- **用法**：用于定义可以被子类重写的类型方法或属性（通常是计算属性）。
- **行为**：方法或属性属于类本身，允许子类提供自己的实现。
- **示例**：

  ```swift
  class SomeClass {
      class func myClassFunc() {
          print("This is a class method.")
      }
  }
  
  class SubClass: SomeClass {
      override class func myClassFunc() {
          print("This is an overridden class method.")
      }
  }
  
  SomeClass.myClassFunc()  // 输出: This is a class method.
  SubClass.myClassFunc()   // 输出: This is an overridden class method.
  ```

**详细解释和使用场景**

1. **`static` 方法**：
   - 这些方法不能被子类重写。
   - 适用于那些你不希望被继承的类型方法或属性。
   - 常用于工具方法或辅助方法，这些方法不需要依赖类的实例，并且不需要在子类中改变其行为。

2. **`class` 方法**：
   - 允许子类重写这些方法。
   - 适用于你希望允许子类提供特定实现的类型方法或属性。
   - 常用于需要在子类中提供不同实现的策略方法或工厂方法。

**示例代码**

**使用 `static` 修饰符**

```swift
class Utility {
    static func utilityMethod() {
        print("Utility method")
    }
}

Utility.utilityMethod() // 输出: Utility method
```

**使用 `class` 修饰符**

```swift
class Animal {
    class func makeSound() {
        print("Some generic animal sound")
    }
}

class Dog: Animal {
    override class func makeSound() {
        print("Bark!")
    }
}

Animal.makeSound() // 输出: Some generic animal sound
Dog.makeSound()    // 输出: Bark!
```

**总结**

- **`static`** 修饰的方法或属性不能被子类重写，适用于那些无需改变的工具方法或常量。
- **`class`** 修饰的方法或属性可以被子类重写，适用于需要在子类中提供不同实现的场景。

通过了解 `static` 和 `class` 修饰符的区别及其使用场景，可以更好地设计类层次结构和行为，在需要扩展或保持方法行为时选择合适的修饰符。
