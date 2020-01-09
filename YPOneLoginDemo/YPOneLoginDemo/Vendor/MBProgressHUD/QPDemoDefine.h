//
//  QPDemoDefine.h
//  YPVerifyDemo
//
//  Created by daizq on 2019/5/9.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#ifndef QPDemoDefine_h
#define QPDemoDefine_h

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]

//获取屏幕 宽度、高度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenFrame ([UIScreen mainScreen].bounds)

#pragma mark - 颜色
// rgb颜色转换（16进制->10进制）
#define kColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0f]
#define kColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:alphaValue]

// 获取RGB颜色
#define kRGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]
#define kRGB(r, g, b) kRGBA(r, g, b, 1.0f)


#endif /* QPDemoDefine_h */
