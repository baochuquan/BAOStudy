//
//  Header.h
//  BAOStudy
//
//  Created by baochuquan on 2018/7/24.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#ifndef BAOUIConstants_h
#define BAOUIConstants_h


/// 几何信息常量
#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define UI_STATUS_BAR_HEIGHT            20
#define UI_STATUS_BAR_HEIGHT_X          44
#define UI_STATUS_BAR_HEIGHT_ALL        (IS_IPHONE_X ? UI_STATUS_BAR_HEIGHT_X : UI_STATUS_BAR_HEIGHT)

#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TAB_BAR_HEIGHT               49

#define UI_COMMON_VERTICAL_PADDING      16
#define UI_COMMON_HORIZONTAL_PADDING    16
#define UI_BOTTOM_PADDING               (IS_IPHONEX ? 34 : 0)

#define UI_ONE_PIXEL_HEIGHT             ([UIScreen mainScreen].scale < 1.5 ? 1 : ([UIScreen mainScreen].scale < 2.5 ? 0.5 : 0.3))


/// 颜色信息常量
#define HEXCOLOR(hex)                   [UIColor colorWithRed:((float)(((hex) & 0xFF0000) >> 16))/255.0 green:((float)(((hex) & 0xFF00) >> 8))/255.0 blue:((float)((hex) & 0xFF))/255.0 alpha:1.0]
#define COLOR_SEPARATOR                 HEXCOLOR(0xE9E9E9)
#define COLOR_TITLE                     HEXCOLOR(0x272727)
#define COLOR_SUB_TITLE                 HEXCOLOR(0x7A7A7A)
#define COLOR_SECONDARY_TEXT            HEXCOLOR(0x909090)
#define COLOR_BACKGROUND                HEXCOLOR(0xFAFAFA)
#define COLOR_SEPARATOR                 HEXCOLOR(0xE9E9E9)

#define COLOR_RED_DEFAULT               HEXCOLOR(0xFA374B)
#define COLOR_BLUE_DEFAULT              HEXCOLOR(0x0099FF)
#define COLOR_YELLOW_DEFAULT            HEXCOLOR(0xFFC021)


/// 字体信息常量
#define FONT_BOLD_SIZE(size)            ([UIFont boldSystemFontOfSize:size])
#define FONT_SIZE(size)                 ([UIFont systemFontOfSize:size])
#define FONT_SIZE_12                    FONT_SIZE(12)
#define FONT_SIZE_13                    FONT_SIZE(13)
#define FONT_SIZE_14                    FONT_SIZE(14)
#define FONT_SIZE_15                    FONT_SIZE(15)
#define FONT_SIZE_16                    FONT_SIZE(16)
#define FONT_SIZE_17                    FONT_SIZE(17)
#define FONT_SIZE_18                    FONT_SIZE(18)
#define FONT_SIZE_19                    FONT_SIZE(19)
#define FONT_SIZE_20                    FONT_SIZE(20)

#endif /* Header_h */
