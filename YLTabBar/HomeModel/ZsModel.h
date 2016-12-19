//
//  ZsModel.h
//  YLTabBar
//
//  Created by yyl on 2016/12/17.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZsData.h"

@class HReward;

@interface ZsModel : NSObject
@property (nonatomic , strong) HReward              * reward;
@property (nonatomic , strong) ZsData              * data;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , copy) NSString              * commond;
@property (nonatomic , assign) NSInteger              total;


@end



@interface HReward :NSObject <NSCoding,NSCopying>
@property (nonatomic , assign) NSInteger              score;
@property (nonatomic , assign) NSInteger              coin;
@property (nonatomic , copy) NSString              * info;

@end



