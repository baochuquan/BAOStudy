//
//  BAOAlgorithmViewController.swift
//  BAOStudy
//
//  Created by baochuquan on 2019/1/16.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation

// Swift
class ListNode<T> {
    var val: T
    var next: ListNode?
    init(_ val: T) {
        self.val = val
        self.next = nil
    }

    // 时间复杂度 O(n)，空间复杂度 O(m)
    func subLists(span: Int) -> [ListNode?] {
        var heads: Array<ListNode?> = []
        for _ in 0..<span {
            heads.append(ListNode(val))
        }
        var tails: Array<ListNode?> = heads

        var listPtr: ListNode? = self
        var i = 0
        while listPtr != nil {
            tails[i % span]?.next = listPtr
            tails[i % span] = tails[i % span]?.next
            listPtr = listPtr?.next
            i += 1
        }
        for i in 0..<span {
            tails[i]?.next = nil
        }
        return heads.map({ (node) -> ListNode? in
            node?.next
        })
    }

    // 打印链表
    func printList() {
        var listPtr: ListNode? = self
        while listPtr != nil {
            print("\(listPtr!.val)", terminator: " -> ")
            listPtr = listPtr?.next
        }
        print("nil")
    }


    // 返回一个链表中奇数位和偶数位节点构成的链表
    // 时间 O(n)，空间 O(n)
    func oddAndEvenList() -> (ListNode?, ListNode?) {
        let oddHead = ListNode(val)
        let evenHead = ListNode(val)
        var oddTail: ListNode? = oddHead
        var evenTail: ListNode? = evenHead

        var listPtr: ListNode? = self, isOdd = false
        while listPtr != nil {
            if isOdd {
                oddTail?.next = listPtr?.subList([0])
//                oddTail?.next = listPtr?.node(of: 0)
//                oddTail?.next = ListNode(listPtr!.val)
                oddTail = oddTail?.next
            } else {
                evenTail?.next = listPtr?.subList([0])
//                evenTail?.next = listPtr?.node(of: 0)
//                evenTail?.next = ListNode(listPtr!.val)
                evenTail = evenTail?.next
            }
            isOdd = !isOdd
            listPtr = listPtr?.next
        }
        return (oddHead.next, evenHead.next)
    }

    // 返回以 head 开始的链表中指定索引的节点构成的子链表
    func subList(_ indices: [Int]) -> ListNode? {
        let listHead = ListNode(val)
        var listTail: ListNode? = listHead

        var i = 0
        while i < indices.count {
            guard let node = self.node(of: indices[i]) else { return listHead.next}
            i += 1
            listTail?.next = node
            listTail = listTail?.next
        }

        return listHead.next
    }

    // 返回以 head 开始的链表中第 index 个节点
    func node(of index: Int) -> ListNode? {
        var i = 0, listPtr: ListNode? = self
        while listPtr != nil && i <= index {
            if i == index {
                return ListNode(listPtr!.val)
            }
            i += 1
            listPtr = listPtr?.next
        }
        return nil
    }



}

@objc(BAOAlgorithmViewController)
class BAOAlgorithmViewController: BAOBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let node0 = ListNode(0)
        let node1 = ListNode(1)
        let node2 = ListNode(2)
        let node3 = ListNode(3)
        let node4 = ListNode(4)
        let node5 = ListNode(5)
        let node6 = ListNode(6)
        let node7 = ListNode(7)
        let node8 = ListNode(8)
        let node9 = ListNode(9)

        node0.next = node1
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        node6.next = node7
        node7.next = node8
        node8.next = node9

        let lists = node0.subLists(span: 2)
        lists[0]?.printList()
        lists[1]?.printList()

//        node0.subList([3, 2, 4, 10, 2, 3, 1])?.printList()
//
//        let (oddList, evenList) = node0.oddAndEvenList()
//        oddList?.printList()
//        evenList?.printList()

    }

}

func test() {
    let node0 = ListNode(0)
    let node1 = ListNode(1)
    let node2 = ListNode(2)
    let node3 = ListNode(3)
    let node4 = ListNode(4)
    let node5 = ListNode(5)
    let node6 = ListNode(6)
    let node7 = ListNode(7)
    let node8 = ListNode(8)
    let node9 = ListNode(9)

    node0.next = node1
    node1.next = node2
    node2.next = node3
    node3.next = node4
    node4.next = node5
    node5.next = node6
    node6.next = node7
    node7.next = node8
    node8.next = node9

    let lists = node0.subLists(span: 2)
    lists[0]?.printList()
    lists[1]?.printList()
}
