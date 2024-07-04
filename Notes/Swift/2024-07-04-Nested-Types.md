---
layout: post
author: "大西瓜"
title: "Nested Types 嵌套类型"
date:   2024-07-04 11:13:44 +0800
categories: [update,Swift] 
---





## 嵌套类型

**在另一种类型的作用域内定义类型。**

通常创建枚举以支持特定类或结构的功能。同样，定义纯粹用于更复杂类型的上下文的实用程序结构以及通常与特定类型结合使用的协议可以很方便。为了实现这一点，Swift 使您能够定义嵌套类型，从而将枚举、结构和协议等支持类型嵌套在它们支持的类型的定义中。

若要将一个类型嵌套在另一个类型中，请将其定义写在其支持的类型的外大括号内。类型可以根据需要嵌套到任意数量的级别。

.

### 1.实际应用中的嵌套类型

下面的示例定义了一个名为 `BlackjackCard` 的结构，该结构对二十一点游戏中使用的扑克牌进行建模。该 `BlackjackCard` 结构包含两个嵌套枚举类型，分别称为 `Suit` 和 `Rank` 。

在二十一点中，Ace 牌的值为 1 或 11。此功能由名为 `Values` 的结构表示，该结构嵌套在枚举中 `Rank` ：

```swift
struct BlackjackCard {


    // nested Suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }


    // nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }


    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}
```

该 `Suit` 枚举描述了四种常见的扑克牌花色，以及表示其符号的原始 `Character` 值。

该 `Rank` 枚举描述了 13 种可能的扑克牌等级，以及表示其面值的原始 `Int` 值。（此原始 `Int` 值不用于杰克、皇后、国王和 Ace 卡。

如上所述， `Rank` 枚举定义了自己的进一步嵌套结构，称为 `Values` 。这种结构封装了这样一个事实，即大多数卡牌都有一个值，但 Ace 卡有两个值。该 `Values` 结构定义了两个属性来表示这一点：

- `first` ，类型 `Int`
- second` 、类型 `Int?` 或“可选 `Int` ”

`Rank` 还定义了一个计算属性 `values` ，它返回 `Values` 结构的实例。此计算属性考虑卡片的等级，并根据其等级使用适当的值初始化一个新的 `Values` 实例。它对 `jack` 、 `queen` 、 `king` 和 `ace` 使用特殊值。对于数字卡，它使用排名的原始 `Int` 值。

`BlackjackCard` 结构本身有两个属性 - `rank` 和 `suit` 。它还定义了一个名为 `description` 的计算属性，它使用 `rank` 和 `suit` 中存储的值来构建卡片名称和值的描述。 `description` 属性使用可选绑定来检查是否有第二个值要显示，如果有，则插入第二个值的附加描述详细信息。

由于 `BlackjackCard` 是一个没有自定义初始值设定项的结构，因此它具有隐式成员初始值设定项，如结构类型的成员初始值设定项中所述。您可以使用此初始化程序来初始化一个名为 `theAceOfSpades` 的新常量：

```swift
let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// Prints "theAceOfSpades: suit is ♠, value is 1 or 11"
```

尽管 `Rank` 和 `Suit` 嵌套在 `BlackjackCard` 中，但它们的类型可以从上下文推断出来，因此该实例的初始化能够引用枚举案例仅按案例名称（ `.ace` 和 `.spades` ）。在上面的示例中， `description` 属性正确报告黑桃 A 的值为 `1` 或 `11` 。





### 2.引用嵌套类型

要在定义上下文之外使用嵌套类型，请在其名称前加上嵌套类型的名称作为前缀：

```swift
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
// heartsSymbol is "♡"
```

对于上面的示例，这使得 `Suit` 、 `Rank` 和 `Values` 的名称可以故意保持简短，因为它们的名称自然由上下文限定它们是被定义的。
