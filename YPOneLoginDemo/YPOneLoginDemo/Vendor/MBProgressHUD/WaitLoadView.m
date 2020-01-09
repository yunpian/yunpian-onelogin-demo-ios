//
//  WaitLoadView.m
//  SourceCode
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 moyan. All rights reserved.
//

#import "WaitLoadView.h"

@implementation WaitLoadView

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (id)getView {
    NSString *nibName = NSStringFromClass([self class]);

    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [topLevelObjects objectAtIndex:0];
}

@end
