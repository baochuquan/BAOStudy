//
//  BAOAdvancedSwiftCollectionViewController.swift
//  BAOStudy
//
//  Created by baochuquan on 2019/1/28.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation

// ---------------------------------------------------------------------------------------------------------------------
// 序列类型

// Sequence, Collection 协议
// Sequence 协议是集合类型结构中的基础。一个序列（Sequence）代表的是一系列具有相同类型的值。

// 满足 Sequence 协议的要求十分简单，只需要提供一个返回迭代器（iterator）的 makeIterator() 方法
/*
protocol Sequence {
    associatedtype Iterator: IteratorProtocol
    func makeIterator() -> Iterator
    ...
}
 */

// Sequence 通过创建一个迭代器来提供对元素的访问。迭代器每次产生一个序列的值，并且当遍历序列时对遍历状态进行管理。
// 在 IteratorProtocol 协议中唯一的一个方法是 next()，该方法需要在每次被调用时返回序列中的下一个值。当序列被耗尽时，应返回 nil
/*
protocol IteratorProtocol {
    associatedtype Element
    mutating func next() -> Element?
}
 */
// 关联类型 Element 指定了迭代器产生的值的类型。

/*
 public protocol Sequence {
    associatedtype Element
    associatedtype Iterator: InteratorProtocol where Iterator.Element == Element
    ...
 }
 */

/*
var iterator = someSequence.makeIterator()
while let element = iterator.next() {
    doSomething(with: element)
}
 */


struct ConstantIterator: IteratorProtocol {
    typealias Element = Int
    mutating func next() -> Int? {
        return 1
    }
}

struct FibsIterator: IteratorProtocol {
    var state = (0, 1)
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

struct PrefixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index

    init(string: String) {
        self.string = string
        offset = string.startIndex
    }

    mutating func next() -> Substring? {
        guard offset < string.endIndex else { return nil }
        offset = string.index(after: offset)
        return string[..<offset]
    }
}

struct PrefixSequence: Sequence {
    let string: String
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

// 基于函数的迭代器和序列
// AnyIterator 还有一个初始化方法，即直接接受一个 next 函数作为参数
func fibsIterator() -> AnyIterator<Int> {
    var state = (0, 1)
    return AnyIterator {
        let upcommingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcommingNumber
    }
}

// 序列和集合的重要区别：序列可以是无限的，集合不行

// Sequence 协议并不关心遵守协议的类型是否会在迭代后将序列的元素销毁。
// 只有 Collection 协议能保证多次进行迭代是安全的，Sequence 中并没有进行保证

// 为什么不能直接吧 IteratorProtocol 的功能包含到 Sequence 中去？
// 对于那种破坏性消耗的序列来说，的确可以，这类序列自己持有迭代状态，并且会随着遍历而发生改变；
// 但对于像斐波那契序列的稳定序列来说，它的内部状态时不能随着 for 循环而改变的，需要独立的遍历状态，这就是迭代器所提供的。makeIterator 方法的目的就是创建这样一个遍历状态

// Sequence 还有另外一个关联类型：SubSequence
/*
protocol Sequence {
    associatedtype Element
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Element
    associatedtype SubSequence
}
 */
// 在返回原序列的切片的操作中，SubSequence 作为返回值的子类型，这类操作包括：
// prefix, suffix
// prefix(while:)
// dropFirst, dropLast
// drop(while:)
// split

// 链表
enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)    // indirect 表示枚举值 node 应该被看做引用
}

extension List {
    // 在链表前添加一个值为 `x` 的节点，并返回该链表
    func cons(_ x: Element) -> List {
        return .node(x, next: self)
    }
}

extension List: ExpressibleByArrayLiteral {             // 通过 ExpressibleByArrayLiteral 支持，可以使用数组字面量的方式来初始化一个链表
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { (partialList, element) in
            partialList.cons(element)
        }
    }
}

extension List {
    mutating func push(_ x: Element) {
        self = self.cons(x)
    }

    mutating func pop() -> Element? {
        switch self {
        case .end: return nil
        case let .node(x, next: tail):
            self = tail
            return x
        }
    }
}

