//
//  BAOTableSectionFooterView.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAOTableSectionFooterViewModel.h"

@interface BAOTableSectionFooterView : UITableViewHeaderFooterView

+ (instancetype)reusableFooterWithTableView:(UITableView *)tableView
                            reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)footerHeight;    /// 需要覆写
+ (CGFloat)footerHeightWithViewModel:(BAOTableSectionFooterViewModel *)viewModel;

- (void)bindDataWithViewModel:(BAOTableSectionFooterViewModel *)viewModel;  /// 需要覆写


@end
