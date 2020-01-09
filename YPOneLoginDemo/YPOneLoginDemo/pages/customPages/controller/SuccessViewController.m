//
//  SuccessViewController.m
//  YPVerifyApp
//
//  Created by daizq on 2019/5/22.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "SuccessViewController.h"
#import "QPCFunctionConst.h"
#import "YPLSetUtil.h"
#import <YPOneLogin/YPOneLogin.h>
#import "NavigationView.h"
#import <YYText.h>
#import "CommonToastHUD.h"
#import <YYLabel.h>

@interface SuccessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tryAgainBtn;
@property (weak, nonatomic) IBOutlet UILabel *costTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originCostTimeLabel;

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [YPLSetUtil setViewRadius:8 toView:_tryAgainBtn];
    NSString *welcomeTemplate = _number ? @"欢迎您, %@" : @"欢迎您";
    NSString *welcomeStr = [NSString stringWithFormat: welcomeTemplate, _number];
    [[CommonToastHUD sharedInstance]showTips:welcomeStr];
    // Do any additional setup after loading the view from its nib.
    [self setupView];
}

- (void)setupView {
    NavigationView *navigationView = [[NavigationView alloc]initWithTitle:_isOneLogin?@"一键登录":@"短信验证"];
    [self.view addSubview:navigationView];
    [self.view setBackgroundColor:F_QPRgb(248, 248, 248)];
    float scrollY = F_QPViewMaxY(_tryAgainBtn)+60;
    CGRect frame = CGRectMake(16, scrollY, F_QPScreenWidth - 32, F_QPScreenHeight - scrollY);
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:frame];
    scroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scroll];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, F_QPViewWidth(scroll), F_QPScreenHeight)];
//    [imageView setContentMode:UIViewContentModeScaleAspectFit];
//    [imageView setImage:[UIImage imageNamed:@"longImag"]];
//    scroll.contentSize = CGSizeMake(0, F_QPViewHeight(imageView));
    YYTextView *textView = [YYTextView new];
    [textView setFrame:CGRectMake(0, 0, F_QPViewWidth(scroll), F_QPScreenHeight)];
    
//    [scroll addSubview:textView];
    
    // 1. 创建属性字符串。
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"传统短信验证码登录花费时间：30s"];
    
    // 2. 将属性设置为文本，可以使用几乎所有的CoreText属性。
    [text yy_setTextHighlightRange:NSMakeRange(text.length - 3, 3)
                          color:[UIColor redColor]
                backgroundColor:[UIColor clearColor]
                      tapAction:nil];
    _originCostTimeLabel.attributedText = text;
    
     float costTime = [[[NSUserDefaults standardUserDefaults]objectForKey:@"_user_default_key_1_"]floatValue];
    NSMutableString *str = [NSMutableString stringWithFormat:@"本次校验花费时间：%.2fs",costTime/1000.0];
    NSMutableAttributedString *text1 = [[NSMutableAttributedString alloc] initWithString:str.copy];
    NSInteger len = [str componentsSeparatedByString:@"："][1].length;
    [text1 yy_setTextHighlightRange:NSMakeRange(text1.length - len, len)
                             color:[UIColor redColor]
                   backgroundColor:[UIColor clearColor]
                         tapAction:nil];
    _costTimeLabel.attributedText = text1;
}

- (IBAction)tryAgainAction:(id)sender {
    // if (_isOneLogin) {
    //     [YPOneLogin preGetTokenWithCompletion:^(NSDictionary * _Nonnull sender) {
    //         NSLog(@"pre get number %@",sender);
    //     }];
    // }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)requestUse:(id)sender {
}

@end
