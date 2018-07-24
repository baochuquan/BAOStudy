//
//  BAOHeaderView.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/25.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAOHeaderView : UIView

@property (nonatomic, strong, readonly) UIView *backgroundView;
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIButton *leftButton;
@property (nonatomic, strong, readonly) UIButton *rightButton;

+ (instancetype)createHeaderViewInView:(UIView *)view;

+ (CGFloat)headerViewHeight;

/// 设置默认样式的标题
- (void)setTitle:(NSString *)title;

/// 设置图片类型的左边按钮
- (void)setLeftImageButtonWithImage:(UIImage *)image
                   highlightedImage:(UIImage *)hlImage
                             target:(id)target
                             action:(SEL)action;

/// 设置图片类型的右边按钮
- (void)setRightImageButtonWithImage:(UIImage *)image
                    highlightedImage:(UIImage *)hlImage
                              target:(id)target
                              action:(SEL)action;

/// 设置 < 样式的左边按钮
- (void)setLeftReturnButtonWithTarget:(id)target
                               action:(SEL)action;

/// 设置文字类型的右边按钮
- (void)setRightButtonWithText:(NSString *)text
                        target:(id)target
                        action:(SEL)action;

/// 设置 X 样式的左边按钮
- (void)setLeftCloseButtonWithTarget:(id)target
                              action:(SEL)action;

/// 设置 ... 样式的右边按钮
- (void)setRightMoreButtonWithTarget:(id)target
                              action:(SEL)action;

/// 移除左边按钮
- (void)removeLeftButton;

/// 移除右边按钮
- (void)removeRightButton;

@end
