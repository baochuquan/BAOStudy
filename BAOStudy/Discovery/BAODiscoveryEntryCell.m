//
//  BAODiscoveryEntryCell.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/29.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAODiscoveryEntryCell.h"
#import "BAODiscoveryEntryCellViewModel.h"

static const CGFloat CellHeight = 55;

@interface BAODiscoveryEntryCell ()

@property (nonatomic, strong) UILabel *title;

@end

@implementation BAODiscoveryEntryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
        [self setupAutoLayout];
    }
    return self;
}

#pragma mark - Setup

- (void)setupSubviews {
    self.title = [[UILabel alloc] init];
    self.title.font = FONT_SIZE_14;
    self.title.textColor = COLOR_TITLE;
    self.title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.title];
}

- (void)setupAutoLayout {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.superview).offset(UI_COMMON_VERTICAL_PADDING);
        make.left.equalTo(self.title.superview).offset(UI_COMMON_HORIZONTAL_PADDING);
    }];
}

#pragma mark - Override

+ (CGFloat)cellHeight {
    return CellHeight;
}

- (void)bindDataWithViewModel:(BAODiscoveryEntryCellViewModel *)viewModel {
    [super bindDataWithViewModel:viewModel];
    self.title.text = viewModel.title;
}

@end
