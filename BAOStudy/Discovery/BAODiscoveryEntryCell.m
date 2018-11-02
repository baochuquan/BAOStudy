//
//  BAODiscoveryEntryCell.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/29.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAODiscoveryEntryCell.h"
#import "BAODiscoveryEntryCellViewModel.h"

static const CGFloat CellHeight = 65;

@interface BAODiscoveryEntryCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

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
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = FONT_SIZE_14;
    self.titleLabel.textColor = COLOR_TITLE;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.titleLabel];

    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.font = FONT_SIZE(10);
    self.descriptionLabel.textColor = COLOR_SUB_TITLE;
    self.descriptionLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.descriptionLabel];
}

- (void)setupAutoLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.superview).offset(UI_COMMON_VERTICAL_PADDING);
        make.left.equalTo(self.titleLabel.superview).offset(UI_COMMON_HORIZONTAL_PADDING);
    }];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        make.left.equalTo(self.descriptionLabel.superview).offset(UI_COMMON_HORIZONTAL_PADDING);
    }];
}

#pragma mark - Override

+ (CGFloat)cellHeight {
    return CellHeight;
}

- (void)bindDataWithViewModel:(BAODiscoveryEntryCellViewModel *)viewModel {
    [super bindDataWithViewModel:viewModel];
    self.titleLabel.text = viewModel.title;
    self.descriptionLabel.text = viewModel.descr;
}

@end
