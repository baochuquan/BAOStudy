//
//  BAOTableSectionHeaderView.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAOTableSectionHeaderViewModel.h"

@interface BAOTableSectionHeaderView : UITableViewHeaderFooterView

+ (instancetype)reusableHeaderWithTableView:(UITableView *)tableView
                            reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)headerHeight;    /// 需要覆写
+ (CGFloat)headerHeightWithViewModel:(BAOTableSectionHeaderViewModel *)viewModel;

- (void)bindDataWithViewModel:(BAOTableSectionHeaderViewModel *)viewModel;  /// 需要覆写

@end
