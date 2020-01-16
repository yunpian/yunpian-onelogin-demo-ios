//
//  YPOneLoginSmsViewModel.h
//  YPOneLogin
//
//  Created by daizq on 2019/7/17.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YPCustomBlock)(UIView *customView, UIViewController *vc);

@interface YPOneLoginSmsViewModel : NSObject

@property (nonatomic, strong) UIColor *backgroundColor; // 视图背景色

@property (nonatomic, strong) UIImage *backImage;//返回按钮图片，没有可以不传
@property (nonatomic, copy) NSString *backTitle;//返回文字，没有可以不传
@property (nonatomic, strong) UIColor *backTitleColor;//返回文字颜色，没有可以不传

@property (nonatomic, strong) UIImage *iconImage;//logo图标
@property (nonatomic, strong) NSString *welcomeTitle; // 欢迎标题
@property (nonatomic, strong) NSString *phoneNumber; // 默认手机号码
@property (nonatomic, strong) NSString *phoneNumberPlaceHolder; // 手机号码输入框默认内容
@property (nonatomic, strong) NSString *codePlaceHolder; // 校验码输入框默认内容
@property (nonatomic, strong) UIColor *phoneNumberBackgroundColor; // 手机号码输入框的背景颜色
@property (nonatomic, strong) UIColor *codeBackgroundColor; // 校验码输入框的背景颜色
@property (nonatomic, strong) NSString *sendSmsCodeButtonContent; // 发送校验码按钮文本内容
@property (nonatomic, strong) NSString *checkCodeButtonContent; // 校验短信校验码按钮文本内容
@property (nonatomic, strong) UIColor *checkButtonBackgroundColor; // 确认校验码按钮背景颜色
@property (nonatomic, strong) UIColor *checkButtonTitleColor; // 确认校验码按钮文字颜色
@property (nonatomic, assign) NSInteger countDownInterval; // 短信发送倒计时时长，默认 60 秒
@property (nonatomic, copy) YPCustomBlock customBlock;//自定义view，宽度为屏幕宽度，高度据底部有10

@end

NS_ASSUME_NONNULL_END
