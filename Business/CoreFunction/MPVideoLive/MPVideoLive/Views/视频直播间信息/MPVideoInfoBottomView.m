//
//  MPVideoInfoBottomView.m
//  LiveCommon
//
//  Created by admin on 2020/1/9.
//  Copyright © 2020 . All rights reserved.
//

#import "MPVideoInfoBottomView.h"
#import <LiveCommon/MPLiveInfoBottomInterface.h>

#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/HttpApiOTMCall.h>
#import <AgoraExtension/AgoraExtManager.h>
#import <Masonry.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>

@interface MPVideoInfoBottomView ()<MPLiveInfoBottomInterface>
@property (nonatomic, strong)NSDictionary *itemsDicForAnchor;
@property (nonatomic, strong)NSDictionary *itemsDicForElse;
@property (nonatomic, assign)BOOL hasPk;

@end

@implementation MPVideoInfoBottomView


+ (instancetype)register{
    return [[MPVideoInfoBottomView alloc] initWithFrame:[self viewFrame]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changeItems:[self getItems]];
    }
    return self;
}

- (void)reloadFunctionBtn{
    [self changeItems:[self getItems]];
}

- (NSArray *)getItems{
    NSArray *funcItemArr;
    NSMutableArray *muArr = [[NSMutableArray alloc] init];
    if ([LiveManager liveInfo].roomRole == RoomRoleForAnchor) {//bottom最多五个按钮
        NSArray *itemArr = @[];
        if ([LiveManager liveInfo].roomModel.liveFunction) {  ///直播购
            itemArr = @[@19,@0,@2,@3,@5,@6,@17,@1,@18,@7,@8,@9,@10,@12,@11,@13,@14,@15,@16];
        }else{ ///多人视频
            itemArr = @[@19,@2,@3,@4,@5,@6,@7,@8,@9,@10,@12,@11,@13,@14,@15,@16];
        }
        for (NSNumber *index in itemArr) {
            NSString *key = [NSString stringWithFormat:@"a_item_%@",index];
            if ([[ProjConfig shareInstence].baseConfig liveAdvancedFunctions]) {
                ///高级功能
                [muArr addObject:self.itemsDicForAnchor[key]];
            }else{
                
                if ([index isEqualToNumber:@2]||[index isEqualToNumber:@3] ||[index isEqualToNumber:@14]) {
                    ///连麦和PK和音乐都不加
                }else{
                    [muArr addObject:self.itemsDicForAnchor[key]];
                }
            }
        }
        
        funcItemArr = [NSArray arrayWithArray:muArr];
        
    }else{   ///观众
        NSArray *itemArr = @[];
        if ([LiveManager liveInfo].roomModel.liveFunction){
            itemArr = @[@11,@0,@1,@2,@3,@4,@5,@6,@8,@7,@9];
        }else{
            itemArr = @[@11,@1,@2,@3,@4,@5,@6,@8,@7,@9];
        }
        for (NSNumber *index in itemArr) {
            NSString *key = [NSString stringWithFormat:@"b_item_%@",index];
            if ([[ProjConfig shareInstence].baseConfig liveAdvancedFunctions]) {
                ///高级功能
                [muArr addObject:self.itemsDicForElse[key]];
            }else{
                if ([index isEqualToNumber:@2]) {
                    ///用户连麦不加
                }else{
                    [muArr addObject:self.itemsDicForElse[key]];
                }
            }
        }
        funcItemArr = [NSArray arrayWithArray:muArr];
    }
    return funcItemArr;
}


- (void)changePKShow:(BOOL)hasPk{
    _hasPk = hasPk;
    [self changeItems:[self getItems]];
}


- (void)clickFunction:(NSInteger)msgType{
    switch (msgType) {
        case 10001:  ///关闭自己的声音
        {
            [self setMicStatus];
        }
            break;
        case 10002:  ///关闭远端的声音
        {
            [self setVoiceStatus];
        }
            break;
        default:
            break;
    };
    
    [self changeItems:[self getItems]];
}

