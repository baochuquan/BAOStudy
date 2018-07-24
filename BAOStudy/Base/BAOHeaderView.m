//
//  BAOHeaderView.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/25.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOHeaderView.h"

@interface BAOHeaderView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation BAOHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContentView];
    }
    return self;
}

#pragma mark - Setup

- (void)setupContentView {
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(UI_STATUS_BAR_HEIGHT_ALL);
        make.left.bottom.right.equalTo(self);
    }];

    UIView *separatorLine = [[UIView alloc] init];
    separatorLine.backgroundColor = COLOR_SEPARATOR;
    [self.backgroundView addSubview:separatorLine];
    [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(separatorLine.superview);
        make.height.equalTo(@(UI_ONE_PIXEL_HEIGHT));
    }];
}

#pragma mark - Public

+ (instancetype)createHeaderViewInView:(UIView *)view {
    BAOHeaderView *headerView = [[self alloc] initWithFrame:CGRectZero];
    [view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([BAOHeaderView headerViewHeight]));
        make.top.left.right.equalTo(view);
    }];
    return headerView;
}

+ (CGFloat)headerViewHeight {
    return UI_STATUS_BAR_HEIGHT_ALL + UI_NAVIGATION_BAR_HEIGHT;
}

- (void)setTitle:(NSString *)title {
    if (self.titleLabel == nil) {
        [self setupTitleLabel];
    }
    self.titleLabel.alpha = 1;
    self.titleLabel.text = title;
}

- (void)setLeftImageButtonWithImage:(UIImage *)image
                   highlightedImage:(UIImage *)hlImage
                             target:(id)target
                             action:(SEL)action {
    [self setImageButtonWithImage:image
                 highlightedImage:hlImage
                           target:target
                           action:action
                     isLeftButton:YES];
}

- (void)setRightImageButtonWithImage:(UIImage *)image
                    highlightedImage:(UIImage *)hlImage
                              target:(id)target
                              action:(SEL)action {
    [self setImageButtonWithImage:image
                 highlightedImage:hlImage
                           target:target
                           action:action
                     isLeftButton:NO];
}

- (void)setLeftButtonWithText:(NSString *)text target:(id)target action:(SEL)action {
    [self setTextButtonWithText:text target:target action:action isLeftButton:YES];
}

- (void)setRightButtonWithText:(NSString *)text target:(id)target action:(SEL)action {
    [self setTextButtonWithText:text target:target action:action isLeftButton:NO];
}

- (void)setLeftReturnButtonWithTarget:(id)target action:(SEL)action {
    [self setImageButtonWithImage:IMAGE(@"NavigationReturnButton")
                 highlightedImage:IMAGE(@"NavigationReturnButton")
                           target:target action:action isLeftButton:YES];
}

- (void)setLeftCloseButtonWithTarget:(id)target action:(SEL)action {
    [self setImageButtonWithImage:IMAGE(@"NavigationCloseButton")
                 highlightedImage:IMAGE(@"NavigationCloseButton")
                           target:target action:action isLeftButton:YES];
}

- (void)setRightMoreButtonWithTarget:(id)target action:(SEL)action {
    [self setImageButtonWithImage:IMAGE(@"NavigationMoreButton")
                 highlightedImage:IMAGE(@"NavigationMoreButtonPressed")
                           target:target action:action isLeftButton:NO];
}

- (void)removeLeftButton {
    if (self.leftButton) {
        [self.leftButton removeFromSuperview];
        self.leftButton = nil;
    }
}

- (void)removeRightButton {
    if (self.rightButton) {
        [self.rightButton removeFromSuperview];
        self.rightButton = nil;
    }
}

#pragma mark - Private View Utils

- (void)setupTitleLabel {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = FONT_BOLD_SIZE(17);
    self.titleLabel.textColor = COLOR_TITLE;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.height.equalTo(self.contentView);
        make.width.lessThanOrEqualTo(@(UI_SCREEN_WIDTH - 133));
    }];
}

- (void)setTextButtonWithText:(NSString *)text
                       target:(id)target
                       action:(SEL)action
                 isLeftButton:(BOOL)isLeftButton {
    UIButton *button = [self createTextButtonWithText:text target:target action:action];
    CGFloat textWidth = ceilf([text sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width);
    [self updateHeaderWithButton:button contentWidth:textWidth isLeftButton:isLeftButton];
}

- (void)setImageButtonWithImage:(UIImage *)image
               highlightedImage:(UIImage *)hlImage
                         target:(id)target
                         action:(SEL)action
                   isLeftButton:(BOOL)isLeftButton {
    UIButton *button = [self createImageButtonWithImage:image
                                       highlightedImage:hlImage
                                                 target:target
                                                 action:action];
    CGFloat imageWidth = image.size.width;
    [self updateHeaderWithButton:button contentWidth:imageWidth isLeftButton:isLeftButton];

}
- (void)updateHeaderWithButton:(UIButton *)button
                  contentWidth:(CGFloat)contentWidth
                  isLeftButton:(BOOL)isLeftButton {
    button.contentEdgeInsets = UIEdgeInsetsMake(0, UI_COMMON_HORIZONTAL_PADDING, 0, UI_COMMON_HORIZONTAL_PADDING);
    if (isLeftButton) {
        [self.leftButton removeFromSuperview];
        self.leftButton = button;
    } else {
        [self.rightButton removeFromSuperview];
        self.rightButton = button;
    }
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(@(UI_COMMON_HORIZONTAL_PADDING * 2 + contentWidth));
        if (isLeftButton) {
            make.left.equalTo(self.contentView);
        } else {
            make.right.equalTo(self.contentView);
        }
    }];
}

- (UIButton *)createImageButtonWithImage:(UIImage *)image
                        highlightedImage:(UIImage *)hlImage
                                  target:(id)target
                                  action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:hlImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIButton *)createTextButtonWithText:(NSString *)text
                                target:(id)target
                                action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:COLOR_TITLE forState:UIControlStateNormal];
    [button setTitleColor:[COLOR_TITLE colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [button setTitleColor:[COLOR_TITLE colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    return button;
}

@end
