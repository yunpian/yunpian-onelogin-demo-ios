//
//  WaitLoadView.h
//  SourceCode
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 moyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitLoadView : UIView

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

/* 获取View模板 */
+ (id)getView;

@end
