//
//  BAODiscoveryEntryCellViewModel.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/29.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAODiscoveryEntryCellViewModel.h"
#import "BAODiscoveryEntryCell.h"

@implementation BAODiscoveryEntryCellViewModel

+ (NSArray<BAODiscoveryEntryCellViewModel *> *)discoveryViewModels {
    NSMutableArray<BAODiscoveryEntryCellViewModel *> *viewModels = [NSMutableArray array];

    BAODiscoveryEntryCellViewModel *arViewModel = [[BAODiscoveryEntryCellViewModel alloc] init];
    arViewModel.title = @"增强现实";
    arViewModel.descr = @"BAOAugmentedRealityListViewController";
    arViewModel.cellId = CellAugmentedReality;
    [viewModels addObject:arViewModel];

    BAODiscoveryEntryCellViewModel *animationViewModel = [[BAODiscoveryEntryCellViewModel alloc] init];
    animationViewModel.title = @"动画效果";
    animationViewModel.descr = @"BAOAnimationListViewController";
    animationViewModel.cellId =  CellAnimation;
    [viewModels addObject:animationViewModel];

    BAODiscoveryEntryCellViewModel *rxSwiftViewModel = [[BAODiscoveryEntryCellViewModel alloc] init];
    rxSwiftViewModel.title = @"RxSwift";
    rxSwiftViewModel.descr = @"BAORxSwiftViewController";
    rxSwiftViewModel.cellId = CellRxSwift;
    [viewModels addObject:rxSwiftViewModel];

    BAODiscoveryEntryCellViewModel *runtimeViewModel = [[BAODiscoveryEntryCellViewModel alloc] init];
    runtimeViewModel.title = @"运行时";
    runtimeViewModel.descr = @"BAORuntimeListViewController";
    runtimeViewModel.cellId = CellRuntime;
    [viewModels addObject:runtimeViewModel];

    BAODiscoveryEntryCellViewModel *gcdViewModel = [[BAODiscoveryEntryCellViewModel alloc] init];
    gcdViewModel.title = @"GCD";
    gcdViewModel.descr = @"BAOGCDViewController";
    gcdViewModel.cellId = CellGCD;
    [viewModels addObject:gcdViewModel];

    return [viewModels copy];
}

+ (NSArray<BAODiscoveryEntryCellViewModel *> *)animationViewModels {
    NSMutableArray<BAODiscoveryEntryCellViewModel *> *viewModels = [NSMutableArray array];

    BAODiscoveryEntryCellViewModel *arViewModel = [[BAODiscoveryEntryCellViewModel alloc] init];
    arViewModel.title = @"Lottie";
    arViewModel.descr = @"BAOAnimationLottieViewController";
    arViewModel.cellId = CellAnimationLottie;
    [viewModels addObject:arViewModel];

    return [viewModels copy];
}

+ (NSArray<BAODiscoveryEntryCellViewModel *> *)runtimeViewModels {
    NSMutableArray<BAODiscoveryEntryCellViewModel *> *viewModels = [NSMutableArray array];

    BAODiscoveryEntryCellViewModel *varViewModel = [[BAODiscoveryEntryCellViewModel alloc] init];
    varViewModel.title = @"Var";
    varViewModel.descr = @"BAOAnimationVarViewController";
    varViewModel.cellId = CellRuntimeVar;
    [viewModels addObject:varViewModel];

    return [viewModels copy];
}

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellClass = BAODiscoveryEntryCell.class;
        self.separatorType = BAOTableViewCellSeparatorTypeDefault;
        self.cellHeight = [BAODiscoveryEntryCell cellHeight];
    }
    return self;
}

@end
