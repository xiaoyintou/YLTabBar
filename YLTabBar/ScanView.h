//
//  ScanView.h
//  YLTabBar
//
//  Created by yyl on 2016/12/20.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#define SelfW self.bounds.size.width
#define SelfH self.bounds.size.height
#define ScanLineH 30

@interface ScanView : UIView<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *session; // 输入输出的中间桥梁
    
    CAGradientLayer *scanLayer;
    
    UIView *scanBox;
}


@end
