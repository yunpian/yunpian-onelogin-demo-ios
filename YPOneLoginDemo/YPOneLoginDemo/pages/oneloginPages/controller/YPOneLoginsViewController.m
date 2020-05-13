//
//  YPOneLoginsViewController.m
//  YPOneLoginDemo
//
//  Created by qipeng_yuhao on 2019/11/13.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "YPOneLoginsViewController.h"
#import "AppDelegate.h"
#import "DisplayIconView.h"
#import "LoginCustomView.h"
#import "CommonToastHUD.h"
#import "SuccessViewController.h"
#import "DemoUtil.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface YPOneLoginsViewController ()<DisplayViewDelegate>

@property (strong, nonatomic) UIImageView *bgImageView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIView *selectModelView;

@property (strong, nonatomic) UILabel *versionInfoLabel;

@property (strong, nonatomic) UIImageView *iphoneLogoImageView;

@property (strong, nonatomic) OLAuthViewModel *olAuthModel;

@property (strong, nonatomic) NSMutableArray *itemsArray;

@property (copy, nonatomic) NSString *maskIphoneNum;

@property (strong, nonatomic) MBProgressHUD *progressHUD;

@end

@implementation YPOneLoginsViewController

#pragma mark - Getter
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _bgImageView.backgroundColor = Blue0Color;
        UIImageView *brokenLineImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        brokenLineImageView.image = [UIImage imageNamed:@"bg2"];
        [_bgImageView addSubview:brokenLineImageView];
    }
    return _bgImageView;
}

- (UIImageView *)iphoneLogoImageView{
    if (!_iphoneLogoImageView) {
        _iphoneLogoImageView = [[UIImageView alloc] init];
        _iphoneLogoImageView.image = [UIImage imageNamed:@"bg3"];
    }
    return _iphoneLogoImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"一键登录";
        _titleLabel.textColor = UIColor.whiteColor;
        [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UIView *)selectModelView{
    if (!_selectModelView) {
        _selectModelView = [[UIView alloc] init];
        DisplayIconView *fullScreenView = [[DisplayIconView alloc] initWithFrame:CGRectMake(0, 0, 120, 120) withTitle:@"全屏展示" withImage:[UIImage imageNamed:@"quanpingzhanshi"] isTransform:NO];
        fullScreenView.displayDelegate = self;
        fullScreenView.tag = TapViewType_full;
        [_selectModelView addSubview:fullScreenView];
        
        DisplayIconView *landscapeView = [[DisplayIconView alloc] initWithFrame:CGRectMake(130, 0, 120, 120) withTitle:@"横屏展示" withImage:[UIImage imageNamed:@"quanpingzhanshi"] isTransform:YES];
        landscapeView.displayDelegate = self;
        landscapeView.tag = TapViewType_land;
        [_selectModelView addSubview:landscapeView];
        
        DisplayIconView *alertScreenView = [[DisplayIconView alloc] initWithFrame:CGRectMake(0, 130, 120, 120) withTitle:@"浮窗展示" withImage:[UIImage imageNamed:@"fuchuangzhanshi"] isTransform:NO];
        alertScreenView.displayDelegate = self;
        alertScreenView.tag = TapViewType_alert;
        [_selectModelView addSubview:alertScreenView];

        DisplayIconView *popScreenView = [[DisplayIconView alloc] initWithFrame:CGRectMake(130, 130, 120, 120) withTitle:@"弹窗展示" withImage:[UIImage imageNamed:@"tanchuangzhanshi"] isTransform:NO];
        popScreenView.displayDelegate = self;
        popScreenView.tag = TapViewType_pop;
        [_selectModelView addSubview:popScreenView];
    }
    
    return _selectModelView;
}

- (UILabel *)versionInfoLabel{
    if (!_versionInfoLabel) {
        _versionInfoLabel = [[UILabel alloc] init];
        _versionInfoLabel.text = [TEST_HOST isEqualToString:@"https://mobileauth.yunpian.com"]?@"云片移动认证产品体验v2.1.0":@"测试环境";
        _versionInfoLabel.textColor = UIColor.whiteColor;
        if (@available(iOS 8.2, *)) {
            _versionInfoLabel.font = [UIFont systemFontOfSize:11 weight:0.5];
        } else {
            _versionInfoLabel.font = [UIFont systemFontOfSize:11];
        }
        _versionInfoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionInfoLabel;
}

- (NSMutableArray *)itemsArray{
    _itemsArray = [NSMutableArray array];
    NSArray *icons = @[@"account",@"wechat",@"weibo"];
    for (int i=0; i<icons.count; i++) {
        LoginCustomModel *model = [[LoginCustomModel alloc] init];
        model.icon = [UIImage imageNamed:icons[i]];
        [_itemsArray addObject:model];
    }
    return _itemsArray;
}


- (OLAuthViewModel *)olAuthModel{
        _olAuthModel = [[OLAuthViewModel alloc] init];
        _olAuthModel.appLogo = [UIImage imageNamed:@"Shape"];
        
    return _olAuthModel;
}

- (MBProgressHUD *)progressHUD{
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        _progressHUD.color = UIColor.blackColor;
        _progressHUD.labelColor = UIColor.whiteColor;
        _progressHUD.animationType = MBProgressHUDAnimationFade;
        _progressHUD.cornerRadius = 5;
        _progressHUD.mode = MBProgressHUDModeText;
        [[UIApplication sharedApplication].keyWindow addSubview:_progressHUD];
    }
    return _progressHUD;
}


#pragma mark - view life

- (void)dealloc{
    NSLog(@"YPOneLoginsViewController 被成功释放");
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self resetNavBarIsBlue:YES];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.iphoneLogoImageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.selectModelView];
    [self.view addSubview:self.versionInfoLabel];
    
    // 上线时注意关闭打印
    [YPOneLogin setLogEnabled:NO];
    
    // 初始化
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [YPOneLogin startWithAppId:AppIDKey completion:^(NSDictionary * _Nullable result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([result[@"status"] integerValue] == 200) {
            DebugLog(@"初始化成功");
        }else{
            DebugLog(@"初始化失败");
        }
    }];
}

