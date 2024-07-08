---
layout: post
author: "大西瓜"
title: "A Collection Of Classified Details 未归来的一些其他细节"
date:   2024-07-07 19:15:05 +0800
categories: [update,Notes] 
---





## 可变参数



###  同一种类型

如果参数为 Type... ,那函数参数应该就是 [type] 数组

```swift
func sum(args:Int...) ->Int{
    var sum = 0
    for item in args{
        sum += item
    }
    return sum
}
```





### 不同类型

归类到Any

```swift
// 定义一个可变参数函数，接受任意类型的参数
func printAllArguments(_ args: Any...) {
    for arg in args {
        print(arg)
    }
}

// 调用函数，传入不同类型和数量的参数
printAllArguments(1, "hello", 3.14, true, [1, 2, 3], ["key": "value"])
```



### 判断类型

你可以使用Swift中的type(of:)函数和条件类型检查（如is关键字）来处理传入的参数类型。这可以让你根据不同类型的参数执行不同的逻辑。下面是一个更复杂的示例，展示如何实现这种逻辑。

```swift
// 定义一个可变参数函数，接受任意类型的参数，并根据类型进行处理
func processArguments(_ args: Any...) {
    for arg in args {
        switch arg {
        case let intArg as Int:  //or case is Int:
            print("Integer: \(intArg)")
        case let stringArg as String:
            print("String: \(stringArg)")
        case let doubleArg as Double:
            print("Double: \(doubleArg)")
        case let boolArg as Bool:
            print("Boolean: \(boolArg)")
        case let arrayArg as [Any]:
            print("Array: \(arrayArg)")
        case let dictArg as [String: Any]:
            print("Dictionary: \(dictArg)")
        default:
            print("Unknown type: \(type(of: arg))")
        }
    }
}

// 调用函数，传入不同类型和数量的参数
processArguments(1, "hello", 3.14, true, [1, 2, 3], ["key": "value"], nil)
```





## 继承AnyObject

在Swift中，AnyObject是一个协议，表示任何类类型的实例。当一个协议继承自AnyObject时，这意味着这个协议只能被类（class）遵循，而不能被结构体（struct）或枚举（enum）遵循。这并不意味着要让类继承AnyObject，而是说遵循该协议的类型必须是类类型。
