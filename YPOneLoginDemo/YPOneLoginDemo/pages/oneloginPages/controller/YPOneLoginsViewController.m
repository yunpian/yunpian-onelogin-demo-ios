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

@interface YPOneLoginsViewController ()<DisplayViewDelegate,YPOneLoginDelegate>

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
        _versionInfoLabel.text = @"云片移动认证产品体验v2.0.0";
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
    
    //上线时注意关闭打印
    [YPOneLogin setLogEnabled:NO];
    
    [YPOneLogin startWithAppId:AppIDKey completion:^(NSDictionary * _Nullable result) {
        if ([result[@"status"] integerValue] == 200) {
            DebugLog(@"初始化成功");
        }else{
            DebugLog(@"初始化失败");
        }
    }];
    

    //在后台提前获取预取号,这个根据需要
    
//    [YPOneLogin startWithAppId:AuthServiceDemoIDKey completion:^(NSDictionary * _Nullable result) {
//        if ([result[@"status"] integerValue] == 200) {
//
//            [YPOneLogin preGetTokenWithCompletion:^(NSDictionary * _Nonnull sender) {
//                DebugLog(@"YPOneLogin preGetToken:%@",sender);
//            }];
//        }else{
//            DebugLog(@"初始化失败");
//        }
//    }];
    
    [YPOneLogin setDelegate:self];
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

#pragma mark - delegate -> OneLogin
- (void)userDidSwitchAccount{
    [YPOneLogin cancelAuthViewController:YES Complete:^{
        
    }];
}

- (void)userDidDismissAuthViewController{

    [YPOneLogin cancelAuthViewController:YES Complete:^{
        
    }];
}


#pragma mark - display style

