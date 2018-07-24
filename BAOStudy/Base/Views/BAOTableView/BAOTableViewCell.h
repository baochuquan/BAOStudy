//
//  BAOTableViewCell.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAOTableCellViewModel;

@interface BAOTableViewCell : UITableViewCell

+ (instancetype)reusableCellWithTableView:(UITableView *)tableView
                          reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)cellHeight;      /// 需要覆写
+ (CGFloat)cellHeightWithViewModel:(BAOTableCellViewModel *)viewModel;

- (CGFloat)bodySeparatorLinePaddingLeft;
- (CGFloat)bodySeparatorLinePaddingRight;
- (UIColor *)bodySeparatorLineColor;

- (CGFloat)topBottomSeparatorLinePaddingLeft;
- (CGFloat)topBottomSeparatorLinePaddingRight;
- (UIColor *)topBottomSeparatorLineColor;

- (void)bindDataWithViewModel:(BAOTableCellViewModel *)viewModel NS_REQUIRES_SUPER;

@end
