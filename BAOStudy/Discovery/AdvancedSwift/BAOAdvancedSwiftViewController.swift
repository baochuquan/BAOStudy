//
//  BAOAdvancedSwiftViewController.swift
//  BAOStudy
//
//  Created by baochuquan on 2019/1/15.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation
import SnapKit

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
    private lazy var viewModel = BAODiscoveryEntryCellViewModel.advancedSwiftViewModels();

    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.backgroundColor = .white
        v.separatorStyle = .none
        v.delegate = self
        v.dataSource = self
        contentView.addSubview(v)
        v.snp.makeConstraints({ (make) in
            make.edges.equalTo(0)
        })
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = viewModel
        _ = tableView
    }
}

extension BAOAdvancedSwiftViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let vm = viewModel?[indexPath.row] else { return }
        switch vm.cellId {
        case CellAdvancedSwiftCollection:
            let vc = BAOAdvancedSwiftCollectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BAODiscoveryEntryCell.cellHeight()
    }
}

extension BAOAdvancedSwiftViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel?[indexPath.row] else { return BAOTableViewCell() }
        guard let cell = vm.reusableCell(with: tableView) else { return BAOTableViewCell() }
        cell.bindData(with: vm)
        return cell;
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vms = viewModel else { return 0 }
        return vms.count
    }

}


