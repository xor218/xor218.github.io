---
layout: post
author: "大西瓜"
title: "Concurrency 并发"
date:   2024-06-28 10:33:08 +0800
categories: [update,Swift] 
---




## Concurrency 并发

**执行异步操作。**



****

**chatGpt**

Swift 的并发模型结合了多线程和协程的概念，通过编译器和运行时共同决定如何调度和执行任务(编**译器看运行环境决定用协程还是多线程**)。这意味着，开发者在编写并发代码时，可以不必关心底层的线程管理，而是专注于任务的逻辑和依赖。Swift 的并发模型主要通过以下几个方面来实现：

- **1. 编译器支持**

> Swift 编译器在编译异步代码时，会将异步函数转换成状态机。这种转换使得异步函数可以在暂停和恢复时保存和恢复其状态，而无需显式地创建和管理线程。

- **2. 运行时调度**

> Swift 的运行时环境（例如，使用 Grand Central Dispatch (GCD) 或者 Swift Concurrency Task 系统）负责实际的任务调度和线程管理。任务调度系统会根据当前系统的负载、任务的优先级等因素，决定如何分配和执行任务。

- **3. 高级抽象**

> Swift 提供了 async/await 关键字和 Task 结构，使得开发者可以方便地编写异步代码，而无需直接管理线程。这些高级抽象由编译器和运行时共同实现，确保高效的任务调度和资源利用。



**示例代码**

以下是一个使用 Swift 并发模型的示例，展示了如何编写异步代码而无需关心底层的线程管理：

```swift
import Foundation

// 声明一个异步函数 会被编译器转换成状态机
func fetchData(from url: URL) async throws -> Data { 
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}

// 使用异步函数
@main
struct MyApp {
    static func main() async {
        let url = URL(string: "https://www.example.com")!
        
        do {
            async let data1 = fetchData(from: url) //async 会立刻执行，执行方式编译器决定
            async let data2 = fetchData(from: url) //async 会立刻执行，执行方式编译器决定
            async let data3 = fetchData(from: url)
            
            let results = await [try data1, try data2, try data3]  //await 关键字会暂停当前任务，直到所有并发任务完成，然后继续执行
            
            for (index, data) in results.enumerated() {
                print("Data \(index + 1): \(data.count) bytes")
            }
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}
```



**执行流程**

​	1.	**异步函数转换**：编译器将 fetchData 异步函数转换为状态机，以便在需要时暂停和恢复执行。

​	2.	**启动并发任务**：async let 声明启动了多个并发任务，这些任务会立即开始执行，具体的执行方式由运行时环境决定。

​	3.	**任务调度**：Swift 的任务调度系统（如 GCD）负责分配和管理线程，以高效地执行这些并发任务。

	4.	**等待任务完成**：await 关键字会暂停当前任务，直到所有并发任务完成，然后继续执行。

**总结**

​	•	**编译器支持**：编译器将异步函数转换为状态机，支持任务的暂停和恢复。

​	•	**运行时调度**：运行时环境（如 GCD 和 Swift Concurrency Task 系统）负责实际的任务调度和线程管理。

​	•	**高级抽象**：async/await 和 Task 结构提供了高级抽象，使开发者可以方便地编写异步代码，而无需直接管理线程。



****



Swift 内置支持以结构化方式编写异步和并行代码。尽管一次只执行一段程序，但异步代码可以暂停并稍后恢复。暂停和恢复程序中的代码可以让它继续在短期操作（例如更新其 UI）上取得进展，同时继续进行长期运行的操作（例如通过网络获取数据或解析文件）。并行代码意味着多段代码同时运行——例如，一台具有四核处理器的计算机可以同时运行四段代码，每个核心执行其中一项任务。使用并行和异步代码的程序一次执行多个操作，并挂起正在等待外部系统的操作。



并行或异步代码带来的额外调度灵活性也伴随着复杂性增加的代价。 Swift 允许您以支持某些编译时检查的方式表达您的意图 - 例如，您可以使用 actor 来安全地访问可变状态。然而，向缓慢或有错误的代码添加并发性并不能保证它会变得更快或正确。事实上，添加并发性甚至可能使代码更难调试。然而，在需要并发的代码中使用 Swift 的语言级并发支持意味着 Swift 可以帮助您在编译时捕获问题。



**本章的其余部分使用术语并发来指代异步和并行代码的这种常见组合。**



> **Note**:如果您以前编写过并发代码，您可能习惯于使用线程。 Swift 中的并发模型构建在线程之上，但您不直接与它们交互。 Swift 中的异步函数可以放弃它正在运行的线程，这让另一个异步函数在该线程上运行，而第一个函数被阻塞。当异步函数恢复时，Swift 不保证该函数将在哪个线程上运行。





