//
//  BAOHomeViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/26.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOHomeViewController.h"

@interface BAOHomeViewController ()

@end

@implementation BAOHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

#pragma mark - Setup Methods

- (void)setupSubviews {
    [self setupHeaderView];
}

- (void)setupHeaderView {
    self.headerView.title = @"首页";
    [self.headerView removeLeftButton];
}

@end
