//
//  TypesFormUtil.m
//  YPOneLoginDemo
//
//  Created by qipeng_yuhao on 2019/11/18.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "TypesFormUtil.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation TypesFormUtil

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    for (int i = 0; i < count; i++) {
        
        // 实例变量
        Ivar ivar = ivarList[i];
        
        // 获取成员属性名
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [ivarName substringFromIndex:1];
        
        id value = dict[key];
        if (value == nil) {
            continue;
        }
        
        // 获得成员变量的类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSLog(@"ivar - %@, type - %@", ivarName, ivarType);
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            
            Class modelClass = NSClassFromString(ivarType);
            value = [modelClass modelWithDict:value];
            
        } else if ([value isKindOfClass:[NSArray class]]) {

//            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
//            
//                NSString *type = [dict arrayContainModelClass][key];
//                Class classModel = NSClassFromString(type);
//                NSMutableArray *arrM = [NSMutableArray array];
//                for (NSDictionary *dict in value) {
//                    id model =  [classModel modelWithDict:dict];
//                    if (model) {
//                        [arrM addObject:model];
//                    }
//                }
//
//                value = arrM;
//            }
        }

        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}
@end