尽管可以在不使用 Swift 语言支持的情况下编写并发代码，但该代码往往更难阅读。例如，以下代码下载照片名称列表，下载该列表中的第一张照片，并向用户显示该照片：



```swift
listPhotos(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    downloadPhoto(named: name) { photo in
        show(photo)
    }
}
```

即使在这种简单的情况下，由于代码必须编写为一系列完成处理程序，因此您最终会编写嵌套的闭包。在这种风格中，具有深层嵌套的更复杂的代码很快就会变得难以处理。



### 1.定义和调用异步函数

异步函数或异步方法是一种特殊的函数或方法，可以在执行中途挂起。这与普通的同步函数和方法形成对比，后者要么运行完成，要么抛出错误，要么从不返回。异步函数或方法仍然执行这三件事之一，但它也可以在等待某些内容时在中间暂停。在异步函数或方法的主体内，您可以标记可以暂停执行的每个位置。


要指示函数或方法是异步的，请在其声明中的参数后面写入 `async` 关键字，类似于使用 `throws` 标记抛出函数的方式。如果函数或方法返回值，请在返回箭头 ( `->` ) 之前写入 `async` 。例如，以下是获取图库中照片名称的方法：

```swift
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... some asynchronous networking code ...
    return result
}
```



对于异步且抛出异常的函数或方法，可以在 `throws` 之前编写 `async` 。

调用异步方法时，执行会暂停，直到该方法返回。您可以在调用前面写入 `await` 以标记可能的挂起点。这就像在调用抛出函数时编写 `try` 一样，以标记出现错误时程序流程可能发生的更改。在异步方法内部，仅当您调用另一个异步方法时，执行流程才会挂起 - 挂起永远不会是隐式的或抢占式的 - 这意味着每个可能的挂起点都用 `await` 标记。标记代码中所有可能的暂停点有助于使并发代码更易于阅读和理解。

例如，下面的代码获取图库中所有图片的名称，然后显示第一张图片：

```swift
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)
```

由于 `listPhotos(inGallery:)` 和 `downloadPhoto(named:)` 函数都需要发出网络请求，因此可能需要相对较长的时间才能完成。通过在返回箭头之前写入 `async` 使它们都是异步的，这样应用程序的其余代码就可以在该代码等待图片准备就绪时继续运行。

为了理解上面示例的并发性质，以下是一种可能的执行顺序：

1. 代码从第一行开始运行，一直运行到第一个 `await` 。它调用 `listPhotos(inGallery:)` 函数并在等待该函数返回时暂停执行。
2. 当该代码的执行被挂起时，同一程序中的一些其他并发代码正在运行。例如，也许一个长时间运行的后台任务会继续更新新照片库的列表。该代码还会运行直到下一个暂停点（由 `await` 标记）或直到完成。
3. `listPhotos(inGallery:)` 返回后，此代码从该点开始继续执行。它将返回的值分配给 `photoNames`。
4. 定义 `sortedNames` 和 `name` 的行是常规同步代码。由于这些行上没有标记 `await` ，因此不存在任何可能的暂停点。
5. 接下来的 `await` 标记对 `downloadPhoto(named:)` 函数的调用。此代码再次暂停执行，直到该函数返回，从而为其他并发代码提供运行的机会。
6. `downloadPhoto(named:)` 返回后，其返回值被赋值给 `photo` ，然后在调用 `show(_:)` 时作为参数传递。

代码中可能的暂停点标记为 `await` 表示当前代码段可能会在等待异步函数或方法返回时暂停执行。这也称为“让出线程”，因为在幕后，Swift 会暂停当前线程上代码的执行，并在该线程上运行一些其他代码。由于带有 `await` 的代码需要能够暂停执行，因此只有程序中的某些位置可以调用异步函数或方法：

1. 异步函数、方法或属性主体中的代码。
2. 用 `@main` 标记的结构、类或枚举的静态 `main()` 方法中的代码。
3. 非结构化子任务中的代码，如下面的非结构化并发中所示。

```swift
func generateSlideshow(forGallery gallery: String) async {
    let photos = await listPhotos(inGallery: gallery)
    for photo in photos {
        // ... render a few seconds of video for this photo ...
        await Task.yield()
    }
}
```

假设渲染视频的代码是同步的，它不包含任何暂停点。渲染视频的工作也可能需要很长时间。但是，您可以定期调用 `Task.yield()` 来显式添加暂停点。以这种方式构建长时间运行的代码可以让 Swift 在完成此任务和让程序中的其他任务完成其工作之间取得平衡。

