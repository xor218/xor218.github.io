---
layout: post
author: "大西瓜"
title: "Type Casting 类型转换"
date:   2024-07-02 10:35:12 +0800
categories: [update,Swift] 
---



## type Casting 类型铸造

**确定值的运行时类型并为其提供更具体的类型信息。**

类型转换是一种检查实例类型的方法，或者将该实例视为与其自己的类层次结构中其他位置不同的超类或子类。

Swift 中的类型转换是通过 `is` 和 `as` 运算符实现的。这两个运算符提供了一种简单而富有表现力的方法来检查值的类型或将值转换为不同的类型。



> **Note**:
>
> 

您还可以使用类型转换来检查类型是否符合协议，如检查协议一致性中所述。





### 1.类型定义转换的类层次结构

您可以对类和子类的层次结构使用类型转换来检查特定类实例的类型，并将该实例转换为同一层次结构中的另一个类。下面的三个代码片段定义了类的层次结构和包含这些类的实例的数组，用于类型转换的示例。



第一个片段定义了一个名为 `MediaItem` 的新基类。此类为数字媒体库中出现的任何类型的项目提供基本功能。具体来说，它声明了一个 `String` 类型的 `name` 属性和一个 `init(name:)` 初始值设定项。 （假设所有媒体项目，包括所有电影和歌曲，都有一个名称。）

```swift
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}
```



下一个代码片段定义了 `MediaItem` 的两个子类。第一个子类 `Movie` 封装了有关电影或影片的附加信息。它在基类 `MediaItem` 之上添加了一个 `director` 属性，以及相应的初始值设定项。第二个子类 `Song` 在基类之上添加 `artist` 属性和初始值设定项：

```swift
class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}


class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}
```

最后的代码片段创建一个名为 `library` 的常量数组，其中包含两个 `Movie` 实例和三个 `Song` 实例。 `library` 数组的类型是通过使用数组文字的内容进行初始化来推断的。 Swift 的类型检查器能够推断出 `Movie` 和 `Song` 有一个共同的超类 `MediaItem` ，因此它推断出 `[MediaItem]` 的类型对于 `library` 数组：

```swift
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
```





存储在 `library` 中的项目仍然是幕后的 `Movie` 和 `Song` 实例。但是，如果您迭代此数组的内容，则收到的项目将键入为 `MediaItem` ，而不是 `Movie` 或 `Song` 。为了将它们作为其本机类型使用，您需要检查它们的类型，或将它们向下转换为不同的类型，如下所述。



### 2. 检查类型

> **Note:**判断实例是不是该中对象的实例子 if instantance is SomeClass{.....}

使用类型检查运算符 （ `is` ） 检查实例是否属于某个子类类型。类型检查运算符将返回实例是否属于该子类类型， `false` 如果实例不是该子类类型，则返回 `true` 。

下面的示例定义了两个变量 `movieCount` 和 `songCount` ，用于计算 `library` 数组中 `Movie` 和 `Song` 实例的数量：

```swift
var movieCount = 0
var songCount = 0


for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}


print("Media library contains \(movieCount) movies and \(songCount) songs")
// Prints "Media library contains 2 movies and 3 songs"
```



此示例循环访问 `library` 数组中的所有项。在每次传递时， `for` - `in` 循环将 `item` 常量设置为数组中的下一个 `MediaItem` 常量。



`item is Movie` 如果当前是 `Movie` 实例， `false` 则返回 `true` ，如果不是 `MediaItem` 。同样， `item is Song` 检查项目是否为 `Song` 实例。在 `for` - `in` 循环的末尾，和 `movieCount` `songCount` 的值包含找到每种类型的实例数 `MediaItem` 的计数。





### 3.向下转换

类似于C++中的C类指针实际上指向的是派生类的对象

因为在内存中 的布局如下

```swift
+-----------------+
| baseProperty    | (基类部分)
+-----------------+
| subProperty     | (子类部分)
+-----------------+
```