//全屏展示
- (void)fullScreenDisplay:(UIGestureRecognizer *)sender{
    
    sender.enabled = NO;
    __weak typeof(self) weakSelf = self;

    OLAuthViewModel *viewModel = [OLAuthViewModel new];

    viewModel.supportedInterfaceOrientations = UIInterfaceOrientationMaskAllButUpsideDown;
    viewModel.appLogo = [UIImage imageNamed:@"Shape"];
    viewModel.naviBackImage = [UIImage imageNamed:@"back"];
    viewModel.naviBgColor = [UIColor blackColor];
    viewModel.webNaviBgColor = [UIColor blackColor];
    OLRect logoRect = {80, 0, 0, 0, 0, 0, {80, 80}};
    viewModel.logoRect = logoRect;
    OLRect phoneNumRect = {190, 0, 0, 0, 0, 0, {0, 0}};
    viewModel.phoneNumRect = phoneNumRect;
    viewModel.switchButtonHidden = YES;
    viewModel.sloganTextColor = Black0Color;
       viewModel.sloganTextFont = [UIFont systemFontOfSize:15];
       OLRect sloganRect = {VCSizeHeight/2 - 30, 0, 0, 0, 0, 0, {0, 0}};
    OLRect authButtonRect = {VCSizeHeight/2 + 30, 0, 0, 0, 0, 0, {VCSizeWidth - 60, 50}};
    viewModel.authButtonRect = authButtonRect;
    viewModel.sloganRect = sloganRect;
    viewModel.defaultCheckBoxState = NO;
    OLRect checkBoxRect = {0, 0, 0, 0, 0, 0, {16, 16}}; // 复选框尺寸，默认为12*12
    viewModel.checkBoxRect = checkBoxRect;
    OLRect termsRect = {VCSizeHeight/2 + 100, 0, 0, 0, 0, 0, {0, 0}};
    viewModel.termsRect = termsRect;
    viewModel.termsAlignment = NSTextAlignmentCenter;

    viewModel.viewLifeCycleBlock = ^(NSString *viewLifeCycle, BOOL animated) {
        if ([viewLifeCycle isEqualToString:@"viewDidDisappear:"]) {
            sender.enabled = YES;
        }
    };
    
    viewModel.customUIHandler = ^(UIView * _Nonnull customAreaView) {
        LoginCustomView *customView = [[LoginCustomView alloc] initWithFrame:CGRectMake(50, VCSizeHeight - 150, VCSizeWidth - 100, 100) Items:weakSelf.itemsArray Complete:^(NSInteger tag) {
            [weakSelf OtherLoginClick:tag];
        }];
        [customAreaView addSubview:customView];
    };
    
    //授权页隐私条款属性
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.paragraphSpacing = 0.0;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.firstLineHeadIndent = 0.0;
    viewModel.privacyTermsAttributes = @{
                                         NSForegroundColorAttributeName : UIColor.redColor,
                                         NSParagraphStyleAttributeName : paragraphStyle,
                                         NSFontAttributeName : [UIFont systemFontOfSize:12]
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
    viewModel.viewLifeCycleBlock = ^(NSString *viewLifeCycle, BOOL animated) {
            
        if ([viewLifeCycle isEqualToString:@"viewDidDisappear:"]) {
            sender.enabled = YES;
            
//            AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//            appdelegate.allowRotate = 0;

            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                if ([[UIDevice currentDevice]   respondsToSelector:@selector(setOrientation:)]) {
                    SEL selector =  NSSelectorFromString(@"setOrientation:");
                    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
                    [invocation setSelector:selector];
                    [invocation setTarget:[UIDevice currentDevice]];
                    int val = UIInterfaceOrientationPortrait;
                    [invocation setArgument:&val atIndex:2];
                    [invocation invoke];
                }
            }
            
            
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
    viewModel.viewLifeCycleBlock = ^(NSString *viewLifeCycle, BOOL animated) {
        if ([viewLifeCycle isEqualToString:@"viewDidDisappear:"]) {
            sender.enabled = YES;
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
    viewModel.viewLifeCycleBlock = ^(NSString *viewLifeCycle, BOOL animated) {
        if ([viewLifeCycle isEqualToString:@"viewDidDisappear:"]) {
            sender.enabled = YES;
        }
    };

    [self OneLoginFunc:viewModel GestureRec:sender];
}

#pragma mark - one login
- (void)OneLoginFunc:(OLAuthViewModel *)viewModel GestureRec:(UIGestureRecognizer *)recoginizer{
    __weak typeof(self) weakSelf = self;
    
    if ([YPOneLogin isPreGetTokenValidate]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [YPOneLogin requestTokenWithViewController:self viewModel:viewModel completion:^(NSDictionary * _Nullable result) {
            if ([result[@"status"] integerValue] == 200) {
                NSString *cid = [result objectForKey:@"cid"];
                DebugLog(@"YPOneLogin requestToken:%@  msg :%@",result,[result valueForKey:@"msg"]);
                [weakSelf validateCid:cid];
            }
        }];
    }else{
        [YPOneLogin preGetTokenWithCompletion:^(NSDictionary * _Nonnull sender) {
            DebugLog(@"YPOneLogin preGetToken:%@",sender);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.maskIphoneNum = [sender valueForKey:@"number"];
                recoginizer.enabled = YES;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([sender[@"status"] integerValue] == 200) {
                    [YPOneLogin requestTokenWithViewController:self viewModel:viewModel completion:^(NSDictionary * _Nullable result) {
                        if ([result[@"status"] integerValue] == 200) {
                            NSString *cid = [result objectForKey:@"cid"];
                            DebugLog(@"YPOneLogin requestToken:%@  msg :%@",result,[result valueForKey:@"msg"]);
                            [weakSelf validateCid:cid];
                        }
                    }];
                }else{
                    NSString *msg = [sender valueForKey:@"msg"];
                    [[CommonToastHUD sharedInstance] showTips: [NSString stringWithFormat:@"取号失败：%@",F_QpIsStringValue_Valid(msg)?msg:@"未知异常"]];
                }
            });
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
    [YPOneLogin cancelAuthViewController:YES Complete:^{
        
    }];

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
