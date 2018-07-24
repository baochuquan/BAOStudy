//
//  BAOTableFooterView.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAOTableFooterViewModel.h"

@interface BAOTableFooterView : UITableViewHeaderFooterView

+ (instancetype)reusableFooterWithTableView:(UITableView *)tableView
                            reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)footerHeight;    /// 需要覆写
+ (CGFloat)footerHeightWithViewModel:(BAOTableFooterViewModel *)viewModel;

- (void)bindDataWithViewModel:(BAOTableFooterViewModel *)viewModel; /// 需要覆写

@end
