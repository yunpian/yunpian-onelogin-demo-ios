//
//  DisplayIconView.m
//  YPAuthServiceDemo
//
//  Created by qipeng_yuhao on 2019/11/13.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import "DisplayIconView.h"

@implementation DisplayIconView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withImage:(UIImage *)image isTransform:(BOOL)transform{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(30, 10, 60, 60);
        if (transform) imageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, self.frame.size.width, 20)];
        titleLable.text = title;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = Black1Color;
        [titleLable setFont:[UIFont systemFontOfSize:14]];
        
        [self addSubview:imageView];
        [self addSubview:titleLable];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}

- (void)tapEvent:(UIGestureRecognizer *)recognizer{
    if (self.displayDelegate && [self.displayDelegate respondsToSelector:@selector(tapEvent:)]) {
        [self.displayDelegate tapEvent:recognizer];
    }
}

@end
