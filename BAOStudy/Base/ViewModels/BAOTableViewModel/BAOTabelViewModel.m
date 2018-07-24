//
//  BAOTabelViewModel.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTabelViewModel.h"

@implementation BAOTabelViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sectionViewModels = [NSMutableArray array];
    }
    return self;
}

- (BAOTableSectionViewModel *)sectionViewModelWithIndex:(NSInteger)index {
    if (index >= self.sectionViewModels.count) {
        return nil;
    }
    return self.sectionViewModels[index];
}

- (BAOTableCellViewModel *)cellViewModelWithIndexPath:(NSIndexPath *)indexPath {
    BAOTableCellViewModel *cellViewModel = nil;
    BAOTableSectionViewModel *sectionViewModel = [self sectionViewModelWithIndex:indexPath.section];
    if (indexPath.row < sectionViewModel.cellViewModels.count) {
        cellViewModel = sectionViewModel.cellViewModels[indexPath.row];
    }
    return cellViewModel;
}

@end
