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

+ (NSArray<BAODiscoveryEntryCellViewModel *> *)defaultViewModels {
    NSMutableArray<BAODiscoveryEntryCellViewModel *> *viewModels = [NSMutableArray array];

    BAODiscoveryEntryCellViewModel *arViewModel = [[BAODiscoveryEntryCellViewModel alloc] init];
    arViewModel.title = @"Augmented reality";
    arViewModel.cellId = CellAugmentedReality;
    [viewModels addObject:arViewModel];

    return [viewModels copy];
}

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
