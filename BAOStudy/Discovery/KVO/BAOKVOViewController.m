//
//  BAOKVOViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/12/4.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BAOKVOViewController.h"
#import <objc/runtime.h>

@interface BAOPerson : NSObject

@property (nonatomic, assign) NSInteger age;

@end

@implementation BAOPerson

- (void)setAge:(NSInteger)age {
    NSLog(@"override setAge");
    _age = age;
}

- (void)willChangeValueForKey:(NSString *)key {
    NSLog(@"willChangeValueForKey: - begin");
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey: - end");
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"didChangeValueForKey: - begin");
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey: - end");
}

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

//    NSLog(@"添加 KVO 之前 - p1 = %p, p2 = %p", [p1 methodForSelector: @selector(setAge:)], [p2 methodForSelector: @selector(setAge:)]);

    // self 监听 p1 的 age 属性
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [p1 addObserver:self forKeyPath:@"age" options:options context:nil];

//    NSLog(@"添加 KVO 之后 - p1 = %p, p2 = %p", [p1 methodForSelector: @selector(setAge:)], [p2 methodForSelector: @selector(setAge:)]);

//    [self printMethods: object_getClass(p1)];
//    [self printMethods: object_getClass(p2)];

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

#pragma mark - Private Method

- (void)printMethods:(Class)cls {
    unsigned int count;
    Method *methods = class_copyMethodList(cls, &count);
    NSMutableString *methodNames = [NSMutableString string];
    [methodNames appendFormat:@"%@ - ", cls];

    for (int i = 0 ; i < count; i++) {
        Method method = methods[i];
        NSString *methodName  = NSStringFromSelector(method_getName(method));

        [methodNames appendString:methodName];
        [methodNames appendString:@" "];

    }

    NSLog(@"%@", methodNames);
    free(methods);
}

@end
