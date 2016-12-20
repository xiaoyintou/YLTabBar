//
//  ScanHelper.h
//  YLTabBar
//
//  Created by yyl on 2016/12/20.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^ScanSuccessBlock)(NSString *scanResult);

@interface ScanHelper : NSObject
@property (nonatomic, strong) ScanSuccessBlock scanBlock;
+ (instancetype)manager;
- (void)scanblock:(ScanSuccessBlock)scanBlock;
- (void)startRunning;
- (void)stopRunning;
- (void)showLayer:(UIView *)superView;
- (void)setScanningRect:(CGRect)scanRect scanView:(UIView *)scanView;
- (void)removeFormSupview;

@end