- (void)viewDidLayoutSubviews{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(StatusBarH + SafeTop);
        } else {
            make.top.mas_equalTo(StatusBarH);
        }
        make.centerX.equalTo(self.view);
    }];
    
    [_iphoneLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(VCSizeWidth - 150);
        make.height.mas_equalTo((VCSizeWidth - 150)*1.2);
        make.centerX.equalTo(self.view);
    }];
    
    [_selectModelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(250);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.versionInfoLabel.mas_top).mas_offset(-20);
    }];
    
    
    [_versionInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(- (SafeBottom + 10));
        } else {
            make.bottom.mas_equalTo(- 10);
        }
        make.left.right.mas_equalTo(0);
    }];
}


#pragma mark - delegate -> event
- (void)tapEvent:(UIGestureRecognizer *)recognizer{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    switch (recognizer.view.tag) {
        case TapViewType_full:
            NSLog(@"全屏展示");
            [self fullScreenDisplay:recognizer];
            break;
        case TapViewType_land:
                NSLog(@"横屏展示");
            [self landscapeDisplay:recognizer];
            break;
        case TapViewType_alert:
                NSLog(@"浮窗展示");
            [self floatWindowDisplay:recognizer];
            break;
        case TapViewType_pop:
            [self popWindowDsiplay:recognizer];
                NSLog(@"弹窗展示");
            break;
        default:
            break;
    }
}


#pragma mark - display style

