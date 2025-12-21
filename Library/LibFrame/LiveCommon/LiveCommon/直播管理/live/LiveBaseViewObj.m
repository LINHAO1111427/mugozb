//
//  LiveBaseViewObj.m
//  LiveCommon
//
//  Created by shirley on 2019/7/25.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveBaseViewObj.h"
#import <LiveCommon/LiveComponentInterface.h>
#import <CoreGraphics/CoreGraphics.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjModel/HttpApiHome.h>
#import "LiveManager.h"
#import <LibProjModel/SlideLiveRoomInfoModel.h>

@interface LiveBaseViewObj () <UIScrollViewDelegate>

@property (nonatomic, copy)NSArray *liveListArr;

@property (nonatomic, weak)UIScrollView *bgScrollV;

@property (nonatomic, weak)LiveLevelView *currPlayLiveV;

@property (nonatomic, assign)NSInteger LiveRoomTotalCount; ///总共多少个live

@property (nonatomic, strong)LiveRoomListReqParam *param;


@end


@implementation LiveBaseViewObj

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
    
    [LiveComponentMsgMgr removeAllListener];
    _liveVC = nil;
    [_managerView removeFromSuperview];
    _managerView = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       // NSLog(@"过滤文字初始化:%s"),__func__);
    }
    return self;
}


- (void)showViewInController:(LiveBaseViewController *)vc mpLiveListReqParam:(LiveRoomListReqParam *)param {
    if (!_liveVC) {
        _liveVC = vc;
        
        vc.navigationController.navigationBarHidden = YES;
        vc.automaticallyAdjustsScrollViewInsets = NO;
        
        UIScrollView *bgScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        bgScrollV.pagingEnabled = YES;
        bgScrollV.delegate = self;
        bgScrollV.bounces = NO;
        bgScrollV.showsHorizontalScrollIndicator = NO;
        bgScrollV.showsVerticalScrollIndicator = NO;
        [_liveVC.view addSubview:bgScrollV];
        _bgScrollV = bgScrollV;
        _managerView = bgScrollV;
        
        
        if (kiOS(11.0)) {
            bgScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else if (kiOS(13.0)) {
            bgScrollV.automaticallyAdjustsScrollIndicatorInsets = YES;
        }
        
        bgScrollV.contentSize = CGSizeMake(0, 0);
        
        LiveLevelView *liveV = [[LiveLevelView alloc] initWithFrame:bgScrollV.bounds];
        liveV.currIndex = -1;
        [bgScrollV addSubview:liveV];
        self.currPlayLiveV = liveV;
        
        self.delegate?[self.delegate LiveBaseView:self liveInfoAtCurrentView:liveV]:nil;
        
        if (param) {
            self.param = param;
            [self reloadShowData];
        }
    }
}



/// 刷新页面
/// @param totalCount 数据总共有多个
/// @param index 当前页的第几个
- (void)reloadListInfo:(NSInteger)totalCount currIndex:(NSInteger)index{
    
    if (totalCount < 1 || (totalCount <= index)) {
        return;
    }
    self.LiveRoomTotalCount = totalCount;
    
    CGFloat num = MIN(3, totalCount);
    self.bgScrollV.contentSize = CGSizeMake(0, self.bgScrollV.height*num);
    self.currPlayLiveV.currIndex = MAX(-1, index);
    
    [self reloadShowViewFrame];
}


///刷新view的frame  填充其他view
- (void)reloadShowViewFrame{
    
    NSInteger index = self.currPlayLiveV.currIndex;
    
    if (index <= 0) { ///第一个
        self.currPlayLiveV.y = 0;
        
        if (self.bgScrollV.contentSize.height > self.bgScrollV.height) {
            LiveLevelView *firstLiveV = [self createShowInfo:CGRectMake(0, self.bgScrollV.height, self.bgScrollV.width, self.bgScrollV.height) index:index+1];
            [self.bgScrollV addSubview:firstLiveV];
        }
        
        if (self.bgScrollV.contentSize.height > self.bgScrollV.height*2) {
            LiveLevelView *lastLiveV = [self createShowInfo:CGRectMake(0, self.bgScrollV.height*2, self.bgScrollV.width, self.bgScrollV.height) index:index+2];
            [self.bgScrollV addSubview:lastLiveV];
        }
        
    }else if(self.LiveRoomTotalCount == index+1) { ///最后一个
        
        self.currPlayLiveV.y = self.bgScrollV.contentSize.height-self.bgScrollV.height;
        
        NSInteger beforeIndex = self.currPlayLiveV.currIndex;
        if (self.currPlayLiveV.y > self.bgScrollV.height) {
            ///中间那个
            LiveLevelView *lastLiveV = [self createShowInfo:CGRectMake(0, self.bgScrollV.height, self.bgScrollV.width, self.bgScrollV.height) index:beforeIndex-1];
            [self.bgScrollV addSubview:lastLiveV];
            beforeIndex = lastLiveV.currIndex;
        }
        
        if (self.currPlayLiveV.y > 0) {
            LiveLevelView *firstLiveV = [self createShowInfo:CGRectMake(0, 0, self.bgScrollV.width, self.bgScrollV.height) index:beforeIndex-1];
            [self.bgScrollV addSubview:firstLiveV];
        }
        
    }else {
        
        self.currPlayLiveV.y = self.bgScrollV.height;
        
        LiveLevelView *firstLiveV = [self createShowInfo:CGRectMake(0, 0, self.bgScrollV.width, self.bgScrollV.height) index:index-1];
        [self.bgScrollV addSubview:firstLiveV];
        
        if (self.bgScrollV.contentSize.height > self.bgScrollV.height*2) {
            LiveLevelView *lastLiveV = [self createShowInfo:CGRectMake(0, self.bgScrollV.height*2, self.bgScrollV.width, self.bgScrollV.height) index:index+1];
            [self.bgScrollV addSubview:lastLiveV];
        }
        
    }
    self.bgScrollV.contentOffset = CGPointMake(0, self.currPlayLiveV.y);
   // NSLog(@"过滤文字====数据frame刷新后===%zi"),self.bgScrollV.subviews.count);
}


/// 获取某一个显示的View
/// @param frame 尺寸
/// @param index 当前数据第几个
- (LiveLevelView *)createShowInfo:(CGRect)frame index:(NSInteger)index{
    LiveLevelView *liveV = [[LiveLevelView alloc] initWithFrame:frame];
    liveV.currIndex = index;
    if (self.liveListArr.count > index) {
        [liveV showCoverViewMakeBaseInfo:self.liveListArr[index]];
    }
    return liveV;
}


///刷新页面显示新的直播间
- (void)reloadPlayLiveInfoData{
    ///当前
    CGFloat offsetY = self.bgScrollV.contentOffset.y;
    /// 播放view的y和offsetY一致，说明位置没变
    if (self.currPlayLiveV.y == offsetY) {
       // NSLog(@"过滤文字=======还在这"));
        return;
    }
    
    kWeakSelf(self);
    __block BOOL hasChangePlay = NO;
   // NSLog(@"过滤文字====滑动停止后===%zi"),self.bgScrollV.subviews.count);
    [self.bgScrollV.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LiveLevelView class]]) {
            LiveLevelView *liveV = (LiveLevelView *)obj;
            if (liveV.y == offsetY) {
               // NSLog(@"过滤文字=======当前的%zi   之后的%zi"),self.currPlayLiveV.currIndex, liveV.currIndex);
                weakself.currPlayLiveV = liveV;
                weakself.delegate?[weakself.delegate LiveBaseView:weakself liveInfoAtCurrentView:liveV]:nil;
                hasChangePlay = YES;
            }else{
                [liveV removeAllSubViews];
                [liveV removeFromSuperview];
            }
        }
    }];
    if (hasChangePlay) {
        [self reloadShowViewFrame];
    }
}

