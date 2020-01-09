//
//  DemoUtil.m
//  YPOneLoginDemo
//
//  Created by daizq on 2019/5/30.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "DemoUtil.h"

@implementation DemoUtil

+ (NSString *)stringFromDic:(NSDictionary *)dic{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    @try {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:&error];
        if (!jsonData || error) {
            
            return nil;
        }
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (jsonString) {
            return jsonString;
        }
    }
    @catch (NSException *exception) {
        
    }
    
    return nil;
    
}

+ (NSString *)stringFromArray:(NSArray *)array{
    if (!array || ![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    @try {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:&error];
        if (!jsonData || error) {
            
            return nil;
        }
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (jsonString) {
            return jsonString;
        }
    }
    @catch (NSException *exception) {
        
    }
    
    return nil;
}

+ (NSData *)dataFromDictionary:(NSDictionary *)dictionary{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    @try {
        NSError *error = nil;
        // iOS5中，苹果引入了一个解析JSON串的NSJSONSerialization类
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
        if (!jsonData || error) {
            
            return nil;
        }
        
        return jsonData;
    }
    @catch (NSException *exception) {
        
    }
    
    return nil;
}

+ (id)objectFromJsonData:(NSData *)jsonData{
    if (!jsonData || ![jsonData isKindOfClass:[NSData class]]) {
        return nil;
    }
    
    @try {
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if (!jsonObject || error) {
            
            return nil;
        }
        return jsonObject;
    }
    @catch (NSException *exception) {
        
    }
    
    return nil;
}

+ (id)objectFromJsonString:(NSString *)aJsonString{
    if (!aJsonString || ![aJsonString isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    @try {
        NSString *jsonString = [aJsonString stringByReplacingOccurrencesOfString:@"\":null" withString:@"\":\"\""];
        
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        if (!jsonData) {
            return nil;
        }
        
        NSError *error = nil;
        
        
        id jsonObject = [self objectFromJsonData:jsonData];
        if (!jsonObject || error) {
            
            return nil;
        }
        return jsonObject;
    }
    @catch (NSException *exception) {
        
    }
    
    return nil;
    
}
@end
