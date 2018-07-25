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
    // Do any additional setup after loading the view.
}

#pragma mark - Setup Methods

- (void)setupSubviews {
    self.contentView.backgroundColor = COLOR_YELLOW_DEFAULT;
    [self setupHeaderView];
}

- (void)setupHeaderView {
    self.headerView.hidden = YES;
    self.headerView.title = @"";
    [self.headerView removeLeftButton];
}

@end
