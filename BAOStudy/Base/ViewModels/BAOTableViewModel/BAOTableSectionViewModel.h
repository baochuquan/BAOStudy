//
//  BAOTableSectionViewModel.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAOTableSectionHeaderViewModel.h"
#import "BAOTableSectionFooterViewModel.h"
#import "BAOTableCellViewModel.h"

@interface BAOTableSectionViewModel : NSObject

@property (nonatomic, assign) NSInteger sectionId;
@property (nonatomic, strong, nullable) __kindof BAOTableSectionHeaderViewModel *headerViewModel;
@property (nonatomic, strong, nullable) __kindof BAOTableSectionFooterViewModel *footerViewModel;
@property (nonatomic, strong, nullable) NSMutableArray<__kindof BAOTableCellViewModel *> *cellViewModels;

@end
