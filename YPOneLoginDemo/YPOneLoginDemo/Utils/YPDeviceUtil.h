//
//  YPDeviceUtil.h
//  YPOneLoginDemo
//
//  Created by qipeng_yuhao on 2019/11/21.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPDeviceUtil : NSObject

+ (NSString *)retrivePhoneMode;     //手机型号
+ (NSString *)retriveOSVersion;     //系统版本
+ (NSString *)retriveBundleId;     //boundleid
+ (NSString *)retriveAppVersion;
+ (NSNumber *)retriveAppVersionCode;
+ (NSString *)retriveIDFA; //IDFA
+ (NSString *)retriveAppName;
+ (NSString *)urlEncode:(NSString *)str;
+ (NSString *)MD5:(NSString *)source;

@end

NS_ASSUME_NONNULL_END
