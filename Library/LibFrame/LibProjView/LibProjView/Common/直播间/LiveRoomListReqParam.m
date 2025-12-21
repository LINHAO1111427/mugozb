//
//  LiveRoomListReqParam.m
//  LibProjView
//
//  Created by shirley on 2022/1/5.
//  Copyright © 2022 KLC. All rights reserved.
//

#import "LiveRoomListReqParam.h"

@implementation LiveRoomListReqParam

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataIndex = 0;
        _hotSortId = -1;
        _channelId = -1;
        _pageSize = 100;
        _address = @"";
        _isRecommend = -1;
        _isAttention = -1;
        _unionId = -1;
        
    }
    return self;
}

- (void)setJoinPosition:(int)joinPosition{
    _joinPosition = joinPosition;
    
    switch (joinPosition) {
        case 1:/// 推荐
            _findType = -1;
            _isRecommend = 1;
            break;
        case 2:/// 视频直播
            _findType = 1;
            break;
        case 3:/// 派对
            _findType = 2;
            break;
        case 4:///直播购
            _findType = 1;
            break;
        case 5:///关注
            _findType = -1;
            _isAttention = 1;
            break;
        case 6:///附近
            _findType = -1;
            break;
        case 7:///工会
            _findType = -1;
            break;
        case 8:///休息中
            _findType = -1;
            break;
        case 9:///其他一个
            _findType = -1;
            break;
        default:
            break;
    }
}


@end
