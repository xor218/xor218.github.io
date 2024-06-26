---
layout: post
author: "大西瓜"
title: "Classes Deinitialization"
date:   2024-06-25 18:47:27 +0800
categories: [update,Swift] 
---



## Deinitialization 去初始化

**释放需要自定义清理的资源。**

在释放类实例之前立即调用析构器。您可以使用 `deinit` 关键字编写反初始化程序，类似于使用 `init` 关键字编写初始化程序。反初始化器仅适用于类类型。





### 1.How Deinitialization Works

当不再需要实例时，Swift 会自动释放实例，以释放资源。 Swift 通过自动引用计数 (ARC) 处理实例的内存管理，如自动引用计数中所述。通常，当实例被释放时，您不需要执行手动清理。但是，当您使用自己的资源时，您可能需要自己执行一些额外的清理工作。例如，如果您创建自定义类来打开文件并向其中写入一些数据，则可能需要在释放类实例之前关闭该文件。

**每个类的类定义最多可以有一个反初始化器。反初始化器不接受任何参数，并且不带括号编写：**

```swift
deinit {
    // perform the deinitialization
}
```

就在实例释放发生之前，自动调用反初始化器。您不能自己调用去初始化程序。超类析构器由其子类继承，并且在子类析构器实现结束时自动调用超类析构器。即使子类不提供自己的反初始化器，超类反初始化器也始终会被调用。

因为实例在调用其反初始化程序之后才会被释放，所以反初始化程序可以访问它所调用的实例的所有属性，并可以根据这些属性修改其行为（例如查找需要关闭的文件的名称） ）。



**deinit 相当于C++中的析构函数,如果基类有deinit 子类也有deinit ,如果计数器为0，会先调用子类的deinit再调用父的deinit**

像拨洋葱一样，先拨外面，再拨里面

```swift
class SomeClass{
    init(){ 
        print("SomeClass be Create")
    }
    deinit{
        print("SomeClass be 摧毁")
    }
}


var someClass = SomeClass()
//out:SomeClass be Create
//在程序结束之前，计数器不为0，不会调用deinit

var otherClass:SomeClass? = SomeClass()
otherClass  = nil
//out:SomeClass be Create
//    SomeClass be 摧毁
// 变量为nil的时候，计数器为0了，所以调用了deinit{}

```





### 2. 反初始化的实例

这是一个正在运行的反初始化器的示例。此示例为一个简单的游戏定义了两个新类型： `Bank` 和 `Player` 。 `Bank` 类管理一种虚拟货币，流通中的硬币永远不会超过 10,000 个。游戏中只能有一个 `Bank` ，因此 `Bank` 被实现为一个具有类型属性和方法来存储和管理其当前状态的类：

```swift
class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}
```



`Bank` 通过其 `coinsInBank` 属性跟踪其当前持有的硬币数量。它还提供了两种方法 - `distribute(coins:)` 和 `receive(coins:)` - 来处理硬币的分配和收集。



`distribute(coins:)` 方法在分发硬币之前检查银行中是否有足够的硬币。如果没有足够的硬币， `Bank` 将返回比请求的数字更小的数字（如果银行中没有剩余硬币，则返回零）。它返回一个整数值来指示所提供的实际硬币数量。

`receive(coins:)` 方法只是将收到的硬币数量添加回银行的硬币存储中。

`Player` 类描述游戏中的玩家。每个玩家的钱包中随时都会存储一定数量的硬币。这由玩家的 `coinsInPurse` 属性表示：

```swift
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}
```



每个 `Player` 实例在初始化期间都会从银行获得指定数量的硬币进行初始化，但如果没有足够的硬币， `Player` 实例可能会收到少于该数量的硬币。



`Player` 类定义了 `win(coins:)` 方法，该方法从银行检索一定数量的硬币并将其添加到玩家的钱包中。 `Player` 类还实现了一个析构器，它在 `Player` 实例被释放之前调用。在这里，反初始化器只是将玩家的所有硬币返回到银行：



```swift
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"
```

