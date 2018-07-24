//
//  ViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOBaseViewController.h"
#import "BAONavigationController.h"

@interface BAOBaseViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UIView *loadErrorView;

@end

@implementation BAOBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_BACKGROUND;
    [self setupNavigationStyle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if ([self.navigationController isKindOfClass:BAONavigationController.class]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (BAONavigationController *)self.navigationController;
    } else {
        if (self.navigationController.viewControllers.count >= 2) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        } else {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

#pragma mark - Setup

- (void)setupNavigationStyle {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"";
    self.navigationItem.backBarButtonItem = item;

    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = COLOR_BACKGROUND;
    [self.view addSubview:self.contentView];

    if ([self shouldHideHeaderView]) {
        self.contentView.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    } else {
        self.headerView = [BAOHeaderView createHeaderViewInView:self.view];
        [self.headerView setTitle:self.title];
        [self.headerView setLeftReturnButtonWithTarget:self
                                                action:@selector(headerViewReturnButtonPressed:)];
        self.contentView.frame = CGRectMake(0,
                                            [BAOHeaderView headerViewHeight],
                                            UI_SCREEN_WIDTH,
                                            UI_SCREEN_HEIGHT - [BAOHeaderView headerViewHeight]);
    }

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.headerView) {
            make.top.equalTo(self.headerView.mas_bottom);
        } else {
            make.top.equalTo(self.view);
        }
        make.left.bottom.right.equalTo(self.view);
    }];
}


#pragma mark - Public

- (BOOL)shouldHideHeaderView {
    return NO;
}

- (BOOL)shouldDisableSwipeGesture {
    return NO;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [self.headerView setTitle:title];
}

#pragma mark - Button Actions

- (void)headerViewReturnButtonPressed:(id)sender {
    if ([BAOViewControllerUtils isPresentedViewController:self]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL result = YES;
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        result &= ![self.navigationController.transitionCoordinator isAnimated];
        result &= self.navigationController.viewControllers.count >= 2;
        result &= ![self shouldDisableSwipeGesture];
    }
    return result;
}

@end
