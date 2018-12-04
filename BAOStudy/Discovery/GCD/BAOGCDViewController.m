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
//    [self asyncSerial];

    // 同步执行 + 主队列
//    [self syncMain];
//    [NSThread detachNewThreadSelector:@selector(syncMain) toTarget:self withObject:nil];

    // 异步执行 + 主队列
//    [self asyncMain];

    // 线程间通信
//    [self communication];

    // 栅栏方法
//    [self barrier];

    // 延时执行方法
//    [self after];

    // 一次性代码
//    [self once];

    // 快速迭代方法
//    [self apply];

    // 队列组
//    [self groupNotify];
//    [self groupWait];
    [self groupEnterAndLeave];
//    [self semaphoreSync];
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

    dispatch_queue_t queue = dispatch_queue_create("me.chuquan.testQueue", DISPATCH_QUEUE_SERIAL);

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

/**
 * 同步执行 + 主队列
 * 特点(主线程调用)：互等卡主不执行。
 * 特点(其他线程调用)：不会开启新线程，执行完一个任务，再执行下一个任务。
 */
- (void)syncMain {
    NSLog(@"currentThread---%@", [NSThread currentThread]);     // 打印当前线程
    NSLog(@"syncMain---begin");

    dispatch_queue_t queue = dispatch_get_main_queue();

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

    NSLog(@"syncMain---end");
}

/**
 * 异步执行 + 主队列
 * 特点：只在主线程中执行任务，执行完一个任务，再执行下一个任务
 */
- (void)asyncMain {
    NSLog(@"currentThread---%@", [NSThread currentThread]);     // 打印当前线程
    NSLog(@"asyncMain---begin");

    dispatch_queue_t queue = dispatch_get_main_queue();

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

    NSLog(@"asyncMain---end");
}

/**
 * 线程间通信
 */
- (void)communication {
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();

    dispatch_async(queue, ^{
        // 异步追加任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
        }

        // 回到主线程
        dispatch_async(mainQueue, ^{
            // 追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
        });
    });
}

/**
 * 栅栏方法 dispatch_barrier_async
 */
- (void)barrier {
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

    dispatch_barrier_async(queue, ^{
        // 追加任务 barrier
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"barrier---%@", [NSThread currentThread]);   // 打印当前线程
        }
    });

    dispatch_async(queue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        // 追加任务4
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"4---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });
}

/**
 * 延时执行方法 dispatch_after
 */
- (void)after {
    NSLog(@"currentThread---%@", [NSThread currentThread]);     // 打印当前线程
    NSLog(@"asyncMain---begin");

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.0秒后追加异步任务代码到主队列，并开始执行
        NSLog(@"after---%@", [NSThread currentThread]);         // 打印当前线程
    });

    NSLog(@"asyncMain--end");
}

/**
 * 一次性代码（只执行一次）dispatch_once
 */
- (void)once {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 只执行1次的代码(这里面默认是线程安全的)
    });
}

/**
 * 快速迭代方法 dispatch_apply
 */
- (void)apply {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    NSLog(@"apply---begin");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
    });
    NSLog(@"apply---end");
}

/**
 * 队列组 dispatch_group_notify
 */
- (void)groupNotify {
    NSLog(@"currentThread---%@", [NSThread currentThread]);     // 打印当前线程
    NSLog(@"group---begin");

    dispatch_group_t group =  dispatch_group_create();

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
        }
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
        }
        NSLog(@"group---end");
    });
}

/**
 * 队列组 dispatch_group_wait
 */
- (void)groupWait {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");

    dispatch_group_t group =  dispatch_group_create();

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

    NSLog(@"group---end");
}

/**
 * 队列组 dispatch_group_enter、dispatch_group_leave
 */
- (void)groupEnterAndLeave {
    NSLog(@"currentThread---%@", [NSThread currentThread]);     // 打印当前线程
    NSLog(@"group---begin");

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程
        }
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]);         // 打印当前线程
        }
        dispatch_group_leave(group);
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程.
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]);         // 打印当前线程
        }
        NSLog(@"group---end");
    });

    //    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    //    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //
    //    NSLog(@"group---end");
}

/**
 * semaphore 线程同步
 */
- (void)semaphoreSync {
    NSLog(@"currentThread---%@", [NSThread currentThread]); // 打印当前线程
    NSLog(@"semaphore---begin");

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    __block int number = 0;
    dispatch_async(queue, ^{
        // 追加任务1
        [NSThread sleepForTimeInterval:2];                  // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);         // 打印当前线程

        number = 100;

        dispatch_semaphore_signal(semaphore);
    });

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %@", @(number));
}


@end
