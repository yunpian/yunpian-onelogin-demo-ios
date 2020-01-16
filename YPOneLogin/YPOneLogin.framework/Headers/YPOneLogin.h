//
//  YPOneLoginSDK.h
//  YPOneLogin
//
//  Created by daizq on 2019/5/14.
//  Copyright © 2019 QiPeng. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "OLAuthViewModel.h"
#import "YPOneLoginSmsViewModel.h"


NS_ASSUME_NONNULL_BEGIN

@protocol YPOneLoginDelegate <NSObject>

@optional

/**
 用户点击了授权页面的返回按钮
 */
- (void)userDidDismissAuthViewController;

/**
 用户点击了授权页面的"切换账户"按钮
 */
- (void)userDidSwitchAccount;

@end

@interface YPOneLogin : NSObject


/**
 启动 SDK
 
 @param appId 后台分配的 appId
 @param completion 初始化完成回调
 */
+ (void)startWithAppId:(NSString *)appId  completion:(void(^)(NSDictionary * _Nullable result))completion;


/**
 设置代理对象
 
 @param delegate 代理对象
 */
+ (void)setDelegate:(nullable id<YPOneLoginDelegate>)delegate;


/**
 设置请求超时时长

 @param timeout 单位为s，默认为5s
*/
+ (void)setRequestTimeout:(NSTimeInterval)timeout;


/**
 预取号接口（注意：需要初始化完成后调用本接口）
 token的有效期，中国移动的有效期为 2 分钟，中国联通的为 30 分钟，中国电信的为 30 天。
 
 @param completion 预取号接口回调
 */
+ (void)preGetTokenWithCompletion:(void(^)(NSDictionary *sender))completion;


/**
 请求一键登录验证

 @param viewController 调用一键登录的界面
 @param viewModel      界面自定义模型
 @param completion     一键登录回调
 */
+ (void)requestTokenWithViewController:(UIViewController *)viewController viewModel:(nullable OLAuthViewModel *)viewModel completion:(void(^)(NSDictionary * _Nullable result))completion;


/**
 预取号的token是否还有效，可根据这个判断是否需要加载预取号接口，提高效率
 
 @return YES 是还在有效期， NO 已失效，需要重新加载预取号接口
*/
+ (BOOL)isPreGetTokenValidate;


/**
 手动取消授权页
 
 * @param isAnimal 是否添加动画；默认是YES
 * @param complete 完成回调
 */
+ (void)cancelAuthViewController:(BOOL)isAnimal Complete:(void(^__nullable)(void))complete;


#pragma mark - 短信校验码接口

/**
 短信校验验证界面（注意：调用本接口前要提前调用预取号接口）
 
 @param viewController          调用短信校验的界面
 @param viewModel               界面自定义模型
 @param sendSmsCompletion       发送短信回调
 @param codeVerfiySmsCompletion 验证校验码回调
 */
+ (void)requestSmsTokenWithViewController:(UIViewController *)viewController viewModel:(nullable YPOneLoginSmsViewModel *)viewModel sendSmsCompletion:(void(^)(NSDictionary * _Nullable result))sendSmsCompletion codeVerfiySmsCompletion:(void(^)(NSDictionary * _Nullable result))codeVerfiySmsCompletion;

/**
 *  短信验证接口
 *
 *  @param phoneNumber   手机号
 *  @param callback      验证接口回调
 */
+ (void)requestSmsVerifyWithPhoneNumber:(NSString *)phoneNumber withCallback:(void(^)(NSDictionary *sender))callback;

/**
 *  短信校验接口
 *
 *  @param code     短信验证码
 *  @param callback 验证接口回调
 */
+ (void)smsVerifyCode:(NSString *)code withCallback:(void(^)(NSDictionary *sender))callback;


/**
 SDK 版本号

 @return SDK 版本
 */
+ (NSString *)sdkVersion;


/**
 开启或关闭打印

 * @param isEnabled 是否开启打印，默认是关闭打印
 */
+ (void)setLogEnabled:(BOOL)isEnabled;

@end


NS_ASSUME_NONNULL_END
