//
//  BaseModel.h
//  YLTabBar
//
//  Created by yyl on 2016/12/17.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reward;


@interface BaseModel : NSObject <NSCoding,NSCopying>
//@property (nonatomic , strong) NSArray<Result *>              * result;
@property (nonatomic , strong) Reward              * reward;
@property (nonatomic , strong) NSArray              * data;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * msg;
@property (nonatomic , copy) NSString              * commond;
@property (nonatomic , assign) NSInteger              total;


@end

@interface Reward :NSObject <NSCoding,NSCopying>
@property (nonatomic , assign) NSInteger              score;
@property (nonatomic , assign) NSInteger              coin;
@property (nonatomic , copy) NSString              * info;

@end

