---
layout: post
author: "大西瓜"
title: "Classes Optional Chaining 可选链接"
date:   2024-06-25 22:41:48 +0800
categories: [update,Swift] 
---





## Optional Chaining 可选链接

**无需解包即可访问可选值的成员。**

可选链接是查询和调用当前可能为 `nil` 的可选属性、方法和下标的过程。如果可选项包含值，则属性、方法或下标调用成功；如果可选值为 `nil` ，则属性、方法或下标调用将返回 `nil` 。多个查询可以链接在一起，如果链中的任何链接是 `nil` ，则整个链会正常失败。

> **Note:**Swift 中的可选链接类似于 Objective-C 中的消息传递 `nil` ，但其方式适用于任何类型，并且可以检查成功或失败。



### 1.可选链接作为强制展开的替代方案

如果可选值不是 `nil` ，**则可以通过在要调用属性、方法或下标的可选值后面放置问号 ( `?` ) 来指定可选链接**。这与在可选值后面放置感叹号 ( `!` ) 以强制展开其值非常相似。主要区别在于，当可选为 `nil` 时，可选链接会正常失败，而当可选为 `nil` 时，强制展开会触发运行时错误。

为了反映可以在 `nil` 值上调用可选链接的事实，可选链接调用的结果始终是可选值，即使您正在查询的属性、方法或下标返回非 -可选值。您可以使用此可选返回值来检查可选链接调用是否成功（返回的可选包含一个值），或者由于链中存在 `nil` 值而失败（返回的可选值为 `nil` ）。

具体来说，可选链接调用的结果与预期返回值的类型相同，但包装在可选值中。通常返回 `Int` 的属性在通过可选链接访问时将返回 `Int?` 。

接下来的几个代码片段演示了可选链接与强制展开的不同之处，并使您能够检查是否成功。

首先，定义两个名为 `Person` 和 `Residence` 的类：

```swift
class Person {
    var residence: Residence?
}


class Residence {
    var numberOfRooms = 1
}
```

`Residence` 实例有一个名为 `numberOfRooms` 的 `Int` 属性，默认值为 `1` 。 `Person` 实例具有 `Residence?`类型的可选 `residence` 属性。



如果您创建一个新的 `Person` 实例，则其 `residence` 属性默认初始化为 `nil` ，因为它是可选的。在下面的代码中， `john` 的 `residence` 属性值为 `nil` ：

```swift
let john = Person()
```

如果您尝试访问此人的 `residence` 的 `numberOfRooms` 属性，通过在 `residence` 后面放置一个感叹号来强制展开其值，则会触发运行时错误，因为没有要解包的 `residence` 值：

```swift
let roomCount = john.residence!.numberOfRooms
// this triggers a runtime error
// 除非确定可选值非nil 要不然触发错误
```

当 `john.residence` 具有非 `nil` 值时，上面的代码会成功，并将 `roomCount` 设置为包含适当房间数量的 `Int` 值。但是，当 `residence` 为 `nil` 时，此代码始终会触发运行时错误，如上所示。

可选链提供了另一种访问 `numberOfRooms` 值的方法。要使用可选链接，请使用问号代替感叹号：

```swift
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."
```

这告诉 Swift 在可选的 `residence` 属性上“链接”，并在 `residence` 存在时检索 `numberOfRooms` 的值。

由于访问 `numberOfRooms` 的尝试有可能失败，因此可选链接尝试返回 `Int?` 类型的值，或“可选 `Int` ”。当 `residence` 为 `nil` 时（如上例所示），此可选 `Int` 也将为 `nil` ，以反映它是无法访问 `numberOfRooms` 。可选的 `Int` 通过可选绑定来访问，以解开整数并将非可选值分配给 `roomCount` 常量。

可以将 `Residence` 实例分配给 `john.residence` ，以便它不再具有 `nil` 值：

```
john.residence = Residence()
```
john.residence 现在包含一个实际的 Residence 实例，而不是 nil 。如果您尝试使用与以前相同的可选链接访问 numberOfRooms ，它现在将返回一个 Int? ，其中包含 1

```swift
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "John's residence has 1 room(s)."
```





### 2.定义可选链接的模型类

您可以使用可选链来调用超过一级深度的属性、方法和下标。这使您能够深入研究相互关联类型的复杂模型中的子属性，并检查是否可以访问这些子属性上的属性、方法和下标。

下面的代码片段定义了四个模型类，用于多个后续示例，包括多级可选链接的示例。这些类通过添加 `Room` 和 `Address` 类以及关联的属性、方法和方法来扩展上面的 `Person` 和 `Residence` 模型。下标。

`Person` 类的定义方式与之前相同：

```swift
class Person {
    var residence: Residence?
}
```

`Residence` 类比以前更复杂。这次， `Residence` 类定义了一个名为 `rooms` 的变量属性，它使用 `[Room]`类型的空数组进行初始化：

```swift
class Residence {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
```

