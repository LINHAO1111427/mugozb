//
//  ShortVideoRecommondViewController.h
//  HomePage
//
//  Created by KLC on 2020/6/11.
//  Copyright © 2020 KLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <JXCategoryView/JXCategoryIndicatorLineView.h>
#import <JXCategoryView/JXCategoryTitleView.h>
#import "JXCategoryView.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum{
    SVDateTypeHome = 0,//首页数据
    SVDateTypeSortList,//分类数据
    SVDateTypeMy,//我的 作品、喜欢、购买相关
    SVDateTypeUser,//他人视频 作品、喜欢、购买等
    SVSVDataTypeSingleComment,// 评论的短视频
    SVDataTypeSingle,// 单独视频
    SVDataTypeLongSV,// 单独视频
} ShortVideoDataType;


@interface ShortVideoListViewController : UIViewController<JXCategoryListContentViewDelegate>


@property (nonatomic, copy)NSDictionary *parameters;
@property(nonatomic,assign)ShortVideoDataType dataType;
 
///parameters参数
@property(nonatomic,assign)int userId;//用户id
@property(nonatomic,assign)int shortVideoId;//短视频id
@property(nonatomic,assign)int index;//初始播放位置

///针对评论的单个短视频
@property (nonatomic, assign)int commentId;//评论id
@property (nonatomic, assign)int checkType;//-1查看详情 1消息评论 2消息点赞

///首页 个人主页/我的 看点
@property(nonatomic,assign)int type;//###首页：0推荐 1关注###  ｜｜  ###我的：1作品 2喜欢 3购买###
@property(nonatomic,assign)int sort;//看点》最多观看 最多评论 最多点赞 最多付费
@property(nonatomic,assign)int classifyId;//看点》热门分类

///长视频
@property(nonatomic,assign)int subClassifyId;//二级分类


@end

NS_ASSUME_NONNULL_END
