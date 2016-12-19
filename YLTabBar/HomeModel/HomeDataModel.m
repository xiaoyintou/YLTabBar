//
//  HomeDataModel.m
//  YLTabBar
//
//  Created by yyl on 2016/12/16.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "HomeDataModel.h"

@implementation HomeDataModel
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"tid" : @"id"};
}
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"name" : @"n",
//             @"page" : @"p",
//             @"desc" : @"ext.desc",
//             @"bookID" : @[@"id",@"ID",@"book_id"]};
//}
@end


//@implementation HomeResult
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"appdata" : [HomeDataModel class]};
//}
//@end

@implementation BaseModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"appdata" : @"data"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"appdata" : [HomeDataModel class]};
}
@end

@implementation ResultModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : [BaseModel class]};
}

@end




