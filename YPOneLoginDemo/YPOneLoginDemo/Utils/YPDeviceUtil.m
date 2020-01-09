//
//  YPDeviceUtil.m
//  YPOneLoginDemo
//
//  Created by qipeng_yuhao on 2019/11/21.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "YPDeviceUtil.h"
#import <UIKit/UIDevice.h>
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import "YPKeychainStoreUtil.h"


@implementation YPDeviceUtil

#pragma mark - public method
+ (NSString *)retrivePhoneMode {
    return [self getSysInfoByName:"hw.machine"];
}

+ (NSString *)retriveBundleId {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return bundleId;
}

+ (NSString *)retriveOSVersion {
    NSString *sysversion = [[UIDevice currentDevice] systemVersion];
    return sysversion;
}

+ (NSString *)retriveAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSNumber *)retriveAppVersionCode {
    NSString *vc = [self retriveAppVersion];
    NSArray *array = [vc componentsSeparatedByString:@"."];
    NSInteger f = 0;
    NSInteger s = 0;
    NSInteger t = 0;
    switch (array.count) {
        case 3:
            f = [array[0] integerValue];
            s = [array[1] integerValue];
            t = [array[2] integerValue];
            break;
        case 2:
            f = [array[0] integerValue];
            s = [array[1] integerValue];
            break;
        case 1:
            f = [array[0] integerValue];
            break;
    }
    if (f >= 1000) {
        NSInteger quotient = f / 10;
        NSInteger remainder = f % 10;
        f = remainder + quotient;
    }
    NSInteger result = f * 1000000 + s * 1000 + t;
    return [NSNumber numberWithInteger:result];
}
#pragma mark - private method
+ (NSString *)getSysInfoByName:(char *)typeSpecifier {
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding:NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

+ (NSString *)retriveIDFA {
    
    NSUUID *uuid = nil;
    
    @try {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        Class class = NSClassFromString(@"ASIdentifierManager");
        SEL sel = NSSelectorFromString(@"sharedManager");
        if (class && [class respondsToSelector:sel]) {
            id objc = [class performSelector:NSSelectorFromString(@"sharedManager")];
            uuid = [objc performSelector:NSSelectorFromString(@"advertisingIdentifier")];
            return uuid ? [uuid UUIDString] : @"";
        } else {
            return @"";
        }
#pragma clang diagnostic pop
    }
    @catch (NSException *exception) {
        return @"";
    }
}

+ (NSString *)retriveAppName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

+ (NSString *)urlEncode:(NSString *)str {
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'\"();:@&=+$,/?%#[]% "].invertedSet];
}




+ (NSString *)MD5:(NSString *)source {
    @try {
        if (!source || ![source isKindOfClass:[NSString class]]) {
            return nil;
        }
        
        const char *cStr = [source UTF8String];
        unsigned char result[16];
        CC_MD5(cStr, (CC_LONG) strlen(cStr), result);
        return [NSString stringWithFormat:
                @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]];
    }
    @catch (NSException *exception) {
        return nil;
    }
}

@end
