//
//  CommonToastHUD.h
//  Objective-C Utils
//
//  Created by 赵伟 on 15/3/4.
//  Copyright (c) 2015年 赵伟. All rights reserved.
//
//  HUD提示共同方法
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonToastHUD : NSObject

+ (CommonToastHUD *)sharedInstance;

/** 温馨提示 */
- (void)showTips:(NSString *)message;

/** 显示锁屏提示 - 所有提示公用一个 */
- (void)showActivityView:(NSString *)msg;

/** 隐藏锁屏提示 */
- (void)hideActivityView;

- (void)showActivityViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle;
@end
