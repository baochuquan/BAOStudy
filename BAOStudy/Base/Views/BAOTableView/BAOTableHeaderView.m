//
//  BAOTableHeaderView.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTableHeaderView.h"

@implementation BAOTableHeaderView

+ (instancetype)reusableHeaderWithTableView:(UITableView *)tableView
                            reuseIdentifier:(NSString *)reuseIdentifier {
    id header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (header == nil) {
        header = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    }
    return header;
}

+ (CGFloat)headerHeight {
    NSAssert(NO, @"Need to override");
    return 0;
}

+ (CGFloat)headerHeightWithViewModel:(BAOTableHeaderViewModel *)viewModel {
    return [self headerHeight];
}

- (void)bindDataWithViewModel:(BAOTableHeaderViewModel *)viewModel {
    NSAssert(NO, @"Need to override");
}

@end
