//
//  HomeCell.m
//  YLTabBar
//
//  Created by yyl on 2016/12/9.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+WebCache.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //去除cell被点击时的背景
     self.selectionStyle = UITableViewCellSelectionStyleNone;
}
+ (instancetype)tempTableViewCellWith:(UITableView *)tableView
                            indexPath:(NSIndexPath *)indexPath andData:(HomeDataModel *)data {
    NSString *identifier = @"";//对应xib中设置的identifier
    NSInteger index = 0; //xib中第几个Cell
    if (![data.summary isEqualToString:@""]) {
        identifier = @"homefirstCell";
        index = 0;
    } else {
        identifier = @"hometwoCell";
        index = 1;
    }
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil] objectAtIndex:index];
    }
    if (![data.summary isEqualToString:@""]) {
       [cell setContent:data tempRow:indexPath.row andIndex:index];
    } else {
        [cell setTwoContent:data tempRow:indexPath.row andIndex:index];
    }
    return cell;
    
}
///设置第一种样式的属性值
- (void)setContent:(HomeDataModel *)data tempRow:(NSInteger)tempRow andIndex:(NSInteger)index {
    self.titleLabel.text = data.title;
    if (index == 0) {
        if (tempRow == 0 || tempRow == 4) {
            self.connectLabel.text = [NSString stringWithFormat:@"adfkjalsfjlask;djfsjfdalkdfjaljfalsfjlasjfals;jfalsjflas;jfla;sjdfla;sjfdl;asjdflaksjdfl;asjfl;askjdflakjdsfljsdlkasjdflajsdl;fjasld;jaslkjasl;jasldkf%@", data.summary];
        } else {
            self.connectLabel.text = data.summary;
        }
    }
    // 先从缓存中查找图片
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:data.pic];
    if (!image) {
        image = [UIImage imageNamed:@"zhanwei"];
    }
    self.midImageView.image = image;
    self.midImageHeight.constant = self.midImageView.frame.size.width * image.size.height / image.size.width;
}
///设置第二种样式的属性值
- (void)setTwoContent:(HomeDataModel *)data tempRow:(NSInteger)tempRow andIndex:(NSInteger)index {
    self.twoTitleLabel.text = data.title;
    // 先从缓存中查找图片
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:data.pic];
    if (!image) {
        image = [UIImage imageNamed:@"zhanwei"];
    }
    self.twoMidImageView.image = image;
    self.twoMIdImageHeight.constant = self.twoMidImageView.frame.size.width * image.size.height / image.size.width;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
