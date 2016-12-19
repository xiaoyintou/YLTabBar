//
//  CarouselView.h
//  YLTabBar
//
//  Created by yyl on 2016/12/13.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselView : UIView<UIScrollViewDelegate> {
    NSTimer *timer;
}
@property (strong, nonatomic) UIScrollView *picsView;
@property (strong, nonatomic) UIPageControl *scrollPage;
@property (nonatomic, strong) NSMutableArray *pics;

+(CarouselView *)instanceCarouselViewWithDataArray:(NSArray *)dataArray;
- (void)createAllImageViewWithDataArray:(NSArray *)dataArray;
- (void)setAllViewAutoLayout;

@end
