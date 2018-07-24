//
//  BAOTableCellViewModel.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAOTableViewCell;

@interface BAOTableCellViewModel : NSObject

/// 默认为 BAOTableViewCell
@property (nonatomic, strong) Class cellClass;

@property (nonatomic, assign) NSInteger cellId;

@property (nonatomic, assign) CGFloat cellHeight;

/// 默认为 BAOTableViewCellSeparatorTypeDefault
@property (nonatomic, assign) BAOTableViewCellSeparatorType separatorType;

- (BAOTableViewCell *)reusableCellWithTableView:(UITableView *)tableView;

@end
