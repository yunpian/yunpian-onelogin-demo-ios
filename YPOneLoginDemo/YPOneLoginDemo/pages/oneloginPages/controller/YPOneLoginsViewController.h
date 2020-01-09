//
//  YPOneLoginsViewController.h
//  YPAuthServiceDemo
//
//  Created by qipeng_yuhao on 2019/11/13.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef  enum{
    TapViewType_full = 0,
    TapViewType_land,
    TapViewType_alert,
    TapViewType_pop
}TapViewType;

@interface YPOneLoginsViewController : YPRootViewController

@end

NS_ASSUME_NONNULL_END
