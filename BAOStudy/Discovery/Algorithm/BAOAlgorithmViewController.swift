//
//  BAOAlgorithmViewController.swift
//  BAOStudy
//
//  Created by baochuquan on 2019/1/16.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation

class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
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

        let subNode = subList(node0, [0, 2, 4, 10, 2, 3, 1])
        printList(subNode)

        let (oddList, evenList) = oddAndEvenList(node0)
        printList(oddList)
        printList(evenList)
    }

    // 返回一个链表中奇数位和偶数位节点构成的链表
    func oddAndEvenList(_ head: ListNode?) -> (ListNode?, ListNode?) {
        guard let head = head else {
            return (nil, nil)
        }

        let oddHead = ListNode(-1)
        let evenHead = ListNode(-1)
        var oddTail: ListNode? = oddHead
        var evenTail: ListNode? = evenHead

        var listPtr: ListNode? = head, isOdd = true
        while listPtr != nil {
            if isOdd {
                oddTail?.next = node(from: listPtr?.next, of: 0)
                oddTail = oddTail?.next
            } else {
                evenTail?.next = node(from: listPtr?.next, of: 0)
                evenTail = evenTail?.next
            }
            isOdd = !isOdd
            listPtr = listPtr?.next
        }
        return (oddHead.next, evenHead.next)
    }

    // 返回以 head 开始的链表中指定索引的节点构成的子链表
    func subList(_ head: ListNode?, _ indices: [Int]) -> ListNode? {
        guard let _ = head else {
            return nil
        }

        let listHead = ListNode(-1)
        var listTail: ListNode? = listHead

        var i = 0
        while i < indices.count {
            guard let node = node(from: head, of: indices[i]) else { return listHead.next}
            i += 1
            listTail?.next = node
            listTail = listTail?.next
        }

        return listHead.next
    }

    // 返回以 head 开始的链表中第 index 个节点
    func node(from head: ListNode?, of index: Int) -> ListNode? {
        guard let head = head else { return nil }

        var i = 0, listPtr: ListNode? = head
        while listPtr != nil && i <= index {
            if i == index {
                return ListNode(listPtr!.val)
            }
            i += 1
            listPtr = listPtr?.next
        }
        return nil
    }

    // 打印链表
    func printList(_ head: ListNode?) {
        guard let head = head else { return }

        var listPtr: ListNode? = head
        while listPtr != nil {
            print("\(listPtr!.val)", terminator: " -> ")
            listPtr = listPtr?.next
        }
        print("nil")
    }

}
