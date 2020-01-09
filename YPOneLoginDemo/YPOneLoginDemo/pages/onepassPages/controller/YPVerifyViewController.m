//
//  YPVerifyViewController.m
//  YPOneLoginApp
//
//  Created by qipeng_yuhao on 2019/11/14.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "YPVerifyViewController.h"
#import "LoginCustomView.h"
#import "CommonToastHUD.h"
#import "SuccessViewController.h"
#import "DemoUtil.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <YPOnePass/YPOnePass.h>



@interface YPVerifyViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *logoView;

@property (nonatomic, strong) UITextField *iphoneNumField;

@property (nonatomic, strong) UIButton *verifyBtn;

@property (nonatomic, strong) UILabel *noticeLabel;

@property (nonatomic, strong) LoginCustomView *customView;

@property (nonatomic, strong) NSMutableArray *itemsArray;

@property (nonatomic, copy) NSString *iphoneNumStr;

@property (strong, nonatomic) YPOnePass *yp_manager;

@property (strong, nonatomic) MBProgressHUD *progressHUD;

@end

@implementation YPVerifyViewController

#pragma mark - Getter
- (UIView *)logoView{
    if (!_logoView) {
        _logoView = [[UIView alloc] init];
        UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Shape"]];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"本机校验";
        titleLabel.textColor = Black0Color;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
        [_logoView addSubview:logoImageView];
        [_logoView addSubview:titleLabel];
        [self.view addSubview:_logoView];
        [_logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.centerX.equalTo(self.view);
            make.height.mas_equalTo(100);
        }];
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.top.mas_equalTo(0);
            make.centerX.equalTo(_logoView);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logoImageView.mas_bottom).mas_offset(10);
            make.centerX.equalTo(_logoView);
            make.height.mas_equalTo(40);
        }];
    }
    return _logoView;
}

- (UITextField *)iphoneNumField{
    if (!_iphoneNumField) {
        _iphoneNumField = [[UITextField alloc] init];
        _iphoneNumField.borderStyle = UITextBorderStyleRoundedRect;
        _iphoneNumField.keyboardType = UIKeyboardTypePhonePad;
        _iphoneNumField.layer.cornerRadius = 5;
        _iphoneNumField.backgroundColor = Gray0Color;
        _iphoneNumField.placeholder = @"请输入手机号";
        _iphoneNumField.delegate = self;
        UIView *placeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, _iphoneNumField.frame.size.height)];
        placeView.backgroundColor = Gray0Color;
        [_iphoneNumField addSubview:placeView];
    }
    return _iphoneNumField;
}

- (UIButton *)verifyBtn{
    if (!_verifyBtn) {
        _verifyBtn = [[UIButton alloc] init];
        _verifyBtn.backgroundColor = UIColor.grayColor;
        _verifyBtn.userInteractionEnabled = NO;
        _verifyBtn.layer.cornerRadius = 5;
        [_verifyBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_verifyBtn setTitle:@"本机验证" forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_verifyBtn addTarget:self action:@selector(verifyClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifyBtn;
}

- (UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] init];
        [_noticeLabel setText:GlobelS_NOTICEINFO];
        [_noticeLabel setFont:[UIFont systemFontOfSize:14]];
        [_noticeLabel setTextColor:Black2Color];
        _noticeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _noticeLabel.numberOfLines = 0;
    }
    return _noticeLabel;
}

- (LoginCustomView *)customView{
    if (!_customView) {
        __weak typeof(self) weakSelf = self;
        _customView = [[LoginCustomView alloc] initWithFrame:CGRectMake(50, VCSizeHeight - 150, VCSizeWidth - 100, 100) Items:self.itemsArray Complete:^(NSInteger tag) {
            [weakSelf OtherLoginClick:tag];
        }];
    }
    return _customView;
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
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetNavBarIsBlue:NO];


    [self.view addSubview:self.logoView];
    [self.view addSubview:self.iphoneNumField];
    [self.view addSubview:self.verifyBtn];
    [self.view addSubview:self.noticeLabel];
    //隐藏自定义view
//    [self.view addSubview:self.customView];
    
    

   // ypOnepass
    _yp_manager = [[YPOnePass alloc] initWithAppId:AppIDKey timeout:3];
    
}

- (void)viewDidLayoutSubviews{
    
    [_iphoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoView.mas_bottom).mas_offset(50);
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
    }];
    
    [_verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iphoneNumField.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
    }];
    
    [_noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.verifyBtn.mas_bottom).mas_offset(30);
       make.left.mas_equalTo(25);
       make.right.mas_equalTo(-25);
    }];
    
    if (@available(iOS 11.0, *)) {
        _customView.frame = CGRectMake(50, VCSizeHeight - 150 - SafeBottom, VCSizeWidth - 100, 100);
    }
}


#pragma mark - verify
- (void)verifyClick:(UIButton *)sender{
    
    self.iphoneNumStr = self.iphoneNumField.text;
        
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    DebugLog(@"%@",self.iphoneNumStr);
    
    
    if (![self checkPhoneNumFormat:self.iphoneNumStr]) {
        [[CommonToastHUD sharedInstance] showTips:@"请输入正确手机号"];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    
   //ypOnepass
    [_yp_manager verifyPhoneNumber:self.iphoneNumStr
                         onSuccess:^(NSDictionary *_Nonnull dicInfo) {
        DebugLog(@"verifyPhoneNumber onSuccess %@", dicInfo);
        NSString *cid = [dicInfo valueForKey:@"cid"];
        [weakSelf validateCid:cid];
    }onFail:^(NSDictionary *_Nonnull dicInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self faileForVerify:NULL];
            DebugLog(@"verifyPhoneNumber onFail %@", dicInfo);
        });
    }];
}

