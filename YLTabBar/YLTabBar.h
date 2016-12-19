//
//  YLTabBar.h
//  YLTabBar
//
//  Created by yyl on 2016/12/8.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ylClickBlock)(NSInteger selectIndex);
typedef void(^midClickBlcok)();

@interface YLTabBar : UITabBar {
    NSInteger picNum;
    NSInteger oldSelect; //用来记录上一个被选中的按钮
    NSArray *ttitles;
    NSArray *tnorImages;
    NSArray *tselectImages;
}
@property (nonatomic, copy) ylClickBlock block;
@property (nonatomic, copy) midClickBlcok midblock;
- (void)ylclickblock:(ylClickBlock)block;
- (void)middleclickblock:(midClickBlcok)midblock;
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles norImages:(NSArray *)norImages selectImages:(NSArray *)selectImages;

@end