特定类类型的常量或变量实际上可能引用后台子类的实例。如果您认为是这种情况，您可以尝试使用类型转换运算符 （ `as?` 或 `as!` ） 向下转换为子类类型。

由于下转换可能会失败，因此类型转换运算符有两种不同的形式。条件形式 `as?` 返回您尝试向下转换到的类型的可选值。强制形式 `as!` ，尝试下沉，并将结果作为单个复合动作强制展开。

当您不确定 downcast 是否会成功时，请使用 type cast 运算符 （ `as?` ） 的条件形式。这种形式的运算符将始终返回一个可选值， `nil` 如果无法向下转换，则该值将为。这使您能够检查是否成功下降。

仅当您确定 downcast 将始终成功时，才使用类型转换运算符 （ `as!` ） 的强制形式。如果尝试向下转换为不正确的类类型，则此形式的运算符将触发运行时错误。

下面的示例遍历 中的 `library` 每个 `MediaItem` 项目，并为每个项目打印适当的描述。为此，它需要将每个项目作为 true `Movie` 或 `Song` 访问，而不仅仅是作为 `MediaItem` .这是必需的，以便它能够访问 `Movie` or `Song` 的 `director` or `artist` 属性以在描述中使用。

在此示例中，数组中的每个项都可能是 `Movie` ，也可能是 `Song` 。您事先不知道每个项目要使用哪个实际类，因此每次通过循环使用类型转换运算符 （ `as?` ） 的条件形式来检查下移是合适的：

```swift
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}


// Movie: Casablanca, dir. Michael Curtiz
// Song: Blue Suede Shoes, by Elvis Presley
// Movie: Citizen Kane, dir. Orson Welles
// Song: The One And Only, by Chesney Hawkes
// Song: Never Gonna Give You Up, by Rick Astley
```

该示例首先尝试将电流 `item` 转换为 `Movie` .因为 `item` 是一个 `MediaItem` 实例，所以它可能是一个 `Movie`;同样，它也可能是一个 `Song` ，甚至只是一个基 `MediaItem` 数。由于这种不确定性， `as?` 类型转换运算符的形式在尝试向下转换为子类类型时返回一个可选值。的结果 `item as? Movie` 类型为 `Movie?` ，或“可选 `Movie` ”。



将 Downcasting `Movie` 转换为库数组中的 `Song` 实例时失败。为了解决这个问题，上面的示例使用可选绑定来检查可选是否 `Movie` 实际包含值（即，找出 downcast 是否成功）。此可选绑定写为 “ `if let movie = item as? Movie` ”，可以理解为：



“尝试 `item` 以 `Movie` .如果此操作成功，请设置一个新的临时常量，该 `movie` 常量调用存储在返回的可选 `Movie` .“ 中的值。



如果下转换成功，则 的 `movie` 属性将用于打印该 `Movie` 实例的描述，包括其 `director` .类似的原理用于检查 `Song` 实例，并在库中找到 a `Song` 时打印适当的描述（包括 `artist` 名称）。



> **Note**:
>
> 强制转换实际上不会修改实例或更改其值。基础实例保持不变;它只是作为它所投射到的类型的实例进行处理和访问。



#### 3.1 as？和as！的区别

在 Swift 中，`as?` 和 `as!` 都用于类型转换，但它们的行为有所不同：

1. **`as?`（条件向下转换）**：
    
    - `as?` 是一种安全的类型转换操作，尝试将一个对象转换为指定类型。
    - 如果转换成功，结果是一个指定类型的可选值（即 `Optional` 类型，非 `nil`）。
    - 如果转换失败，结果是 `nil`。
    - 这种转换方式不会导致运行时错误。
    
    ```swift
    if let movie = item as? Movie {
        // 转换成功，movie 是一个非可选的 Movie 类型
        print("Movie: \(movie.name), directed by \(movie.director)")
    } else {
        // 转换失败，movie 为 nil
        print("Not a movie")
    }
    ```
    
