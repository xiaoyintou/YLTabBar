//
//  BzViewController.h
//  YLTabBar
//
//  Created by yyl on 2016/12/13.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselView.h"

@interface BzViewController : UIViewController
@property (nonatomic, strong) CarouselView *carouselView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (strong, nonatomic) UIScrollView *picsView;
@property (nonatomic, strong) UIView *connectView; //显示在scrollview上的过度视图，用来放子控件
@property (strong, nonatomic) UIPageControl *scrollPage;
@property (nonatomic, strong) NSMutableArray *pics;


@end
