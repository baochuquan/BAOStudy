//
//  BAOTabBarController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/26.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTabBarController.h"
#import "BAOTabBarItem.h"
#import "BAONavigationController.h"
#import "BAOBaseViewController.h"
#import "BAOHomeViewController.h"
#import "BAODiscoveryViewController.h"
#import "BAOMeViewController.h"

@interface BAOTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) NSArray<BAOTabBarItem *> *tabBarItems;

@end

@implementation BAOTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setupAppearance];
    [self setupTabBarItems];
}

#pragma mark - Setup

- (void)setupAppearance {
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;
}

- (void)setupTabBarItems {
    BAOTabBarItem *homeItem = [self createTabBarItemWithClass:[BAOHomeViewController class]
                                                   tabBarType:BAOTabBarItemTypeHome
                                                        title:@"首页"
                                                    imageName:@"TabBarHome"];
    BAOTabBarItem *discoveryItem = [self createTabBarItemWithClass:[BAODiscoveryViewController class]
                                                        tabBarType:BAOTabBarItemTypeDiscovery
                                                         title:@"发现"
                                                     imageName:@"TabBarDiscovery"];
    BAOTabBarItem *meItem = [self createTabBarItemWithClass:[BAOMeViewController class]
                                                 tabBarType:BAOTabBarItemTypeMe
                                                      title:@"我"
                                                  imageName:@"TabBarMe"];
    self.tabBarItems = @[homeItem, discoveryItem, meItem];
    self.viewControllers = @[homeItem.navigationController,
                             discoveryItem.navigationController,
                             meItem.navigationController];
    [self.tabBar addSubview:meItem.indicatorView];
}

- (BAOTabBarItem *)createTabBarItemWithClass:(Class)class
                                  tabBarType:(NSInteger)tabBarType
                                       title:(NSString *)title
                                   imageName:(NSString *)imageName {
    BAOTabBarItem *tabBarItem = [[BAOTabBarItem alloc] init];
    tabBarItem.itemType = tabBarType;
    BAOBaseViewController *vc = [[class alloc] init];
    tabBarItem.viewController = vc;
    UIImage *originalImage = [IMAGE(imageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [IMAGE([imageName stringByAppendingString:@"Selected"]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:originalImage selectedImage:selectedImage];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR_SECONDARY_TEXT} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR_YELLOW_DEFAULT} forState:UIControlStateSelected];
    item.titlePositionAdjustment = UIOffsetMake(0, -3);

    UINavigationController *nav = [[BAONavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem = item;
    tabBarItem.navigationController = nav;
    tabBarItem.indicatorView.hidden = YES;
    return tabBarItem;
}


#pragma mark - Public

- (BOOL)jumpWithTabBarItemType:(BAOTabBarItemType)itemType {
    for (BAOTabBarItem *item in self.tabBarItems) {
        NSUInteger newIndex = [self.tabBarItems indexOfObject:item];
        if (item.itemType == itemType) {
            [self setSelectedIndex:newIndex];
            return YES;
        }
    }
    return NO;
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    BAOTabBarItem *selectedItem = self.tabBarItems[index];
    selectedItem.indicatorView.hidden = YES;
}

#pragma mark - Interface Orientation

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

@end
