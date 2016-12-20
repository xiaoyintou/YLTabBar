//
//  MeViewController.m
//  YLTabBar
//
//  Created by yyl on 2016/12/13.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "MeViewController.h"
#import "ScanHelper.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"扫一扫功能";
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //扫描框定义
    CGRect scanRect = self.framView.frame;
    self.framView.layer.borderColor = [UIColor redColor].CGColor;
    self.framView.layer.borderWidth = 1;
    
    //封装调用方法
    [[ScanHelper manager] showLayer:self.view];
    [[ScanHelper manager] setScanningRect:scanRect scanView:self.framView];
    [[ScanHelper manager] scanblock:^(NSString *scanResult) {
//        NSLog(@"扫描到的字符串 %@", scanResult);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:scanResult delegate:self cancelButtonTitle:@"yes" otherButtonTitles:nil, nil];
        [alertView show];
        [[ScanHelper manager] stopRunning];
        [[ScanHelper manager] removeFormSupview];
    }];
    [[ScanHelper manager] startRunning];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
