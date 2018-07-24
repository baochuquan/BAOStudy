//
//  BAOTableSectionFooterViewModel.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAOTableSectionFooterView;

@interface BAOTableSectionFooterViewModel : NSObject

@property (nonatomic, strong) Class sectionClass;

@property (nonatomic, assign) CGFloat footerHeight;

- (BAOTableSectionFooterView *)reusableFooterWithTableView:(UITableView *)tableView;

@end
