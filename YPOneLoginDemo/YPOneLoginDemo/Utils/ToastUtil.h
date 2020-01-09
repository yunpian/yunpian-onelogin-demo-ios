//
//  ToastUtil.h
//  YPOneLoginDemo
//
//  Created by qipeng_yuhao on 2019/11/14.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToastUtil : NSObject

+ (UIAlertController *)UIAlertViewTitle:(NSString *)title WithMessage:(NSString *)message WithCancelTitle:(NSString *)cancelTitle CancelClick:(void(^)(void))cancelClick;

@end

NS_ASSUME_NONNULL_END
