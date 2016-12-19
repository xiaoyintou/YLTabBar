//
//  HomeModel.h
//  YLTabBar
//
//  Created by yyl on 2016/12/17.
//  Copyright © 2016年 dml. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel
+ (NSDictionary *)modelContainerPropertyGenericClass;
@end


@interface HomeDataModel : NSObject <NSCoding,NSCopying>
@property (nonatomic , copy) NSString              *timestamp;
@property (nonatomic , copy) NSString              *isbest;
@property (nonatomic , copy) NSString              *summary;
@property (nonatomic , copy) NSString              *id;
@property (nonatomic , copy) NSString              *talentType;
@property (nonatomic , copy) NSString              * srctxt;
@property (nonatomic , copy) NSString              * bbsid;
@property (nonatomic , copy) NSString              * tagcolor;
@property (nonatomic , copy) NSString              * say;
@property (nonatomic , copy) NSString              * count_agree;
@property (nonatomic , copy) NSString              * srcid;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * istop;
@property (nonatomic , copy) NSString              * coin;
@property (nonatomic , copy) NSString              * tag;
@property (nonatomic , copy) NSString              * ageid;
@property (nonatomic , copy) NSString              * levelname;
@property (nonatomic , copy) NSString              * lastupdate;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * exptime;
@property (nonatomic , copy) NSString              * showBBSPic;
@property (nonatomic , copy) NSString              * itime;
@property (nonatomic , copy) NSString              * tagid;
@property (nonatomic , copy) NSString              * isshow;
@property (nonatomic , copy) NSString              * hd_end;
@property (nonatomic , copy) NSString              * count_comment;
@property (nonatomic , copy) NSString              * count_view;
@property (nonatomic , copy) NSString              *pic;
@property (nonatomic , copy) NSString              * hd_start;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * infotype;
@property (nonatomic , copy) NSString              * userid;

@end
