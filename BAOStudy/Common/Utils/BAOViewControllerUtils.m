//
//  BAOViewControllerUtils.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/25.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOViewControllerUtils.h"

@implementation BAOViewControllerUtils

+ (BOOL)isPresentedViewController:(UIViewController *)viewController {
    // 1. VC1(presenting) -> VC2(presented, end) => VC2 is presented
    BOOL isPresented = viewController.presentingViewController.presentedViewController == viewController;

    // 2. VC1(presenting) -> VC2(presented, UINavigationController) ~> VC3(pushed, end)  => VC2 and VC3 is presented
    if (viewController.navigationController != nil && viewController == viewController.navigationController.viewControllers[0]) {
        isPresented |= viewController.presentingViewController.presentedViewController == viewController.navigationController;
    }

    // 3. VC1(presenting) -> VC2(presented, UITabBarController) ~> VC3(UINavigationController) ~> VC4(pushed, end)  => VC2, VC3 and VC4 is presented
    // 4. VC1(presenting) -> VC2(presented, UITabBarController) ~> VC3(end) => VC2 and VC3 is presented
    return isPresented;
}

@end
