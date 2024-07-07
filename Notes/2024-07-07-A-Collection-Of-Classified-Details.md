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

unknown 
