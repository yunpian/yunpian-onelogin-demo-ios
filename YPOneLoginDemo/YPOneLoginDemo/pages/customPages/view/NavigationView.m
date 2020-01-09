//
//  NavigationView.m
//  YPVerifyApp
//
//  Created by daizq on 2019/5/24.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "NavigationView.h"
#import "YPLSetUtil.h"
#import "QPCFunctionConst.h"

@implementation NavigationView

- (instancetype)initWithTitle:(NSString *)title{
    // 顶部导航栏
    CGRect topViewFrame = CGRectMake(0, 0, F_QPScreenWidth, [YPLSetUtil naviHeigt] + [UIApplication sharedApplication].statusBarFrame.size.height);
    self = [[NavigationView alloc] initWithFrame:topViewFrame];
    [self setBackgroundColor:YP_DefaultBlueColor];
    // 顶部导航标题
    float height = 18.0;
    UILabel *topTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, topViewFrame.size.height - height - 15, topViewFrame.size.width, height)];
    [topTitleLabel setTextAlignment:NSTextAlignmentCenter];
    topTitleLabel.text = title;
    [topTitleLabel setFont:[UIFont systemFontOfSize:height]];
    [topTitleLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:topTitleLabel];
    return self;
}

@end
