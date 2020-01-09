//
//  YPRootViewController.m
//  YPAuthServiceDemo
//
//  Created by qipeng_yuhao on 2019/11/13.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "YPRootViewController.h"
#import "BackButton.h"

@interface YPRootViewController ()
@end

@implementation YPRootViewController


-(void)viewWillAppear:(BOOL)animated{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.allowRotate = 0;
}

- (void)viewWillDisappear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;
    
}

- (void)resetNavBarIsBlue:(BOOL)IsYPRootVCNavColorBlue{
    self.navigationController.navigationBar.translucent = NO;
    [self findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;

    
    BackButton *backBtn = [[BackButton alloc] init];
    UIImage *backImage;
    if (IsYPRootVCNavColorBlue) {
        self.navigationController.navigationBar.barTintColor = Blue0Color;
        backImage = [UIImage imageNamed:@"jiantouW"];
        [backBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    }else{
        self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;
        backImage = [UIImage imageNamed:@"jiantouB"];
        [backBtn setTitleColor:Black2Color forState:UIControlStateNormal];
    }

    [backBtn setImage:backImage forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    backBtn.titleRect = CGRectMake(25, 0, 35, 20);
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
