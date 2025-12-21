//
//  ShoppingComponent.m
//  LiveCommon
//
//  Created by klc_sl on 2020/7/7.
//  Copyright © 2020 . All rights reserved.
//

#import "ShoppingComponent.h"

#import "LiveBuyGoodsShowObj.h"
#import "LiveAddShoppingBanner.h"
#import "LiveShoppingAccrossList.h"
#import "LiveShoppingListShowView.h"

#import <SDWebImage.h>
#import <TXImKit/TXImKit.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentInterface.h>
#import <LibProjView/LiveGoodsManagerView.h>

#import <LiveCommon/LiveInfomation.h>
#import <LiveCommon/LiveManager.h>
 
#import <libProjBase/LibProjBase.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>

#import <LibProjModel/HttpApiShopBusiness.h>
#import <LibProjModel/ShopLiveGoodsDTOModel.h>
#import <LibProjModel/AppJoinRoomVOModel.h>
#import <LibProjModel/LiveLiveModel.h>
#import <LibProjModel/ShopLiveGoodsModel.h>
#import <LibProjModel/ApiShopLiveGoodsModel.h>
 
 
@interface ShoppingComponent ()<LiveComponentMsgListener>
/// 第二层
@property (nonatomic, weak) UIView *secondView;

@property (nonatomic, weak) UIView *fouthView;;

@property (nonatomic, weak) UIView *shoppingBannerBg;;
@property (nonatomic, weak) UIImageView *shoppingBanner;

@property (nonatomic, weak) UIViewController *weakVC;

@property (nonatomic, weak) UIButton *speakGoods;

@property (nonatomic, copy) LiveBuyGoodsShowObj *goodsShow;

    /**
商品id
 */
@property (nonatomic, assign) int64_t goodsId;


@end

@implementation ShoppingComponent

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

- (void)parInitViewController:(UIViewController *)superVC views:(NSArray <UIView *>*)views{

    [LiveComponentMsgMgr addMsgListener:self];
    [[IMSocketIns getIns] addReceiver:socketGroupLive receiver:self];
    _weakVC = superVC;
    // 第二层
    _secondView = views[1];
    
    _fouthView = views[3];
    
}

// MARK: - 组件消息
- (void)onMsg:(NSInteger)msgType msgDic:(NSDictionary *)msgDic{
    
    switch (msgType) {
        case LM_AddActivityBanner:
        {
            ///上传活动横幅
            [LiveAddShoppingBanner addShoppingBanner];
        }
            break;
        case LM_ShoppingBanner:
        {
            NSString *url = msgDic[@"url"];
            if (url.length > 0) {
                [self.shoppingBanner sd_setImageWithURL:[NSURL URLWithString:url]];
            }else{
                 
                [_shoppingBanner removeFromSuperview];
                [_shoppingBannerBg removeFromSuperview];
                _shoppingBanner = nil;
                _shoppingBannerBg = nil;
            }
             
        }
            break;
        case LM_GoodExplanation:{
            //讲解中的
            BOOL hasGoodExplain = [msgDic[@"hasGoodExplain"] boolValue];
            if ([LiveManager liveInfo].roomModel.liveFunction && hasGoodExplain) {
                NSString *pic = msgDic[@"pic"];
                int64_t goodsId = [msgDic[@"goodsId"] intValue];
                [self.speakGoods sd_setImageWithURL:[NSURL URLWithString:pic] forState:UIControlStateNormal];
                self.goodsId = goodsId;
            }else{
                [self.speakGoods removeFromSuperview];
                self.speakGoods = nil;
            }
             
        }
            break;
        case LM_ShowShoppingGoods:
        {
            if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {
                [self showGoodsForAnchorList];
            }else{
                BOOL changeMode = [msgDic[@"changeMode"] boolValue];
                if (changeMode) {
                    [self showGoodsForAnchorList];
                }else{
                    [LiveShoppingListShowView showGoodsList];
                }
            }
            
        }
            break;
        case LM_SetLiveGoods: ///添加直播商品
        {
            [LiveGoodsManagerView showGoodsListType:GoodsManagerTypeLive selectedModel:nil CallBack:nil];
        }
            break;
        case LM_LiveRoomInfo:  ///开播信息
        {
            [self createViewShow];
        }
            break;
        case LM_ShoppingGoodsDetail:{   ///商品详情
            [RouteManager routeForName:RN_Shopping_Commodity_DetailVC currentC:_weakVC parameters:msgDic];
        }
            break;
        case LM_StoreHomePage:{   ///商店
            [RouteManager routeForName:RN_Store_Home_DetailVC currentC:_weakVC parameters:msgDic];
        }
            break;
        default:
            break;
    }
}

- (void)createViewShow{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LiveInfomation *info = [LiveManager liveInfo];
        if (info.roomModel.liveFunction &&  info.roomRole != RoomRoleForAnchor) {
            [self showGoodsForAnchorList];
            if (info.roomModel.shopLiveBanner.length > 0) {
                [self.shoppingBanner sd_setImageWithURL:[NSURL URLWithString:info.roomModel.shopLiveBanner]];
            }
        }
    });
     
}


- (void)panView:(UIPanGestureRecognizer *)pan{
    UIView *moveV = pan.view;
    //获取偏移量
    // 返回的是相对于最原始的手指的偏移量
    CGPoint moveP = [pan translationInView:moveV];
    
    if (pan.view.x + moveP.x < 0) {
        moveP = CGPointMake(0-pan.view.x, moveP.y);
    }
    if (pan.view.maxX + moveP.x > kScreenWidth) {
        moveP = CGPointMake(kScreenWidth-pan.view.maxX, moveP.y);
    }
    if (pan.view.y + moveP.y < 0) {
        moveP = CGPointMake(moveP.x, 0-pan.view.y);
    }
    if (pan.view.maxY + moveP.y > kScreenHeight) {
        moveP = CGPointMake(moveP.x, kScreenHeight - pan.view.maxY);
    }
    
    moveV.center = CGPointMake(pan.view.center.x + moveP.x, pan.view.center.y + moveP.y);
    // 复位,表示相对上一次
    [pan setTranslation:CGPointZero inView:moveV];
}