// 让 List 遵守 Sequence
extension List: IteratorProtocol, Sequence {
    mutating func next() -> Element? {
        return pop()
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// 集合类型

// 集合类型 Collection 指的是那些稳定的序列，能够被多次遍历且保持一致。
// Collection 协议是建立在 Sequence 协议上的。除了从 Sequence 继承了全部方法以外，得益于可以获取指定位置的元素以及稳定迭代的保证。

protocol Queue {
    associatedtype Element
    mutating func enqueue(_ newElement: Element)
    mutating func dequeue() -> Element?
}

struct FIFOQueue<Element>: Queue {
    private var left: [Element] = []
    private var right: [Element] = []
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// 遵守 Collection 协议

// Collection 协议有六个关联类型，四个属性，七个实例方法，两个下标方法
/*
protocol Collection: Sequence {
    associatedtype Element
    associatedtype Index: Comparable
    associatedtype IndexDistance: SignedInteger = Int
    associatedtype Iterator: IteratorProtocol = IndexingIterator<Self> where Iterator.Element == Element
    associatedtype SubSequence: Sequence
    associatedtype Indices: Sequence = DefaultIndices<Self>
    var first: Element? { get }
    var indices: Indices { get }
    var isEmpty: Bool { get }
    var count: IndexDistance { get }
    func makeIterator() -> Iterator
    func prefix(through: Index) -> SubSequence
    func prefix(upTo: Index) -> SubSequence
    func suffix(from: Index) -> SubSequence
    func distance(from: Index, to: Index) -> IndexDistance
    func index(_: Index, offsetBy: IndexDistance) -> Index
    func index(_: Index, offsetBy: IndexDistance, limitedBy: Index) -> Index?
    subscript(position: Index) -> Element { get }
    subscript(bounds: Range<Index>) -> SubSequence { get }
}
 */

class BAOAdvancedSwiftCollectionViewController: BAOBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        var iterator = ConstantIterator()
//        while let x = iterator.next() {
//            print(x)
//        }

        print("-------------------")
        for prefix in PrefixSequence(string: "Hello") {
            print(prefix)
        }

        // 迭代器和值语义
        print("-------------------")
        let seq = stride(from: 0, to: 10, by: 1)
        var i1 = seq.makeIterator()
        print(i1.next())
        print(i1.next())
        var i2 = i1
        print(i1.next())
        print(i1.next())
        print(i2.next())
        print(i2.next())
        // AnyIterator 是一个对别的迭代器进行封装的迭代器，可以用来将原来的迭代器的具体类型抹消掉。
        var i3 = AnyIterator(i1)
        var i4 = i3
        print(i3.next())
        print(i4.next())
        print(i3.next())
        print(i3.next())
        print(i1.next())
        print(i3.next())

        // 基于函数的迭代器和序列
        print("-------------------")
        let fibsSequence0 = AnySequence(fibsIterator)
        print(Array(fibsSequence0.prefix(10)))
        // sequence(first:next:)
        // sequence(state:next:)
        let fibsSequence2 = sequence(state: (0, 1), next: { (state: inout (Int, Int)) -> Int? in
            let upcomingNumber = state.0
            state = (state.1, state.0 + state.1)
            return upcomingNumber
        })
        print(Array(fibsSequence2.prefix(10)))

        // 不稳定序列
        print("-------------------")
        let standardIn = AnySequence {
            return AnyIterator {
                readLine()
            }
        }
        let numberedStdIn = standardIn.enumerated()
        for (i, line) in numberedStdIn {
            print("\(i+1):\(line)")
        }

        // 链表
        print("-------------------")
        let emptyList = List<Int>.end
        let oneElementList = List.node(1, next: emptyList)
        let list0 = List<Int>.end.cons(1).cons(2).cons(3)
        let list1: List = [3, 2, 1]
        print("-------------------")
        var stack: List<Int> = [3, 2, 1]
        var a = stack
        var b = stack
        a.pop()
        a.pop()
        a.pop()
        b.pop()
        b.pop()
        b.pop()
        stack.pop()
        stack.pop()
        stack.pop()
        print("-------------------")
        let list: List = ["1", "2", "3"]
        for x in list {
            print("\(x)", terminator: "->")
        }
        list.joined(separator: ",")
        list.contains("2")
        list.flatMap { Int($0) }
        list.elementsEqual(["1", "2", "3"])
    }

}
