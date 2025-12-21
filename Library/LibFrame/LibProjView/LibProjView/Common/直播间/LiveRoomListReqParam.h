//
//  LiveRoomListReqParam.h
//  LibProjView
//
//  Created by shirley on 2022/1/5.
//  Copyright © 2022 KLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveRoomListReqParam : NSObject


///数据所在当前列表的位置
@property (nonatomic, assign)NSInteger dataIndex;
///加入直播的位置 1:推荐 2:视频直播 3:派对 4:直播购 5:关注 6:附近 7:工会 8:休息中 9:其他一个
@property (nonatomic, assign)int joinPosition;



#pragma mark - 自动设置的值，默认不用传 -
///isAttention 关注 0:不关注 1:关注
@property (nonatomic, assign)int isAttention;
///findType 查询类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 （可不传 根据joinPosition有默认数据）
@property (nonatomic, assign)int findType;
///是否推荐 -1:全部 0:不推荐 1:已推荐
@property (nonatomic, assign)int isRecommend;
///hotSortId 热门类型ID
@property (nonatomic, assign)int64_t hotSortId;
///定位地址
@property (nonatomic, copy)NSString *address;
///频道ID
@property (nonatomic, assign)int64_t channelId;
///pageSize 每页的条数
@property (nonatomic, assign)int pageSize;
///工会ID
@property (nonatomic, assign)int64_t unionId;

@end

NS_ASSUME_NONNULL_END