将创建一个新的 `Player` 实例，并请求 100 个硬币（如果可用）。此 `Player` 实例存储在名为 `playerOne`的可选 `Player` 变量中。这里使用了一个可选变量，因为玩家可以随时离开游戏。该选项可让您跟踪当前是否有玩家在游戏中。

因为 `playerOne` 是可选的，所以当访问其 `coinsInPurse` 属性以打印其默认硬币数量时，以及每当其 `win(coins:)` 方法被调用：

```swift
playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// Prints "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// Prints "The bank now only has 7900 coins left"
```

在这里，玩家赢得了 2,000 个金币。玩家的钱包现在有 2,100 个硬币，而银行只剩下 7,900 个硬币。

```swift
playerOne = nil
print("PlayerOne has left the game")
// Prints "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// Prints "The bank now has 10000 coins"
```

该玩家现已离开游戏。这是通过将可选的 `playerOne` 变量设置为 `nil` 来指示的，意思是“没有 `Player` 实例”。当这种情况发生时， `playerOne` 变量对 `Player` 实例的引用就被破坏了。没有其他属性或变量仍然引用 `Player` 实例，因此它被释放以释放其内存。就在这发生之前，它的去初始化器被自动调用，并且它的硬币被返回到银行。





### 3.引用类型的生命周期

```swift

class Father{
    var name:String
    
    init(name:String){
        self.name = name
    }
    deinit{
        print("Father name:\(name) be free")
    }
}

class Son:Father{
    var age:Int
    init(name:String,age:Int){
        self.age = age
        super.init(name: name)
    }
    deinit{
        print("Son Age:\(age) be free")
    }
}


func tmp(){
    let varInStack = Son(name:"hello",age:14)  //调用完函数.声明周期结束
}

tmp()
```

**内存管理和引用计数**

1. **对象创建和计数器增加**：
   - 当 `Son(name: "hello", age: 14)` 在函数 `tmp()` 中被创建时，Swift 会在堆空间为 `Son` 实例分配内存，并初始化它的属性。
   - 此时，引用计数（ARC）会被设置为 1，因为 `varInStack` 引用了这个实例。

2. **函数执行**：
   - 在函数 `tmp()` 的作用域内，`varInStack` 持有对 `Son` 实例的强引用，所以引用计数保持为 1。
   - 函数内部可以对 `varInStack` 进行操作和访问。

3. **函数返回和计数器减少**：
   - 当函数 `tmp()` 执行结束时，`varInStack` 超出了它的作用域，这意味着它不再引用 `Son` 实例。
   - ARC 会自动减少 `Son` 实例的引用计数。

4. **对象销毁**：
   - 如果引用计数减少到 0，ARC 会销毁 `Son` 实例，释放堆空间，并调用 `Son` 的析构函数（`deinit`）。

**内存管理流程**

1. **函数开始执行前**：
   - `Son` 实例尚未创建，堆空间未分配。

2. **函数执行期间**：
   - 创建 `Son` 实例，堆空间分配，引用计数设为 1。
   - 在函数作用域内，`varInStack` 持有 `Son` 实例的引用。

3. **函数执行结束**：
   - `varInStack` 超出作用域，不再持有 `Son` 实例的引用。
   - 引用计数减少到 0，ARC 释放堆空间，调用析构函数。

**实例销毁的触发**

```swift
class Father {
    var name: String

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Father name: \(name) be free")
    }
}

class Son: Father {
    var age: Int

    init(name: String, age: Int) {
        self.age = age
        super.init(name: name)
    }

    deinit {
        print("Son Age: \(age) be free")
    }
}

func tmp() {
    let varInStack = Son(name: "hello", age: 14)
    // 引用计数为 1
} // 引用计数变为 0，调用 deinit
```

运行 `tmp()` 函数时，`Son` 实例在堆上分配内存，函数结束时引用计数变为 0，触发析构函数，输出析构信息。

**总结**

- **引用类型在堆上分配内存，栈上保存指向堆空间的指针**。
- **函数返回前**：引用计数增加和减少。
- **引用计数为零时**：ARC 释放堆空间，调用析构函数。

通过这种内存管理机制，Swift 确保引用类型在使用时的内存安全和高效管理。
