---
layout: post
author: "大西瓜"
title: "attributes 属性"
date:   2024-05-15 08:58:20 +0800
categories: [update,Swift] 
---

在 Swift 中，属性（attributes）是一种元数据，用于修饰和增强代码的功能和行为。以下是 Swift 中一些常见的属性及其用途：
在 Swift 中，属性（attributes）是一种元数据，用于修饰和增强代码的功能和行为。以下是 Swift 中一些常见的属性及其用途：

### 1. `@discardableResult`
允许函数或方法的返回值可以被忽略，而不会导致编译器警告。
```swift
@discardableResult
func myFunction() -> Int {
    return 42
}
```

### 2. `@available`
指定 API 的可用性，可以用于标记方法、属性、类、协议等的可用性和弃用信息。
```swift
@available(iOS 10, *)
func newFeature() {
    // Code that requires iOS 10 or later
}
```

### 3. `@objc`
使 Swift 方法或属性可以被 Objective-C 代码调用，通常用于与 Objective-C 代码进行交互或兼容性处理。
```swift
@objc
class MyClass: NSObject {
    @objc func myMethod() {
        // Objective-C can call this method
    }
}
```

### 4. `@IBAction` 和 `@IBOutlet`
用于 Interface Builder，将 Swift 代码与用户界面元素连接。
```swift
class MyViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!

    @IBAction func buttonTapped(_ sender: UIButton) {
        myLabel.text = "Button was tapped!"
    }
}
```

### 5. `@NSCopying`
用于标记属性，使其在赋值时进行复制（通常用于 Objective-C 的 `NSCopying` 协议）。
```swift
class MyClass: NSObject {
    @NSCopying var name: NSString
}
```

### 6. `@IBInspectable` 和 `@IBDesignable`
使自定义视图的属性可以在 Interface Builder 中进行设置和预览。
```swift
@IBDesignable
class CustomView: UIView {
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
```

### 7. `@testable`
允许在单元测试中访问内部作用域的实体。
```swift
@testable import MyAppModule
import XCTest

class MyAppTests: XCTestCase {
    func testExample() {
        let example = MyInternalClass()
        // Can access internal properties and methods
    }
}
```

### 8. `@inline(__always)` 和 `@inline(never)`
用于控制函数的内联行为。
```swift
@inline(__always)
func alwaysInlinedFunction() {
    // This function will always be inlined
}

@inline(never)
func neverInlinedFunction() {
    // This function will never be inlined
}
```

### 9. `@frozen`
用于标记结构体或枚举为冻结的，意味着它们的布局将不会改变。这是一个性能优化提示。
```swift
@frozen
public struct MyStruct {
    public var x: Int
    public var y: Int
}
```

### 10. `@propertyWrapper`
用于定义属性包装器，简化属性的封装和管理。
```swift
@propertyWrapper
struct Capitalized {
    private var text: String

    var wrappedValue: String {
        get { text }
        set { text = newValue.capitalized }
    }

    init(wrappedValue: String) {
        self.text = wrappedValue.capitalized
    }
}

struct Person {
    @Capitalized var name: String
}
```

### 11. `@main`
指定应用程序的入口点（仅用于 Swift 应用程序）。
```swift
@main
struct MyApp {
    static func main() {
        print("Hello, World!")
    }
}
```

### 12. `@escaping`
用于标记闭包，表明闭包可以逃逸出函数作用域。
```swift
func performAsyncTask(completion: @escaping () -> Void) {
    DispatchQueue.global().async {
        completion()
    }
}
```

### 13. `@autoclosure`
用于自动将表达式包装在闭包中，常用于简化语法。
```swift
func logIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("It's true!")
    }
}

logIfTrue(2 > 1) // 自动将表达式 2 > 1 包装在闭包中
```

### 14. `@dynamicCallable` 和 `@dynamicMemberLookup`
使类型支持动态调用和动态成员查找。
```swift
@dynamicCallable
struct Callable {
    func dynamicallyCall(withArguments args: [Int]) -> Int {
        return args.reduce(0, +)
    }
}

let callable = Callable()
print(callable(1, 2, 3)) // 输出：6

@dynamicMemberLookup
struct DynamicLookup {
    let dictionary = ["foo": 42, "bar": 100]

    subscript(dynamicMember member: String) -> Int {
        return dictionary[member, default: 0]
    }
}

let lookup = DynamicLookup()
print(lookup.foo) // 输出：42
print(lookup.bar) // 输出：100
```

