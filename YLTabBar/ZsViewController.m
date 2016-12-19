//
//  ZsViewController.m
//  YLTabBar
//
//  Created by yyl on 2016/12/13.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "ZsViewController.h"
#import "JSONKit.h"
#import "AFNetworking.h"
#import "ZsModel.h"

@interface ZsViewController ()

@end

@implementation ZsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"钻石王老五";
    
    [self createView];
    [self getData];
}
#pragma mark -------------------------------
#pragma mark 纯代码使用autolayout进行适配
- (void)createView {
    UIView *purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:purpleView];
    
    [purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
       //在这个block里面，利用make对象创建约束
        make.size.equalTo(CGSizeMake(100, 100));
        make.center.equalTo(self.view);
    }];
    
    UIView *midView = [[UIView alloc] init];
    midView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:midView];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bottomView];
    
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.top.equalTo(purpleView.bottom).with.offset(50);
        make.height.equalTo(30);
    }];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midView.right).with.offset(50);
        make.top.equalTo(midView.top);
        make.right.equalTo(self.view).with.offset(-50);
        make.height.equalTo(midView.height);
        make.width.equalTo(midView.width);
    }];
    
}

#pragma mark -----------------------
#pragma mark 获取配置数据
- (void)getData {
    
    // 读取用户偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults removeObjectForKey:@"data"];
    //    self.one.on = [defaults boolForKey:@"one"];
    NSDictionary *tempDic = [defaults objectForKey:@"configdata"];
    ZsModel *model = [ZsModel yy_modelWithDictionary:tempDic];
    NSLog(@"输出的数组taoclass的数据是  name   =  %@",  [model.data.taoClasses firstObject].name);
    if (model.data.taoClasses.count > 0) {
        return;
    }

//    HomeModel *model = [HomeModel yy_modelWithDictionary:tempDic];
//    if (model.appdata.count > 0) {
//        [self.dataArray addObjectsFromArray:model.appdata];
//        [self handleMidImage];
//        [self.homeTableView reloadData];
//        return;
//    }
    
    
    NSString *URL = [NSString stringWithFormat:@"http://www.baidu.com"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    [dic1 setObject:@"getConfigNew" forKey:@"commond"];

    
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
        [defaults setObject:[[resultDict objectForKey:@"result"] firstObject] forKey:@"configdata"];
        //         注意：UserDefaults设置数据时，不是立即写入，而是根据时间戳定时地把缓存中的数据写入本地磁盘。所以调用了set方法之后数据有可能还没有写入磁盘应用程序就终止了。
        //         出现以上问题，可以通过调用synchornize方法强制写入
        //         现在这个版本不用写也会马上写入 不过之前的版本不会
        [defaults synchronize];
        //        ResultModel *resultModel = model.result;
        ZsModel *model = [ZsModel yy_modelWithDictionary:[[resultDict objectForKey:@"result"] firstObject]];
        NSLog(@"输出的数组taoclass的数据是  name   =  %@", [model.data.taoClasses firstObject].name);
//        NSLog(@"fafjasklfjaklfj kl    %@", model.data.jsForWebview);
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
