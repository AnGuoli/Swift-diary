
# Swift笔记(二)

### Swift原始数据类型
- Swift数据类型包括: 整型，浮点型，布尔型，字符，字符串，元组，集合，枚举，结构体
- 这些类型都赋值给函数传递时的方式不同，可以分为:值类型和引用类型。值类型就是创建一个副本，把副本赋值传递过去，这样在函数的调用过程中不会影响原始类型。引用类型就是把数据本身的引用赋值或传递过去，这样函数的调用过程中影响的原始数据

#### 整型
```
//整型8 16 32 64 位形式的有符号以及无符号的整数

print("UInt8 range: \(UInt8.min) ~ \(UInt8.max)")

print("Int8 range: \(Int8.min) ~ \(Int8.max)")

print("UInt range: \(UInt.min) ~ \(UInt.max)")

print("UInt64 range: \(UInt64.min) ~ \(UInt64.max)")

print("Int64 range: \(Int64.min) ~ \(Int64.max)")

print("Int range: \(Int.min) ~ \(Int.max)")

```

-  代码例子是通过整数的min和max属性计算各个类型的范围。min属性获得当前整数的最小值，max属性获得当前最大值
-  我们声明通过变量，有时明确指定数据类型，有时没有指定

```
var ageForStudent = 30

var scoreForStudent: Int = 90

```

- 变量ageForStudent没有指定任何数据类型，把30赋值给它，30默认表示Int类型的30，因此ageForStudent类型就被

#### 浮点型
- 浮点型主要用来储存小数值，也可以用来储存范围较大的整数。它分为浮点数(float)和双精度浮点数(double)两种，双精度浮点数所用的内存空间比浮点数多，可表示的数值范围和精度也比较大
- `float`  32位浮点数， 不需要很多大的浮点数使用
-   `double`  64 位浮点数      默认的浮点数

```
var myMoney: Float = 300.5
var yourMoney: Double = 360.5
let pi = 3.14159
```
#### 数字表达式

- 整型和浮点型都表示数字类型，那么在给这些类型的变量或常量赋值时，应该如何表示这些数字的值呢?上述使用30表示整数Int，使用3.14159表示浮点数Double,在程序代码中，数字比较丰富的分别介绍一下数字和指数表示方式

#### 进值数字表示

- 如果一个整数变量赋值，使用二进制，八进制，十六制表示
- 二进制， 以`0b`为前缀， `0`是阿拉伯数字，不要误以为是英文字母`o`,`b`是英文小写字母，不能大写
- 八进制,以`0o`,第一个是字符阿拉伯数字`0`,第二个字符是英文小写字母`o`，不能大写
- 十六位进制数，以`0x`为前缀，第一个字母是阿拉伯数字`0`，第二个字符是英文小写字母`x`，不能大写

```
let decimalInt = 28
let bingaryInt = 0b11100
let octalInt = 0o34
let hexadecimalInt = 0x1C

```

#### 指数表示
- 进行数字计算时候，往往会调用表示的数值，如果采用十进制表示指数，我们需要使用大写或者小写的e表示幂，e2表示10^2

比如

```
var myMoney = 3.36e2
var interesRate = 1.56e-2

```

- 十六进制表示指数，需要p表示幂，十进制不同是 p2表示2^2，由于十六进制换算起来比较麻烦，因为我们推荐使用十进制表示

#### 其他表示
- 在swift中，为了阅读方便，整数和浮点数均可添加多个0或下划线提高可读性，两种格式不会影响实际值

```
var interseRate = 000.0156
var myMoney = 3_360_000
```

## 数字类型之间的转换

- 对于类型的检查非常严格，不同类型之间不能随意转换

#### 整型之间的转换
- c oc java语言，整型之间有两种转换方法
- 从小范围到大范围转换自定的】
- 从大范围到小范围需要强制类型转换，有可能造成，类型精度的丢失

```
let hisstoryScore: UInt8 = 90

let englishScore: UInt16 = 130

//这句代码是错误的
let totalScore  = hisstoryScore + englishScore


let totalScore  = UInt16(hisstoryScore) + englishScore


let totalScore  = hisstoryScore + UInt8(englishScore)


```

*上面代码中声明和初始两个常量`hisstoryScore`和`englishScore `,将他们赋值给`totalScore`，报错原因是因为没有说明类型，所以他们之间不能进行相加*

- 一种把UInt8 的historyScore转换为UInt16类型，由于从小范围转换为大范围，这种转换时安全是
- 另一种是把UInt16的englishScore转换为Unit8类型，由于从大到小范围类型为小范围数，这种转换是不安全的，如果转换的数比较大的可能会造成精度的丢失
- UInt16（historyScore）和Uint8(englishScore)事实上是构造函数。整型，浮点型，布尔型，字符，字符串，和集合等类型本质上都是结构体类型，结构体可以有结构函数，通过构造函数创建并初始话实例