除了我之前提到的常见属性（attributes），Swift 中还有一些其他有用的属性。下面是一些附加的属性及其用途：

### 15. `@usableFromInline`
用于标记模块内可见的符号，允许它们在 `@inlinable` 函数中被内联。
```swift
@usableFromInline
internal struct InternalStruct {
    @usableFromInline
    var value: Int

    @usableFromInline
    init(value: Int) {
        self.value = value
    }
}
```

### 16. `@inlinable`
允许函数、方法、计算属性的代码在模块外部可见，从而可以被内联。
```swift
@inlinable
public func myPublicFunction() {
    // 这个函数可以被其他模块内联
}
```

### 17. `@nonobjc`
防止 Swift 方法、属性或类暴露给 Objective-C 运行时。
```swift
class MyClass {
    @nonobjc func mySwiftOnlyMethod() {
        // 这个方法不会暴露给 Objective-C
    }
}
```

### 18. `@GKInspectable`
使属性可在 Apple 的 GameplayKit 中的 Inspector 中显示。
```swift
class MyComponent: GKComponent {
    @GKInspectable var speed: Float = 0.0
}
```

### 19. `@NSManaged`
用于 Core Data 中，表示属性或方法的实现由 Core Data 在运行时提供。
```swift
class MyManagedObject: NSManagedObject {
    @NSManaged var name: String
}
```

### 20. `@UIApplicationMain`
用于标记应用程序的入口点，自动生成 main.swift 并设置 UIApplicationDelegate。
```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // 应用程序入口点
}
```

### 21. `@NSApplicationMain`
类似 `@UIApplicationMain`，用于 macOS 应用程序。
```swift
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    // 应用程序入口点
}
```

### 22. `@testable`
允许在测试目标中访问模块的内部接口。
```swift
@testable import MyModule
import XCTest

class MyModuleTests: XCTestCase {
    func testExample() {
        let example = MyInternalClass()
        // 可以访问内部属性和方法
    }
}
```

### 23. `@convention`
指定函数类型的调用约定。
```swift
let cFunction: @convention(c) (Int, Int) -> Int = { x, y in
    return x + y
}
```

### 24. `@main`
指定应用程序的入口点（Swift 5.3 及以后版本）。
```swift
@main
struct MyApp {
    static func main() {
        print("Hello, World!")
    }
}
```

### 25. `@dynamicCallable`
使类型支持动态调用。
```swift
@dynamicCallable
struct Callable {
    func dynamicallyCall(withArguments args: [Int]) -> Int {
        return args.reduce(0, +)
    }
}

let callable = Callable()
print(callable(1, 2, 3)) // 输出：6
```

### 26. `@dynamicMemberLookup`
使类型支持动态成员查找。
```swift
@dynamicMemberLookup
struct DynamicLookup {
    let dictionary = ["foo": 42, "bar": 100]

    subscript(dynamicMember member: String) -> Int {
        return dictionary[member, default: 0]
    }
}

let lookup = DynamicLookup()
print(lookup.foo) // 输出：42
print(lookup.bar) // 输出：100
```

### 27. `@propertyWrapper`
用于定义属性包装器，简化属性的封装和管理。
```swift
@propertyWrapper
struct Capitalized {
    private var text: String

    var wrappedValue: String {
        get { text }
        set { text = newValue.capitalized }
    }

    init(wrappedValue: String) {
        self.text = wrappedValue.capitalized
    }
}

struct Person {
    @Capitalized var name: String
}
```

Swift 中有许多属性（attributes）可以用来修饰和增强代码的功能和行为。以下是一些其他有用的属性及其用途：

### 28. `@warn_unqualified_access`
防止模块名被误用，确保在访问成员时明确指定模块名。
```swift
struct MyStruct {
    @warn_unqualified_access
    func doSomething() {
        print("Doing something")
    }
}
```

### 29. `@inline(__always)` 和 `@inline(never)`
控制函数的内联行为，`@inline(__always)` 强制内联，`@inline(never)` 禁止内联。
```swift
@inline(__always)
func alwaysInlinedFunction() {
    // This function will always be inlined
}

@inline(never)
func neverInlinedFunction() {
    // This function will never be inlined
}
```