在编写简单代码来了解并发如何工作时， `Task.sleep(for:tolerance:clock:)` 方法非常有用。此方法将当前任务挂起至少给定的时间。下面是 `listPhotos(inGallery:)` 函数的一个版本，它使用 `sleep(for:tolerance:clock:)` 来模拟等待网络操作：

```swift
func listPhotos(inGallery name: String) async throws -> [String] {
    try await Task.sleep(for: .seconds(2))
    return ["IMG001", "IMG99", "IMG0404"]
}
```

上面代码中的 `listPhotos(inGallery:)` 版本既是异步的又是抛出错误的，因为对 `Task.sleep(until:tolerance:clock:)` 的调用可能会抛出错误。当您调用此版本的 `listPhotos(inGallery:)` 时，您将同时编写 `try` 和 `await` ：

```swift
let photos = try await listPhotos(inGallery: "A Rainy Weekend")
```

异步函数与抛出函数有一些相似之处：定义异步或抛出函数时，用 `async` 或 `throws` 标记它，并用 `await`。一个异步函数可以调用另一个异步函数，就像一个抛出函数可以调用另一个抛出函数一样。

然而，有一个非常重要的区别。您可以将抛出代码包装在 `do` - `catch` 块中来处理错误，或者使用 `Result` 来存储错误以便代码在其他地方处理它。这些方法允许您从非抛出代码调用抛出函数。例如：

```swift
func availableRainyWeekendPhotos() -> Result<[String], Error> {
    return Result {
        try listDownloadedPhotos(inGallery: "A Rainy Weekend")
    }
}
```

相反，没有安全的方法来包装异步代码，因此您可以从同步代码调用它并等待结果。 Swift 标准库有意省略了这种不安全的功能——尝试自己实现它可能会导致微妙的竞争、线程问题和死锁等问题。向现有项目添加并发代码时，应自上而下进行。具体来说，首先将最顶层的代码转换为使用并发性，然后开始转换它调用的函数和方法，一次一层地完成项目的架构。无法采用自下而上的方法，因为同步代码永远无法调用异步代码。





### 2.异步序列

上一节中的 `listPhotos(inGallery:)` 函数在数组的所有元素准备就绪后立即异步返回整个数组。另一种方法是使用异步序列一次等待集合中的一个元素。异步序列的迭代如下所示：

```swift
import Foundation


let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}
```

上面的示例没有使用普通的 `for` - `in` 循环，而是在 `for` 后面加上 `await` 。就像调用异步函数或方法时一样，编写 `await` 表示可能的挂起点。 `for` - `await` - `in` 循环可能会在每次迭代开始时暂停执行，等待下一个元素可用。

就像您可以通过添加与 `Sequence` 协议的一致性来在 `for` - `in` 循环中使用您自己的类型一样，您也可以在通过添加与 `AsyncSequence` 协议的一致性来实现 `for` - `await` - `in` 循环。



#### 2.1 for...in 和for try await in的区别

在 Swift 中，`for ... in` 和 `for try await ... in` 是两种不同类型的循环结构，它们用于不同的场景。

**`for ... in`**

`for ... in` 是最基本的循环结构，用于遍历集合（如数组、字典、集合等）中的每一个元素。

**用法**

- 用于同步代码
- 遍历普通集合

**示例**

```swift
let numbers = [1, 2, 3, 4, 5]

for number in numbers {
    print(number)
}
```

`for try await ... in`

`for try await ... in` 是专门用于异步序列的循环结构，用于遍历 `AsyncSequence` 中的元素。它不仅支持异步操作，还支持抛出错误。

**用法**

- 用于异步代码
- 遍历 `AsyncSequence`
- 支持异步操作和错误处理

**示例**

```swift
import Foundation

// 模拟一个异步序列
struct AsyncNumberSequence: AsyncSequence {
    typealias Element = Int

    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 0

        mutating func next() async throws -> Int? {
            guard current < 5 else { return nil }
            current += 1
            await Task.sleep(500_000_000) // 模拟异步延迟
            return current
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator()
    }
}

let asyncNumbers = AsyncNumberSequence()

Task {
    do {
        for try await number in asyncNumbers {
            print(number)
        }
    } catch {
        print("Error: \(error)")
    }
}

// 保持主线程运行
RunLoop.main.run()
```

**区别总结**

1. **执行环境**：
   - `for ... in`：用于同步环境。
   - `for try await ... in`：用于异步环境，适用于 `AsyncSequence`。

2. **集合类型**：
   - `for ... in`：遍历普通集合（如数组、字典、集合等）。
   - `for try await ... in`：遍历异步序列（`AsyncSequence`）。

3. **错误处理**：
   - `for ... in`：不直接支持错误处理。
   - `for try await ... in`：支持错误处理，可以使用 `try` 和 `catch` 处理遍历过程中可能发生的错误。

