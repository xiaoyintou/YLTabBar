//
//  FirstViewController.h
//  YLTabBar
//
//  Created by yyl on 2016/12/9.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
    NSInteger num;
}
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