2. **`as!`（强制向下转换）**：
    
    - `as!` 是一种强制类型转换操作，试图将一个对象强制转换为指定类型。
    - 如果转换成功，结果是一个指定类型的非可选值。
    - 如果转换失败，会导致运行时错误（崩溃）。
    - 这种转换方式在确保转换成功时使用，否则可能会导致程序崩溃。
    - as！不能在if 条件语句中使用
    
    ```swift
    let movie = item as! Movie
    // 如果 item 不是 Movie 类型，这里会导致运行时错误
    print("Movie: \(movie.name), directed by \(movie.director)")
    ```

**总结**

- `as?`：安全类型转换，如果转换失败，结果为 `nil`，不会引发运行时错误。
- `as!`：强制类型转换，如果转换失败，会引发运行时错误。

**示例代码**

以下示例展示了两种类型转换的用法和差异：

```swift
class MediaItem {
    var name: String

    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String

    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String

    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let items: [MediaItem] = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley")
]

// 使用 as? 进行安全转换
for item in items {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), directed by \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    } else {
        print("Unknown media item")
    }
}

// 使用 as! 进行强制转换（假设已知 items[0] 是 Movie 类型）
let firstItem = items[0]
let firstMovie = firstItem as! Movie
print("Movie: \(firstMovie.name), directed by \(firstMovie.director)")

// 如果强制转换失败会导致运行时错误
// let secondItem = items[1]
// let secondMovie = secondItem as! Movie // 这行代码会导致运行时错误，因为 items[1] 是 Song 类型
```

通过这些示例，你可以清楚地看到 `as?` 和 `as!` 的区别以及使用场景。`as?` 适用于不确定转换是否成功的情况，`as!` 适用于确定转换一定成功的情况，但使用时需要非常小心，以避免运行时错误。





### 4.Any和AnyObject的类型转换

Swift 提供了两种特殊类型来处理非特定类型：

- `Any` 可以表示任何类型的实例，包括函数类型。
- `AnyObject` 可以表示任何类类型的实例。

`AnyObject` 仅当您明确需要它们提供的行为和功能时才使用 `Any` 。最好具体说明您希望在代码中使用的类型。

下面是用于 `Any` 混合使用不同类型（包括函数类型和非类类型）的示例。该示例创建一个名为 `things` 的数组，该数组可以存储以下类型的 `Any` 值：

```swift
var things: [Any] = []


things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })
```

该 `things` 数组包含两个 `Int` 值、两个 `Double` 值、一个 `String` 值、一个元组类型 `(Double, Double)`、电影“捉鬼敢死队”和一个接受一个 `String` 值并返回另一个 `String` 值的闭包表达式。

**要捕捉参数或者对象或者变量需要用as，判断是什么class 用is 就可以了，爷可以加where 用于let 值的判断**

若要发现已知类型 `Any` 为 or `AnyObject` 的常量或变量的特定类型，可以在 `switch` 语句的大小写中使用 `is`或 `as` 模式。下面的示例遍历数组中的项， `things` 并使用 `switch` 语句查询每个项的类型。 `switch` 语句的几个大小写将其匹配值绑定到指定类型的常量，以便打印其值：

```swift
for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}


// zero as an Int
// zero as a Double
// an integer value of 42
// a positive double value of 3.14159
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// a movie called Ghostbusters, dir. Ivan Reitman
// Hello, Michael
```



> **Note**:类型 `Any` 表示任何类型的值，包括可选类型。如果您使用可选值，而需要 type `Any` 值，Swift 会向您发出警告。如果确实需要使用可选值作为 `Any` 值，则可以使用 `as` 运算符将可选值显式转换为 `Any` ，如下所示。
>
> ```swift
> let optionalNumber: Int? = 3
> things.append(optionalNumber)        // Warning
> things.append(optionalNumber as Any) // No warning
> ```
>
> ```swift
> var anyList:[Any] = []
> 
> 
> let opInt:Int? = 3
> 
> 
> anyList.append(opInt as Any)
> 
> let tt = anyList[0]
> //把tt尝试转换为Int？类型，然后选可选绑定
> if let tt = tt as? Int? {
>     if let value = tt {
>         print(value)
>     }
> }
> 
> ```
>
> 