### 30. `@escaping`
用于标记闭包，表明闭包可以逃逸出函数作用域。
```swift
func performAsyncTask(completion: @escaping () -> Void) {
    DispatchQueue.global().async {
        completion()
    }
}
```

### 31. `@autoclosure`
自动将表达式包装在闭包中，简化语法。
```swift
func logIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("It's true!")
    }
}

logIfTrue(2 > 1) // 自动将表达式 2 > 1 包装在闭包中
```

### 32. `@frozen`
用于标记结构体或枚举为冻结的，意味着它们的布局将不会改变。这是一个性能优化提示。
```swift
@frozen
public struct MyStruct {
    public var x: Int
    public var y: Int
}
```

### 33. `@dynamicMemberLookup`
使类型支持动态成员查找。
```swift
@dynamicMemberLookup
struct DynamicLookup {
    let dictionary = ["foo": 42, "bar": 100]

    subscript(dynamicMember member: String) -> Int {
        return dictionary[member, default: 0]
    }
}

let lookup = DynamicLookup()
print(lookup.foo) // 输出：42
print(lookup.bar) // 输出：100
```

### 34. `@dynamicCallable`
使类型支持动态调用。
```swift
@dynamicCallable
struct Callable {
    func dynamicallyCall(withArguments args: [Int]) -> Int {
        return args.reduce(0, +)
    }
}

let callable = Callable()
print(callable(1, 2, 3)) // 输出：6
```

### 35. `@resultBuilder`（原名 `@_functionBuilder`）
用于创建 DSL（领域特定语言），简化复杂嵌套结构的创建。
```swift
@resultBuilder
struct ArrayBuilder {
    static func buildBlock(_ components: Int...) -> [Int] {
        return components
    }
}

@ArrayBuilder
func makeArray() -> [Int] {
    1
    2
    3
}

let array = makeArray()
print(array) // 输出：[1, 2, 3]
```

### 36. `@propertyWrapper`
用于定义属性包装器，简化属性的封装和管理。
```swift
@propertyWrapper
struct Capitalized {
    private var text: String

    var wrappedValue: String {
        get { text }
        set { text = newValue.capitalized }
    }

    init(wrappedValue: String) {
        self.text = wrappedValue.capitalized
    }
}

struct Person {
    @Capitalized var name: String
}

var person = Person(name: "john")
print(person.name) // 输出：John
```

### 37. `@propertyWrapper` with `projectedValue`
用于属性包装器，提供额外的投射值。
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
someStructure.someNumber = 10
print(someStructure.$someNumber) // 输出：false
someStructure.someNumber = 13
print(someStructure.$someNumber) // 输出：true
```
在 Swift 中，还有一些其他有用的属性（attributes）和修饰符，用于不同的场景和需求。以下是更多的 Swift 属性及其用途：

### 38. `@objcMembers`
自动将类的所有成员暴露给 Objective-C。
```swift
@objcMembers
class MyClass: NSObject {
    var name: String = "Default"
    func greet() {
        print("Hello, \(name)")
    }
}
```

### 39. `@NSCopying`
用于属性，该属性遵循 `NSCopying` 协议，在赋值时进行复制。
```swift
class MyClass: NSObject {
    @NSCopying var name: NSString = "Default"
}
```

### 40. `@NSManaged`
用于 Core Data，表示属性或方法的实现由 Core Data 在运行时提供。
```swift
class MyManagedObject: NSManagedObject {
    @NSManaged var name: String
}
```

### 41. `@GKInspectable`
使属性可在 Apple 的 GameplayKit 中的 Inspector 中显示。
```swift
class MyComponent: GKComponent {
    @GKInspectable var speed: Float = 0.0
}
```

### 42. `@UIApplicationMain`
用于标记应用程序的入口点，自动生成 `main.swift` 并设置 `UIApplicationDelegate`。
```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // 应用程序入口点
}
```

### 43. `@NSApplicationMain`
类似 `@UIApplicationMain`，用于 macOS 应用程序。
```swift
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    // 应用程序入口点
}
```

### 44. `@convention`
指定函数类型的调用约定。
```swift
let cFunction: @convention(c) (Int, Int) -> Int = { x, y in
    return x + y
}
```

### 45. `@warn_unqualified_access`
防止模块名被误用，确保在访问成员时明确指定模块名。
```swift
struct MyStruct {
    @warn_unqualified_access
    func doSomething() {
        print("Doing something")
    }
}
```

### 46. `@frozen`
用于标记结构体或枚举为冻结的，意味着它们的布局将不会改变。这是一个性能优化提示。
```swift
@frozen
public struct MyStruct {
    public var x: Int
    public var y: Int
}
```

### 47. `@discardableResult`
允许函数或方法的返回值可以被忽略，而不会导致编译器警告。
```swift
@discardableResult
func myFunction() -> Int {
    return 42
}
```

### 48. `@nonobjc`
防止 Swift 方法、属性或类暴露给 Objective-C 运行时。
```swift
class MyClass {
    @nonobjc func mySwiftOnlyMethod() {
        // 这个方法不会暴露给 Objective-C
    }
}
```

### 49. `@IBAction` 和 `@IBOutlet`
用于 Interface Builder，将 Swift 代码与用户界面元素连接。
```swift
class MyViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!

    @IBAction func buttonTapped(_ sender: UIButton) {
        myLabel.text = "Button was tapped!"
    }
}
```

### 50. `@inline(__always)` 和 `@inline(never)`
控制函数的内联行为，`@inline(__always)` 强制内联，`@inline(never)` 禁止内联。
```swift
@inline(__always)
func alwaysInlinedFunction() {
    // This function will always be inlined
}

