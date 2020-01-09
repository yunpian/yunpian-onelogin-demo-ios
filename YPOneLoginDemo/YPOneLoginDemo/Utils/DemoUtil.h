//
//  DemoUtil.h
//  YPOneLoginDemo
//
//  Created by daizq on 2019/5/30.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoUtil : NSObject

+ (NSString *)stringFromDic:(NSDictionary *)dic;
+ (NSData *)dataFromDictionary:(NSDictionary *)dictionary;
+ (NSString *)stringFromArray:(NSArray *)array;
+ (id)objectFromJsonData:(NSData *)jsonData;
+ (id)objectFromJsonString:(NSString *)aJsonString;

@end

NS_ASSUME_NONNULL_END
