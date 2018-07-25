//
//  BAOTabBarItem.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/26.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAOTabBarItem : NSObject

@property (nonatomic, assign) BAOTabBarItemType itemType;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong, nullable) UINavigationController *navigationController;

// root view controller of navigationController
@property (nonatomic, strong, nullable) __kindof UIViewController *viewController;
@property (nonatomic, strong, nullable) UIView *indicatorView;

@end
