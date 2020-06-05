//
//  NSString+extension.m
//  YPOneLoginDemo
//
//  Created by qipeng_yuhao on 2019/11/14.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "NSString+extension.h"


@implementation NSString (extension)

- (BOOL)isPhoneNumber
{
    return [self match:@"^1[35789]\\d{9}$"];
    
}

- (BOOL)match:(NSString *)pattern
{
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return results.count > 0;
}

@end
