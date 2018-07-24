//
//  BAOTableSectionHeaderViewModel.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTableSectionHeaderViewModel.h"
#import "BAOTableSectionHeaderView.h"

@interface BAOTableSectionHeaderViewModel ()

@property (nonatomic, strong) NSString *reuseIdentifier;

@end

@implementation BAOTableSectionHeaderViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sectionClass = BAOTableSectionHeaderView.class;
    }
    return self;
}

- (void)setSectionClass:(Class)sectionClass {
    _sectionClass = sectionClass;
    self.reuseIdentifier = [NSString stringWithFormat:@"%@Identifier", NSStringFromClass(sectionClass)];
}

- (BAOTableSectionHeaderView *)reusableHeaderWithTableView:(UITableView *)tableView {
    return [self.sectionClass reusableHeaderWithTableView:tableView reuseIdentifier:self.reuseIdentifier];
}

@end
