//
//  MeViewController.m
//  YLTabBar
//
//  Created by yyl on 2016/12/13.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "MeViewController.h"
#import "ScanHelper.h"
#import "AFNetworking.h"

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
    
    __weak MeViewController *weakself = self;
    //封装调用方法
    [[ScanHelper manager] showLayer:self.view];
    [[ScanHelper manager] setScanningRect:scanRect scanView:self.framView];
    [[ScanHelper manager] scanblock:^(NSString *scanResult) {
//        NSLog(@"扫描到的字符串 %@", scanResult);
        [weakself ymxDataWithBarcode:scanResult];
        [[ScanHelper manager] stopRunning];
        [[ScanHelper manager] removeFormSupview];
    }];
    [[ScanHelper manager] startRunning];
}
#pragma mark ------------------
#pragma mark 亚马逊条码扫描接口
- (void)ymxDataWithBarcode:(NSString *)barcode {
    NSString *urlstr = [NSString stringWithFormat:@"https://match-visualsearch-cn.amazon.cn/pisa/search/barcode?barcode=%@&barcodeType=EAN_13&catalogs=Amazon&username=amzn-mbl-cscan-cn&application=amzn-mbl-cscan-cn&authtoken=C74986996F84AFE27EA62183194E9189&ts=1482391558&amznSessionId=453-2586596-8583224&app=amzn-mbl-cscan-cn&appPlatform=iPhone&device=iPhone6%%2C1&deviceOs=iPhone%%20OS_9.1&requestId=1B3F9ED37FA6492B935A&uniqueDeviceId=CA51DA5A-9E5E-413B-B7CF-A3D27D309C12", barcode];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //        manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据
    [manager POST:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDict = [NSJSONSerialization
                                    JSONObjectWithData:responseObject
                                    options:NSJSONReadingMutableLeaves
                                    error:nil];
//        NSLog(@"条码扫描接口返回的数据    %@", resultDict);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@", resultDict] delegate:self cancelButtonTitle:@"yes" otherButtonTitles:nil, nil];
        [alertView show];


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
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
