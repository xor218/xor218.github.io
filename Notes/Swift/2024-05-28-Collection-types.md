---
layout: post
author: "大西瓜"
title: "Collection types"
date:   2024-05-28 19:46:49 +0800
categories: [update,Swift] 
---



# 集合类型



Swift 提供了三种主要的集合类型，即数组、集合和字典，用于存储值的集合。数组是值的有序集合。集合是唯一值的无序集合。字典是键值关联的无序集合。



![](https://docs.swift.org/swift-book/images/CollectionTypes_intro~dark@2x.png)



Swift 中的数组、集合和字典总是清楚它们可以存储的值和键的类型。这意味着您不能错误地将错误类型的值插入到集合中。



**Note**:
**Swift 的数组、集合和字典类型被实现为泛型集合。有关泛型类型和集合的更多信息，请参阅泛型。**



## 集合的可变性

如果创建数组、集合或字典，并将其分配给变量，则创建的集合将是可变的。这意味着您可以在创建集合后通过添加、删除或更改集合中的项目来更改（或改变）集合。如果将数组、集合或字典分配给常量(const)，则该集合是不可变的，并且其大小和内容无法更改。

**NOTE**:

**常量集合不可以改变**















## 1.Array 数组



数组将相同类型的值存储在有序列表中。相同的值可以在数组的不同位置多次出现。



### 1.1 Array类型简写语法

Swift 数组的类型完整写为 `Array<Element>` ，其中 `Element` 是数组允许存储的值的类型。您还可以将数组的类型写成简写形式 `[Element]` 。尽管这两种形式在功能上相同，但在引用数组类型时，首选速记形式，并且在本指南中始终使用速记形式。



### 1.2 创建一个空数组

您可以使用初始化语法创建某种类型的空数组：

```swift
//let someInts: [Int] = []  //可以声明，但是无法添加元素。const 类型
var someInts: [Int] = []
print("someInts is of type [Int] with \(someInts.count) items.")
// Prints "someInts is of type [Int] with 0 items."
```

请注意， `someInts` 变量的类型是根据初始值设定项的类型推断为 `[Int]` 的。

或者，如果上下文已提供类型信息，例如函数参数或已类型化的变量或常量，则可以使用空数组文字创建一个空数组，将其写为 `[]` （一个空对方括号）：

```swift
someInts.append(3) // someInts now contains 1 value of type Int 
someInts = [] // someInts is now an empty array, but is still of type [Int]
```



### 1.3 创建具有默认值的数组

Swift 的 `Array` 类型还提供了一个初始化程序，用于创建特定大小的数组，并将其所有值设置为相同的默认值。您向此初始值设定项传递适当类型的默认值（称为 `repeating` ）：以及该值在新数组中重复的次数（称为 `count` ）：

```swift
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
```



### 1.4 将两个数组加起来创建数组

您可以通过使用加法运算符 ( `+` ) 将两个具有兼容类型的现有数组添加在一起来创建新数组。新数组的类型是根据添加在一起的两个数组的类型推断出来的：

```swift
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]


var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
```



### 1.5 String数组

您还可以使用数组文字来初始化数组，这是一种将一个或多个值写入数组集合的简写方式。数组文字被写为值列表，用逗号分隔，并用一对方括号括起来：

```swift
[<#value 1#>, <#value 2#>, <#value 3#>]
```

下面的示例创建一个名为 `shoppingList` 的数组来存储 `String` 值：

```swift
var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList has been initialized with two initial items
```

`shoppingList` 变量被声明为“字符串值数组”，写为 `[String]` 。因为这个特定的数组指定了值类型 `String` ，所以它只允许存储 `String` 值。这里， `shoppingList` 数组使用两个 `String` 值（ `"Eggs"` 和 `"Milk"` ）进行初始化，并写入数组文字中。



**Note**

The `shoppingList` array is declared as a variable (with the `var` introducer) and not a constant (with the `let` introducer) because more items are added to the shopping list in the examples below.
`shoppingList` 数组被声明为变量（使用 `var` 引入器）而不是常量（使用 `let` 引入器），因为更多商品添加到购物中请在下面的示例中列出。





在本例中，数组文字包含两个 `String` 值，仅包含其他值。这与 `shoppingList` 变量声明的类型（只能包含 `String` 值的数组）匹配，因此允许将数组文字赋值作为初始化 `shoppingList` 有两个初始项目。



感谢 Swift 的类型推断，如果您使用包含相同类型值的数组文字来初始化数组，则不必编写数组的类型。 `shoppingList` 的初始化可以写成更短的形式：



### 1.6 访问和修改数组

您可以通过数组的方法和属性或使用下标语法来访问和修改数组。

要找出数组中的项目数，请检查其只读 `count` 属性：

```swift
print("The shopping list contains \(shoppingList.count) items.")
// Prints "The shopping list contains 2 items."
```

使用布尔 `isEmpty` 属性作为检查 `count` 属性是否等于 `0` 的快捷方式：

```swift
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list isn't empty.")
}
// Prints "The shopping list isn't empty."
```

您可以通过调用数组的 `append(_:)` 方法将新项目添加到数组的末尾：

```swift
shoppingList.append("Flour")
// shoppingList now contains 3 items, and someone is making pancakes
```

或者，使用加法赋值运算符 ( `+=` ) 附加一个或多个兼容项的数组：

```swift
shoppingList += ["Baking Powder"]
// shoppingList now contains 4 items
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList now contains 7 items
```

使用下标语法从数组中检索值，在数组名称后面的方括号内传递要检索的值的索引：

```swift
var firstItem = shoppingList[0]
// firstItem is equal to "Eggs"
```



> **Note**:数组中的第一项的索引为 `0` ，而不是 `1` 。 Swift 中的数组始终是零索引的。

您可以使用下标语法来更改给定索引处的现有值：

```swift
shoppingList[0] = "Six eggs" 
// the first item in the list is now equal to "Six eggs" rather than "Eggs"
```

当您使用下标语法时，您指定的索引需要有效。例如，编写 `shoppingList[shoppingList.count] = "Salt"` 来尝试将项目追加到数组末尾会导致运行时错误。



您还可以使用下标语法一次更改值范围，即使替换值集的长度与要替换的范围不同。以下示例将 `"Chocolate Spread"` 、 `"Cheese"` 和 `"Butter"` 替换为 `"Bananas"` 和 `"Apples"` ：



```swift
shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList now contains 6 items
```



要将项目插入到数组的指定索引处，请调用数组的 `insert(_:at:)` 方法：

```swift
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList now contains 7 items
// "Maple Syrup" is now the first item in the list
```



对 `insert(_:at:)` 方法的调用会在购物列表的最开头插入一个值为 `"Maple Syrup"` 的新项目，由索引 `0` 指示。

同样，您可以使用 `remove(at:)` 方法从数组中删除一个项目。此方法删除指定索引处的项目并返回删除的项目（尽管如果不需要，可以忽略返回值）：

```
let mapleSyrup = shoppingList.remove(at: 0)
// the item that was at index 0 has just been removed
// shoppingList now contains 6 items, and no Maple Syrup
// the mapleSyrup constant is now equal to the removed "Maple Syrup" string
```





> **Note**:如果您尝试访问或修改超出数组现有范围的索引值，则会触发运行时错误。您可以在使用索引之前将其与数组的 `count` 属性进行比较来检查索引是否有效。数组中最大的有效索引是 `count - 1` 因为数组是从零开始索引的 - 但是，当 `count` 是 `0` （意味着数组为空）时，有没有有效的索引。



当删除一个项目时，数组中的任何间隙都会被关闭，因此索引 `0` 处的值再次等于 `"Six eggs"` ：

```swift
firstItem = shoppingList[0]
// firstItem is now equal to "Six eggs"
```



如果要从数组中删除最后一项，请使用 `removeLast()` 方法而不是 `remove(at:)` 方法，以避免需要查询数组的 `count` 属性。与 `remove(at:)` 方法一样， `removeLast()` 返回已删除的项目：

```swift
let apples = shoppingList.removeLast()
// the last item in the array has just been removed
// shoppingList now contains 5 items, and no apples
// the apples constant is now equal to the removed "Apples" string
```





### 1.7 迭代数组

您可以使用 `for` - `in` 循环迭代数组中的整个值集：

```swift
for item in shoppingList {
    print(item)
}
// Six eggs
// Milk
// Flour
// Baking Powder
// Bananas
```







## 2. Set 集合



集合在集合中存储相同类型的不同值，没有定义的顺序。当项目的顺序不重要或者需要确保某个项目仅出现一次时，您可以使用集合而不是数组。



### 2.1 集合类型的哈希值

类型必须是可散列的才能存储在集合中 - 也就是说，该类型必须提供一种计算自身散列值的方法。哈希值是一个 `Int` 值，对于同等比较的所有对象都相同，因此如果 `a == b` ，则 `a` 的哈希值等于哈希值 `b` 的值。

所有 Swift 的基本类型（例如 `String` 、 `Int` 、 `Double` 和 `Bool` ）默认都是可哈希的，并且可以使用作为设置值类型或字典键类型。默认情况下，没有关联值的枚举案例值（如枚举中所述）也是可散列的。



### 2.2 集合类型语法

Swift 集合的类型写为 `Set<Element>` ，其中 `Element` 是集合允许存储的类型。与数组不同，集合没有等效的简写形式。



### 2.3 创建并且初始化空集合

您可以使用初始值设定项语法创建特定类型的空集：

```swift
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// Prints "letters is of type Set<Character> with 0 items."
```

> **Note**:根据初始化器的类型， `letters` 变量的类型被推断为 `Set<Character>` 。

或者，如果上下文已提供类型信息，例如函数参数或已类型化的变量或常量，则可以使用空数组文字创建一个空集：

```swift
letters.insert("a")
// letters now contains 1 value of type Character
letters = []
// letters is now an empty set, but is still of type Set<Character>
```



### 2.4 使用数组文字创建集合

您还可以使用数组文字初始化集合，作为将一个或多个值写入集合集合的简写方式。

下面的示例创建一个名为 `favoriteGenres` 的集合来存储 `String` 值：

```swift
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
// favoriteGenres has been initialized with three initial items

//or 直接声明set 编译器自动推断为Set<String>
var setString: Set = ["Rock", "Classical", "Hip hop"]
```

 `favoriteGenres` 变量被声明为“一组 `String` 值”，写为 `Set<String>` 。因为这个特定的集合指定了值类型 `String` ，所以它只允许存储 `String` 值。此处， `favoriteGenres` 集使用三个 `String` 值（ `"Rock"` 、 `"Classical"` 和 `"Hip hop"` ）进行初始化，写在数组文字中。



> **Note**:`favoriteGenres` 集被声明为变量（使用 `var` 引入器）而不是常量（使用 `let` 引入器），因为项目是在下面的例子。



集合类型不能单独从数组文字推断出来，因此必须显式声明类型 `Set` 。但是，由于 Swift 的类型推断，如果您使用仅包含一种类型的值的数组文字对其进行初始化，则不必编写集合元素的类型。 `favoriteGenres` 的初始化可以写成更短的形式：

```swift
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
```



因为数组文字中的所有值都具有相同的类型，所以 Swift 可以推断 `Set<String>` 是用于 `favoriteGenres` 变量的正确类型。





### 2.5 访问和修改集合

您可以通过集合的方法和属性来访问和修改集合。

要找出集合中的项目数，请检查其只读 `count` 属性：

```swift
print("I have \(favoriteGenres.count) favorite music genres.")
// Prints "I have 3 favorite music genres."
```

使用布尔 `isEmpty` 属性作为检查 `count` 属性是否等于 `0` 的快捷方式：

```swift
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
// Prints "I have particular music preferences."
```

您可以通过调用集合的 `insert(_:)` 方法将新项目添加到集合中：

```swift
favoriteGenres.insert("Jazz")
// favoriteGenres now contains 4 items
```

您可以通过调用集合的 `remove(_:)` 方法从集合中删除项目，如果该项目是集合的成员，则该方法会删除该项目，并返回删除的值，或者如果该项目是集合的成员，则返回 `nil` set 不包含它。或者，可以使用其 `removeAll()` 方法删除集合中的所有项目。

```swift
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
// Prints "Rock? I'm over it."
```



要检查集合是否包含特定项目，请使用 `contains(_:)` 方法。

```swift
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// Prints "It's too funky in here."
```



### 2.6 迭代集合

您可以使用 `for` - `in` 循环迭代集合中的值。

```swift
for genre in favoriteGenres {
    print("\(genre)")
}
// Classical
// Jazz
// Hip hop
```

Swift 的 `Set` 类型没有定义的顺序。要按特定顺序迭代集合的值，请使用 `sorted()` 方法，该方法将集合的元素作为使用 `<` 运算符排序的数组返回。



### 2.7 执行集合操作

您可以有效地执行基本的集合操作，例如将两个集合组合在一起，确定两个集合有哪些共同值，或者确定两个集合是否包含全部、部分或不包含相同的值。



### 2.7.1 基本集合运算

下图描绘了两个集合 - `a` 和 `b` - 各种集合运算的结果由阴影区域表示。

![](https://docs.swift.org/swift-book/images/setVennDiagram@2x.png)





- 使用 `intersection(_:)` 方法创建一个新集，其中仅包含两个集共有的值。
- 用 `symmetricDifference(_:)` 方法创建一个新集，其中包含任一集中的值，但不能同时包含两个集中的值。
- 使用 `union(_:)` 方法创建一个包含两个集中所有值的新集。
- 使用 `subtracting(_:)` 方法创建一个新集，其中的值不在指定集中。



```swift
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]


oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]
```



### 2.7.2 设置成员资格和平等

下图描绘了三个集合 - `a` 、 `b` 和 `c` - 重叠区域表示集合之间共享的元素。 Set `a` 是 Set `b` 的超集，因为 `a` 包含 `b` 中的所有元素。相反，集合 `b` 是集合 `a` 的子集，因为 `b` 中的所有元素也包含在 `a` 中。集合 `b` 和集合 `c` 彼此不相交，因为它们没有共同的元素。

![](https://docs.swift.org/swift-book/images/setEulerDiagram@2x.png)





- 使用“等于”运算符 ( `==` ) 来确定两个集合是否包含所有相同的值。
- 使用 `isSubset(of:)` 方法确定集合中的所有值是否都包含在指定集合中。
- 使用 `isSuperset(of:)` 方法确定集合是否包含指定集合中的所有值。
- 使用 `isStrictSubset(of:)` 或 `isStrictSuperset(of:)` 方法确定集合是子集还是超集，但不等于指定集合。
- 使用 `isDisjoint(with:)` 方法确定两个集合是否没有共同值。



```swift
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]


houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true
```







## 3. Dictionaries 字典

字典将相同类型的键和相同类型的值之间的关联存储在集合中，没有定义的顺序。每个值都与一个唯一的键相关联，该键充当字典中该值的标识符。与数组中的项目不同，字典中的项目没有指定的顺序。

当您需要根据标识符查找值时，可以使用字典，这与现实世界中的字典用于查找特定单词的定义的方式大致相同。

>**Note**:
>
>Nothing





### 3.1 创建空字典

与数组一样，您可以使用初始化语法创建特定类型的空 `Dictionary` ：



```swift
var namesOfIntegers: [Int: String] = [:]
// namesOfIntegers is an empty [Int: String] dictionary
```



此示例创建一个 `[Int: String]` 类型的空字典来存储人类可读的整数值名称。它的键的类型为 `Int` ，其值的类型为 `String` 。

如果上下文已经提供了类型信息，则可以使用空字典文字创建一个空字典，将其写为 `[:]` （一对方括号内的冒号）：

```swift
namesOfIntegers[16] = "sixteen"
// namesOfIntegers now contains 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]
```



### 3.2 创建非空字典

您还可以使用字典文字初始化字典，它的语法与前面看到的数组文字类似。字典文字是将一个或多个键值对编写为 `Dictionary` 集合的简写方式。

键值对是键和值的组合。在字典文字中，每个键值对中的键和值都用冒号分隔。键值对写成一个列表，用逗号分隔，并用一对方括号括起来：

```swift
[<#key 1#>: <#value 1#>, <#key 2#>: <#value 2#>, <#key 3#>: <#value 3#>]
```



下面的示例创建一个字典来存储国际机场的名称。在此字典中，键是三个字母的国际航空运输协会代码，值是机场名称：

```swift
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```



`airports` 字典被声明为 `[String: String]` 类型，这意味着“一个 `Dictionary` ，其键的类型为 `String` ，并且其值也是 `String` 类型”。



> **Note**:`airports` 字典被声明为变量（使用 `var` 引入器），而不是常量（使用 `let` 引入器），因为更多的机场被添加到下面例子中的字典。**const 字典不可以修改**

`airports` 字典使用包含两个键值对的字典文字进行初始化。第一对的键为 `"YYZ"` ，值为 `"Toronto Pearson"` 。第二对的键为 `"DUB"` ，值为 `"Dublin"` 。

该字典文字包含两个 `String: String` 对。此键值类型与 `airports` 变量声明的类型匹配（只有 `String` 键和 `String` 值的字典），因此允许使用字典文字作为用两个初始项初始化 `airports` 字典的方法。

与数组一样，如果您使用其键和值具有一致类型的字典文字来初始化字典，则不必编写字典的类型。 `airports` 的初始化可以写成更短的形式：

```swift
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

因为文字中的所有键都具有相同的类型，并且同样所有值都具有相同的类型，所以 Swift 可以推断 `[String: String]` 是用于 `airports` 字典。





### 3.3 访问和修改字典

您可以通过字典的方法和属性或使用下标语法来访问和修改字典。

与数组一样，您可以通过检查其只读 `count` 属性来找出 `Dictionary` 中的项目数：

```swift
print("The airports dictionary contains \(airports.count) items.")
// Prints "The airports dictionary contains 2 items."
```

使用布尔 `isEmpty` 属性作为检查 `count` 属性是否等于 `0` 的快捷方式：

```swift
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary isn't empty.")
}
// Prints "The airports dictionary isn't empty."
```

您可以使用下标语法将新项目添加到字典中。使用适当类型的新键作为下标索引，并分配适当类型的新值：

```swift
airports["LHR"] = "London"
// the airports dictionary now contains 3 items
```

您还可以使用下标语法来更改与特定键关联的值：

```swift
airports["LHR"] = "London Heathrow"
// the value for "LHR" has been changed to "London Heathrow"
```

作为下标的替代方法，可以使用字典的 `updateValue(_:forKey:)` 方法来设置或更新特定键的值。与上面的下标示例类似，如果键不存在，则 `updateValue(_:forKey:)` 方法会设置一个值；如果该键已存在，则更新该值。然而，与下标不同的是， `updateValue(_:forKey:)` 方法在执行更新后返回旧值。这使您能够检查是否发生了更新。



`updateValue(_:forKey:)` 方法返回字典值类型的可选值。例如，对于存储 `String` 值的字典，该方法返回 `String?` 类型的值，或“可选 `String` ”。如果更新之前存在该键，则此可选值包含该键的旧值；如果不存在值，则包含 `nil` ：



```
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// Prints "The old value for DUB was Dublin."
```



您还可以使用下标语法从字典中检索特定键的值。因为可以请求一个不存在值的键，所以字典的下标返回字典值类型的可选值。

如果字典包含所请求键的值，则下标返回包含该键的现有值的可选值。否则，下标返回 `nil` ：

```swift
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport isn't in the airports dictionary.")
}
// Prints "The name of the airport is Dublin Airport."
```



您可以使用下标语法通过为该键分配值 `nil` 来从字典中删除键值对：

```swift
airports["APL"] = "Apple International"
// "Apple International" isn't the real airport for APL, so delete it
airports["APL"] = nil
// APL has now been removed from the dictionary
```

或者，使用 `removeValue(forKey:)` 方法从字典中删除键值对。此方法将删除键值对（如果存在）并返回删除的值，或者如果不存在值则返回 `nil` ：

```swift
if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary doesn't contain a value for DUB.")
}
// Prints "The removed airport's name is Dublin Airport."
```





### 3.4 迭代字典

您可以使用 `for` - `in` 循环迭代字典中的键值对。字典中的每个项目都作为 `(key, value)` 元组返回，并且您可以在迭代过程中将元组的成员分解为临时常量或变量：



```swift
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
// LHR: London Heathrow
// YYZ: Toronto Pearson
```



您还可以通过访问字典的 `keys` 和 `values` 属性来检索字典的键或值的可迭代集合：

```swift
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: LHR
// Airport code: YYZ


for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: London Heathrow
// Airport name: Toronto Pearson
```



如果您需要通过采用 `Array` 实例的 API 使用字典的键或值，请使用 `keys` 或 `values` 属性初始化一个新数组:



```swift
let airportCodes = [String](airports.keys)
// airportCodes is ["LHR", "YYZ"]


let airportNames = [String](airports.values)
// airportNames is ["London Heathrow", "Toronto Pearson"]
```



Swift 的 `Dictionary` 类型没有定义的顺序。要按特定顺序迭代字典的键或值，请在其 `keys` 或 `values` 属性上使用 `sorted()` 方法。



-- -

[引用](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes)