4. **暂停和继续**：
   - `for ... in`：一次性遍历整个集合，不涉及异步操作。
   - `for try await ... in`：每次迭代可以是异步的，允许在每次迭代之间暂停和继续。

**示例对比**

`for ... in`

```swift
let numbers = [1, 2, 3, 4, 5]

for number in numbers {
    print(number)
}
```

`for try await ... in`

```swift
import Foundation

struct AsyncNumberSequence: AsyncSequence {
    typealias Element = Int

    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 0

        mutating func next() async throws -> Int? {
            guard current < 5 else { return nil }
            current += 1
            await Task.sleep(500_000_000) // 模拟异步延迟
            return current
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator()
    }
}

let asyncNumbers = AsyncNumberSequence()

Task {
    do {
        for try await number in asyncNumbers {
            print(number)
        }
    } catch {
        print("Error: \(error)")
    }
}

// 保持主线程运行
RunLoop.main.run()
```

**总结**

- **`for ... in`**：用于遍历普通集合的同步循环结构。
- **`for try await ... in`**：用于遍历异步序列的异步循环结构，支持异步操作和错误处理。

根据您的需求选择适合的循环结构，确保在适当的场景中使用异步和同步代码。如果有任何进一步的问题，请随时告诉我。



#### 2.2 Task的用法

当然，可以详细介绍一下 `Task` 的用法。`Task` 是 Swift 并发模型中的一个核心部分，用于创建和管理异步任务。通过 `Task`，您可以并发地执行异步代码，并获取其结果。

**Task 的基本用法**

**1. 创建和运行任务**

可以使用 `Task` 来创建并运行一个新的异步任务。任务会立即开始执行。

```swift
Task {
    await someAsyncFunction()
}
```

**2. 捕获和处理错误**

在 `Task` 中，您可以使用 `do-catch` 语句来捕获和处理异步函数可能抛出的错误。

```swift
Task {
    do {
        try await someThrowingAsyncFunction()
    } catch {
        print("Error: \(error)")
    }
}
```

**3. 任务的取消**

任务可以被取消，您可以检查任务是否被取消，并根据需要提前退出。

```swift
Task {
    for i in 0..<10 {
        guard !Task.isCancelled else {
            print("Task was cancelled")
            return
        }
        print(i)
        await Task.sleep(1_000_000_000) // 模拟工作
    }
}
```

**4. 任务结果**

使用 `async let` 创建并发任务，并在稍后使用 `await` 来等待任务完成并获取结果。

```swift
Task {
    async let result1 = fetchData(from: "url1")
    async let result2 = fetchData(from: "url2")

    let results = await [result1, result2]
    print(results)
}
```

**详细示例**

以下是一个更详细的示例，演示了如何使用 `Task` 来并发执行多个异步任务，并处理任务结果和错误。

```swift
import Foundation

// 模拟一个异步函数
func fetchData(from url: String) async throws -> String {
    // 模拟网络延迟
    await Task.sleep(2_000_000_000)
    if url == "url2" {
        throw URLError(.badURL)
    }
    return "Data from \(url)"
}

let urls = ["url1", "url2", "url3"]

Task {
    do {
        // 使用 async let 并发执行多个异步任务
        async let data1 = fetchData(from: urls[0])
        async let data2 = fetchData(from: urls[1])
        async let data3 = fetchData(from: urls[2])

        // 使用 await 等待所有任务完成
        let allData = try await [data1, data2, data3]
        print(allData)
    } catch {
        print("Error: \(error)")
    }
}

// 保持主线程运行，以便异步任务有机会完成
RunLoop.main.run()
```

#### 2.3 Task 的高级用法

**1. 嵌套任务**

您可以在任务中创建子任务来进一步细化并发任务的执行。

```swift
Task {
    async let result1 = Task {
        await fetchData(from: "url1")
    }
    
    async let result2 = Task {
        await fetchData(from: "url2")
    }
    
    let results = await [result1, result2]
    print(results)
}
```

**2. 任务组**

任务组允许您动态地添加多个任务，并等待所有任务完成。

```swift
import Foundation

func fetchData(from url: String) async -> String {
    await Task.sleep(1_000_000_000)
    return "Data from \(url)"
}

let urls = ["url1", "url2", "url3"]

Task {
    await withTaskGroup(of: String.self) { group in
        for url in urls {
            group.addTask {
                return await fetchData(from: url)
            }
        }
        
        for await result in group {
            print(result)
        }
    }
}
```

**总结**

