//
//  BAOTableSectionFooterView.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTableSectionFooterView.h"

@implementation BAOTableSectionFooterView

#pragma mark - Lifecycle

+ (instancetype)reusableFooterWithTableView:(UITableView *)tableView
                            reuseIdentifier:(NSString *)reuseIdentifier {
    id footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (footer == nil) {
        footer = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    }
    return footer;
}

#pragma mark - Public Methods

+ (CGFloat)footerHeight {
    NSAssert(NO, @"Need to override");
    return 0;
}

+ (CGFloat)footerHeightWithViewModel:(BAOTableSectionFooterViewModel *)viewModel {
    return [self footerHeight];
}

- (void)bindDataWithViewModel:(BAOTableSectionFooterViewModel *)viewModel {
    NSAssert(NO, @"Need to override");
}

@end
