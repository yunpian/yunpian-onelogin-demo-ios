//
//  YPLSetUtil.h
//  YPOneLogin
//
//  Created by daizq on 2019/5/15.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPLSetUtil : NSObject

+ (NSBundle *)getSDKResourceBundle;
+ (UIImage *)getBundleImageWithName:(NSString *)imageName;

// 导航栏高度
+ (float)naviHeigt;
// 是否刘海屏
+ (BOOL)isBangSreen;

+ (void)setViewRadius:(CGFloat)radius toView:(UIView *)view;
+ (void)setViewRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color toView:(UIView *)view;

// color 转 image
+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (NSString *)urlEncode:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
