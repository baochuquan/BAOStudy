//
//  BAODiscoveryEntryCellViewModel.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/29.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTableCellViewModel.h"

static const NSInteger CellAugmentedReality = 0;

@interface BAODiscoveryEntryCellViewModel : BAOTableCellViewModel

@property (nonatomic, strong) NSString *title;

+ (NSArray<BAODiscoveryEntryCellViewModel *> *)defaultViewModels;

@end
