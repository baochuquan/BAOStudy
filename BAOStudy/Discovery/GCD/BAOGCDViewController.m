//
//  BAOGCDViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/11/27.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BAOGCDViewController.h"

@interface BAOGCDViewController ()

@end

@implementation BAOGCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];

    // 同步执行 + 并发队列
//    [self syncConcurrent];

    // 异步执行 + 并发队列
//    [self asyncConcurrent];

    // 同步执行 + 串行队列
//    [self syncSerial];

    // 异步执行 + 串行队列
    [self asyncSerial];
}

- (void)setupSubviews {
    [self setupHeaderView];
}

- (void)setupHeaderView {
    self.headerView.title = @"GCD";
}

/**
 * 同步执行 + 并发队列
 * 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)syncConcurrent {
    NSLog(@"currentThread---%@", [NSThread currentThread]);     // 打印当前线程
    NSLog(@"syncConcurrent---begin");

    dispatch_queue_t queue = dispatch_queue_create("me.chuquan.testQueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });

    dispatch_sync(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });

    dispatch_sync(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    NSLog(@"syncConcurrent---end");
}

/**
 * 异步执行 + 并发队列
 * 特点：可以开启多个线程，任务交替（同时）执行。
 */
- (void)asyncConcurrent {
    NSLog(@"currentThread---%@", [NSThread currentThread]);     // 打印当前线程
    NSLog(@"asyncConcurrent---begin");

    dispatch_queue_t queue = dispatch_queue_create("me.chuquan.testQueue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });

    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });

    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });

    NSLog(@"asyncConcurrent---end");
}

/**
 * 同步执行 + 串行队列
 * 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)syncSerial {
    NSLog(@"currentThread---%@", [NSThread currentThread]);     // 打印当前线程
    NSLog(@"syncSerial---begin");

    dispatch_queue_t queue = dispatch_queue_create("me.chuquan.testQueue", DISPATCH_QUEUE_SERIAL);

    dispatch_sync(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });
    dispatch_sync(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });
    dispatch_sync(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });

    NSLog(@"syncSerial---end");
}

/**
 * 异步执行 + 串行队列
 * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)asyncSerial {
    NSLog(@"currentThread---%@", [NSThread currentThread]);     // 打印当前线程
    NSLog(@"asyncSerial---begin");

    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);

    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });

    NSLog(@"asyncSerial---end");
}

@end