- (void)changeItems:(NSArray *)items{
    
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *subDic in items) {
        
        LiveFunctionItemModel *model = [[LiveFunctionItemModel alloc] init];
        model.msgType = [subDic[@"msgType"] integerValue];
        model.name = subDic[@"name"];
        model.iconStr = subDic[@"icon"];
        
        switch (model.msgType) {
            case 10001:
            {
                model.iconStr = [LiveManager liveInfo].offMic? subDic[@"selectIcon"]:subDic[@"icon"];
            }
                break;
            case 10002:
            {
                model.iconStr = [LiveManager liveInfo].offAudio? subDic[@"selectIcon"]:subDic[@"icon"];
            }
                break;
            default:
                break;
        }
        
        [muArr addObject:model];
    }
    
    [self changeFunctionItems:[NSArray arrayWithArray:muArr]];
}


- (void)setMicStatus{
    [LiveManager liveInfo].offMic = ![LiveManager liveInfo].offMic;
    [[AgoraExtManager pubMethod] localAudioClosed:[LiveManager liveInfo].offMic];
}

- (void)setVoiceStatus{
    [LiveManager liveInfo].offAudio = ![LiveManager liveInfo].offAudio;
    [[AgoraExtManager pubMethod] remoteVoiceClosed:[LiveManager liveInfo].offAudio];
}


#pragma mark - lazy load
- (NSDictionary *)itemsDicForAnchor{
    if (!_itemsDicForAnchor) {
        _itemsDicForAnchor = @{
            @"a_item_0":@{@"name":kLocalizationMsg(@"小店"),@"icon":@"live_zhibogou_shopping",@"selectIcon":@"live_zhibogou_shopping",@"msgType":@(LM_ShowShoppingGoods)},
            @"a_item_1":@{@"name":kLocalizationMsg(@"设置横幅"),  @"icon":@"live_shopping_haibao",@"selectIcon":@"live_shopping_haibao",       @"msgType":@(LM_AddActivityBanner)},
            @"a_item_2":@{@"name":kLocalizationMsg(@"连麦"),@"icon":@"live_lixian_black",@"selectIcon":@"live_lixian_black",@"msgType":@(LM_InviteVideoInteraction)},
            @"a_item_3":@{@"name":@"PK", @"icon":@"live_pk_black",@"selectIcon":@"live_pk_black",@"msgType":@(LM_LaunchPK)},
            @"a_item_4":@{@"name":kLocalizationMsg(@"静音"),@"icon":@"live_jingyin_open",@"selectIcon":@"live_jingyin_close",@"msgType":@(10001)},
            @"a_item_5":@{@"name":kLocalizationMsg(@"分享"),@"icon":@"live_fenxiang_black",@"selectIcon":@"live_fenxiang_black",@"msgType":@(LM_ShareView)},
            @"a_item_6":@{@"name":kLocalizationMsg(@"更多"),@"icon":@"live_gengduo",@"selectIcon":@"live_gengduo",@"msgType":@(10000)},
            @"a_item_7":@{@"name":kLocalizationMsg(@"美颜"),@"icon":@"live_meiyan_white",@"selectIcon":@"live_meiyan_white",@"msgType":@(LM_BeautyShow)},
            @"a_item_8":@{@"name":kLocalizationMsg(@"心愿单"),@"icon":@"add_wish_xinyuandan",@"selectIcon":@"add_wish_xinyuandan", @"msgType":@(LM_AddWish)},
            @"a_item_9":@{@"name":kLocalizationMsg(@"设置"),@"icon":@"live_shezhi",@"selectIcon":@"live_shezhi",   @"msgType":@(LM_SetRoomInfo)},
            @"a_item_10":@{@"name":kLocalizationMsg(@"任务"),@"icon":@"live_renwu_more", @"selectIcon":@"live_renwu_more", @"msgType":@(LM_ShowTask)},
            @"a_item_11":@{@"name":kLocalizationMsg(@"粉丝团"),@"icon":@"live_fensituan_pink",@"selectIcon":@"live_fensituan_pink",@"msgType":@(LM_SetFans)},
            @"a_item_12":@{@"name":kLocalizationMsg(@"红包"),@"icon":@"live_hongbao_more", @"selectIcon":@"live_hongbao_more",@"msgType":@(LM_SendRedPacket)},
            @"a_item_13":@{@"name":kLocalizationMsg(@"翻转"), @"icon":@"live_fanzhuan_black", @"selectIcon":@"live_fanzhuan",@"msgType":@(LM_RotateCamera)},
            @"a_item_14":@{@"name":kLocalizationMsg(@"背景音乐"),@"icon":@"live_music_white",@"selectIcon":@"live_music_white",@"msgType":@(LM_SelectMusic)},
            @"a_item_15":@{@"name":kLocalizationMsg(@"房间公告"),@"icon":@"live_fangjiangonggao",@"selectIcon":@"live_fangjiangonggao",@"msgType":@(LM_ChangeNotice)},
            @"a_item_16":@{@"name":kLocalizationMsg(@"直播时长"),@"icon":@"live_livetime",@"selectIcon":@"live_livetime",@"msgType":@(LM_ShowLiveTime)},
            @"a_item_17":@{@"name":kLocalizationMsg(@"商品橱窗"),@"icon":@"live_shopping_liveGoods",@"selectIcon":@"live_shopping_liveGoods",@"msgType":@(LM_SetLiveGoods)},
            @"a_item_18":@{@"name":kLocalizationMsg(@"静音"),@"icon":@"live_mute_shop_open",@"selectIcon":@"live_mute_shop_close",@"msgType":@(10001)},
            @"a_item_19":@{@"name":kLocalizationMsg(@"宝箱"),@"icon":@"game_magicBox_icon",@"selectIcon":@"game_magicBox_icon",@"msgType":@(LM_MagicBox)},
        };
    }
    return _itemsDicForAnchor;
}

