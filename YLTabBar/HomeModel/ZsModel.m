//
//  ZsModel.m
//  YLTabBar
//
//  Created by yyl on 2016/12/17.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "ZsModel.h"

@implementation ZsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [ZsData class]};
}
@end

@implementation HReward
// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }

@end

//@implementation HData
//
//// 直接添加以下代码即可自动完成
//- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
//- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
//- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
//- (NSUInteger)hash { return [self yy_modelHash]; }
//- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
//- (NSString *)description { return [self yy_modelDescription]; }
//
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"taoClasses" : [TaoClasses class]};
//}
//
//
//@end
//
//
//@implementation TaoClasses
//// 直接添加以下代码即可自动完成
//- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
//- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
//- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
//- (NSUInteger)hash { return [self yy_modelHash]; }
//- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
//- (NSString *)description { return [self yy_modelDescription]; }
//
//@end