@inline(never)
func neverInlinedFunction() {
    // This function will never be inlined
}
```

### 51. `@escaping`
用于标记闭包，表明闭包可以逃逸出函数作用域。
```swift
func performAsyncTask(completion: @escaping () -> Void) {
    DispatchQueue.global().async {
        completion()
    }
}
```

### 52. `@autoclosure`
自动将表达式包装在闭包中，简化语法。
```swift
func logIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("It's true!")
    }
}

logIfTrue(2 > 1) // 自动将表达式 2 > 1 包装在闭包中
```

### 53. `@propertyWrapper`
用于定义属性包装器，简化属性的封装和管理。
```swift
@propertyWrapper
struct Capitalized {
    private var text: String

    var wrappedValue: String {
        get { text }
        set { text = newValue.capitalized }
    }

    init(wrappedValue: String) {
        self.text = wrappedValue.capitalized
    }
}

struct Person {
    @Capitalized var name: String
}

var person = Person(name: "john")
print(person.name) // 输出：John
```

### 54. `@dynamicCallable`
使类型支持动态调用。
```swift
@dynamicCallable
struct Callable {
    func dynamicallyCall(withArguments args: [Int]) -> Int {
        return args.reduce(0, +)
    }
}

let callable = Callable()
print(callable(1, 2, 3)) // 输出：6
```

### 55. `@dynamicMemberLookup`
使类型支持动态成员查找。
```swift
@dynamicMemberLookup
struct DynamicLookup {
    let dictionary = ["foo": 42, "bar": 100]

    subscript(dynamicMember member: String) -> Int {
        return dictionary[member, default: 0]
    }
}

let lookup = DynamicLookup()
print(lookup.foo) // 输出：42
print(lookup.bar) // 输出：100
```

### 56. `@resultBuilder`（原名 `@_functionBuilder`）
用于创建 DSL（领域特定语言），简化复杂嵌套结构的创建。
```swift
@resultBuilder
struct ArrayBuilder {
    static func buildBlock(_ components: Int...) -> [Int] {
        return components
    }
}

@ArrayBuilder
func makeArray() -> [Int] {
    1
    2
    3
}

let array = makeArray()
print(array) // 输出：[1, 2, 3]
```

### 57. `@main`
指定应用程序的入口点（Swift 5.3 及以后版本）。
```swift
@main
struct MyApp {
    static func main() {
        print("Hello, World!")
    }
}
```

### 58. `@testable`
允许在测试目标中访问模块的内部接口。
```swift
@testable import MyModule
import XCTest

class MyModuleTests: XCTestCase {
    func testExample() {
        let example = MyInternalClass()
        // 可以访问内部属性和方法
    }
}
```


