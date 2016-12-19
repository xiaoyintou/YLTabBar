//
//  ZsData.h
//  YLTabBar
//
//  Created by yyl on 2016/12/17.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaoClasses;

@interface ZsData : NSObject
@property (nonatomic , copy) NSString              * iosVersion;
//@property (nonatomic , strong) NSArray<GuangHotClasses *>              * guangHotClasses;
//@property (nonatomic , strong) IndexConfig              * indexConfig;
@property (nonatomic , assign) NSInteger              androidVersion;
@property (nonatomic , copy) NSString              * b2cDiscount;
@property (nonatomic , copy) NSString              * iosInfo;
@property (nonatomic , copy) NSString              * taoDiscount;
//@property (nonatomic , strong) NSArray<GuangFocus *>              * guangFocus;
//@property (nonatomic , strong) NSArray<ShopList *>              * shopList;
//@property (nonatomic , strong) NSArray<GuangTaoClasses *>              * guangTaoClasses;
@property (nonatomic , strong) NSArray<NSString *>              * searchKey;
@property (nonatomic , copy) NSString              * androidInfo;
@property (nonatomic , copy) NSString              * editor;
@property (nonatomic , strong) NSArray<TaoClasses *>              * taoClasses;
@property (nonatomic , copy) NSString              * jsForWebview;

+ (NSDictionary *)modelContainerPropertyGenericClass;

@end

//@interface HData :NSObject <NSCoding,NSCopying>
//
//@end

@interface TaoClasses :NSObject <NSCoding,NSCopying>
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * id;

@end
