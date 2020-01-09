//
//  NSDictionary+changeNSString.m
//  YPOneLoginDemo
//
//  Created by qipeng_yuhao on 2019/11/14.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "NSDictionary+changeNSString.h"


@implementation NSDictionary (changeNSString)

- (NSString *)dictionaryToString
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