- **Task**：用于创建和管理异步任务，可以并发执行代码。
- **async let**：用于并发执行多个异步任务，并在稍后使用 `await` 获取结果。
- **取消任务**：通过 `Task.isCancelled` 检查任务是否被取消，并根据需要提前退出。
- **任务组**：用于动态地添加多个任务，并等待所有任务完成。

这些功能使 Swift 的并发模型变得强大且灵活，能够处理各种异步编程需求。如果有任何具体问题或需要进一步的解释，请随时告诉我。







#### 2.3其他

****

**chatGpt**

异步的for循环要服从AsyncSequence协议

```swift
import Foundation

// 定义异步数组类型
struct AsyncArray<Element>: AsyncSequence {
    typealias Element = Element
    
    private let array: [Element]
    
    init(_ array: [Element]) {
        self.array = array
    }
    
    struct AsyncIterator: AsyncIteratorProtocol {
        private let array: [Element]
        private var currentIndex = 0
        
        init(_ array: [Element]) {
            self.array = array
        }
        
        mutating func next() async throws -> Element? {
            guard currentIndex < array.count else { return nil }
            let element = array[currentIndex]
            currentIndex += 1
            await Task.sleep(100_000_000) // 模拟异步操作的延迟，100ms
            return element
        }
    }
    
    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(array)
    }
}

// 异步数组实例
let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
let asyncArray = AsyncArray(arr)

// 创建一个任务来运行异步代码
Task {
    do {
        for try await element in asyncArray {
            print(element)
        }
    } catch {
        print("Error: \(error)")
    }
}

// 确保程序不会立即退出
RunLoop.main.run()
```

**解释**

​	1.	**定义** **AsyncArray**：

​	•	AsyncArray 遵循 AsyncSequence 协议。

​	•	内部的 AsyncIterator 逐个异步返回数组元素，并模拟异步操作的延迟。

​	2.	**创建任务**：

​	•	使用 Task 来运行异步代码。

​	•	使用 for try await 循环遍历 AsyncArray，并打印每个元素。

​	3.	**保持主线程运行**：

​	•	RunLoop.main.run() 确保主线程保持运行，等待异步任务完成。在命令行工具或 Playground 环境中运行时，确保任务有足够的时间执行。



**运行效果**

确保在支持 Swift 并发的环境中运行上面的代码。运行时，您应该看到异步打印出的数组元素，每个元素之间有100毫秒的延迟。这样可以确认异步序列的实现是正确的。

****











### 3.并行调用异步函数

> **Note:**
>
> 1.用**aysnc let**定义的变量会马上执行，async let var = someAsyncFunc()
>
> 2.用**await** 会阻塞等待所有并发任务完成，然后等待他们的结果
>
> 3.顶层代码（即不在函数或方法内部的代码）不能直接使用 await，因为顶层代码必须在同步上下文中运行。这就是 Task 的作用。



使用 `await` 调用异步函数一次仅运行一段代码。当异步代码运行时，调用者会等待该代码完成，然后再继续运行下一行代码。例如，要从图库中获取前三张照片，您可以等待对 `downloadPhoto(named:)` 函数的三次调用，如下所示：

```swift
//Error coding:
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])


let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

这种方法有一个重要的缺点：虽然下载是异步的，并且可以在下载过程中进行其他工作，但一次只运行一次对 `downloadPhoto(named:)` 的调用。每张照片都会在下一张照片开始下载之前下载完毕。然而，这些操作不需要等待——每张照片都可以独立下载，甚至可以同时下载。

要调用异步函数并让它与其周围的代码并行运行，请在定义常量时在 `let` 前面写入 `async` ，然后写入 `await` 每次使用该常量时。

```swift
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])


let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

在此示例中，对 `downloadPhoto(named:)` 的所有三个调用都会启动，而无需等待前一个调用完成。如果有足够的系统资源，它们可以同时运行。这些函数调用都没有用 `await` 标记，因为代码不会挂起以等待函数的结果。相反，执行会继续，直到定义 `photos` 的行 - 此时，程序需要这些异步调用的结果，因此您可以编写 `await` 来暂停执行，直到所有三张照片完成下载。



您可以通过以下方式思考这两种方法之间的差异：

1. 当以下行中的代码取决于该函数的结果时，使用 `await` 调用异步函数。这将创建按顺序执行的工作。

2. 当您稍后在代码中不需要结果时，请使用 `async` - `let` 调用异步函数。这创造了可以并行执行的工作。

3. `await` 和 `async` - `let` 都允许其他代码在挂起时运行。

4. 在这两种情况下，您都可以使用 `await` 标记可能的暂停点，以指示如果需要，执行将暂停，直到异步函数返回。

您还可以在同一代码中混合使用这两种方法。



### 4.任务和任务组

