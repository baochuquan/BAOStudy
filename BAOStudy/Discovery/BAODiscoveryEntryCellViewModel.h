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

static const NSInteger CellAnimationLottie = 11;

@interface BAODiscoveryEntryCellViewModel : BAOTableCellViewModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;

+ (NSArray<BAODiscoveryEntryCellViewModel *> *)discoveryViewModels;
+ (NSArray<BAODiscoveryEntryCellViewModel *> *)animationViewModels;

@end