//全屏展示
- (void)fullScreenDisplay:(UIGestureRecognizer *)sender{
    
    sender.enabled = NO;
    __weak typeof(self) weakSelf = self;

    OLAuthViewModel *viewModel = [OLAuthViewModel new];

    // 设置屏幕显示方向
    viewModel.supportedInterfaceOrientations = UIInterfaceOrientationMaskAllButUpsideDown;
    
    // 导航栏设置
    viewModel.naviBackImage = [UIImage imageNamed:@"jiantouB"];// 导航栏返回按钮图片
    viewModel.naviBgColor = UIColor.whiteColor; // 导航栏背景色
    OLRect backButtonRect = {0, 0, 20, 0, 0, 0, {0, 0}}; // 返回按钮偏移、大小设置，偏移量和大小设置值需大于0，否则取默认值，默认可不设置
    viewModel.backButtonRect = backButtonRect;

    
    // 公司logo设置
    viewModel.appLogo = [UIImage imageNamed:@"Shape"];
    OLRect logoRect = {80, 0, 0, 0, 0, 0, {80, 80}};//  logo偏移、大小设置，偏移量和大小设置值需大于0，否则取默认值，默认可不设置，logo大小默认为图片大小
    viewModel.logoHidden = NO; // 是否隐藏logo，默认不隐藏
    viewModel.logoCornerRadius = 0; // logo圆角，默认为0
    viewModel.logoRect = logoRect;
    
    
    // 手机掩码的设置
    OLRect phoneNumRect = {190, 0, 0, 0, 0, 0, {0, 0}};
    viewModel.phoneNumRect = phoneNumRect;
    
    
    // 切换按钮设置
    viewModel.switchButtonColor = UIColor.orangeColor; // 切换按钮颜色
    viewModel.switchButtonFont = [UIFont systemFontOfSize:15];  // 切换按钮字体
    viewModel.switchButtonText = @"切换其他方式";  // 切换按钮文案
    viewModel.switchButtonHidden = YES; // 是否隐藏切换按钮，默认不隐藏
    OLRect switchButtonRect = {0, 0, 0, 0, 0, 0, {0, 0}};  // 切换按钮偏移、大小设置，偏移量和大小设置值需大于0，否则取默认值，默认可不设置
    viewModel.switchButtonRect = switchButtonRect;

    
    // slogan设置
    viewModel.sloganTextColor = Black0Color;
    viewModel.sloganTextFont = [UIFont systemFontOfSize:15];
    OLRect sloganRect = {VCSizeHeight/2 - 30, 0, 0, 0, 0, 0, {0, 0}};//slogan偏移、大小设置，偏移量和大小设置值需大于0，否则取默认值，默认可不设置
    viewModel.sloganRect = sloganRect;

    // 登录按钮设置
    OLRect authButtonRect = {VCSizeHeight/2 + 30, 0, 0, 0, 0, 0, {VCSizeWidth - 60, 50}};
    viewModel.authButtonRect = authButtonRect;
    viewModel.notCheckProtocolHint = @"请您先同意服务条款"; // 未勾选，点击按钮的文字提示
    
    
    // 复选框的设置
    viewModel.defaultCheckBoxState = NO;// 是否勾选复选框
    OLRect checkBoxRect = {0, 0, 0, 0, 0, 0, {16, 16}}; // 复选框尺寸，默认为12*12
    viewModel.checkBoxRect = checkBoxRect;
    
    
    // 协议样式设置
    OLRect termsRect = {VCSizeHeight/2 + 105, 0, 0, 0, 0, 0, {0, 0}};
    viewModel.termsRect = termsRect; // 隐私条款 位置及大小
    viewModel.hasQuotationMarkOnCarrierProtocol = YES;// 协议加上《》
    viewModel.termsAlignment = NSTextAlignmentCenter; // 协议是否居中显示
    
    
    //授权页隐私条款属性
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.paragraphSpacing = 0.0;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.firstLineHeadIndent = 0.0;
    viewModel.privacyTermsAttributes = @{
                                         NSForegroundColorAttributeName : UIColor.redColor,
                                         NSParagraphStyleAttributeName : paragraphStyle,
                                         NSFontAttributeName : [UIFont systemFontOfSize:14]
                                         };
    
    // 服务条款web页面导航栏标题
       viewModel.webNaviBgColor = UIColor.whiteColor; // 服务条款导航栏背景色
       viewModel.webNaviHidden = NO;   // 服务条款导航栏是否隐藏

    
    // 自定义授权页弹出动画
       viewModel.pullAuthVCStyle = OLPullAuthVCStylePush;
    
    //    CATransition *animation = [CATransition animation];
    //    animation.duration = 0.5;
    //    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    animation.type = kCATransitionPush;
    //    animation.subtype = kCATransitionFromRight;
    //    viewModel.modalPresentationAnimation = animation;
    //
    //    CATransition *dismissAnimation = [CATransition animation];
    //    dismissAnimation.duration = 0.5;
    //    dismissAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    dismissAnimation.type = kCATransitionPush;
    //    dismissAnimation.subtype = kCATransitionFromLeft;
    //    viewModel.modalDismissAnimation = dismissAnimation;


    // 授权页的生命周期
    viewModel.viewLifeCycleBlock = ^(NSString * _Nonnull viewLifeCycle, BOOL animated) {
        if ([viewLifeCycle isEqualToString:@"viewDidLoad"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                sender.enabled = YES;
            });
        }
    };
    
    
    
    // 自定义区域设置,比如可以设置其他登录方式
    viewModel.customUIHandler = ^(UIView * _Nonnull customAreaView) {
        LoginCustomView *customView = [[LoginCustomView alloc] initWithFrame:CGRectMake(50, VCSizeHeight - 150, VCSizeWidth - 100, 100) Items:weakSelf.itemsArray Complete:^(NSInteger tag) {
            [weakSelf OtherLoginClick:tag];
        }];
        [customAreaView addSubview:customView];
    };


    [self OneLoginFunc:viewModel GestureRec:sender];

}


