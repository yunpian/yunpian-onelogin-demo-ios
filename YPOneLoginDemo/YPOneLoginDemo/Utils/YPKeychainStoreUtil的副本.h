//
//  YPKeychainStoreUtil.h
//  YPOneLoginDemo
//
//  Created by qipeng_yuhao on 2019/11/21.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPKeychainStoreUtil : NSObject

+ (NSString *)getPasswordForUsername:(NSString *)username
                      andServiceName:(NSString *)serviceName
                               error:(NSError **)error;


+ (BOOL)storeUsername:(NSString *)username
          andPassword:(NSString *)password
       forServiceName:(NSString *)serviceName
       updateExisting:(BOOL)updateExisting
                error:(NSError **)error;


+ (BOOL)deleteItemForUsername:(NSString *)username
               andServiceName:(NSString *)serviceName
                        error:(NSError **)error;


+ (void)saveValue:(NSString *)aValue forKey:(NSString *)aKey inAppKey:(NSString *)aAppKey;
+ (NSString *)getValueForKey:(NSString *)aKey inAppKey:(NSString *)aAppKey;
+ (void)removeValueForKey:(NSString *)aKey inAppKey:(NSString *)aAppKey;

@end

NS_ASSUME_NONNULL_END
