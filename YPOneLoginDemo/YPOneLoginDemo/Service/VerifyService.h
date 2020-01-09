//
//  VerifyService.h
//  YPOneLoginDemo
//
//  Created by daizq on 2019/5/22.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerifyService : NSObject

+ (void)validateCid:(NSString *)cid complete:(void(^)(NSDictionary *))complete;

+ (void)validateTokenAndGetLoginInfo:(NSDictionary *)params completion:(void(^)(NSDictionary *data))complete;

@end

NS_ASSUME_NONNULL_END
