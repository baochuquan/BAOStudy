//
//  BAOAnimationLottieViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/31.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAOAnimationLottieViewController.h"
#import <Lottie/Lottie.h>

@interface BAOAnimationLottieViewController ()

@property (nonatomic, strong) LOTAnimationView *laAnimation;
@property (nonatomic, strong) UIButton *playButton;

@end

@implementation BAOAnimationLottieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [self setupAutoLayout];
}

#pragma mark - Setup

- (void)setupSubviews {
    NSString *URL = [NSString stringWithFormat:@"file://%@", [[NSBundle mainBundle] pathForResource:@"TwitterHeart.json" ofType:nil]];
    self.laAnimation = [[LOTAnimationView alloc] initWithContentsOfURL:[NSURL URLWithString:URL]];
    self.laAnimation.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.laAnimation];

    self.playButton = [[UIButton alloc] init];
    self.playButton.layer.cornerRadius = 25;
    self.playButton.layer.masksToBounds = YES;
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    [self.playButton setBackgroundColor:COLOR_RED_DEFAULT];
    [self.playButton addTarget:self
                        action:@selector(playButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.playButton];
}

- (void)setupAutoLayout {
    [self.laAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.laAnimation.superview);
    }];

    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.playButton.superview);
        make.width.height.equalTo(@50);
        make.bottom.equalTo(self.playButton.superview).offset(- UI_BOTTOM_PADDING - UI_COMMON_VERTICAL_PADDING);
    }];
}

#pragma mark - Button Actions

- (void)playButtonPressed:(UIButton *)button {
    if (self.laAnimation.isAnimationPlaying) {
        [self.laAnimation pause];
    } else {
        [self.laAnimation playWithCompletion:^(BOOL animationFinished) {
            NSLog(@"Animation Finished");
        }];
    }
}

@end
