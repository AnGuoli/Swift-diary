//: Playground - noun: a place where people can play

import UIKit

//在 Swift 中有一类很有意思的写法，可以让我们不直接使用实例来调用这个实例上的方法，而是通过类型取出这个类型的某个实例方法的签名，然后再通过传递实例来拿到实际需要调用的方法。比如我们有这样的定义：
/*
class MyClass {
    func method(number: Int) -> Int {
        return number + 1
    }
}

*/


//想要调用 method 方法的话，最普通的使用方式是生成 MyClass 的实例，然后用 .method 来调用它：

let object = MyClass()
let result = object.method(1)

// result = 2
//这就限定了我们只能够在编译的时候就决定 object 实例和对应的方法调用。其实我们还可以使用刚才说到的方法，将上面的例子改写为：
/*
let f = MyClass.method
let object = MyClass()
let result = f(object)(1)

这种语法看起来会比较奇怪，但是实际上并不复杂。Swift 中可以直接用 Type.instanceMethod 的语法来生成一个可以柯里化的方法。如果我们观察 f 的类型 (Alt + 单击)，可以知道它是：

f: MyClass -> (Int) -> Int
其实对于 Type.instanceMethod 这样的取值语句，实际上刚才

let f = MyClass.method
做的事情是类似于下面这样的字面量转换：

let f = { (obj: MyClass) in obj.method }
//这下就不难理解为什么上面的调用方法可以成立了。

//这种方法只适用于实例方法，对于属性的 getter 或者 setter 是不能用类似的写法的。另外，如果我们遇到有类型方法的名字冲突时：
*/

class MyClass {
    func method(number: Int) -> Int {
        return number + 1
    }
    
    class func method(number: Int) -> Int {
        return number
    }
}
//如果不加改动，MyClass.method 将取到的是类型方法，如果我们想要取实例方法的话，可以显式地加上类型声明加以区别。这种方式不仅在这里有效，在其他大多数名字有歧义的情况下，都能很好地解决问题：

let f1 = MyClass.method
// class func method 的版本

let f2: Int -> Int = MyClass.method
// 和 f1 相同

let f3: MyClass -> Int -> Int = MyClass.method
// func method 的柯里化版本

