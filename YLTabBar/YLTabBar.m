//
//  YLTabBar.m
//  YLTabBar
//
//  Created by yyl on 2016/12/8.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "YLTabBar.h"

@implementation YLTabBar
- (void)ylclickblock:(ylClickBlock)block {
    self.block = block;
}
- (void)middleclickblock:(midClickBlcok)midblock {
    self.midblock = midblock;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        oldSelect = 1;
    }
    return self;
}
- (IBAction)midClickAction:(UIButton *)sender {
    self.midblock();
}
- (IBAction)clickAction:(UIButton *)sender {
    //被点击的按钮设置被选中的状态
    sender.selected = YES;
    //上一个被点击的按钮取消选中的状态
    UIButton *tempButton = (UIButton *)[self viewWithTag:oldSelect];
    tempButton.selected = NO;
    //更新被选中按钮的记录
    oldSelect = sender.tag;
    self.block(sender.tag - 1);
}

//设置tabbar上原有view的位置, 放到屏幕之外的很远的位置, 用自定义的view来代替原有的view
-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *tabBarButton in self.subviews) {
        // 判断下是否是UITabBarButton
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            tabBarButton.frame = CGRectMake(-300, 200, 0, 0);
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
