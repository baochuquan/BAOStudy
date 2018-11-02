//
//  BAOLogicConstants.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/25.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#ifndef BAOLogicConstants_h
#define BAOLogicConstants_h


#define IMAGE(name)                     [UIImage imageNamed:name]


/// 设备信息常量
#define IS_IPHONE                       ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPAD                         ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE_X                     ([[UIScreen mainScreen] nativeBounds].size.height == 2436)


/// 操作系统信息常量
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define IS_IOS9                         SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define IS_IOS11                        SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")

#endif /* BAOLogicConstants_h */