### 整型浮点型之间的转换

```
let historyScore: Float = 90.6

let englishScore: UInt16 = 130

//这句代码是错误的
let totalScore  = historyScore + englishScore


let totalScore  = historyScore + Float(englishScore)


let totalScore  = UInt16(historyScore) + englishScore

```

- `historyScore `变量类型是float, `englishScore `变量还是UInt16类型,不能直接进行计算，结果有错误


## 布尔型
- bool有两个值，`true`和`false`

```
var is 🐶 = true
var is 🐱: Bool = false

```

- 两个表现形式看是一个图像，实际上在计算内存是Unicode编码，整型和浮点型等其他类型一样，如果没有指定数据类型，swift自动可以推断类型

```
if (is 🐶) {

    print("是的，它是狗")

} else {

    print("不，他是其他")

}

```

## 元组类型

- *元组(tuple)这个词很抽象，它是一种数据结构，在数学中应用广泛，元祖是关系数据库中的基本概念，元祖表中一条记录，每列就是一个字段，因此在二维码表，元祖也成为记录*
- *元祖将多个相互关联的组值合并多个单个值，以便管理和计算，元祖内的值可以任意类型，各字段类型不必相同*

```
学号(id)        姓名(name)        英语成绩(english_score)     语文成绩(chinese_score)
1001   张三   30    90
1002   李四   32    80
```

- 我们可以定义一个元祖`Student`元组，那么使用swift语法表示就是

```
//第一种写法
("1001", "张三",30,90)
//第二种写法
(id: "1001", name:"张三", english_score: 30, chinese_score:90)
```

- *这两种写法都表示一个叫“张三”的学生的元组，第一种写法代码可读性不太好，不太清楚说明，或者要说明内容和意思*

```
var student1 = ("10001","张三", 30, 90)
print("学生: \(student1.1) 学号: \(student1.0) 语文成绩: \(student1.2) 语文成绩: \(student1.3)")

var student2 = (id: "1002", name:"李四", english_score: 32, chinese_score:80)
print("学生: \(student2.1) 学号: \(student2.0) 语文成绩: \(student2.2) 语文成绩: \(student2.3)")

let (id1, name1, age1,score1) = student1

print("学生: \(name1) 学号: \(id1) 语文成绩: \(age1) 语文成绩: \(score1)")

let (id2,name2,_,_) = student2

print("学生: \(name2) 学号:\(id2)")

```
- 虽然从技术角度可以将无关值放到元组中，但是这样的元组没有任何实际意义

## 可选类型

- swift所有的数据类型声明的变量或者常量都是不能为空值

#### 可选类型的概念

```
var n1: Int = 10      
ni = nil                1
let str: String = nil   2
```

- 1和2会发生编译错误，因为Int和String类型不能接受nil，但是程序运行过程中赋值给nil在所难免。我们查询数据库记录，没有查询符合条件的数据是很正常的事情，因此，swift为每一种类型提供了可选类型optional，即某个类型后面加上问号或者感叹号
- 修改后的代码

```
var n1: Int? = 10
n1 = nil
let str: String! =nil

```
- Int?和String!都是原有的类型int和string的可选类型，他们可以接受nil


### 可选类型值的拆包
- 在可选类型之后的问号(?)或者感叹号(!)有什么样的区别，这是可选类型的拆包有关，拆包是将可选类型变成普通类型，如果我们之间打印非空的可选类型值

```
var n1: Int? = 10
print(n1)
```
- 输出的结果为option（10）,而非.说明n1不是普通类型，也不能不同值进行计算，所以计算表达式n1 + 100会发生编译错误

```
var n1: Int? = 100
print(n1 + 100)//编译错误

```
- *因此，对可选类型值进行拆包是必要的，拆包分为显示拆包和隐形拆包，使用问号声明的可选类型拆包时需要使用感叹号，这种拆包成为显式拆包；使用感叹号声明的可选类型字拆包时可以不适用感叹号，这种表示成为隐拆包*

```
var n1: Int? = 10
print(n1! + 100)

var n2: Int! = 100
print(n2 + 100)

```

- n1!为显示拆包，因为n1在声明的时候Int可选类型，n2为隐拆包因为n2声明的时候是Int！可选类型。实际上隐拆包可以带有感叹号


## 可选绑定

- 在不能保证可选类型值是否为非空之前最好不要拆包，否则有可能运行下面的最经典错若

