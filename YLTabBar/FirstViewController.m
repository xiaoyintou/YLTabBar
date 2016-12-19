//
//  FirstViewController.m
//  YLTabBar
//
//  Created by yyl on 2016/12/9.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "FirstViewController.h"
#import "HomeCell.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "JSONKit.h"
//#import "HomeDataModel.h"
//#import "HomeModel.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.s
    self.navigationItem.title = @"首页";
    [self initData];
    [self getData];
}
#pragma mark ---------------------
#pragma mark 初始化数据容器
- (void)initData {
    self.dataArray = [[NSMutableArray alloc] init];
}
#pragma mark --------------------------
#pragma mark tabbleview的协议方法 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.homeTableView.rowHeight = UITableViewAutomaticDimension;
    self.homeTableView.estimatedRowHeight = 170;
    return self.homeTableView.rowHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary *data = [NSDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
    HomeDataModel *dataModel = [self.dataArray objectAtIndex:indexPath.row];
//    HomeDataModel *dataModel = [HomeDataModel yy_modelWithDictionary:[self.dataArray objectAtIndex:indexPath.row]];
    HomeCell *cell = (HomeCell *)[HomeCell tempTableViewCellWith:tableView indexPath:indexPath andData:dataModel];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -----------------------
#pragma mark 获取数据
- (void)getData {
    
//    // 读取用户偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:@"data"];
//    self.one.on = [defaults boolForKey:@"one"];
    NSDictionary *tempDic = [defaults objectForKey:@"data"];
    HomeModel *model = [HomeModel yy_modelWithDictionary:tempDic];
    if (model.data.count > 0) {
        [self.dataArray addObjectsFromArray:model.data];
        [self handleMidImage];
        [self.homeTableView reloadData];
        return;
    }
    
    
    NSString *URL = [NSString stringWithFormat:@"http://www.baidu.com"];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    [dic1 setObject:@"getTips" forKey:@"commond"];
    [dic2 setObject:@"0" forKey:@"bbsid"];
    [dic2 setObject:@"lastupdate" forKey:@"order"];
    [dic2 setObject:@"1" forKey:@"page"];
    [dic1 setObject:dic2 forKey:@"data"];
    
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
        [defaults setObject:[[resultDict objectForKey:@"result"] firstObject] forKey:@"data"];
//         注意：UserDefaults设置数据时，不是立即写入，而是根据时间戳定时地把缓存中的数据写入本地磁盘。所以调用了set方法之后数据有可能还没有写入磁盘应用程序就终止了。
//         出现以上问题，可以通过调用synchornize方法强制写入
//         现在这个版本不用写也会马上写入 不过之前的版本不会
        [defaults synchronize];
//        ResultModel *resultModel = model.result;
        HomeModel *model = [HomeModel yy_modelWithDictionary:[[resultDict objectForKey:@"result"] firstObject]];
        [self.dataArray addObjectsFromArray:model.data];
        [self handleMidImage];
        [self.homeTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -------------------------
#pragma mark 判断网络图片是否全部请求完毕
- (void)handleMidImage {
    num = 0;
    for (int i = 0; i < self.dataArray.count; i++) {
//        HomeDataModel *dataModel = [HomeDataModel yy_modelWithDictionary:[self.dataArray objectAtIndex:i]];
        HomeDataModel *dataModel = [self.dataArray objectAtIndex:i];
        // 利用 SDWebImage 框架提供的功能下载图片
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:dataModel.pic] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            // do nothing
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            [[SDImageCache sharedImageCache] storeImage:image forKey:dataModel.pic toDisk:YES];
            num++;
            if (num == self.dataArray.count) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.homeTableView reloadData];
                });
            }
        }];
    }
}
////获取将要旋转的状态
//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    [self.homeTableView reloadData];
//}
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
