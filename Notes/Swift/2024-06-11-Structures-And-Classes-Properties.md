---
layout: post
author: "大西瓜"
title: "Structures And Classes Properties 结构和类的性能"
date:   2024-06-11 16:22:15 +0800
categories: [update,Swift] 
---





## Properties 性能

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
