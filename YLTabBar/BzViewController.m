//
//  BzViewController.m
//  YLTabBar
//
//  Created by yyl on 2016/12/13.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "BzViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "JSONKit.h"
//#import "Data.h"

@interface BzViewController ()

@end

@implementation BzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"保障人民群众的权益";
    self.dataArray = [NSMutableArray array];
    [self getData];
    
    //    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"CarouselView" owner:nil options:nil];
    //    CarouselView *cv =[nibView objectAtIndex:0];
}
#pragma mark ---------------------------
#pragma mark 创建轮播图

- (void)createCarouselView {
    if (self.carouselView) {
        [self.carouselView removeFromSuperview];
        self.carouselView = nil;
    }
    //得到第一个UIView
    self.carouselView = [CarouselView instanceCarouselViewWithDataArray:self.dataArray];
    [self.view addSubview:self.carouselView];
    [self.carouselView setAllViewAutoLayout];
}
#pragma mark ----------------------------------------
#pragma mark 获取轮播图的数据 
- (void)getData {
    
    // 读取用户偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults removeObjectForKey:@"data"];
    //    self.one.on = [defaults boolForKey:@"one"];
    NSDictionary *tempDic = [defaults objectForKey:@"cardata"];
    if (tempDic.count > 0) {
        [self.dataArray addObjectsFromArray:[[[tempDic objectForKey:@"result"] firstObject] objectForKey:@"data"]];
        [self createCarouselView];
        return;
    }
    
    
    NSString *URL = [NSString stringWithFormat:@"http://www.baidu.com"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    [dic1 setObject:@"getIndexFocus" forKey:@"commond"];
    
    NSArray *tempArray = [NSArray arrayWithObjects:dic1, nil];
    
    //    NSDictionary *resultDic = [NSDictionary dictionaryWithObjectsAndKeys:[tempArray JSONString64], @"data", nil];
    [resultDic setObject:[tempArray JSONString64] forKey:@"data"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //        manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据
    [manager POST:URL parameters:resultDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDict = [NSJSONSerialization
                                    JSONObjectWithData:responseObject
                                    options:NSJSONReadingMutableLeaves
                                    error:nil];
        // 获取用户偏好设置对象
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // 保存用户偏好设置
        [defaults setObject:resultDict forKey:@"cardata"];
        // 注意：UserDefaults设置数据时，不是立即写入，而是根据时间戳定时地把缓存中的数据写入本地磁盘。所以调用了set方法之后数据有可能还没有写入磁盘应用程序就终止了。
        // 出现以上问题，可以通过调用synchornize方法强制写入
        // 现在这个版本不用写也会马上写入 不过之前的版本不会
        [defaults synchronize];
        
        [self.dataArray addObjectsFromArray:[[[resultDict objectForKey:@"result"] firstObject] objectForKey:@"data"]];
        if (self.dataArray.count > 0) {
            [self createCarouselView];
        }

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
