//
//  BAORuntimeVarModel.m
//  BAOStudy
//
//  Created by baochuquan on 2018/11/20.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import "BAORuntimeVarModel.h"

@interface BAORuntimeVarModel ()

@property (nonatomic, assign) NSInteger catInt1;

@end

@implementation BAORuntimeVarModel {
    NSString *_insStr1;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _insStr1 = @"insStrValue";
        self.pubStr1 = @"pubStrValue";
        self.pubDict1 = @{@"bao": @"chuquan"};
        self.catInt1 = 10;
    }
    return self;
}

@end
