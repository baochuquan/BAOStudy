//
//  BAOTableSectionViewModel.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTableSectionViewModel.h"

@implementation BAOTableSectionViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellViewModels = [NSMutableArray array];
    }
    return self;
}

@end
