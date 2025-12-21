//
//  LiveLevelView.m
//  LiveCommon
//
//  Created by shirley on 2021/12/31.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "LiveLevelView.h"
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import "LiveManager.h"
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentInterface.h>
#import <LibProjModel/AppHomeHallDTOModel.h>
#import "LiveCloseInfoView.h"
#import <LibProjModel/SlideLiveRoomInfoModel.h>
#import <LibProjView/CheckRoomPermissions.h>


@interface ClearScrollView : UIScrollView
@end

@implementation ClearScrollView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;
}
@end

@interface PageLevelView : UIView
@end
@implementation PageLevelView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;
}
@end


@interface LiveCoverView : PageLevelView
@property (nonatomic, weak)UIImageView *imgV;
@property (nonatomic, copy)void(^closeBtnClick)(void);

@end

@implementation LiveCoverView
- (UIImageView *)imgV{
    if (!_imgV) {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.clipsToBounds = YES;
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgV];
        _imgV = imgV;
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UIVisualEffectView *effectV = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)]];
        [self addSubview:effectV];
        [effectV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        ///关闭关闭
        UIButton *closeBtn = [UIButton buttonWithType:0];
        CGFloat contentInset = (liveHeaderBannerH - 16)/2.0;
        closeBtn.frame = CGRectMake(kScreenWidth-liveHeaderBannerH-(12-contentInset), liveHeaderBannerY, liveHeaderBannerH, liveHeaderBannerH);
        [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_white"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(contentInset, contentInset, contentInset, contentInset)];
        [self addSubview:closeBtn];
    }
    return _imgV;
}

- (void)closeBtnClick:(UIButton *)btn{
    self.closeBtnClick?self.closeBtnClick():nil;
}

@end



@interface LiveLevelView () <UIScrollViewDelegate>

///左右滑动
@property (nonatomic, weak) ClearScrollView *clearScroll;
///第一层视图
@property (nonatomic, weak) UIView *firstView;
///第二层视图
@property (nonatomic, weak) UIView *secondView;

@property (nonatomic, assign) BOOL clearScreenState; ///当前屏幕状态  yes:清屏  no:显示
///遮盖
@property (nonatomic, weak)LiveCoverView *coverView;
///关播页面
@property (nonatomic, weak)LiveCloseInfoView *closeView;
///直播中的view
@property (nonatomic, weak)UIView *liveBgView;

@end