任务是一个工作单元，可以作为程序的一部分异步运行。所有异步代码都作为某些任务的一部分运行。任务本身一次只做一件事，但是当您创建多个任务时，Swift 可以安排它们同时运行。

上一节中描述的 `async` - `let` 语法隐式创建子任务 - 当您已经知道程序需要运行哪些任务时，此语法效果很好。您还可以创建任务组（ `TaskGroup` 的实例）并向该组显式添加子任务，这使您可以更好地控制优先级和取消，并允许您创建动态数量的任务。

任务按层次结构排列。给定任务组中的每个任务都有相同的父任务，并且每个任务可以有子任务。由于任务和任务组之间存在显式关系，因此这种方法称为结构化并发。任务之间显式的父子关系有几个优点：

1. 在父任务中，您不能忘记等待其子任务完成。
2. 当为子任务设置更高的优先级时，父任务的优先级会自动升级。
3. 当父任务被取消时，其每个子任务也会自动取消。
4. 任务本地值有效且自动地传播到子任务。

这是下载照片的代码的另一个版本，可以处理任意数量的照片：

```swift
await withTaskGroup(of: Data.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        group.addTask {
            return await downloadPhoto(named: name)
        }
    }


    for await photo in group {
        show(photo)
    }
}
```

上面的代码创建一个新任务组，然后创建子任务来下载图库中的每张照片。 Swift 在条件允许的情况下同时运行尽可能多的这些任务。一旦子任务完成下载照片，就会显示该照片。无法保证子任务的完成顺序，因此该图库中的照片可以按任何顺序显示。

> **Note**:如果下载照片的代码可能会引发错误，您可以调用 `withThrowingTaskGroup(of:returning:body:)` 。

在上面的代码清单中，每张照片都会被下载然后显示，因此任务组不会返回任何结果。对于返回结果的任务组，您可以添加在传递给 `withTaskGroup(of:returning:body:)` 的闭包内累积其结果的代码。

```swift
let photos = await withTaskGroup(of: Data.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        group.addTask {
            return await downloadPhoto(named: name)
        }
    }


    var results: [Data] = []
    for await photo in group {
        results.append(photo)
    }


    return results
}
```

与前面的示例一样，此示例为每张照片创建一个子任务以下载它。与前面的示例不同， `for` - `await` - `in` 循环等待下一个子任务完成，将该任务的结果附加到结果数组中，然后继续等待，直到所有子任务完成。最后，任务组返回下载的照片数组作为其总体结果。




### 5.任务取消

Swift 并发使用协作取消模型。每个任务都会在执行过程中的适当位置检查它是否已被取消，并适当地响应取消。根据任务正在执行的工作，响应取消通常意味着以下情况之一：

- 抛出类似 `CancellationError` 的错误
- 返回 `nil` 或空集合
- 返回部分完成的工作

如果图片较大或网络较慢，下载图片可能需要很长时间。为了让用户停止这项工作，而不需要等待所有任务完成，任务需要检查取消，如果被取消则停止运行。任务可以通过两种方式执行此操作：通过调用 `Task.checkCancellation()` 类型方法，或通过读取 `Task.isCancelled` 类型属性。如果任务被取消，调用 `checkCancellation()` 会抛出错误；抛出任务可以将错误传播到任务之外，从而停止任务的所有工作。这样做的优点是易于实现和理解。为了获得更大的灵活性，请使用 `isCancelled` 属性，该属性允许您在停止任务时执行清理工作，例如关闭网络连接和删除临时文件。

```swift
let photos = await withTaskGroup(of: Optional<Data>.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        let added = group.addTaskUnlessCancelled {
            guard !Task.isCancelled else { return nil }
            return await downloadPhoto(named: name)
        }
        guard added else { break }
    }


    var results: [Data] = []
    for await photo in group {
        if let photo { results.append(photo) }
    }
    return results
}
```

上面的代码相对于之前的版本做了一些修改：

1. 每个任务都是使用 `TaskGroup.addTaskUnlessCancelled(priority:operation:)` 方法添加的，以避免取消后开始新的工作。
2. 每次调用 `addTaskUnlessCancelled(priority:operation:)` 后，代码都会确认新的子任务已添加。如果该组被取消， `added` 的值为 `false` — 在这种情况下，代码将停止尝试下载其他照片。
3. 每个任务在开始下载照片之前都会检查取消情况。如果已取消，任务将返回 `nil` 。
4. 最后，任务组在收集结果时会跳过 `nil` 值。通过返回 `nil` 处理取消意味着任务组可以返回部分结果（取消时已下载的照片），而不是丢弃已完成的工作。

> **Note:**要检查任务是否已从该任务外部取消，请使用 `Task.isCancelled` 实例属性而不是 type 属性。

