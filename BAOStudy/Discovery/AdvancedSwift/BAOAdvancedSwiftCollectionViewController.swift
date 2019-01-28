//
//  BAOAdvancedSwiftCollectionViewController.swift
//  BAOStudy
//
//  Created by baochuquan on 2019/1/28.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation

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
    }

}