//横屏展示
- (void)landscapeDisplay:(UIGestureRecognizer *)sender{
    
    sender.enabled = NO;
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.allowRotate = 1;
    
    OLAuthViewModel *viewModel = [OLAuthViewModel new];
    viewModel.switchButtonHidden = YES;
    viewModel.appLogo = [UIImage imageNamed:@"Shape"];
    viewModel.defaultCheckBoxState = NO;
    viewModel.supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscapeRight;

    viewModel.viewLifeCycleBlock = ^(NSString * _Nonnull viewLifeCycle, BOOL animated) {
        if ([viewLifeCycle isEqualToString:@"viewDidLoad"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                sender.enabled = YES;
            });
        }
    };

    [self OneLoginFunc:viewModel GestureRec:sender];
}

//浮窗展示
- (void)floatWindowDisplay:(UIGestureRecognizer *)sender{
    sender.enabled = NO;

    OLAuthViewModel *viewModel = [OLAuthViewModel new];
    viewModel.switchButtonHidden = YES;
    viewModel.appLogo = [UIImage imageNamed:@"Shape"];
    viewModel.isPopup = YES;
    viewModel.defaultCheckBoxState = NO;
    viewModel.canClosePopupFromTapGesture = YES;
    viewModel.popupAnimationStyle = OLAuthPopupAnimationStyleCoverVertical;
    OLRect popupRect = {[self ol_screenHeight] - 340, 0, 0, 0, 0, 0, {[self ol_screenWidth], 340}};
    viewModel.popupRect = popupRect;
    viewModel.tapAuthBackgroundBlock = ^{
    };
    
    viewModel.viewLifeCycleBlock = ^(NSString * _Nonnull viewLifeCycle, BOOL animated) {
        if ([viewLifeCycle isEqualToString:@"viewDidLoad"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                sender.enabled = YES;
            });
        }
    };


    [self OneLoginFunc:viewModel GestureRec:sender];

}