#pragma mark  - UIScrollViewDelegate -

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   // NSLog(@"过滤文字scrollViewDidEndDecelerating"));
    [self reloadPlayLiveInfoData];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
       // NSLog(@"过滤文字scrollViewDidEndDragging"));
        [self reloadPlayLiveInfoData];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
}



#pragma mark - data handle -


/// 请求数据接口
- (void)reloadShowData{
    if (!self.param) {
        return;
    }
    kWeakSelf(self);
    int64_t currRoomId = [LiveManager liveInfo].roomId;
    int64_t channelId = self.param.channelId;
    NSString *city = self.param.address;
    int findType = self.param.findType;
    int64_t hotSortId = self.param.hotSortId;
    int isAttention = self.param.isAttention;
    int64_t guildId = self.param.unionId;
    int isRecommend = self.param.isRecommend;
    [HttpApiHome getLiveListAtPosition:channelId city:city findType:findType guildId:guildId hotSortId:hotSortId isAttention:isAttention isRecommend:isRecommend pageIndex:0 pageSize:self.param.pageSize roomId:currRoomId callback:^(int code, NSString *strMsg, SlideLiveRoomVOModel *model) {
        if (code == 1) {
            weakself.liveListArr = model.slideLiveRoomInfoList;
            [weakself reloadListInfo:weakself.liveListArr.count currIndex:model.mySerialNumber];
            
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}



@end
