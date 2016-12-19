//
//  YLTabBarController.m
//  YLTabBar
//
//  Created by yyl on 2016/12/8.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "YLTabBarController.h"
#import "YLTabBar.h"
#import "FirstViewController.h"
#import "ZsViewController.h"
#import "BzViewController.h"
#import "MeViewController.h"

@interface YLTabBarController ()

@end

@implementation YLTabBarController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (instancetype)createTabBar
{
    YLTabBarController *tabBarC = [[YLTabBarController alloc] init];
    FirstViewController *firstVC = [[FirstViewController alloc]init];
    ZsViewController *twoVC = [[ZsViewController alloc] init];
    BzViewController *threeVC = [[BzViewController alloc] init];
    MeViewController *fourthVC = [[MeViewController alloc] init];
    
    firstVC.view.backgroundColor = [UIColor lightGrayColor];
    twoVC.view.backgroundColor = [UIColor grayColor];
    threeVC.view.backgroundColor = [UIColor greenColor];
    fourthVC.view.backgroundColor = [UIColor blueColor];
    
    UINavigationController *firstNavigationCon = [[UINavigationController alloc]initWithRootViewController:firstVC];
    UINavigationController *twoNavigationCon = [[UINavigationController alloc]initWithRootViewController:twoVC];
    UINavigationController *threeNavigationCon = [[UINavigationController alloc]initWithRootViewController:threeVC];
    UINavigationController *fourthNavigationCon = [[UINavigationController alloc]initWithRootViewController:fourthVC];
    
    NSArray *viewContrllerArray = [NSArray arrayWithObjects:firstNavigationCon, twoNavigationCon, threeNavigationCon, fourthNavigationCon, nil];
    [tabBarC setViewControllers:viewContrllerArray];
    
    return tabBarC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化自定义的tabbar上要显示view
    NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"YLTabBar" owner:nil options:nil];
    YLTabBar *tabbar = [nibView objectAtIndex:0];
    self.selectedIndex = 0;
    //触发tabbar上按钮响应的回调方法,来设置控制器的显示
    __weak YLTabBarController *oldTabbarCon = self;
    [tabbar ylclickblock:^(NSInteger selectIndex) {
        oldTabbarCon.selectedIndex = selectIndex;
    }];
    [tabbar middleclickblock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"送你个大礼物" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    //把自定义的view添加到tabbar上
    [self setValue:tabbar forKeyPath:@"tabBar"];
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
