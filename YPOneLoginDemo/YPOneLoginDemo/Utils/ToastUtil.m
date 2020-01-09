//
//  ToastUtil.m
//  YPOneLoginDemo
//
//  Created by qipeng_yuhao on 2019/11/14.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "ToastUtil.h"

@implementation ToastUtil

+ (UIAlertController *)UIAlertViewTitle:(NSString *)title WithMessage:(NSString *)message WithCancelTitle:(NSString *)cancelTitle CancelClick:(void(^)(void))cancelClick{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelClick();
    }];
    [alertController addAction:cancelAction];
    return alertController;
}
@end