@implementation LiveLevelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    for (UIView *subV in self.subviews) {
        
        if (subV.tag == 99901) { ///直播页面
            
            for (UIView *subV in self.subviews) {
                if ([subV isKindOfClass:[_clearScroll class]]) {
                    for (UIView *scrollSubView in _clearScroll.subviews) {
                        [scrollSubView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                        [scrollSubView removeFromSuperview];
                    }
                }
                [subV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [subV removeFromSuperview];
            }
            
        }
        
        [subV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [subV removeFromSuperview];
    }
}


- (UIView *)liveBgView{
    if (!_liveBgView) {
        
        UIView *liveBgV = [[UIView alloc] initWithFrame:self.bounds];
        liveBgV.tag = 99901;
        [self addSubview:liveBgV];
        _liveBgView = liveBgV;
        
        UIView *firstView = [[UIView alloc] initWithFrame:liveBgV.bounds];
        firstView.clipsToBounds = YES;
        [liveBgV addSubview:firstView];
        _firstView = firstView;
        
        ClearScrollView *clearScreenV = [[ClearScrollView alloc] initWithFrame:liveBgV.bounds];
        clearScreenV.contentSize = CGSizeMake(liveBgV.width *2.0, 0);
        clearScreenV.delegate = self;
        clearScreenV.pagingEnabled = YES;
        clearScreenV.scrollEnabled = NO;
        clearScreenV.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            clearScreenV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
        }
        
        [liveBgV addSubview:clearScreenV];
        _clearScroll = clearScreenV;
        clearScreenV.contentOffset = CGPointMake(liveBgV.width, 0);
        
        UIView *secondView = [[UIView alloc] initWithFrame:liveBgV.bounds];
        secondView.clipsToBounds = YES;
        [self setX:secondView x:liveBgV.width];
        _secondView = secondView;
        
        //    PageLevelView *secondView = [[PageLevelView alloc] initWithFrame:liveBgV.bounds];
        //    [self setX:secondView x:contentBgView.width];
        //    _secondView = secondView;
        //    secondView.clipsToBounds = YES;
        
        PageLevelView *thirdView = [[PageLevelView alloc] initWithFrame:liveBgV.bounds];
        [self setX:thirdView x:liveBgV.width];
        thirdView.clipsToBounds = YES;
        
        PageLevelView *fourthView = [[PageLevelView alloc] initWithFrame:liveBgV.bounds];
        [self setX:fourthView x:liveBgV.width];
        fourthView.clipsToBounds = YES;
        
        PageLevelView *fifthView = [[PageLevelView alloc] initWithFrame:liveBgV.bounds];
        [self setX:fifthView x:liveBgV.width];
        fifthView.clipsToBounds = YES;
        
        PageLevelView *sixthView = [[PageLevelView alloc] initWithFrame:liveBgV.bounds];
        [self setX:sixthView x:liveBgV.width];
        sixthView.clipsToBounds = YES;
        
        [clearScreenV addSubview:secondView];
        [clearScreenV addSubview:thirdView];
        [clearScreenV addSubview:fourthView];
        [clearScreenV addSubview:fifthView];
        [clearScreenV addSubview:sixthView];
        
        thirdView.userInteractionEnabled = NO;
        fourthView.userInteractionEnabled = NO;
        sixthView.userInteractionEnabled = NO;
        
        _liveViews = @[firstView, secondView, thirdView, fourthView ,fifthView, sixthView];
        
        
        [self setCanClear:_canClear];
        
    }
    return _liveBgView;
}

- (LiveCloseInfoView *)closeView{
    if (!_closeView) {
        LiveCloseInfoView *closeV = [[LiveCloseInfoView alloc] initWithFrame:self.bounds];
        [self addSubview:closeV];
        _closeView = closeV;
        kWeakSelf(self);
        closeV.closeBtnClick = ^{
            weakself.viewDelegate?[weakself.viewDelegate leaveLiveRoomForNotJoin]:nil;
        };
    }
    return _closeView;
}

- (LiveCoverView *)coverView{
    if (!_coverView) {
        LiveCoverView *coverV = [[LiveCoverView alloc] initWithFrame:self.bounds];
        [self addSubview:coverV];
        _coverView = coverV;
        kWeakSelf(self);
        coverV.closeBtnClick = ^{
            weakself.viewDelegate?[weakself.viewDelegate leaveLiveRoomForNotJoin]:nil;
        };
    }
    return _coverView;
}


- (void)setCanClear:(BOOL)canClear{
    _canClear = canClear;
    if (canClear) {
        [self addSwipeGeatureRecongnizer];
    }else{
        [self removeSwipeGeatureTrcongnizer];
    }
}

- (void)addSwipeGeatureRecongnizer{
    
    [self removeSwipeGeatureTrcongnizer];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(scrollDirection:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_secondView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(scrollDirection:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_firstView addGestureRecognizer:swipeLeft];
}


- (void)removeSwipeGeatureTrcongnizer{
    kWeakSelf(self);
    NSArray<__kindof UIGestureRecognizer *> * secondGR = _secondView.gestureRecognizers;
    [secondGR enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:[UISwipeGestureRecognizer class]]) {
            [weakself.secondView removeGestureRecognizer:obj];
        }
    }];
    NSArray<__kindof UIGestureRecognizer *> * firstGR = _firstView.gestureRecognizers;
    [firstGR enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isMemberOfClass:[UISwipeGestureRecognizer class]]) {
            [weakself.firstView removeGestureRecognizer:obj];
        }
    }];
}

- (void)scrollDirection:(UISwipeGestureRecognizer *)swipe{
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight: ///清屏
        {
            _clearScreenState = YES;
            [_clearScroll setContentOffset:CGPointMake(0, 0) animated:YES];
            if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(clearScreen:startOrEnd:)]) {
                [self.viewDelegate clearScreen:_clearScreenState startOrEnd:YES];
            }
        }
            break;
        case UISwipeGestureRecognizerDirectionLeft:  ///显屏
        {
            _clearScreenState = NO;
            [self firstViewSendToBack:YES];
            [_clearScroll setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
            if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(clearScreen:startOrEnd:)]) {
                [self.viewDelegate clearScreen:_clearScreenState startOrEnd:YES];
            }
        }
            break;
        default:
            break;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (_clearScreenState) {
        [self firstViewSendToBack:NO];
    }
    
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(clearScreen:startOrEnd:)]) {
        [self.viewDelegate clearScreen:_clearScreenState startOrEnd:NO];
    }
}

///将firstview放置在scrollview上或者scorllview下
- (void)firstViewSendToBack:(BOOL)back{
    if (back) {
        [self setX:_firstView x:0];
        [self addSubview:_firstView];
        [self sendSubviewToBack:_firstView];
    }else{
        [self setX:_firstView x:0];
        [_clearScroll addSubview:_firstView];
    }
}

///设置某一个视图的X坐标
- (void)setX:(UIView *)view x:(CGFloat)x{
    CGRect rc = view.frame;
    rc.origin.x = x;
    view.frame = rc;
}


- (void)clearView:(BOOL)clear animation:(BOOL)animation{
    if (_canClear && clear != _clearScreenState) {
        _clearScreenState = clear;
        if (!clear) {
            [self firstViewSendToBack:YES];
        }
        [_clearScroll setContentOffset:CGPointMake(_clearScreenState?0:kScreenWidth, 0) animated:animation];
        if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(clearScreen:startOrEnd:)]) {
            [self.viewDelegate clearScreen:_clearScreenState startOrEnd:YES];
        }
        if (!animation) {
            [self scrollViewDidEndScrollingAnimation:_clearScroll];
        }
    }
}





