//
//  CarouselView.m
//  YLTabBar
//
//  Created by yyl on 2016/12/13.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "CarouselView.h"


@implementation CarouselView
+(CarouselView *)instanceCarouselViewWithDataArray:(NSArray *)dataArray {
    CarouselView *cv = [[CarouselView alloc] init];
    cv.backgroundColor = [UIColor whiteColor];
    cv.pics = [NSMutableArray arrayWithArray:dataArray];
    [cv createAllImageViewWithDataArray:dataArray];
    return cv;
}
- (void)createAllImageViewWithDataArray:(NSArray *)dataArray {
    self.picsView = [[UIScrollView alloc] init];
    self.picsView.backgroundColor = [UIColor redColor];
    self.picsView.pagingEnabled = YES;
    self.picsView.bounces = NO;
    self.picsView.delegate = self;
    self.picsView.showsVerticalScrollIndicator = NO;
    self.picsView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.picsView];
    
    self.scrollPage = [[UIPageControl alloc] init];
    self.scrollPage.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.scrollPage];

    for (int i = 0; i < dataArray.count + 2; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.tag = i + 1;
        if (i == 0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[[dataArray objectAtIndex:dataArray.count - 1] objectForKey:@"picurl"]] placeholderImage:nil];
        } else if (i == dataArray.count + 1) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[[dataArray firstObject] objectForKey:@"picurl"]] placeholderImage:nil];
        } else {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[[dataArray objectAtIndex:i - 1] objectForKey:@"picurl"]] placeholderImage:nil];
        }
        // 单击的 Recognizer
        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adImageBtnAction:)];
        //点击的次数
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        //给view添加一个手势监测；
        [imageView addGestureRecognizer:singleRecognizer];
        [self.picsView addSubview:imageView];
    }
    [self addTimer];
}
- (void)setAllViewAutoLayout {
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo([self superview]).with.offset(0);
        make.right.equalTo([self superview]).with.offset(0);
        make.top.equalTo([self superview]).with.offset(80);
        make.height.equalTo([[UIScreen mainScreen] bounds].size.width * 160 / 375);
    }];
    [self.picsView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(self);
        make.width.equalTo(self);
    }];

    [self.scrollPage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
        make.bottom.equalTo(self).with.offset(-10);
        make.height.equalTo(15);
    }];
    UIImageView *lastImageView = nil;
    for (int i = 0; i < self.pics.count + 2; i++) {
        UIImageView *imageView = (UIImageView *)[self viewWithTag:i+1];
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo(self);
            if (lastImageView) {
                make.left.equalTo(lastImageView.mas_right);
            } else {
                make.left.equalTo(0);
            }
            if (i == self.pics.count + 1) {
                make.right.equalTo(0);
            }
        }];
        lastImageView = imageView;
    }
    [self.picsView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastImageView.mas_right);
    }];
}
#pragma mark -------------------
//#pragma mark 轮播图的响应事件
- (void)adImageBtnAction:(UITapGestureRecognizer*)recognizer {
    NSInteger selectIndex;
    if (recognizer.view.tag == 1) {
//        self.picblock(self.pics.count - 1);
        selectIndex = self.pics.count - 1;
    } else if (recognizer.view.tag == self.pics.count + 2) {
//        self.picblock(0);
        selectIndex = 0;
    } else {
//        self.picblock(button.tag - 2);
        selectIndex = recognizer.view.tag - 2;
    }
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"这是第%ld", selectIndex] delegate:self cancelButtonTitle:@"yes" otherButtonTitles:nil, nil];
    [alertV show];
}

- (void)nextImage
{
    NSInteger adsCount = [self.pics count];
    int currentPage = (int)floor(self.picsView.contentOffset.x / self.picsView.frame.size.width);
//    NSLog(@"自动滚动的  %d", currentPage);
    if (currentPage == 0) {
        [self.picsView scrollRectToVisible:CGRectMake(self.picsView.frame.size.width * adsCount, 0, self.picsView.frame.size.width, self.picsView.frame.size.height) animated:NO];
    } else if ( currentPage == adsCount + 1) {
        [self.picsView scrollRectToVisible:CGRectMake(self.picsView.frame.size.width, 0.0f, self.picsView.frame.size.width, self.picsView.frame.size.height) animated:NO];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
        [self.picsView scrollRectToVisible:CGRectMake(self.picsView.frame.size.width * (currentPage + 1), 0.0f, self.picsView.frame.size.width, self.picsView.frame.size.height) animated:NO];
        }];
    }
}
/**
 *  开启定时器
 */
- (void)addTimer{
    [self.picsView scrollRectToVisible:CGRectMake(self.picsView.frame.size.width, 0.0f, self.picsView.frame.size.width, self.picsView.frame.size.height) animated:NO];
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
/**
 *  关闭定时器
 */
- (void)removeTimer
{
    [timer invalidate];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ( scrollView == self.picsView ){
        self.scrollPage.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width) - 1;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ( scrollView == self.picsView ){
        NSInteger adsCount = [self.pics count];
        
        int currentPage = (int)floor(scrollView.contentOffset.x / scrollView.frame.size.width);
//        NSLog(@"手动滚动的 %d", currentPage);
        if (currentPage == 0) {
            [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width * adsCount,0, scrollView.frame.size.width, scrollView.frame.size.height) animated:NO];
        } else if ( currentPage == adsCount + 1) {
            [scrollView scrollRectToVisible:CGRectMake(scrollView.frame.size.width, 0.0f, scrollView.frame.size.width, scrollView.frame.size.height) animated:NO];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ( scrollView == self.picsView ){
        if ([timer isValid]) {
            [timer invalidate];
        }
    }
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ( scrollView == self.picsView ){
        if (![timer isValid]) {
            timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
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