//弹窗展示
- (void)popWindowDsiplay:(UIGestureRecognizer *)sender{
    sender.enabled = NO;

    OLAuthViewModel *viewModel = [OLAuthViewModel new];
    viewModel.switchButtonHidden = YES;
    viewModel.appLogo = [UIImage imageNamed:@"Shape"];
    viewModel.isPopup = YES;
    viewModel.defaultCheckBoxState = NO;
    viewModel.canClosePopupFromTapGesture = YES;
    self.olAuthModel.tapAuthBackgroundBlock = ^{
    };
    
    viewModel.viewLifeCycleBlock = ^(NSString * _Nonnull viewLifeCycle, BOOL animated) {
        if ([viewLifeCycle isEqualToString:@"viewDidLoad"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                sender.enabled = YES;
            });
        }
    };

    [self OneLoginFunc:viewModel GestureRec:sender];
}

#pragma mark - onelogin
- (void)OneLoginFunc:(OLAuthViewModel *)viewModel GestureRec:(UIGestureRecognizer *)recoginizer{
    __weak typeof(self) weakSelf = self;
    
    if ([YPOneLogin isPreGetTokenValid]) {
        [YPOneLogin requestTokenWithViewController:self viewModel:viewModel completion:^(NSDictionary * _Nullable result) {
            NSInteger status = [result[@"status"] integerValue];

            if (status && status == 200) {// 登录成功
                NSString *cid = [result objectForKey:@"cid"];
                DebugLog(@"YPOneLogin requestToken:%@  msg :%@",result,[result valueForKey:@"msg"]);
                [weakSelf validateCid:cid];
            }else if(status && status == KYPO_LoginEventCode_Back){// 返回
                DebugLog(@"back");
            }else if (status && status == KYPO_LoginEventCode_Switch) {// 切换
                DebugLog(@"switch");
                [[CommonToastHUD sharedInstance] showTips:@"您点击了切换按钮"];
            }else {// 异常
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    recoginizer.enabled = YES;
                });
                DebugLog(@"error:%@",result[@"msg"]);
                [[CommonToastHUD sharedInstance] showTips:result[@"msg"]];
            }
            
        }];
    }else{
        [YPOneLogin preGetTokenWithCompletion:^(NSDictionary * _Nonnull sender) {
            if ([sender[@"status"] integerValue] == 200) {
                [YPOneLogin requestTokenWithViewController:self viewModel:viewModel completion:^(NSDictionary * _Nullable result) {
                    NSInteger status = [result[@"status"] integerValue];

                    if (status && status == 200) {// 登录成功
                        NSString *cid = [result objectForKey:@"cid"];
                        DebugLog(@"YPOneLogin requestToken:%@  msg :%@",result,[result valueForKey:@"msg"]);
                        [weakSelf validateCid:cid];
                    }else if(status && status == KYPO_LoginEventCode_Back){// 返回
                        DebugLog(@"back");

                    }else if (status && status == KYPO_LoginEventCode_Switch) {// 切换
                        DebugLog(@"switch");
                        [[CommonToastHUD sharedInstance] showTips:@"您点击了切换按钮"];
                    }else {// 异常
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            recoginizer.enabled = YES;
                        });
                        DebugLog(@"error:%@",result[@"msg"]);
                        [[CommonToastHUD sharedInstance] showTips:result[@"msg"]];
                    }
                    
                }];

            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    recoginizer.enabled = YES;
                    [[CommonToastHUD sharedInstance] showTips:sender[@"msg"]];
                });
            }
        }];
    }

}

//开发者服务器
- (void)validateCid:(NSString *)cid{
    [VerifyService validateCid:cid complete:^(NSDictionary * _Nonnull dic) {
        DebugLog(@"validateToken dic:%@",dic);
        NSString *resultPhone = dic[@"result"];
        if (F_QpIsStringValue_Valid(resultPhone)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [YPOneLogin cancelAuthViewController:YES Complete:^{
                    [self loginSuccess:self.maskIphoneNum];
                }];
            });
        }else{
            NSString *tips = [NSString stringWithFormat:@"发生错误：%@",dic[@"msg"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[CommonToastHUD sharedInstance] showTips: tips];
            });
        }
    }];
    
}


