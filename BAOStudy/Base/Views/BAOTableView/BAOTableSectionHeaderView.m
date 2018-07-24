//
//  BAOTableSectionHeaderView.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTableSectionHeaderView.h"

@implementation BAOTableSectionHeaderView

+ (instancetype)reusableHeaderWithTableView:(UITableView *)tableView
                            reuseIdentifier:(NSString *)reuseIdentifier {
    id header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (header == nil) {
        header = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    }
    return header;
}

#pragma mark - Public Methods

+ (CGFloat)headerHeight {
    NSAssert(NO, @"Need to override");
    return 0;
}

+ (CGFloat)headerHeightWithViewModel:(BAOTableSectionHeaderViewModel *)viewModel {
    return [self headerHeight];
}

- (void)bindDataWithViewModel:(BAOTableSectionHeaderViewModel *)viewModel {
    NSAssert(NO, @"Need to override");
}

@end
