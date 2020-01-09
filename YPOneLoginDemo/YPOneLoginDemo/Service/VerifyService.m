//
//  VerifyService.m
//  YPOneLoginDemo
//
//  Created by daizq on 2019/5/22.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "VerifyService.h"
#import "DemoUtil.h"

@implementation VerifyService

// 使用token获取用户的登录信息
+ (void)validateCid:(NSString *)cid complete:(void(^)(NSDictionary *))complete{

    NSURL *url = [NSURL URLWithString:TEST_ACQUIREPHONE];

    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:(NSURLRequestCachePolicy)0 timeoutInterval:10.0];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:cid  forKey:@"cid"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:(NSJSONWritingOptions)0 error:nil];
    
    mRequest.HTTPMethod = @"POST";
    mRequest.HTTPBody = data;
    [mRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [[[NSURLSession sharedSession] dataTaskWithRequest:mRequest
                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                         NSDictionary *dic = [DemoUtil objectFromJsonData:data];
                                         if (complete) {
                                             complete(dic);
                                         }
                                     }] resume];
}

// 使用token获取用户的登录信息
+ (void)validateTokenAndGetLoginInfo:(NSDictionary *)params completion:(void(^)(NSDictionary *))complete{
    
    NSURL *url = [NSURL URLWithString:TEST_ACQUIREPHONE];
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:url];
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:(NSJSONWritingOptions)0 error:nil];
    mRequest.HTTPMethod = @"POST";
    mRequest.HTTPBody = data;
    [mRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:mRequest
                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                         NSDictionary *dic = [DemoUtil objectFromJsonData:data];
                                         NSLog(@"result data: %@", dic);
                                         if (complete) {
                                             complete(dic);
                                         }
                                     }] resume];
    
}

@end