对于需要立即通知取消的工作，请使用 `Task.withTaskCancellationHandler(operation:onCancel:)` 方法。例如：

```swift
let task = await Task.withTaskCancellationHandler {
    // ...
} onCancel: {
    print("Canceled!")
}


// ... some time later...
task.cancel()  // Prints "Canceled!"
```

使用取消处理程序时，任务取消仍然是协作性的：任务要么运行完成，要么检查取消并提前停止。由于取消处理程序启动时任务仍在运行，因此请避免在任务及其取消处理程序之间共享状态，这可能会产生竞争条件。



https://developer.apple.com/documentation/swift/task





### 6.非机构化并发

除了前面几节中描述的结构化并发方法之外，Swift 还支持非结构化并发。与任务组中的任务不同，非结构化任务没有父任务。您可以完全灵活地按照程序需要的任何方式管理非结构化任务，但您也对其正确性负全部责任。要创建在当前参与者上运行的非结构化任务，请调用 `Task.init(priority:operation:)` 初始值设定项。要创建不属于当前参与者的非结构化任务（更具体地称为分离任务），请调用 `Task.detached(priority:operation:)` 类方法。这两个操作都会返回一个您可以与之交互的任务 - 例如，等待其结果或取消它。

```swift
let newPhoto = // ... some photo data ...
let handle = Task {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.value
```

