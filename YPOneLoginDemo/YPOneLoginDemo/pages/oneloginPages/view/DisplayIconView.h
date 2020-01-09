//
//  DisplayIconView.h
//  YPAuthServiceDemo
//
//  Created by qipeng_yuhao on 2019/11/13.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DisplayViewDelegate <NSObject>

- (void)tapEvent:(UIGestureRecognizer *)recognizer;

@end

@interface DisplayIconView : UIView

@property (weak, nonatomic) id <DisplayViewDelegate> displayDelegate;

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withImage:(UIImage *)image isTransform:(BOOL)transform;
@end

NS_ASSUME_NONNULL_END
