//
//  ViewController.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAOHeaderView.h"

@interface BAOBaseViewController : UIViewController

// 自定义导航栏视图
@property (nonatomic, strong) BAOHeaderView *headerView;

// 内容视图，如果有自定义导航栏，y从导航栏底部开始计算
@property (nonatomic, strong) UIView *contentView;

// 是否隐藏自定义导航栏，默认为NO
- (BOOL)shouldHideHeaderView;

// 是否禁用侧滑返回，默认为NO
- (BOOL)shouldDisableSwipeGesture;


@end

