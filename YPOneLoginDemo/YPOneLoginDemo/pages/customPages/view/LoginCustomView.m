//
//  LoginCustomView.m
//  YPAuthServiceDemo
//
//  Created by qipeng_yuhao on 2019/11/14.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "LoginCustomView.h"

@implementation LoginCustomView

- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray<LoginCustomModel *> *)array Complete:(nonnull LoginTypeBlock)complete{
    if (self = [super initWithFrame:frame]) {
        
         UILabel *otherLoginBel = [[UILabel alloc] init];
         otherLoginBel.text = @"其他登录方式";
         otherLoginBel.textColor = [UIColor blackColor];
         [otherLoginBel setTextAlignment:NSTextAlignmentCenter];
         [otherLoginBel setFont:[UIFont systemFontOfSize:20]];
         [self addSubview:otherLoginBel];
        
        [otherLoginBel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(30);
        }];

        float offX = 30;
        float width = 40;
        float height = 40;
        float marginX = (self.frame.size.width - array.count*width - (array.count - 1)*offX)/2;
        for (int i=0; i<array.count; i++) {
            LoginCustomModel *model = array[i];
            UIButton *otherLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(marginX + (offX + width)*i, 60, width, height)];
            otherLoginBtn.layer.masksToBounds = YES;
            otherLoginBtn.layer.cornerRadius = otherLoginBtn.frame.size.width/2;
            
            otherLoginBtn.tag = 11000 + i;
            [otherLoginBtn setBackgroundImage:model.icon forState:UIControlStateNormal];
            [otherLoginBtn addTarget:self action:@selector(OtherloginAct:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:otherLoginBtn];
            
        }
        _loginTypeBlock = complete;
    }
    return self;
}

-(void)OtherloginAct:(UIButton *)sender{
    _loginTypeBlock(sender.tag);
}

@end