- (void)loginSuccess:(NSString *)iphoneNum{
    YPOneLoginSuccessViewController *ypOneLoginSuccessVC = [[YPOneLoginSuccessViewController alloc] init];
    ypOneLoginSuccessVC.iphoneNum = iphoneNum;
    ypOneLoginSuccessVC.successInfo = @"登录成功";
    [self.navigationController pushViewController:ypOneLoginSuccessVC animated:YES];
}

- (void)OtherLoginClick:(NSInteger)tag{
    switch (tag) {
        case 11000 + 0://短信
        {
            [self smsVerifyFunc];
            break;
        }
            
        case 11000 + 1://微信
        {
            self.progressHUD.labelText = @"您点击了微信登录";
            [self.progressHUD show:YES];
            [self.progressHUD hide:YES afterDelay:3.0];
            break;
        }
        case 11000 + 2://微博
            self.progressHUD.labelText = @"您点击了微博登录";
            [self.progressHUD show:YES];
            [self.progressHUD hide:YES afterDelay:3.0];
            break;
        default:
            break;
    }

}

#pragma mark - sms
- (void)smsVerifyFunc{
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    NSTimeInterval startTime = F_QpCurrentTimeInterval_13;

    YPOneLoginSmsViewModel *smsViewModel = [[YPOneLoginSmsViewModel alloc] init];
    smsViewModel.backImage = [UIImage imageNamed:@"jiantouB"];
    smsViewModel.iconImage = [UIImage imageNamed:@"Shape"];
    smsViewModel.backTitle = @"返回";
    
    smsViewModel.customBlock = ^(UIView * _Nonnull customView, UIViewController * _Nonnull vc) {
        LoginCustomView *loginview = [[LoginCustomView alloc] initWithFrame:CGRectMake(50, 30, VCSizeWidth - 100, 100) Items:self.itemsArray Complete:^(NSInteger tag) {
            switch (tag) {
                case 11000 + 0://返回
                {
                    if (vc.presentingViewController) {
                        [vc dismissViewControllerAnimated:YES completion:nil];
                    } else {
                        [vc.navigationController popViewControllerAnimated:YES];
                    }
                    break;
                }
                    
                case 11000 + 1://微信
                {
                    self.progressHUD.labelText = @"您点击了微信登录";
                    [self.progressHUD show:YES];
                    [self.progressHUD hide:YES afterDelay:3.0];
                    break;
                }
                case 11000 + 2://微博
                    self.progressHUD.labelText = @"您点击了微博登录";
                    [self.progressHUD show:YES];
                    [self.progressHUD hide:YES afterDelay:3.0];
                    break;
                default:
                    break;
            }

        }];
        [customView addSubview:loginview];
    };

    [YPOneLogin requestSmsTokenWithViewController:self viewModel:smsViewModel sendSmsCompletion:^(NSDictionary * _Nullable result) {
        DebugLog(@"sms success %@",result);
        if ([result[@"status"]integerValue] == 200) {
            [[CommonToastHUD sharedInstance] showTips:@"验证码已发送"];
        }
    } codeVerfiySmsCompletion:^(NSDictionary * _Nullable result) {
        DebugLog(@"sms faile %@",result);

        if ([result[@"passed"]boolValue]) {
            NSTimeInterval costTime = F_QpCurrentTimeInterval_13 - startTime;
            NSUserDefaults *userDefault =  [NSUserDefaults standardUserDefaults];
            [userDefault setObject:@(costTime) forKey:@"_user_default_key_1_"];
            [userDefault synchronize];
            dispatch_async(dispatch_get_main_queue(), ^{
                SuccessViewController *vc = [[SuccessViewController alloc] initWithNibName:nil bundle:nil];
                vc.number = result[@"number"];
                [self.navigationController pushViewController:vc animated:YES];
            });
        }else{
            [[CommonToastHUD sharedInstance] showTips:@"验证码错误"];
        }
    }];
    
}

#pragma mark - screen size

- (CGFloat)ol_screenWidth {
    return MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

- (CGFloat)ol_screenHeight {
    return MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}


@end
