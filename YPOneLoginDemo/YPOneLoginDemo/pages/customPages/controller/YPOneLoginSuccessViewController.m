//
//  YPOneLoginSuccessViewController.m
//  YPAuthServiceDemo
//
//  Created by qipeng_yuhao on 2019/11/13.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "YPOneLoginSuccessViewController.h"

@interface YPOneLoginSuccessViewController ()

@property (nonatomic, strong) UIImageView *successLogoImageView;

@property (nonatomic, strong) UILabel *iphoneNumMaskLabel;

@property (nonatomic, strong) UILabel *loginSuccessLabel;

@property (nonatomic, strong) UIButton *againBtn;

@end

@implementation YPOneLoginSuccessViewController

#pragma mark - Getter
- (UIImageView *)successLogoImageView{
    if (!_successLogoImageView) {
        _successLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg4"]];
    }
    return _successLogoImageView;
}

- (UILabel *)iphoneNumMaskLabel{
    if (!_iphoneNumMaskLabel) {
        _iphoneNumMaskLabel = [[UILabel alloc] init];
        _iphoneNumMaskLabel.textColor = Black2Color;
        [_iphoneNumMaskLabel setFont:[UIFont systemFontOfSize:25]];
        _iphoneNumMaskLabel.text = self.iphoneNum.length>0?self.iphoneNum:@"";
    }
    return _iphoneNumMaskLabel;
}

- (UILabel *)loginSuccessLabel{
    if (!_loginSuccessLabel) {
        _loginSuccessLabel = [[UILabel alloc] init];
        _loginSuccessLabel.text = self.successInfo;
        _loginSuccessLabel.textColor = Black2Color;
        [_loginSuccessLabel setFont:[UIFont systemFontOfSize:25]];
    }
    return _loginSuccessLabel;
}

- (UIButton *)againBtn{
    if (!_againBtn) {
        _againBtn = [[UIButton alloc] init];
        _againBtn.backgroundColor = Blue0Color;
        _againBtn.layer.cornerRadius = 5;
        [_againBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_againBtn setTitle:@"再试一次" forState:UIControlStateNormal];
        [_againBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_againBtn addTarget:self action:@selector(againClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _againBtn;
}

#pragma mark - view life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self resetNavBarIsBlue:NO];
    self.navigationController.navigationBar.hidden = YES;

    [self.view addSubview:self.successLogoImageView];
    [self.view addSubview:self.iphoneNumMaskLabel];
    [self.view addSubview:self.loginSuccessLabel];
    [self.view addSubview:self.againBtn];

    if ([[UIDevice currentDevice]   respondsToSelector:@selector(setOrientation:)]) {
            SEL selector =     NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            int val =UIInterfaceOrientationPortrait;
            [invocation setArgument:&val atIndex:2];
            [invocation invoke];
        }

}



- (void)viewDidLayoutSubviews{
    [_successLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(35 + StatusBarH + SafeTop);
        } else {
            make.top.mas_equalTo(35 + StatusBarH);
        }
        make.centerX.equalTo(self.view);
    }];
    
    [_iphoneNumMaskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successLogoImageView.mas_bottom).mas_offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    [_loginSuccessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iphoneNumMaskLabel.mas_bottom).mas_offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    [_againBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginSuccessLabel.mas_bottom).mas_offset(40);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(60);
    }];
}


#pragma mark - click
- (void)againClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