///显示主播的商品列表
- (void)showGoodsForAnchorList{
    [LiveShoppingAccrossList showGoodsList];
}


- (void)getShoppingInfo{
    kWeakSelf(self);
    if ([LiveManager liveInfo].liveType == LiveTypeForShoppingLive) {
        [HttpApiShopBusiness getLiveInfo:[LiveManager liveInfo].anchorId callback:^(int code, NSString *strMsg, ShopLiveInfoDTOModel *model) {
            if (code == 1) {
                [weakself showBaseInfoView:model];
            }
        }];
    }
}

///显示页面基本信息
- (void)showBaseInfoView:(ShopLiveInfoDTOModel *)infoModel{
    
    [LiveManager liveInfo].roomModel.shopLiveBanner = infoModel.appUsersLive.shopLiveBanner;

    if (infoModel.appUsersLive.shopLiveBanner.length > 0) {
        [self.shoppingBanner sd_setImageWithURL:[NSURL URLWithString:infoModel.appUsersLive.shopLiveBanner]];
    }
    if (infoModel.shopLiveGoods.idExplain > 0) {
        NSString *picStr = @"";
        if (infoModel.shopLiveGoods.goodsPicture.length > 0) {
            picStr = [infoModel.shopLiveGoods.goodsPicture componentsSeparatedByString:@","].firstObject;
        }
        [self.speakGoods sd_setImageWithURL:[NSURL URLWithString:picStr] forState:UIControlStateNormal];
    }

}


- (UIButton *)speakGoods{
    if (!_speakGoods) {
        UIButton *btn = [UIButton buttonWithType:0];
        btn.frame = CGRectMake(_secondView.width-12-60, kStatusBarHeight+100+30, 60, 60);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 3.0;
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [btn addTarget:self action:@selector(onUserLiveBuyShowGoodsDetail:) forControlEvents:UIControlEventTouchUpInside];
        [_secondView addSubview:btn];
        _speakGoods = btn;
        
        UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(5, 37, 50, 18)];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.backgroundColor = kRGB_COLOR(@"#FF5500");
        titleL.text = kLocalizationMsg(@"·讲解中");
        titleL.font = [UIFont systemFontOfSize:10];
        titleL.textColor = [UIColor whiteColor];
        [btn addSubview:titleL];
        titleL.layer.masksToBounds = YES;
        titleL.layer.cornerRadius = 9;
    }
    return _speakGoods;
}

- (UIImageView *)shoppingBanner{
    if (!_shoppingBanner) {
        
        CGFloat safeSpace = 3;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(_secondView.width-12-90, kStatusBarHeight+100+50, 90, 180)];
        bgView.backgroundColor = kRGB_COLOR(@"#EAC7F6");
        self.shoppingBannerBg = bgView;
        [_secondView addSubview:bgView];

        UIImageView *banner = [[UIImageView alloc] initWithFrame:CGRectMake(safeSpace, safeSpace, bgView.width-(safeSpace*2), bgView.height-(safeSpace*2))];
        banner.contentMode = UIViewContentModeScaleAspectFit;
        banner.userInteractionEnabled = YES;
        [bgView addSubview:banner];
        _shoppingBanner = banner;

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
        [bgView addGestureRecognizer:pan];
    }
    return _shoppingBanner;
}


- (LiveBuyGoodsShowObj *)goodsShow{
    if (!_goodsShow) {
        _goodsShow = [[LiveBuyGoodsShowObj alloc] initWithSuperView:_fouthView];
    }
    return _goodsShow;
}

- (void)onUserLiveBuyShowGoodsDetail:(UIButton *)btn {
    [LiveComponentMsgMgr sendMsg:LM_ShoppingGoodsDetail msgDic:@{@"goodId":@(self.goodsId)}];
}

#pragma mark - 直播购 -

 
/** 修改直播商品讲解中状态 */
- (void)onUsersLiveGoodsStatus:(ApiShopLiveGoodsModel *)apiShopLiveGoods{
    
    if (apiShopLiveGoods.idExplain > 0) {
        NSString *picStr = @"";
        if (apiShopLiveGoods.goodsPicture.length > 0) {
            picStr = [apiShopLiveGoods.goodsPicture componentsSeparatedByString:@","].firstObject;
        }
        [self.speakGoods sd_setImageWithURL:[NSURL URLWithString:picStr] forState:UIControlStateNormal];
        self.goodsId = apiShopLiveGoods.goodsId;
    }else{
        [self.speakGoods removeFromSuperview];
        self.speakGoods = nil;
    }
}

/** 设置直播横幅成功后发送 */
- (void)onUsersShopBanner:(NSString *)shopLiveBanner{
    if (shopLiveBanner.length > 0) {
        [self.shoppingBanner sd_setImageWithURL:[NSURL URLWithString:shopLiveBanner]];
    }else{
        
        [self.shoppingBanner removeFromSuperview];
        [self.shoppingBannerBg removeFromSuperview];
        self.shoppingBanner = nil;
        self.shoppingBannerBg = nil;
    }
}

/** 用户下单发送房间消息 */
- (void)onBuyGoodsRoom:(UserBuyDTOModel *)userBuyDTO{
    [self.goodsShow playGoods:userBuyDTO];
}

@end
