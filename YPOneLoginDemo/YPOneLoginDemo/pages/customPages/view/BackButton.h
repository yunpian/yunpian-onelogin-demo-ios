//
//  BackButton.h
//  YPAuthServiceDemo
//
//  Created by qipeng_yuhao on 2019/11/13.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackButton : UIButton

//重定义文字位置
@property (nonatomic,assign) CGRect titleRect;
//重定义图片位置
@property (nonatomic,assign) CGRect imageRect;

@end

NS_ASSUME_NONNULL_END