- (NSDictionary *)itemsDicForElse{
    if (!_itemsDicForElse) {
        _itemsDicForElse = @{
            @"b_item_0":@{@"name":kLocalizationMsg(@"小店"),@"icon":@"live_zhibogou_shopping",@"selectIcon":@"live_zhibogou_shopping",@"msgType":@(LM_ShowShoppingGoods)},
            @"b_item_1":@{@"name":kLocalizationMsg(@"礼物"),@"icon":@"live_songli",@"selectIcon":@"live_songli",@"msgType":@(LM_ShowGiftView)},
            @"b_item_2":@{@"name":kLocalizationMsg(@"连麦"), @"icon":@"live_lixian_black",@"selectIcon":@"live_lixian_black",@"msgType":@(LM_LaunchConnMic)},
            @"b_item_3":@{@"name":kLocalizationMsg(@"贵族"),@"icon":@"live_guizu",@"selectIcon":@"live_guizu",@"msgType":@(LM_BuyVIP)},
            @"b_item_4":@{@"name":kLocalizationMsg(@"更多"),@"icon":@"live_gengduo",@"selectIcon":@"live_gengduo",@"msgType":@(10000)},
            @"b_item_5":@{@"name":kLocalizationMsg(@"分享"),@"icon":@"live_fenxiang_more",@"selectIcon":@"live_fenxiang_more",@"msgType":@(LM_ShareView)},
            @"b_item_6":@{@"name":kLocalizationMsg(@"粉丝团"), @"icon":@"live_fensituan_pink", @"selectIcon":@"live_fensituan_pink", @"msgType":@(LM_JoinFans)},
            @"b_item_7":@{@"name":kLocalizationMsg(@"红包"), @"icon":@"live_hongbao_more", @"selectIcon":@"live_hongbao_more",@"msgType":@(LM_SendRedPacket)},
            @"b_item_8":@{@"name":kLocalizationMsg(@"静音"),@"icon":@"live_voice_open", @"selectIcon":@"live_voice_close", @"msgType":@(10002)},
            @"b_item_9":@{@"name":kLocalizationMsg(@"任务"),@"icon":@"live_renwu_more",@"selectIcon":@"live_renwu_more",@"msgType":@(LM_ShowTask)},
//            @"b_item_10":@{@"name":kLocalizationMsg(@"大转盘"),@"icon":@"live-zhuanpan", @"selectIcon":@"live-zhuanpan",@"msgType":@(LM_LuckySpin)},
            @"b_item_11":@{@"name":kLocalizationMsg(@"宝箱"),@"icon":@"game_magicBox_icon",@"selectIcon":@"game_magicBox_icon",@"msgType":@(LM_MagicBox)},
        };
    }
    return _itemsDicForElse;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}

@end