//开发者服务器
- (void)validateCid:(NSString *)cid{
    [VerifyService validateCid:cid complete:^(NSDictionary * _Nonnull dic) {
        DebugLog(@"validateToken dic:%@",dic);
        NSString *resultPhone = dic[@"result"];
        if (F_QpIsStringValue_Valid(resultPhone)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self successForVerify];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self faileForVerify:dic];
            });
        }
    }];
    
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

- (void)successForVerify{
    YPOneLoginSuccessViewController *ypOneLoginSuccessVC = [[YPOneLoginSuccessViewController alloc] init];
    ypOneLoginSuccessVC.successInfo = @"验证成功";
    [self.navigationController pushViewController:ypOneLoginSuccessVC animated:YES];
}

- (void)faileForVerify:(NSDictionary *)result{

    [[CommonToastHUD sharedInstance] showTips:@"验证失败,请用短信验证"];
    
    [self smsVerifyFunc];
}

#pragma mark - sms
- (void)smsVerifyFunc{
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    NSTimeInterval startTime = F_QpCurrentTimeInterval_13;
//    self.navigationController.navigationBar.hidden = YES;
    
//    [self dismissViewControllerAnimated:YES completion:^{
//
//    }];
    
    YPOnePassSmsViewModel *smsViewModel = [[YPOnePassSmsViewModel alloc] init];
    smsViewModel.backImage = [UIImage imageNamed:@"jiantouB"];
    smsViewModel.backTitle = @"返回";
    smsViewModel.iconImage = [UIImage imageNamed:@"Shape"];
    smsViewModel.phoneNumber = self.iphoneNumStr;
    
    smsViewModel.customBlock = ^(UIView * _Nonnull customView, UIViewController * _Nonnull vc) {
        LoginCustomView *loginview = [[LoginCustomView alloc] initWithFrame:CGRectMake(50,customView.frame.size.height - 120, customView.frame.size.width - 100, 100) Items:self.itemsArray Complete:^(NSInteger tag) {
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
    
    [_yp_manager requestSmsTokenWithViewController:self viewModel:smsViewModel sendSmsCompletion:^(NSDictionary * _Nullable result) {
        DebugLog(@"sms result:%@ msg:%@",result,[result valueForKey:@"msg"]);
            if ([result[@"status"]integerValue] == 200) {
                [[CommonToastHUD sharedInstance] showTips:@"验证码已发送"];
            }
    } codeVerfiySmsCompletion:^(NSDictionary * _Nullable result) {
        if ([result[@"passed"] boolValue]) {
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - textFildDelegate


- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.iphoneNumStr = textField.text;

    if (textField.text.length >= 11 && [textField.text isPhoneNumber]) {
        _verifyBtn.backgroundColor = Blue0Color;
        _verifyBtn.userInteractionEnabled = YES;
    }else{
        _verifyBtn.backgroundColor = UIColor.grayColor;
        _verifyBtn.userInteractionEnabled = NO;
    }

}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{


//    if (textField.text.length >= 11) {
//        textField.text = [textField.text substringToIndex:11];
//        self.iphoneNumStr = textField.text;
//    }
    return YES;
}



#pragma mark - check num
- (BOOL)checkPhoneNumFormat:(NSString *)num {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,147,148,150,151,152,157,158,159,172,178,182,183,184,187,188,198
     * 联通：130,131,132,145,146,152,155,156,166,171,175,176,185,186
     * 电信：133,1349,153,173,174,177,180,181,189,199
     */
    
    /**
     * 宽泛的手机号过滤规则
     */
    NSString * MOBILE = @"^1([3-9])\\d{9}$";
    
    /**
     * 虚拟运营商: Virtual Network Operator
     * 不支持
     */
    NSString * VNO = @"^170\\d{8}$";
    
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,147,150,151,152,157,158,159,172,178,182,183,184,187,188
     */
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|4[78]|5[0-27-9]|7[28]|8[2-478]|98)\\d)\\d{7}$";
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,176,185,186
     */
    
    NSString * CU = @"^1(3[0-2]|45|5[256]|7[156]|8[56])\\d{8}$";
    
    /**
     * 中国电信：China Telecom
     * 133,1349,153,173,177,180,181,189
     */
    
    NSString * CT = @"^1((33|53|7[347]|8[019]|99)[0-9]|349)\\d{7}$";
    
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    NSPredicate *regexTestVNO = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VNO];
    
    NSPredicate *regexTestCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regexTestCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regexTestCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regexTestMobile evaluateWithObject:num] == YES &&
        (([regexTestCM evaluateWithObject:num] == YES) ||
        ([regexTestCT evaluateWithObject:num] == YES) ||
        ([regexTestCU evaluateWithObject:num] == YES)) &&
        [regexTestVNO evaluateWithObject:num] == NO) {
        return YES;
    }
    else return NO;
}



@end
