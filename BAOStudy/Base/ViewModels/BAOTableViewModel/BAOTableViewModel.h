//
//  BAOTabelViewModel.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAOTableHeaderViewModel.h"
#import "BAOTableFooterViewModel.h"
#import "BAOTableSectionViewModel.h"
#import "BAOTableSectionHeaderViewModel.h"
#import "BAOTableSectionFooterViewModel.h"
#import "BAOTableCellViewModel.h"

@interface BAOTableViewModel : NSObject

@property (nonatomic, strong, nullable) __kindof BAOTableHeaderViewModel *headerViewModel;
@property (nonatomic, strong, nullable) __kindof BAOTableFooterViewModel *footerViewModel;
@property (nonatomic, strong) NSMutableArray<__kindof BAOTableSectionViewModel *> *sectionViewModels;

- (__kindof BAOTableSectionViewModel *)sectionViewModelWithIndex:(NSInteger)index;
- (__kindof BAOTableCellViewModel *)cellViewModelWithIndexPath:(NSIndexPath *)indexPath;

@end
