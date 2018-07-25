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
                                                     tabBarId:BAOTabItemIdHome
                                                        title:@"检查"
                                                    imageName:@"TabBarArithmetic"
                                                indicatorView:nil
                                                 logEventName:ClickTabCheckButton];
    BAOTabBarItem *practiceItem = [self createTabBarItemWithClass:[BAOPracticeHomeViewController class]
                                                         tabBarId:BAOTabItemIdPractice
                                                            title:@"练习"
                                                        imageName:@"TabBarPractice"
                                                    indicatorView:nil
                                                     logEventName:ClickTabExerciseButton];
    BAOTabBarItem *kumonItem = [self createTabBarItemWithClass:[BAOKumonViewController class]
                                                      tabBarId:BAOTabItemIdKumon
                                                         title:@"学院"
                                                     imageName:@"TabbarKumon"
                                                 indicatorView:[BAOViewUtils createRedPointView]
                                                  logEventName:ClickTabKumonButton];
    BAOTabBarItem *meItem = [self createTabBarItemWithClass:[BAOProfileViewController class]
                                                   tabBarId:BAOTabItemIdMe
                                                      title:@"我"
                                                  imageName:@"TabBarMe"
                                              indicatorView:[BAOViewUtils createRedPointView]
                                               logEventName:ClickTabMeButton];
    self.tabBarItems = @[homeItem, practiceItem, kumonItem, meItem];
    self.viewControllers = @[homeItem.navigationController, practiceItem.navigationController, kumonItem.navigationController, meItem.navigationController];

    kumonItem.indicatorView.hidden = ![[BAOUserTable sharedInstance] shouldShowKumonRedPoint];
    [self.tabBar addSubview:kumonItem.indicatorView];
    [self.tabBar addSubview:meItem.indicatorView];
}

- (BAOTabBarItem *)createTabBarItemWithClass:(Class)class
                                    tabBarId:(NSInteger)tabBarId
                                       title:(NSString *)title
                                   imageName:(NSString *)imageName
                               indicatorView:(UIView *)indicatorView
                                logEventName:(NSString *)logEventName {
    BAOTabBarItem *tabBarItem = [[BAOTabBarItem alloc] init];
    tabBarItem.itemId = tabBarId;
    BAOBaseViewController *vc = [[class alloc] init];
    tabBarItem.viewController = vc;
    UIImage *originalImage = [IMAGE(imageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [IMAGE([imageName stringByAppendingString:@"Pressed"]) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:originalImage selectedImage:selectedImage];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR_SECONDARY_TEXT} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR_YELLOW_DEFAULT} forState:UIControlStateSelected];
    item.titlePositionAdjustment = UIOffsetMake(0, -3);

    UINavigationController *nav = [[BAONavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem = item;
    tabBarItem.navigationController = nav;
    tabBarItem.indicatorView = indicatorView;
    tabBarItem.indicatorView.hidden = YES;
    tabBarItem.logEventName = logEventName;
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
