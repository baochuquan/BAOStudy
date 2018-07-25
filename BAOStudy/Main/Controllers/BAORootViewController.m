//
//  BAORootViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/26.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAORootViewController.h"
#import "BAOTabBarController.h"

@interface BAORootViewController ()

@end

@implementation BAORootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupChildViewControllersIfNeeded];
}

#pragma mark - Override

- (BOOL)shouldHideHeaderView {
    return YES;
}

#pragma mark - Setup

- (void)setupChildViewControllersIfNeeded {
    if (self.childViewControllers.count > 0) {
        return;
    }
    [self switchToTabBarControllerFromViewController:nil];
}

#pragma mark - Private Utils

- (void)switchToTabBarControllerFromViewController:(UIViewController *)vc {
    BAOTabBarController *tabBarController = [[BAOTabBarController alloc] init];
    [self switchFromViewController:vc toViewController:tabBarController];
}

- (void)switchFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (toVC == nil) {
        return;
    }

    [self addChildViewController:toVC];
    [self.view addSubview:toVC.view];
    toVC.view.frame = self.view.bounds;
    [toVC didMoveToParentViewController:self];

    if (fromVC != nil) {
        [toVC.view addSubview:fromVC.view];
        [fromVC willMoveToParentViewController:nil];
        [UIView animateWithDuration:0.25 animations:^{
            fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            [fromVC.view removeFromSuperview];
            [fromVC removeFromParentViewController];
        }];
    }
}

@end
