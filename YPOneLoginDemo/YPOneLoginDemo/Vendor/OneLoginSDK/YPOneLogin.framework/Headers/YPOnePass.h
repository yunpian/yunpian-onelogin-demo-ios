//
//  YPOnePass.h
//  YPOneLogin
//
//  Created by qipeng_yuhao on 2020/3/24.
//  Copyright © 2020 QiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPOneLoginSmsViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPOnePass : NSObject

/**
 初始化接口
 * @param appId   云片appId
 * @param timeout 超时时间
 * @return        类实例对象
 */
- (instancetype)initWithAppId:(NSString *)appId timeout:(NSTimeInterval)timeout;

/**
 本机号码校验接口

 * @param phoneNum 待验证手机号
 * @param success  成功回调
 * @param fail     失败回调
 */
- (void)verifyPhoneNumber:(NSString *)phoneNum onSuccess:(void (^)(NSDictionary *dicInfo))success onFail:(void (^)(NSDictionary *dicInfo))fail;


#pragma mark - 短信校验码接口

/**
 短信校验验证界面
 
 * @param viewController          调用短信校验的界面
 * @param viewModel               界面自定义模型
 * @param sendSmsCompletion       发送短信回调
 * @param codeVerfiySmsCompletion 验证校验码回调
 */
- (void)requestSmsTokenWithViewController:(UIViewController *)viewController viewModel:(nullable YPOneLoginSmsViewModel *)viewModel sendSmsCompletion:(void(^)(NSDictionary * _Nullable result))sendSmsCompletion codeVerfiySmsCompletion:(void(^)(NSDictionary * _Nullable result))codeVerfiySmsCompletion;

/**
 *  短信验证接口
 *
 *  @param phoneNumber   手机号
 *  @param callback      验证接口回调
 */
- (void)requestSmsVerifyWithPhoneNumber:(NSString *)phoneNumber withCallback:(void(^)(NSDictionary *sender))callback;

/**
 *  短信校验接口
 *
 *  @param code     短信验证码
 *  @param callback 验证接口回调
 */
- (void)smsVerifyCode:(NSString *)code withCallback:(void(^)(NSDictionary *sender))callback;


@end

NS_ASSUME_NONNULL_END
