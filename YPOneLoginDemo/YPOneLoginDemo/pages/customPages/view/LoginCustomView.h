//
//  LoginCustomView.h
//  YPAuthServiceDemo
//
//  Created by qipeng_yuhao on 2019/11/14.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginCustomModel.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^LoginTypeBlock)(NSInteger tag);

@interface LoginCustomView : UIView

@property (nonatomic, copy) LoginTypeBlock loginTypeBlock;

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray<LoginCustomModel *> *)array Complete:(LoginTypeBlock)complete;

@end

NS_ASSUME_NONNULL_END
