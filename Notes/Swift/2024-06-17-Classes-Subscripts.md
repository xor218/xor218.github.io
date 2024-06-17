---
layout: post
author: "大西瓜"
title: "Classes Subscripts下标"
date:   2024-06-17 13:50:08 +0800
categories: [update,Swift] 
---





## Subscripts 下标

**类似C++的operator[]**

访问集合的元素

类、结构和枚举可以定义下标，下标是访问集合、列表或序列的成员元素的快捷方式。您可以使用下标按索引设置和检索值，而无需单独的设置和检索方法。例如，您可以以 `someDictionary[key]` for `someArray[index]` 的形式访问 `Array` 实例中的元素， `Dictionary` 以 .



您可以为单个类型定义多个下标，并根据传递给下标的索引值类型选择要使用的相应下标重载。下标不限于单个维度，您可以定义具有多个输入参数的下标，以满足自定义类型的需求。**可以重载**



### 1.Subscript syntax 下标语法

**关键字:subscript**

下标允许您通过在实例名称后的方括号中写入一个或多个值来查询类型的实例。它们的语法类似于实例方法语法和计算属性语法。您可以使用 `subscript` 关键字编写下标定义，并指定一个或多个输入参数和返回类型，其方式与实例方法相同。与实例方法不同，下标可以是读写或只读的。此行为由 getter 和 setter 以与计算属性相同的方式进行通信：



```swift
subscript(index: Int) -> Int {
    get {
        // Return an appropriate subscript value here.
    }
    set(newValue) {
        // Perform a suitable setting action here.
    }
}
```

`newValue` 类型与下标的返回值相同。与计算属性一样，您可以选择不指定 setter `(newValue)` 的参数。如果您自己不提供默认参数，则会向 setter 提供一个默认 `newValue` 参数。



与只读计算属性一样，可以通过删除 `get` 关键字及其大括号来简化只读下标的声明：

```swift
subscript(index: Int) -> Int {
    // Return an appropriate subscript value here.
    // 只读
}
```

下面是一个只读下标实现的示例，它定义了一个 `TimesTable` 结构来表示整数的 n-times-table：

```swift
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"
```

在此示例中， `TimesTable` 将创建一个新实例来表示 three-times-table。这是通过将值 `3` 传递给结构的值 `initializer` 作为实例 `multiplier` 参数的值来指示的。

您可以通过调用 `threeTimesTable` 实例的下标来查询实例，如对 的 `threeTimesTable[6]` 调用中所示。这将请求 three-times-table 中的第六个条目，该条目返回值 `18` 或 `3`times `6` 。



> **Note:**n-times-table 基于固定的数学规则。设置为新值是不合适的 `threeTimesTable[someIndex]` ，因此将 的 `TimesTable` 下标定义为只读下标。



### 2. Subscript Usage 下标用法

“下标”的确切含义取决于使用它的上下文。下标通常用作访问集合、列表或序列中的成员元素的快捷方式。您可以自由地以最适合特定类或结构功能的方式实现下标。

例如，Swift `Dictionary` 的类型实现一个下标来设置和检索存储在 `Dictionary` 实例中的值。您可以通过在下标括号内提供字典键类型的键，并将字典的值类型的值分配给下标来设置字典中的值：

```swift
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2  //直接append
```



上面的示例定义了一个变量，该变量被调用 `numberOfLegs` ，并使用包含三个键值对的字典文本对其进行初始化。 `numberOfLegs` 字典的类型被推断为 `[String: Int]` 。创建字典后，此示例使用下标赋值将键 of `"bird"` 和 `Int` 值 of `2` 添加到 `String` 字典中。



> 
>
> **Note**:
>
> Swift `Dictionary` 的类型将其键值下标实现为接受并返回可选类型的下标。对于上面的 `numberOfLegs` 字典，键值下标接受并返回一个类型 `Int?` 为 或“可选 int”的值。该 `Dictionary` 类型使用可选的下标类型来模拟并非每个键都具有值的事实，并通过为该键分配 `nil` 值来提供删除该键值的方法。



### 3.Subscript Opotions 下标选项

**下标可以采用任意数量的输入参数，这些输入参数可以是任何类型**。下标还可以返回任何类型的值。

与函数一样，下标可以采用不同数量的参数并为其参数提供默认值，如可变参数和默认参数值中所述。但是，与函数不同，**下标不能使用 in-out 参数**。

类或结构可以根据需要提供任意数量的下标实现，并且将根据使用下标时下标括号内包含的一个或多个值的类型来推断要使用的相应下标。这种对多个下标的定义称为下标重载。

```swift
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range") //assert 语法
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
```

`Matrix` 提供了一个初始值设定项，该初始值设定项采用两个名为 `rows` 和 `columns` 的参数，并创建一个足够大的数组来存储 `rows * columns` 类型的 `Double` 值。矩阵中的每个位置都有一个初始 `0.0` 值 。为此，数组的大小和初始单元格值 `0.0` 将传递给数组初始值设定项，该数组初始值设定项创建并初始化正确大小的新数组。此初始值设定项在创建具有默认值的数组中进行了更详细的描述。

您可以通过将适当的行和列计数传递给其初始值设定项来构造新 `Matrix` 实例：

```swift
var matrix = Matrix(rows: 2, columns: 2)
```

上面的示例创建一个包含两行和两列的新 `Matrix` 实例。此 `Matrix` 实例的 `grid` 数组实际上是矩阵的扁平化版本，从左上角到右下角读取：

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/subscriptMatrix01@2x.png" style="width:50%">

矩阵中的值可以通过将行和列值传递到下标中来设置，下标用逗号分隔：

```swift
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
```



这两个语句调用下标的 setter 在矩阵的右上角位置（其中 `row` is `0` 和 `column` is `1` ）和 `3.2`左下角位置（其中 `row` is `1` 和 `column` is `0` ）设置值： `1.5`

<img src="https://docs.swift.org/swift-book/images/org.swift.tspl/subscriptMatrix02@2x.png" style="width:20%">

`Matrix` 下标的 getter 和 setter 都包含一个断言，用于检查下标 `row` 的 和 `column` values 是否有效。为了帮助这些断言， `Matrix` 包括一个名为 `indexIsValid(row:column:)` 的便捷方法，该方法检查请求 `row` 的 和 `column` 是否在矩阵的边界内：

```swift
func indexIsValid(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
}
```

如果尝试访问矩阵边界之外的下标，则会触发断言：

```swift
let someValue = matrix[2, 2]
// This triggers an assert, because [2, 2] is outside of the matrix bounds.
```





### 4.Type Subscripts 类型下标

如上所述，实例下标是在特定类型的实例上调用的下标。还可以定义在类型本身上调用的下标。这种下标称为类型下标。您可以通过在 `subscript` 关键字之前写 `static` 入关键字来指示类型下标。类可以改用关键 `class` 字，以允许子类覆盖超类对该下标的实现。下面的示例显示了如何定义和调用类型下标：

```swift
//定义了一个枚举类型 Planet，其原始值类型为 Int。
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
  
  //静态下标，属于类型的operator[]方法
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
      	//通过原始值 n 初始化 Planet 枚举成员。rawValue 是 Planet 枚举的一个初始化方法，它返回一个可选的 Planet 值。如果 n 不在有效范围内，这个初始化会返回 nil。! 表示强制解包，这意味着如果 n 的值不在 1 到 8 之间，程序会崩溃。
    }
}
let mars = Planet[4]
print(mars)
```

