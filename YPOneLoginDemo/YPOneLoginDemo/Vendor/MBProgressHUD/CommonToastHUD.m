//
//  CommonToastHUD.m
//  Objective-C Utils
//
//  Created by 赵伟 on 15/3/4.
//  Copyright (c) 2015年 赵伟. All rights reserved.
//

#import "CommonToastHUD.h"
#import "AppDelegate.h"
#import "QPDemoDefine.h"
#import "MBProgressHUD.h"
#import "WaitLoadView.h"

#define kAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate

@interface CommonToastHUD () {
}

@property (strong, nonatomic) MBProgressHUD *HUD;

@end

@implementation CommonToastHUD

+ (CommonToastHUD *)sharedInstance {
    static CommonToastHUD *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/* 温馨提示 */
- (void)showTips:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!message || [@"" isEqualToString:message])
            return;
        
        UIView *superView = [UIApplication sharedApplication].keyWindow;
        
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:superView];
        [superView addSubview:hud];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = message;
        hud.detailsLabelFont = [UIFont systemFontOfSize:16];
        hud.margin = 10.f;
        hud.userInteractionEnabled = NO;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud show:YES];
        [hud hide:YES afterDelay:1.0f];
    });
}

/** 显示锁屏提示 - 所有提示公用一个 */
- (void)showActivityView:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self->_HUD) {
            [self->_HUD removeFromSuperview];
            self->_HUD = nil;
        }
        
        UIView *superView = [UIApplication sharedApplication].keyWindow;
        
        self.HUD = [[MBProgressHUD alloc] initWithView:superView];
        [superView addSubview:self->_HUD];
        
        self->_HUD.mode = MBProgressHUDModeIndeterminate;
        self->_HUD.activityIndicatorColor = [UIColor whiteColor];
        self->_HUD.labelText = msg;
        self->_HUD.margin = 20;
        
        self->_HUD.dimBackground = NO; //使背景成黑灰色，让MBProgressHUD成高亮显示
        self->_HUD.square = NO;        //设置显示框的高度和宽度一样
        self->_HUD.color = [UIColor blackColor];
        
        self->_HUD.backgroundColor = kRGBA(1, 1, 1, 0.5); // 背景颜色
        
        [self->_HUD show:YES];
    });
}
/** 带有子标题的HUD */
- (void)showActivityViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    if (_HUD) {
        [_HUD removeFromSuperview];
        _HUD = nil;
    }
    
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    
    self.HUD = [[MBProgressHUD alloc] initWithView:superView];
    [superView addSubview:_HUD];
    
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.activityIndicatorColor = [UIColor blackColor];
    _HUD.labelText = title;
    
    _HUD.detailsLabelText = subTitle;
    _HUD.margin = 20;
    
    _HUD.dimBackground = NO; //使背景成黑灰色，让MBProgressHUD成高亮显示
    _HUD.square = NO;        //设置显示框的高度和宽度一样
    _HUD.color = [UIColor blackColor];
    
    _HUD.backgroundColor = kRGBA(1, 1, 1, 0.5); // 背景颜色
    
    [_HUD show:YES];
}
/** 隐藏锁屏提示 */
- (void)hideActivityView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_HUD removeFromSuperview];
    });
}

@end
