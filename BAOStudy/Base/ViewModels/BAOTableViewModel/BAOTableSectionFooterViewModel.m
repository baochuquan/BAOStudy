//
//  BAOTableSectionFooterViewModel.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTableSectionFooterViewModel.h"
#import "BAOTableSectionFooterView.h"

@interface BAOTableSectionFooterViewModel ()

@property (nonatomic, strong) NSString *reuseIdentifier;

@end

@implementation BAOTableSectionFooterViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sectionClass = BAOTableSectionFooterView.class;
    }
    return self;
}

- (void)setSectionClass:(Class)sectionClass {
    _sectionClass = sectionClass;
    self.reuseIdentifier = [NSString stringWithFormat:@"%@Identifier", NSStringFromClass(sectionClass)];
}

- (BAOTableSectionFooterView *)reusableFooterWithTableView:(UITableView *)tableView {
    return [self.sectionClass reusableFooterWithTableView:tableView reuseIdentifier:self.reuseIdentifier];
}


@end
