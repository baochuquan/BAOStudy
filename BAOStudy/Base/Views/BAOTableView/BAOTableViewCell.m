//
//  BAOTableViewCell.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOTableViewCell.h"
#import "BAOTableCellViewModel.h"

@interface BAOTableViewCell ()

@property (nonatomic, strong) UIView *topSeparatorLine;
@property (nonatomic, strong) UIView *bodySeparatorLine;
@property (nonatomic, strong) UIView *bottomSeparatorLine;

@end

@implementation BAOTableViewCell

+ (instancetype)reusableCellWithTableView:(UITableView *)tableView
                          reuseIdentifier:(NSString *)reuseIdentifier {
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault
                           reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupTableViewCellSubviews];
        [self setupTableViewCellAutoLayout];
    }
    return self;
}

#pragma mark - Setup

- (void)setupTableViewCellSubviews {
    [self setupTableViewCellTopSeparatorLine];
    [self setupTableViewCellBodySeparatorLine];
    [self setupTableViewCellBottomSeparatorLine];
}

- (void)setupTableViewCellTopSeparatorLine {
    self.topSeparatorLine = [[UIView alloc] initWithFrame:CGRectZero];
    self.topSeparatorLine.backgroundColor = [self topBottomSeparatorLineColor];
    [self.contentView addSubview:self.topSeparatorLine];
}

- (void)setupTableViewCellBodySeparatorLine {
    self.bodySeparatorLine = [[UIView alloc] initWithFrame:CGRectZero];
    self.bodySeparatorLine.backgroundColor = [self bodySeparatorLineColor];
    [self.contentView addSubview:self.bodySeparatorLine];
}

- (void)setupTableViewCellBottomSeparatorLine {
    self.bottomSeparatorLine = [[UIView alloc] initWithFrame:CGRectZero];
    self.bottomSeparatorLine.backgroundColor = [self topBottomSeparatorLineColor];
    [self.contentView addSubview:self.bottomSeparatorLine];
}

- (void)setupTableViewCellAutoLayout {
    [self.topSeparatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topSeparatorLine.superview);
        make.left.equalTo(self.topSeparatorLine.superview).offset([self topBottomSeparatorLinePaddingLeft]);
        make.right.equalTo(self.topSeparatorLine.superview).offset(-[self topBottomSeparatorLinePaddingRight]);
        make.height.equalTo(@(UI_ONE_PIXEL_HEIGHT));
    }];

    [self.bodySeparatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bodySeparatorLine.superview).offset([self bodySeparatorLinePaddingLeft]);
        make.right.equalTo(self.bodySeparatorLine.superview).offset(-[self bodySeparatorLinePaddingRight]);
        make.bottom.equalTo(self.bodySeparatorLine.superview);
        make.height.equalTo(@(UI_ONE_PIXEL_HEIGHT));
    }];

    [self.bottomSeparatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomSeparatorLine.superview).offset([self topBottomSeparatorLinePaddingLeft]);
        make.right.equalTo(self.bottomSeparatorLine.superview).offset(-[self topBottomSeparatorLinePaddingRight]);
        make.bottom.equalTo(self.bottomSeparatorLine.superview);
        make.height.equalTo(@(UI_ONE_PIXEL_HEIGHT));
    }];
}

#pragma mark - Public Methods

+ (CGFloat)cellHeight {
    NSAssert(NO, @"Need to override");
    return 0;
}

+ (CGFloat)cellHeightWithViewModel:(BAOTableCellViewModel *)viewModel {
    return [self cellHeight];
}

- (CGFloat)bodySeparatorLinePaddingLeft {
    return UI_COMMON_HORIZONTAL_PADDING;
}

- (CGFloat)bodySeparatorLinePaddingRight {
    return 0;
}

- (UIColor *)bodySeparatorLineColor {
    return COLOR_SEPARATOR;
}

- (CGFloat)topBottomSeparatorLinePaddingLeft {
    return 0;
}

- (CGFloat)topBottomSeparatorLinePaddingRight {
    return 0;
}

- (UIColor *)topBottomSeparatorLineColor {
    return COLOR_SEPARATOR;
}

- (void)bindDataWithViewModel:(BAOTableCellViewModel *)viewModel {
    switch (viewModel.separatorType) {
        case BAOTableViewCellSeparatorTypeDefault:
            self.topSeparatorLine.hidden = NO;
            self.bodySeparatorLine.hidden = YES;
            self.bottomSeparatorLine.hidden = NO;
            break;
        case BAOTableViewCellSeparatorTypeHead:
            self.topSeparatorLine.hidden = NO;
            self.bodySeparatorLine.hidden = NO;
            self.bottomSeparatorLine.hidden = YES;
            break;
        case BAOTableViewCellSeparatorTypeBody:
            self.topSeparatorLine.hidden = YES;
            self.bodySeparatorLine.hidden = NO;
            self.bottomSeparatorLine.hidden = YES;
            break;
        case BAOTableViewCellSeparatorTypeTail:
            self.topSeparatorLine.hidden = YES;
            self.bodySeparatorLine.hidden = YES;
            self.bottomSeparatorLine.hidden = NO;
            break;
        case BAOTableViewCellSeparatorTypeNone:
            self.topSeparatorLine.hidden = YES;
            self.bodySeparatorLine.hidden = YES;
            self.bottomSeparatorLine.hidden = YES;
            break;
        default:
            break;
    }
}

@end
