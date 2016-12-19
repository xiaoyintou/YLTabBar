//
//  HomeCell.h
//  YLTabBar
//
//  Created by yyl on 2016/12/9.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeCell : UITableViewCell
///第一种cell的样式属性
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *connectLabel;
@property (weak, nonatomic) IBOutlet UIImageView *midImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midImageHeight;

///第二种cell的样式属性
@property (weak, nonatomic) IBOutlet UIImageView *twoMidImageView;
@property (weak, nonatomic) IBOutlet UILabel *twoTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoMIdImageHeight;


/**
 *  @author god~long, 16-04-03 15:04:19
 *
 *  初始化Cell的方法
 *
 *  @param tableView 对应的TableView
 *  @param indexPath 对应的indexPath
 *
 *  @return TempTableViewCell
 */
+ (instancetype)tempTableViewCellWith:(UITableView *)tableView
                            indexPath:(NSIndexPath *)indexPath andData:(HomeDataModel *)data;
@end