#pragma mark - handle -
- (void)joinRoomAllCompInfo:(Class<LiveComponentProtocol>)liveCompConfig successHandle:(void (^)(void))successHandle{
    
    kWeakSelf(self);
    if (self.currIndex != -1) {
        [CheckRoomPermissions share].noNotifyForOnceAtChangeRoom = YES;
        [[CheckRoomPermissions share] joinRoom:self.roomId liveDataType:self.LiveType joinRoom:^(AppJoinRoomVOModel * _Nonnull joinModel) {
            
            successHandle?successHandle():nil;
            [LiveManager liveInfo].roomModel = joinModel;
            [weakself showAllCompInfo:liveCompConfig];
        
        } closeRoom:^(AppHomeHallDTOModel * _Nonnull dtoModel) {
            [weakself showCloseInfo:dtoModel];
        } fail:^(JoinRoomFailType failType) {
            if (failType == JoinRoomFailTypeForVIP) {
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserSimpleInfo:) name:@"updateUserSimpleInfo" object:nil];
            }
        }];
    }else{
        if (!self.isPlayInfo) {
            successHandle?successHandle():nil;
            [self showAllCompInfo:liveCompConfig];
        }
    }
}


- (void)showAllCompInfo:(Class<LiveComponentProtocol>)liveCompConfig{
    self.liveBgView.hidden = NO;
    _isPlayInfo = YES;
    NSArray<Class> * compList = [self getCurrentLiveCompClass:[LiveManager liveInfo].liveType compClass:liveCompConfig];
    for (Class objs in compList) {
        id<LiveComponentInterface> comp =  [[objs alloc] init];
        [comp parInitViewController:[LiveManager getCurrentVC] views:self.liveViews];
    }
    if ([LiveManager liveInfo].roomModel) {
        [LiveComponentMsgMgr sendMsg:LM_LiveRoomInfo msgDic:nil];
    }
    [_coverView removeFromSuperview];
}

- (void)showCloseInfo:(AppHomeHallDTOModel *)dtoModel{
    self.closeView.dtoModel = dtoModel;
    _isPlayInfo = NO;
    
    [_coverView removeFromSuperview];
}

- (void)showCoverViewMakeBaseInfo:(SlideLiveRoomInfoModel *)dtoModel {
    if (!_isPlayInfo) {
        _isPlayInfo = NO;
        [self.coverView.imgV sd_setImageWithURL:[NSURL URLWithString:dtoModel.liveThumb]];
        _roomId = dtoModel.roomId;
        _LiveType = dtoModel.liveType;
    }
}


///获取当前的组建
- (NSArray<Class> *)getCurrentLiveCompClass:(LiveInfo_LiveType)liveType compClass:(Class<LiveComponentProtocol>)compClass{

    ///设置当前房间的view
    [self setCurrentLiveViewClass:liveType compClass:compClass];
    
    ///设置当前房间的使用组建
    NSArray<Class> *compArr = [[NSArray alloc] init];
    LiveInfo_roomRole roomRole = [LiveManager liveInfo].roomRole;
    switch (liveType) {
        case LiveTypeForMPVideoLive:
        case LiveTypeForShoppingLive:{
            compArr = ((roomRole==RoomRoleForAnchor)?[compClass getAnchorVideoComptClass]:[compClass getAudienceVideoComptClass]);
        }
            break;
        case LiveTypeForMPAudioLive:{
            compArr = ((roomRole==RoomRoleForAnchor)?[compClass getAnchorAudioComptClass]:[compClass getAudienceAudioComptClass]);
        }
            break;
        case LiveTypeForOneToOne:{
            compArr = ([LiveManager liveInfo].o2oModel.isVideo?[compClass getOTOVideoComptClass]:[compClass getOTOAudioComptClass]);
        }
            break;
        default:
            break;
    }

    return compArr;
}

///设置当前房间的view
- (void)setCurrentLiveViewClass:(LiveInfo_LiveType)liveType compClass:(Class<LiveComponentProtocol>)compClass{
    switch (liveType) {
        case LiveTypeForMPVideoLive:
        case LiveTypeForShoppingLive:{
            [LiveManager liveInfo].mpViewConfig = [compClass getMpVideoViewClass];
        }
            break;
        case LiveTypeForMPAudioLive:{
            [LiveManager liveInfo].mpViewConfig = [compClass getMpAudioViewClass];
        }
            break;
        case LiveTypeForOneToOne:{
            [LiveManager liveInfo].oneViewConfig = [compClass getOtoLiveViewClass];
        }
            break;
        default:
            break;
    }
}

///更新用户的VIP数据
- (void)updateUserSimpleInfo:(NSNotification *)notify{
    if (!self.isPlayInfo) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        self.viewDelegate?[self.viewDelegate reloadLiveRoomInfo:self]:nil;
    }
}


@end
