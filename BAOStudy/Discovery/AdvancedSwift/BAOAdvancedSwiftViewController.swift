//
//  BAOAdvancedSwiftViewController.swift
//  BAOStudy
//
//  Created by baochuquan on 2019/1/15.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation

fileprivate extension Sequence {
    func last(_ predicate: (Element) -> Bool) -> Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}

// -------------------------------------------------------------------------------------------------------------------

enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}

extension List {
    func cons(_ x: Element) -> List {
        return .node(x, next: self)
    }
}

extension List: ExpressibleByArrayLiteral {
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

extension List: IteratorProtocol, Sequence {
    mutating func next() -> Element? {
        return pop()
    }
}

// -------------------------------------------------------------------------------------------------------------------

// 集合类型

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

//protocol Collection: Sequence {
//    associatedtype Element
//    associatedtype Index: Comparable
//    associatedtype IndexDistance: SignedInteger = Int
//    associatedtype Iterator: IteratorProtocol = IndexingIterator<Self> where Iterator.Element == Element
//    associatedtype SubSequence: Sequence
//    associatedtype Indices: Sequence = DefaultIndices<Self>
//    var first: Element? { get }
//    var indices: Indices { get }
//    var isEmpty: Bool { get }
//    var count: IndexDistance { get }
//    func makeIterator() -> Iterator
//    func prefix(through: Index) -> SubSequence
//    func prefix(upTo: Index) -> SubSequence
//    func suffix(from: Index) -> SubSequence
//    func distance(from: Index, to: Index) -> IndexDistance
//    func index(_: Index, offsetBy: IndexDistance) -> Index
//    func index(_: Index, offsetBy: IndexDistance, limitedBy: Index) -> Index?
//    subscript(position: Index) -> Element { get }
//    subscript(bounds: Range<Index>) -> SubSequence { get }
//}

@objc(BAOAdvancedSwiftViewController)
class BAOAdvancedSwiftViewController: BAOBaseViewController {
    private var viewModel = BAOTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let names = ["Paula", "Elena", "Zoe"]
        let match = names.last { $0.hasSuffix("a") }
        print("match: \(match!)")

        // 序列
        let list1 = List<Int>.end.cons(1).cons(2).cons(3)
        print("\(list1)")
        let list2: List = [3, 2, 1]
        print("\(list2)")
        let list3: List = ["1", "2", "3"]
        for x in list3 {
            print("\(x)", terminator: "")
        }
    }

    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.backgroundView = .white
        v.separatorStyle = .none
        v.delegate = self
        v.dataSource = self
        return v
    }()

    private func setupSubviews() {

    }
}

extension BAOAdvancedSwiftViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension BAOAdvancedSwiftViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
}


