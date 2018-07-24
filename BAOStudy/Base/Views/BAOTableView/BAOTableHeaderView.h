//
//  BAOTableHeaderView.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAOTableHeaderViewModel.h"

@interface BAOTableHeaderView : UITableViewHeaderFooterView

+ (instancetype)reusableHeaderWithTableView:(UITableView *)tableView
                            reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)headerHeight;    /// 需要覆写
+ (CGFloat)headerHeightWithViewModel:(BAOTableHeaderViewModel *)viewModel;

- (void)bindDataWithViewModel:(BAOTableHeaderViewModel *)viewModel; /// 需要覆写

@end
