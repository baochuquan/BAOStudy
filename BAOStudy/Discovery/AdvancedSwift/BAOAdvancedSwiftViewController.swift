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

@objc(BAOAdvancedSwiftViewController)
class BAOAdvancedSwiftViewController: BAOBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let names = ["Paula", "Elena", "Zoe"]
        let match = names.last { $0.hasSuffix("a") }
        print("match: \(match!)")
    }
}


