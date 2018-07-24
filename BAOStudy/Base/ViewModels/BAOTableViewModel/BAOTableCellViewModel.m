//
//  BAOTableCellViewModel.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTableCellViewModel.h"
#import "BAOTableViewCell.h"

@interface BAOTableCellViewModel ()

@property (nonatomic, strong) NSString *reuseIdentifier;

@end

@implementation BAOTableCellViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.separatorType = BAOTableViewCellSeparatorTypeDefault;
        self.cellClass = BAOTableViewCell.class;
    }
    return self;
}

- (void)setCellClass:(Class)cellClass {
    _cellClass = cellClass;
    self.reuseIdentifier = [NSString stringWithFormat:@"%@Identifier", NSStringFromClass(cellClass)];
}

- (BAOTableViewCell *)reusableCellWithTableView:(UITableView *)tableView {
    return [self.cellClass reusableCellWithTableView:tableView reuseIdentifier:self.reuseIdentifier];
}

@end
