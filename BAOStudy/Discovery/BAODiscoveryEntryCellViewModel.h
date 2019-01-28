//
//  BAODiscoveryEntryCellViewModel.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/29.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTableCellViewModel.h"

static const NSInteger CellAugmentedReality = 0;
static const NSInteger CellAnimation = 1;
static const NSInteger CellRxSwift = 2;
static const NSInteger CellRuntime = 3;
static const NSInteger CellGCD = 4;
static const NSInteger CellKVO = 5;
static const NSInteger CellAdvancedSwift = 6;
static const NSInteger CellAlgorithm = 7;

static const NSInteger CellAnimationLottie = 1001;
static const NSInteger CellRuntimeVar = 3001;

static const NSInteger CellAdvancedSwiftCollection = 6001;

@interface BAODiscoveryEntryCellViewModel : BAOTableCellViewModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;

+ (NSArray<BAODiscoveryEntryCellViewModel *> *)discoveryViewModels;

+ (NSArray<BAODiscoveryEntryCellViewModel *> *)advancedSwiftViewModels;
+ (NSArray<BAODiscoveryEntryCellViewModel *> *)animationViewModels;
+ (NSArray<BAODiscoveryEntryCellViewModel *> *)runtimeViewModels;

@end