由于此版本的 `Residence` 存储 `Room` 实例的数组，因此其 `numberOfRooms` 属性被实现为计算属性，而不是存储属性。计算出的 `numberOfRooms` 属性仅返回 `rooms` 数组中 `count` 属性的值。



作为访问其 `rooms` 数组的快捷方式，此版本的 `Residence` 提供了一个读写下标，可提供对 `rooms` 中请求索引处的房间的访问大批。

此版本的 `Residence` 还提供了一种名为 `printNumberOfRooms` 的方法，该方法仅打印住宅中的房间数量。

最后， `Residence` 定义了一个名为 `address` 的可选属性，其类型为 `Address?` 。此属性的 `Address` 类类型定义如下。

用于 `rooms` 数组的 `Room` 类是一个简单的类，具有一个名为 `name` 的属性，以及一个将该属性设置为合适的房间名称的初始值设定项：

```swift
class Room {
    let name: String
    init(name: String) { self.name = name }
}
```

该模型中的最后一个类称为 `Address` 。此类具有 `String?` 类型的三个可选属性。前两个属性 `buildingName` 和 `buildingNumber` 是将特定建筑物标识为地址一部分的替代方法。第三个属性 `street` 用于命名该地址的街道：

```swift
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}
```

`Address` 类还提供了一个名为 `buildingIdentifier()` 的方法，其返回类型为 `String?` 。此方法检查地址的属性，如果有值则返回 `buildingName` ，如果两者都有值则返回 `buildingNumber` 与 `street` 连接，或者 `nil`



### 3.通过可选链接访问属性

**可选链接不仅可以访问,还可以赋值，当可选值为nil的时候，都不成功**

如可选链接作为强制展开的替代方案中所示，您可以使用可选链接来访问可选值上的属性，并检查该属性访问是否成功。

使用上面定义的类创建一个新的 `Person` 实例，并尝试像以前一样访问其 `numberOfRooms` 属性：

```swift
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
```

因为 `john.residence` 是 `nil` ，所以这个可选的链接调用会以与之前相同的方式失败。

您还可以尝试通过可选链接设置属性的值：

```swift
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress //尝试设置john.residence 的 address 属性将失败，因为 john.residence 当前为 nil 。
```

在此示例中，尝试设置 `john.residence` 的 `address` 属性将失败，因为 `john.residence` 当前为 `nil` 。

该赋值是可选链的一部分，这意味着 `=` 运算符右侧的任何代码都不会被计算。在前面的示例中，很难看出 `someAddress` 从未被求值，因为访问常量没有任何副作用。下面的清单执行相同的分配，但它使用函数来创建地址。该函数在返回值之前打印“函数被调用”，这让您可以查看 `=` 运算符的右侧是否已计算。

```swift
func createAddress() -> Address {
    print("Function was called.")


    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"


    return someAddress
}
john.residence?.address = createAddress()
```

您可以看出 `createAddress()` 函数没有被调用，因为没有打印任何内容。



### 4.通过可选链调用方法



>  **Note:** **可以测试可选链接的调用方法,如果可选链接有值，调用其方法 会有返回值 Void 的返回值为 Void?**
> **可以测试可选链接设置属性，如果可选链接有值,可以和C一样 测试赋值表达式是否为nil**



您可以使用可选链来调用可选值的方法，并检查该方法调用是否成功。即使该方法没有定义返回值，您也可以执行此操作。

`Residence` 类上的 `printNumberOfRooms()` 方法打印 `numberOfRooms` 的当前值。该方法如下所示：

```swift
func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
}
```

该方法不指定返回类型。但是，没有返回类型的函数和方法具有隐式返回类型 `Void` ，如无返回值的函数中所述。这意味着它们返回值 `()` 或空元组。

如果您使用可选链对可选值调用此方法，则该方法的返回类型将为 `Void?` ，而不是 `Void` ，因为通过可选链调用时返回值始终是可选类型。这使您能够使用 `if` 语句来检查是否可以调用 `printNumberOfRooms()` 方法，即使该方法本身没有定义返回值。将 `printNumberOfRooms` 调用的返回值与 `nil` 进行比较，看看方法调用是否成功：

```swift
// 可选链接调用方法 本来返回的是隐藏的Void,但是通过可选链接调用的返回值是 Void?
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// Prints "It was not possible to print the number of rooms."
```



如果您尝试通过可选链接设置属性，情况也是如此。上面通过可选链接访问属性中的示例尝试为 `john.residence` 设置 `address` 值，即使 `residence` 属性为 `nil` 。任何通过可选链接设置属性的尝试都会返回 `Void?` 类型的值，这使您能够与 `nil` 进行比较以查看属性是否已成功设置：

```swift
if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
// Prints "It was not possible to set the address."
```



or

```swift
if john.residence?.rooms.append(Room(name:"Kitchen")) != nil {
    print("测试可选链接函数调用是否成功")
}
```



### 5.通过可选链接访问下表



您可以使用可选链来尝试从可选值的下标检索和设置值，并检查该下标调用是否成功。



> **Note**:当您通过可选链访问可选值的下标时，您将问号放在下标括号之前，而不是之后。可选链问号始终紧跟在表达式可选部分之后。



