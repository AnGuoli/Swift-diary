//: Playground - noun: a place where people can play

import UIKit
/*
我们提到过使用 Framework 的方式来组织和分离代码。除了能够得到更清晰的架构层次和方便的代码重用外，我们还能通过这个方式得到一个额外的好处，那就是在项目的 Playground 中使用这些代码。

一般来说，最主要的使用 Playground 的方式可能是建立单独的 Playground，然后在其中实验一些小的代码片段和 API。但是在实际开发中，我们面临的更多的是针对具体项目的问题。如果我们想在单独的 Playground 中使用我们已经写的类或者方法的话，我们只能将这些类和方法的代码复制到 Playground 中，然后再进行依赖于它们的实验。这样的做法非常麻烦：迅速地确定所有代码的依赖关系本身就不是一件容易的事情，很可能你需要多次复制和检查才能最终架立起一套可用的环境；另一个问题是你需要时刻记住，Ctrl + C 和 V 在绝大多数情况下都是恶魔，想想如果你的项目代码之后发生了改变，你要怎么样才能让 Playground 里的内容和它们同步呢？从头开始再来一遍？显然这么做会是个悲剧。

Playground 其实是可以用在项目里的，通过配置，我们是可以做到让 Playground 使用项目中已有的代码的。直接说结论的话，我们需要满足以下的一些条件：

Playground 必须加入到项目之中，单独的 Playground 是不能使用项目中的已有代码的；

最简单的方式是在项目中使用 File -> New -> File... 然后在里面选择 Playground。注意不要直接选择 File -> New -> Playground...，否则的话你还需要将新建的 Playground 拖到项目中来。

想要使用的代码必须是通过 Cocoa (Touch) Framework 以一个单独的 target 的方式进行组织的；

编译结果的位置需要保持默认位置，即在 Xcode 设置中的 Locations 里 Derived Data 保持默认值；

如果是 iOS 应用，这个框架必须已经针对 iPhone 5s Simulator 这样的** 64 位的模拟器**作为目标进行过编译；

iOS 的 Playground 其实是运行在 64 位模拟器上的，因此为了能找到对应的符号和执行文件，框架代码的位置和编译架构都是有所要求的。
在满足这些条件后，你就可以在 Playground 中通过 import 你的框架 module 名字来导入代码，然后进行使用了。
*/