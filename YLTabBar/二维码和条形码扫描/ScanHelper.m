//
//  ScanHelper.m
//  YLTabBar
//
//  Created by yyl on 2016/12/20.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "ScanHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanHelper() <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *_session; //输入输出的中间桥梁
    AVCaptureVideoPreviewLayer *_layer; //捕捉视频预览层
    AVCaptureMetadataOutput *_output; //捕捉元数据输出
    AVCaptureDeviceInput *_input; //采集设备输入
    UIView *_superView; //图层的负累
    UIView *_scanView;

}
@end


@implementation ScanHelper
- (void)scanblock:(ScanSuccessBlock)scanBlock {
    self.scanBlock = scanBlock;
}
+ (instancetype)manager {
    static ScanHelper *scanHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scanHelper = [[ScanHelper alloc] init];
    });
    return scanHelper;
}
///初始化单例，只调用一次
- (id)init {
    self = [super init];
    if (self) {
     //初始化链接对象
        _session = [[AVCaptureSession alloc] init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        //避免模拟器运行崩溃 先不佳判断了
        if (!TARGET_IPHONE_SIMULATOR) {
            //获取摄像设备
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            //创建输入流
            _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            [_session addInput:_input];
            
            //创建输出流
            _output = [[AVCaptureMetadataOutput alloc] init];
            //设置代理  在主线程里刷新
            [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [_session addOutput:_output];
            
            //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
            _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
            //要在addoutput之后，否则ios10会崩溃
            _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
            _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        }
    }
    return self;
}
#pragma mark -----------------------------------
#pragma mark 开始扫描，结束扫描
- (void)startRunning {
    if (!TARGET_IPHONE_SIMULATOR) {
        [_session startRunning];
    }
}
- (void)stopRunning {
    if (!TARGET_IPHONE_SIMULATOR) {
        [_session stopRunning];
    }
}
#pragma mark ----------------------------------------
#pragma mark AVCaptureMetadataOutputObjects Delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
            self.scanBlock(metadataObject.stringValue);
    }
}
#pragma mark --------------------------------
#pragma mark 设置扫描区域
/*
  设置扫描范围区域  CGRectMake(y的起点／屏幕的高，x的起点／屏幕的宽，扫描的区域的高／屏幕的高，扫描区域的宽／屏幕的宽)
 */
- (void)setScanningRect:(CGRect)scanRect scanView:(UIView *)scanView {
    CGFloat x, y, width ,height;
    x = scanRect.origin.y / _layer.frame.size.height;
    y = scanRect.origin.x / _layer.frame.size.width;
    width = scanRect.size.height / _layer.frame.size.height;
    height = scanRect.size.width / _layer.frame.size.width;
    
    _output.rectOfInterest = CGRectMake(x, y, width, height);
    _scanView = scanView;
    if (_scanView) {
        _scanView.frame = scanRect;
        if (_superView) {
            [_superView addSubview:_scanView];
        }
    }
}
#pragma mark -----------------
#pragma mark 显示图层

/**
 显示图层

 @param superView 需要在哪个view显示
 */
- (void)showLayer:(UIView *)superView {
    _superView = superView;
    _layer.frame = _superView.layer.frame;
    [_superView.layer insertSublayer:_layer atIndex:0];
}
#pragma mark --------------------
#pragma mark 从俯视图上移除
- (void)removeFormSupview {
//    [_scanView removeFromSuperview];
//    _scanView = nil;
//    for (UIView *tempView in _superView.subviews) {
//        [tempView removeFromSuperview];
//    }
//    _superView = nil;
}

@end
