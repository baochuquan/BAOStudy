//
//  BAORxSwiftViewController.swift
//  BAOStudy
//
//  Created by baochuquan on 2018/11/3.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

import UIKit

@objc(BAORxSwiftViewController)
class BAORxSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var array = [1, 2, 3]
        for number in array {
            print(number)
            array = [4, 5, 6]
        }
        print(array)
    }


}
