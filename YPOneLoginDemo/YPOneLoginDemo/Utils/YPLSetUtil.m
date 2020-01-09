//
//  YPLSetUtil.m
//  YPOneLogin
//
//  Created by daizq on 2019/5/15.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "YPLSetUtil.h"

@implementation YPLSetUtil

+ (NSBundle *)getSDKResourceBundle {
    NSString *myBundlePath = [[NSBundle mainBundle] pathForResource:@"OneLoginResource" ofType:@"bundle"];
    NSBundle *myBundle = [NSBundle bundleWithPath:myBundlePath];
    return myBundle;
}

+ (UIImage *)getBundleImageWithName:(NSString *)imageName {
    NSString *imagePath = [[YPLSetUtil getSDKResourceBundle] pathForResource:imageName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

#pragma mark - UI

/** 设置视图圆角 */
+ (void)setViewRadius:(CGFloat)radius toView:(UIView *)view {
    [self setViewRadius:radius borderWidth:0 borderColor:[UIColor clearColor] toView:view];
}

/**
 设置视图圆角、边框、边框颜色
 view:需要添加圆角和边框的视图，必须有
 radius:圆角半径，必须有，0：没有半径
 width:边框半径，必须有，0：没有边框
 color:边框颜色，可以nil，默认黑色
 */
+ (void)setViewRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color toView:(UIView *)view {
    if (!view || ![view isKindOfClass:[UIView class]])
        return; // 视图判断
    
    // 半径判断
    if (radius > 0) {
        [view.layer setMasksToBounds:YES];
        [view.layer setCornerRadius:radius]; // 设置圆角半径
    } else {
        [view.layer setMasksToBounds:NO];
        [view.layer setCornerRadius:0];
    }
    
    // 宽度判断
    if (width > 0) {                       // 边框宽度和颜色
        [view.layer setBorderWidth:width]; // 设置边框宽度
        
        UIColor *borderColor = color; // 边框颜色
        borderColor = color ? color : [UIColor blackColor];
        
        [view.layer setBorderColor:[borderColor CGColor]]; // 设置边框颜色
    } else {
        [view.layer setBorderWidth:0];   // 设置边框宽度
        [view.layer setBorderColor:nil]; // 设置边框颜色
    }
}

// 是否刘海屏
+ (BOOL)isBangSreen {
    if (@available(iOS 11.0, *)) {
        if (UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom > 0.0) {
            return YES;
        }
    }
    return NO;
}

// 导航栏高度，不同机型不同
+ (float)naviHeigt {
    return [self isBangSreen] ? 68 : 44;
}

#pragma mark - color image

+ (UIImage *)createImageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (NSString *)urlEncode:(NSString *)str {
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'\"();:@&=+$,/?%#[]% "].invertedSet];
}

@end
