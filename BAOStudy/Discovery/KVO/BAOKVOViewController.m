//
//  BAOKVOViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/12/4.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BAOKVOViewController.h"

@interface BAOPerson : NSObject

@property (nonatomic, assign) NSInteger age;

@end

@implementation BAOPerson

@end



@interface BAOKVOViewController ()

@end

@implementation BAOKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];

    BAOPerson *p1 = [[BAOPerson alloc] init];
    BAOPerson *p2 = [[BAOPerson alloc] init];
    p1.age = 1;
    p1.age = 2;
    p2.age = 2;

    // self 监听 p1 的 age 属性
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [p1 addObserver:self forKeyPath:@"age" options:options context:nil];
    p1.age = 10;
    [p1 removeObserver:self forKeyPath:@"age"];
}

- (void)setupSubviews {
    [self setupHeaderView];
}

- (void)setupHeaderView {
    self.headerView.title = @"KVO";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到 %@ 的 %@ 改变了 %@", object, keyPath,change);
}

@end