有关管理分离任务的更多信息，请参阅 [Task](https://developer.apple.com/documentation/swift/task) 。





### 7.Actors 演员

您可以使用任务将程序分解为独立的并发部分。任务彼此隔离，这使得它们同时运行是安全的，但有时您需要在任务之间共享一些信息。 Actor 可以让您在并发代码之间安全地共享信息。

与类一样，参与者也是引用类型，因此类是引用类型中值类型和引用类型的比较适用于参与者和类。与类不同，参与者一次只允许一个任务访问其可变状态，这使得多个任务中的代码可以安全地与参与者的同一实例进行交互。例如，这是一个记录温度的演员：

```swift
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int


    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

```

您可以使用 `actor` 关键字引入一个 actor，后跟一对大括号中的定义。 `TemperatureLogger` actor 具有该 actor 外部的其他代码可以访问的属性，并限制 `max` 属性，以便只有 actor 内部的代码可以更新最大值。

您可以使用与结构和类相同的初始化语法来创建参与者的实例。当您访问参与者的属性或方法时，您可以使用 `await` 来标记潜在的暂停点。例如：

```swift
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)
// Prints "25"
```

在此示例中，访问 `logger.max` 是一个可能的暂停点。因为参与者一次只允许一个任务访问其可变状态，所以如果另一个任务的代码已经与记录器交互，则该代码在等待访问属性时会挂起。


相反，作为参与者一部分的代码在访问参与者的属性时不会编写 `await` 。例如，以下是用新温度更新 `TemperatureLogger` 的方法：

```swift
extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}
```

`update(with:)` 方法已经在 actor 上运行，因此它不会使用 `await` 标记对 `max` 等属性的访问。此方法还显示了 Actor 一次只允许一个任务与其可变状态交互的原因之一：对 Actor 状态的某些更新会暂时破坏不变量。 `TemperatureLogger`actor 会跟踪温度列表和最高温度，并在您记录新测量值时更新最高温度。在更新过程中，在附加新测量值之后但在更新 `max` 之前，温度记录器处于临时不一致状态。防止多个任务同时与同一实例交互可以防止出现以下事件序列之类的问题：

1. 您的代码调用 `update(with:)` 方法。它首先更新 `measurements` 数组。
2. 在您的代码更新 `max` 之前，其他地方的代码会读取最大值和温度数组。
3. 您的代码通过更改 `max` 完成更新。

在这种情况下，在其他地方运行的代码将读取不正确的信息，因为它对 actor 的访问是在调用 `update(with:)` 的过程中交错进行的，而数据暂时无效。使用 Swift Actor 时可以防止此问题，因为它们一次只允许对其状态执行一项操作，并且该代码只能在 `await` 标记挂起点的位置中断。由于 `update(with:)` 不包含任何暂停点，因此其他代码无法在更新过程中访问数据。

如果参与者外部的代码尝试直接访问这些属性（例如访问结构或类的属性），您将收到编译时错误。例如：

```swift
print(logger.max)  // Error
```

在不写入 `await` 的情况下访问 `logger.max` 会失败，因为 actor 的属性是该 actor 的隔离本地状态的一部分。访问此属性的代码需要作为参与者的一部分运行，这是一个异步操作，需要编写 `await` 。 Swift 保证只有在 Actor 上运行的代码才能访问该 Actor 的本地状态。这种保证称为参与者隔离。

Swift 并发模型的以下方面共同作用，使共享可变状态的推理变得更加容易：

- 可能的挂起点之间的代码按顺序运行，不会被其他并发代码中断。
- 与参与者的本地状态交互的代码仅在该参与者上运行。
- 演员一次只运行一段代码。

由于这些保证，不包含 `await` 且位于 Actor 内部的代码可以进行更新，而不会存在程序中其他位置观察到暂时无效状态的风险。例如，下面的代码将测量的温度从华氏温度转换为摄氏度：

```swift
extension TemperatureLogger {
    func convertFahrenheitToCelsius() {
        measurements = measurements.map { measurement in
            (measurement - 32) * 5 / 9
        }
    }
}
```

上面的代码一次转换一个测量值数组。当地图操作正在进行时，某些温度以华氏度为单位，其他温度以摄氏度为单位。但是，由于没有代码包含 `await` ，因此此方法中没有潜在的挂起点。此方法修改的状态属于参与者，这可以防止代码读取或修改它，除非该代码在参与者上运行。这意味着在进行单位转换时，其他代码无法读取部分转换的温度列表。

除了在参与者中编写代码通过忽略潜在的挂起点来保护临时无效状态之外，您还可以将该代码移至同步方法中。上面的 `convertFahrenheitToCelsius()` 方法是同步方法，因此保证永远不会包含潜在的挂起点。该函数封装了暂时使数据模型不一致的代码，并且使任何阅读代码的人都更容易认识到在完成工作恢复数据一致性之前没有其他代码可以运行。将来，如果您尝试向此函数添加并发代码，引入可能的挂起点，您将得到编译时错误，而不是引入错误。



### 8. Sendable Types 可发送类型

任务和参与者让您可以将程序分成可以安全并发运行的部分。在任务或参与者的实例内部，程序中包含可变状态（如变量和属性）的部分称为并发域。某些类型的数据无法在并发域之间共享，因为该数据包含可变状态，但它不能防止重叠访问。

可以从一个并发域共享到另一个并发域的类型称为可发送类型。例如，它可以在调用 actor 方法时作为参数传递，或者作为任务结果返回。本章前面的示例没有讨论可发送性，因为这些示例使用简单的值类型，这些类型始终可以安全地共享在并发域之间传递的数据。相反，某些类型在并发域之间传递并不安全。例如，当您在不同任务之间传递该类的实例时，包含可变属性并且不序列化对这些属性的访问的类可能会产生不可预测且不正确的结果。

您可以通过声明符合 `Sendable` 协议来将类型标记为可发送。该协议没有任何代码要求，但确实有 Swift 强制执行的语义要求。一般来说，类型可通过三种方式发送：

- 该类型是值类型，其可变状态由其他可发送数据组成 - 例如，具有可发送的存储属性的结构或具有可发送的关联值的枚举。
- 该类型没有任何可变状态，其不可变状态由其他可发送数据组成 - 例如，仅具有只读属性的结构或类。
- 该类型具有确保其可变状态安全的代码，例如标记为 `@MainActor` 的类或在特定线程或队列上序列化对其属性的访问的类。

For a detailed list of the semantic requirements, see the [`Sendable`](https://developer.apple.com/documentation/swift/sendable) protocol reference.
有关语义要求的详细列表，请参阅 `Sendable` 协议参考。

有些类型始终是可发送的，例如仅具有可发送属性的结构和仅具有可发送关联值的枚举。例如：

```swift
struct TemperatureReading: Sendable {
    var measurement: Int
}


extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}


let logger = TemperatureLogger(label: "Tea kettle", measurement: 85)
let reading = TemperatureReading(measurement: 45)
await logger.addReading(from: reading)
```

由于 `TemperatureReading` 是一个仅具有可发送属性的结构，并且该结构未标记为 `public` 或 `@usableFromInline`，因此它是隐式可发送的。以下是隐含符合 `Sendable` 协议的结构版本：

```swfit
struct TemperatureReading {
    var measurement: Int
}
```

要显式地将类型标记为不可发送，覆盖对 `Sendable` 协议的隐式一致性，请使用扩展：

```swift
struct FileDescriptor {
    let rawValue: CInt
}


@available(*, unavailable)
extension FileDescriptor: Sendable { }
```

上面的代码显示了 POSIX 文件描述符包装器的一部分。尽管文件描述符接口使用整数来识别打开的文件并与之交互，并且整数值是可发送的，但跨并发域发送文件描述符并不安全。

在上面的代码中， `FileDescriptor` 是一个满足隐式可发送条件的结构。但是，该扩展使其无法遵守 `Sendable` ，从而导致该类型无法发送。