下面的示例尝试使用 `Residence` 类中定义的下标检索 `john.residence` 属性的 `rooms` 数组中第一个房间的名称。由于 `john.residence` 当前为 `nil` ，因此下标调用失败：

```swift
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "Unable to retrieve the first room name."
```

此下标调用中的可选链接问号紧邻 `john.residence` 之后、下标括号之前放置，因为 `john.residence` 是尝试进行可选链接的可选值。

同样，您可以尝试通过带有可选链接的下标设置新值：

```swift
john.residence?[0] = Room(name: "Bathroom")
```

此下标设置尝试也失败，因为 `residence` 当前为 `nil` 。

如果您创建一个实际的 `Residence` 实例并将其分配给 `john.residence` ，并且其 `rooms` 数组中有一个或多个 `Room` 实例，则可以使用 `Residence` 下标通过可选链接访问 `rooms` 数组中的实际项目：

```swift
let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse


if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "The first room name is Living Room."
```



### 6.访问可选类型的下标

如果下标返回可选类型的值 - 例如 Swift 的 `Dictionary` 类型的键下标 - 在下标的右括号后面放置一个问号以链接其可选返回值：

```swift
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72  //not exists
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
```

上面的示例定义了一个名为 `testScores` 的字典，其中包含两个键值对，将 `String` 键映射到 `Int` 值数组。该示例使用可选链接将 `"Dave"` 数组中的第一项设置为 `91` ；将 `"Bev"` 数组中的第一项增加 `1` ；并尝试为 `"Brian"` 键设置数组中的第一项。前两个调用成功，因为 `testScores` 字典包含 `"Dave"` 和 `"Bev"` 的键。第三次调用失败，因为 `testScores` 字典不包含 `"Brian"` 的键。







### 6.链接多个级别的链接

您可以将多个级别的可选链接链接在一起，以深入了解模型中的属性、方法和下标。但是，多层可选链接不会为返回值添加更多级别的可选性。

换一种方式：

- 如果您尝试检索的类型不是可选的，则由于可选链接，它将变成可选的。
- 如果您尝试检索的类型已经是可选的，则它不会因为链接而变得更加可选。

所以:

- 如果您尝试通过可选链接检索 `Int` 值，则始终返回 `Int?` ，无论使用多少级链接。
- 同样，如果您尝试通过可选链接检索 `Int?` 值，则始终返回 `Int?` ，无论使用多少级链接。

也就是说:

- **可选链使用** **?**：一旦使用了 ?，后续所有访问都会返回可选值。
- **链条中任何一步为** **nil**：整个表达式返回 nil，后续的访问不会执行。
- **避免程序崩溃**：可选链是一种安全的方式来处理多层次的可选值，避免了在访问 nil 值时导致的程序崩溃。

下面的示例尝试访问 `john` 的 `residence` 属性的 `address` 属性的 `street` 属性。这里使用了两个级别的可选链接，通过 `residence` 和 `address` 属性进行链接，这两个属性都是可选类型：

```swift
if let johnsStreet = john.residence?.address?.street {  //如果john.residence?为nil不会计算其他的可选链接，整个都返回nil
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Unable to retrieve the address."
```

`john.residence` 的值当前包含有效的 `Residence` 实例。但是， `john.residence.address` 的值当前为 `nil` 。因此，对 `john.residence?.address?.street` 的调用失败。

请注意，在上面的示例中，您尝试检索 `street` 属性的值。该属性的类型是 `String?` 。因此， `john.residence?.address?.street` 的返回值也是 `String?` ，即使除了属性的基础可选类型之外还应用了两级可选链接。

如果您将实际的 `Address` 实例设置为 `john.residence.address` 的值，并为地址的 `street` 属性设置实际值，则可以访问 < b3> 通过多级可选链的属性：

```swift
let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress


if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "John's street name is Laurel Street."
```



### 7.链接具有可选返回值的方法

前面的示例演示了如何通过可选链接检索可选类型的属性值。您还可以使用可选链接来调用返回可选类型值的方法，并在需要时链接该方法的返回值。

下面的示例通过可选链接调用 `Address` 类的 `buildingIdentifier()` 方法。此方法返回 `String?` 类型的值。如上所述，可选链后该方法调用的最终返回类型也是 `String?` ：

```swift
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// Prints "John's building identifier is The Larches."
```

如果您想对此方法的返回值执行进一步的可选链接，请将可选链接问号放在该方法的括号后面：

```swift
if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier doesn't begin with \"The\".")
    }
}
// Prints "John's building identifier begins with "The"."
// 可选链接为nil的时候，不进入条件
// 整个表达式的的可选链接都非nil，然后再判断 .hasPrefix("The") 返回Bool类型
// 只要非nil 都会进入条件
//再在条件里面判断 Bool为true or false
```



> **Note :**在上面的示例中，您将可选链接问号放在括号后面，因为您链接的可选值是 `buildingIdentifier()`方法的返回值，而不是 `buildingIdentifier()` 方法本身。
