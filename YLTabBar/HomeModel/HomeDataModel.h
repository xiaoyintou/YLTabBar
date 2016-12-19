//
//  HomeDataModel.h
//  YLTabBar
//
//  Created by yyl on 2016/12/16.
//  Copyright © 2016年 dml. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "BaseModel.h"

//@class HomeResult;

//@class BaseModel, Reward, ResultModel;


@interface HomeDataModel : NSObject
@property (nonatomic , copy) NSString              *timestamp;
@property (nonatomic , copy) NSString              *isbest;
@property (nonatomic , copy) NSString              *summary;
@property (nonatomic , copy) NSString              *tid;
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

//@interface HomeResult : BaseModel
//@end


//@interface BaseModel : NSObject
//@property (nonatomic , strong) Reward *reward;
//@property (nonatomic , strong) NSArray<HomeDataModel *> *appdata;
//@property (nonatomic , copy) NSString  *code;
//@property (nonatomic , copy) NSString  *msg;
//@property (nonatomic , copy) NSString  *commond;
//@property (nonatomic , assign) NSInteger total;
//
//@end
//
//
//@interface Reward :NSObject <NSCoding,NSCopying>
//@property (nonatomic , assign) NSInteger score;
//@property (nonatomic , assign) NSInteger coin;
//@property (nonatomic , copy) NSString *info;
//
//@end
//
//
//@interface ResultModel :NSObject
//@property (nonatomic , strong) NSArray<BaseModel *>  *result;
//
//@end


