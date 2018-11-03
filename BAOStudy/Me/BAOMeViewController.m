//
//  BAOMeViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/29.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOMeViewController.h"

@interface BAOMeViewController ()

@end

@implementation BAOMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupValues];
    [self setupSubviews];
}

#pragma mark - Setup Methods

- (void)setupValues {
    
}

- (void)setupSubviews {
    [self setupHeaderView];
}

- (void)setupHeaderView {
    self.headerView.title = @"我";
    [self.headerView removeLeftButton];
}

@end