`fatal error: unexpectedlu found nil while unwrapping an optional value`

```
func divide(n1: Int, n2: Int) ->Double? {
    if n2 == 0 {
        return nil
    }
    return Double(n1)/Double(n2)

}
let result: Double? = divide(100, n2: 200)

```

- 使用divide函数进行除法运算，在第二个参数n2为0的情况下，函数返回为空值nil，所以获得函数返回值要么有值，我们为空值，为了能够接受返回值为空值nil的情况下，我们需要返回值类型声明可选类型

```
if let result = divide(100, n2: 0) {
    print(result)
    print("Sucess.")
}else{
//    编译错误
//    print(result)
    print("fail")
}
```
- 这种可选类型在if或者whiel语句中赋值并进行判断写法成为可选绑定，可选绑定过程中做了两件事情：首先判断表达式是否为空值nil；如果为非空值则将可选类型拆包，并赋值给一个常量。常量的作用域是if或者while语句true的分支

## Swift原生字符串
#### Unicode编码
- Swift是一种现代语言，它采用UNicode编码，它的字符几乎覆盖了我们所有知道一切的字符。表示一个字符可以使用字符本身，也可以使用它的Unicode编码，看看代码

```
let andSign1: Character = "&"
let andSign2: Character = "\u{26}"

let lamda1: Character = "@"
let lamda2: Character = "\u{03bb}"

let simle1: Character = "😀"
let simle2: Character = "\u{0001f603}"
```
- oc语言中，字符是放在单引号之间，然而在swift中，我们不能使用单引号方式，必须使用双引导把字符括起来。swift也是一样
- 在swift中字符串类型是`Character`其他类型相识声明类型，我们可以指定变量或者常量类型为`Character`，但是如果省略`Character`类型声明，编译器自动推断出的类型不是字符类型，而是字符串类型，因此声明语句中，angsing1不是字符类型而是字符串类型

`let andSign1 = "&"`

- 字符类型表示时候双引导中一定是一个字符

- //编译错误

`let andsign1: Character = "&A"`

- 常量andsign1和andsign2保存有字符，它的unicode编码是0026，属于单字节编码，使用\u{26}表示。常量lamda1和lamda2一样1有字符，属于双字节编码，使用\u{03bb}表示.常量smile1和simle2保存有笑脸的符号，它的Unicode编码是0001f603，属于双字节编码，使用\u{0001f603}表示，这些编码很难记住

### 转义符
- swift中，为了表示一些特殊字符，前面要加上反斜杠`\`
- 代码示例

```
let specialCharTab1 = "Hello\tWrold"
print("specialCharTab1:\(specialCharTab1)")

let specialCharNewLine = "Hello\nWrold"
print("specialCharNewLine:\(specialCharNewLine)")


let specialCharReturn = "Hello\rWrold."
print("specialCharReturn:\(specialCharReturn)")


let specialCharWQuotationMark = "Hello\"Wrold\"."
print("specialCharWQuotationMark:\(specialCharWQuotationMark)")

let specialCharAppStore = "Hello\'Wrold\'."
print("specialCharAppStore:\(specialCharAppStore)")

let specialCharFeverseSolidus = "Hello\\Wrold."
print("specialCharFeverseSolidus:\(specialCharFeverseSolidus)")

```
## 创建字符串

- 在swift中字符串类型是string,事实上string是一个结构体

```
在OS X和ios应用开发中有一个基础框架 Foundation框架，这个框架也有字符串NSString  NSString是一个类，而并非string结构体。因此提到字符串时应该明确swift中原生的字符串string，还是foundation框架中的字符串NSString
```

- 要创建一个字符串，我们可以使用字符串直接赋值，也可以通过结构体的构造函数创建

```
let 🐶 = "🐗🐗🐗🐗🐗🐗🐗🐗"

print("已经上船的小动物数: \(🐶.characters.count)")

let 狗 = "🐶"
let 熊 = "🐼"

let 🐼 = 熊 + 狗

let emptyString1  = ""
let emptyString2  = String

```

- 由于swift的标识符也可以都是Unicode编码,所以上述代码可以用使用中文汉字，两个图标作为符号为常量名，除了直接赋值字符串，我们可以通过加号把多个字符拼接成一个字符串`emptyString1 `,`emptyString2`常量被赋值为空的字符串，其中string（）是调用stirng的构造函数。

## 可变字符串

- 字符串有两种: 不可变字符串和可变字符串，二者的区别是不可变字符串不能进行拼接，追加等修改
- let 声明的字符串常量是不可变字符串，var声明的字符串变量是可变字符串
- 提示 Foundation框架也可变字符串类型 NSString NSMutableString 继承于NSString


## 字符串拼接
- swift中string字符串之间的拼接可以使用+和=运算符，String字符串拼接可以使用是String的append方法
- 代码示例

```
var 🐶 = "🐴🐗🐱🐗🐗🐗🐗"

