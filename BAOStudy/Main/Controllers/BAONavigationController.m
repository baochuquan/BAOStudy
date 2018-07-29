//
//  BAONavigationController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/25.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAONavigationController.h"
#import "BAOBaseViewController.h"

@interface BAONavigationController ()

@end

@implementation BAONavigationController

#pragma mark - override methods

+ (void)load {
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    return self;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL result = YES;
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        BOOL isSwipeGestureDisable = NO;
        if ([self.topViewController isKindOfClass:BAOBaseViewController.class]) {
            isSwipeGestureDisable = [(BAOBaseViewController *)self.topViewController shouldDisableSwipeGesture];
        }

        result &= ![self.transitionCoordinator isAnimated];
        result &= self.viewControllers.count >= 2;
        result &= !isSwipeGestureDisable;
    }
    return result;
}

#pragma mark - Rotation

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

@end