🐶 = 🐶 + "🐴"
🐶 += "🐱"

var flower: Character = "🐗"

🐶.append(flower)
print("诺亚方舟乘客: \(🐶.characters.count)")

let number = 9
let total = "\(number) 加 10 等 于 \(Double(number) + 10"

```

- \()语句非常强大，可以将任何数据类型拼接起来，它和print函数结合起来使用，可以完全代替Foundation框架中Nslog函数。NLog函数在输出的时候需要拼接数据类型指定格式说明符，
- `Nslog("诺亚舟乘客：%i", 🐶.characters.cpunt)`

### 字符串插入，删除和替换
- 可变字符串还可以插入，删除和替换，String提供几个方法可以帮助实现这些操作

```
//在索引位置插入字符
func insert(_ newElement: Character, atIndex i: Index)

//在索引位置删除字符
func removeAtIndex(_ i: Index) ->Character

//删除指定范围内的字符串
func removeRange(_ subRange: Range<Index>)

//使用字符串或者替换指定范围内的字符串
func replaceRange(_ subRange: Range<Index>, with newElements: String)

/*
 Index是索引类型，Range是范围类型，Range<Index>是范围类型的index泛型表示
 */

var str = "obejctive-c and swift"
print("原始字符串:\(str)")

//插入字符
str.insert(".", atIndex: str.endIndex)
print("插入.字符后: \(str)")

str.removeAtIndex(str.endIndex.predecessor())
print("删除.字符后: \(str)")

var startIndex = str.startIndex
var endIndex = startIndex.advancedBy(9)
var range = startIndex...endIndex
//删除范围
str.removeRange(range)
print("删除范围后: \(str)")

startIndex = str.startIndex
endIndex = startIndex.advancedBy(0)
range = startIndex...endIndex
//替换范围
str.replaceRange(range,with: "C++")
print("替换范围后: \(str)")

```



- 代码解释
- *使用insert(_ :atindex)函数插入“.”字符,removeAtIndex(_:)行删除指定字符，PredEcessor()方法可以返回索引的前有个索引值还有success()，它可以返回索引后的一个索引值*

## 字符串比较
- 字符串类型和浮点型一样，都可以进行比较大小，比较的依据是Unicode编码值的大小

```
🐶 Unicode: 1F43C
🐱 Unicode: 1F431

```
- 我们比较`1F43C `和`1F431 `大小就是看Unicode，因此🐶>🐱

```
let 狗 = "🐶"
let 猫 = "🐱"
	if 狗 > 猫 {
	print("🐶 >🐱")
}else{
	print("🐶 <🐱")
}
```

- 这只是动物之间的相互比较大小是没有任何的实际意思，但是比较A ,B ，C有意思
- 除了比较大小，我们需要比较字符串是否相等

```
let 🐶 = 狗 + 猫

if 🐱 == "🐶🐱" {
    print("🐶 是 🐶🐱 ")
}else{
    print("🐶 不是 🐶🐱 ")

}

let emtyString1 = ""
let emtyString2 = String()

if emtyString1 == emtyString2 {
    print("相等")
}else{
    print("不相等")
}

```


- swift中字符Character和字符串String都是结构体类型，只能使用==或！=比较是否相等或不等，而foundation框架中NSString字符串的比较是否相等于或不等，则需要使用 ====或者！==运算符

## 前缀和后缀比较
- 字符串比较中有时候比较前缀或后缀，比如，如果判断某个文件夹特定类型的文件，我们就要判断它们的扩展名，这就需要判断他的后缀，比较后缀可以使用string字符串方法，如果需要判断某个文件夹特定字符串开头，我们就可以使用string字符串来判断后缀

```
let docFolder = ["java.docx","javaBean.docx","oc.docx","swift.docx"]

var wordDocCount = 0
for doc in docFolder {
    if doc.hasSuffix(".docx"){
        ++wordDocCount
    }
}
print("文件夹world文档是: \(wordDocCount)")

var javaDocCount = 0
for doc in docFolder {
    let lowecaseDoc = doc.lowercaseString
    if lowecaseDoc.hasSuffix("java"){
        ++javaDocCount
    }

}
print("文件夹world文档是: \(javaDocCount)")

```
- 初始话数组变量docFloder,for in语句遍历数组集合，这个过程就是从集合docFloder中取出一个元素保存在doc变量中
