//
//  LiveSetFunctionView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveSetFunctionView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiHttpLive.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LiveCommon/LiveManager.h>
#import <Masonry.h>
#import "SetFunctionItemCell.h"
#import <LibProjModel/KLCAppConfig.h>
#import "LiveKickingUserListView.h"
#import "LiveManagerUserListView.h"
#import "LiveDisableMsgListView.h"
#import "ChangeRoomTypeView.h"
#import <LibProjView/ForceAlertController.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/OpenAuthDataVOModel.h>

@interface LiveSetFunctionView ()<UITableViewDelegate,UITableViewDataSource,SetFunctionItemCellDeleagte>

@property (nonatomic, weak)UITableView *tableV;
@property (nonatomic, copy)NSArray *itemArr;

@end

@implementation LiveSetFunctionView

+ (void)showSetView{
    
    LiveSetFunctionView *functionV = [[self alloc] init];
    [functionV show: [self getSetItems]];
    
}

+ (NSArray *)getSetItems{
    ///房间模式0普通房间1私密房间2收费房间3计时房间4贵族房间
    RoomTypeModel *typeModel = [ChangeRoomTypeView getCurrentRoomType];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:@{@"typeId":@(6), @"title":kLocalizationMsg(@"更改房间名称"),   @"typeValue":[LiveManager liveInfo].roomModel.title, @"hasArrow":@(1)}];
    if ([LiveManager liveInfo].liveType == LiveTypeForMPAudioLive) {
        [items addObject:@{@"typeId":@(7), @"title":kLocalizationMsg(@"清除麦位火力值"),   @"typeValue":@"", @"hasArrow":@(0)}];
    }
    [items addObject:@{@"typeId":@(1), @"title":kLocalizationMsg(@"当前房间模式"), @"typeValue":typeModel.roomTypeStr , @"hasArrow":@(1)}];
    
    if ([ProjConfig isContainShopping] && [LiveManager liveInfo].liveType == LiveTypeForMPVideoLive) {
        [items addObject:@{@"typeId":@(5), @"title":kLocalizationMsg(@"我要直播带货"),  @"typeValue":@([LiveManager liveInfo].roomModel.liveFunction), @"hasArrow":@(0)}];
    }
    if ([LiveManager liveInfo].anchorId == [ProjConfig userId]) {
        [items addObject:@{@"typeId":@(2), @"title":kLocalizationMsg(@"管理员列表"),   @"typeValue":@"" , @"hasArrow":@(1)}];
    }
    [items addObject:@{@"typeId":@(3), @"title":kLocalizationMsg(@"禁言列表"),    @"typeValue":@"" , @"hasArrow":@(1)}];
    [items addObject:@{@"typeId":@(4), @"title":kLocalizationMsg(@"踢人列表"),    @"typeValue":@"" , @"hasArrow":@(1)}];
    
    return items;
}

- (void)show:(NSArray *)itemArr{
    self.itemArr = itemArr;
    self.frame = CGRectMake(0, 0, kScreenWidth, self.tableV.height+20);
    [self.tableV reloadData];
    
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"") detailView:self cover:NO];
}

- (UITableView *)tableV{
    if (!_tableV) {
        UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _itemArr.count*50) style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.tableFooterView = [UIView new];
        [tableV registerClass:[SetFunctionItemCell class] forCellReuseIdentifier:@"SetFunctionItemCellIdentifier"];
        tableV.bounces = NO;
        tableV.backgroundColor = [UIColor whiteColor];
        tableV.separatorInset = UIEdgeInsetsMake(0.5, 0, 0, 0);
        tableV.scrollEnabled = NO;
        [self addSubview:tableV];
        _tableV = tableV;
    }
    return _tableV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic= _itemArr[indexPath.item];
    SetFunctionItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetFunctionItemCellIdentifier" forIndexPath:indexPath];
    int type = [dic[@"typeId"] intValue];
    cell.delegate = self;
    if (type == 5) {
        cell.shopSwitch.hidden = NO;
        cell.detailTextLabel.hidden = YES;
        cell.imageV.hidden = YES;
        cell.shopSwitch.on = [LiveManager liveInfo].roomModel.liveFunction;
    }else{
        cell.shopSwitch.hidden = YES;
        cell.detailTextLabel.hidden = NO;
        cell.imageV.hidden = ![dic[@"hasArrow"] boolValue];
    }
    cell.titleL.text = dic[@"title"];
    if (type != 5) {
        cell.detailL.text = [dic[@"typeValue"] isEmpty]?@"":dic[@"typeValue"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic= _itemArr[indexPath.item];
    switch ([dic[@"typeId"] intValue]) {
        case 1:
        {
            kWeakSelf(self);
            [ChangeRoomTypeView selectRoomTypeIsModify:YES roomTypeSelect:^(RoomTypeModel * _Nonnull selectRoomType) {
                [LiveManager liveInfo].roomModel.roomType = selectRoomType.roomType;
                [LiveManager liveInfo].roomModel.roomTypeVal = selectRoomType.roomTypeValue;
                NSMutableArray *muArr = [[NSMutableArray alloc] initWithCapacity:weakself.itemArr.count];
                for (NSDictionary *subDic in weakself.itemArr) {
                    NSDictionary *itemDic = subDic;
                    if ([subDic[@"typeId"] intValue] == 1) {
                        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:subDic];
                        [muDic setValue:selectRoomType.roomTypeStr forKey:@"typeValue"];
                        itemDic = muDic;
                    }
                    [muArr addObject:itemDic];
                }
                weakself.itemArr = muArr;
                [weakself.tableV reloadData];
            }];
        }
            break;
        case 2:
        {
            [LiveManagerUserListView showManagerUserList];
        }
            break;
        case 3:
        {
            [LiveDisableMsgListView showDisableMsgUserList];
        }
            break;
        case 4:
        {
            [LiveKickingUserListView showKickingUserList];
        }
            break;
        case 5:  ///直播购
        {
            
        }
            break;
        case 6:  ///更改房间名称
        {
            kWeakSelf(self);
            __block UITextField *textF;
            ForceAlertController *alert = [ForceAlertController alertTitle:kLocalizationMsg(@"更改房间名称") message:nil];
            [alert addOptions:kLocalizationMsg(@"取消") textColor:ForceAlert_BlackColor clickHandle:nil];
            [alert addOptions:kLocalizationMsg(@"确认") textColor:ForceAlert_NormalColor clickHandle:^{
                [weakself changeRoomName:textF];
            }];
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.font = [UIFont systemFontOfSize:14];
                textField.placeholder = kLocalizationMsg(@"请填写房间名称");
                textField.text = [LiveManager liveInfo].roomModel.title;
                textField.clearButtonMode = UITextFieldViewModeAlways;
                textF = textField;
            }];
            [[ProjConfig currentVC] presentViewController:alert animated:YES completion:nil];
        }
            break;
        case 7:   ///清除麦位火力值
        {
            [self clearRoomHotNum];
        }
            break;
        default:
            break;
    }
}
#pragma mark - SetFunctionItemCellDeleagte
- (void)SetFunctionItemCell:(SetFunctionItemCell *)cell switchShopChange:(BOOL)switchOn{
    [self justOpenLive:switchOn];
}

///修改房间名称
- (void)changeRoomName:(UITextField *)textF{
    if (textF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:textF.placeholder];
        return;
    }
    kWeakSelf(self);
    [HttpApiPublicLive updateLiveTitle:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId roomTitle:textF.text callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [LiveManager liveInfo].roomModel.title = textF.text;
            weakself.itemArr = [LiveSetFunctionView getSetItems];
            [weakself.tableV reloadData];
            OpenAuthDataVOModel *openModel = [LiveManager liveInfo].openData;
            openModel.title = textF.text;
            [LiveManager liveInfo].openData = openModel;
        }
        [SVProgressHUD showInfoWithStatus:strMsg];
    }];
}

///清除直播间麦位火力值
- (void)clearRoomHotNum{
    [HttpApiPublicLive clearRoomVotes:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        [SVProgressHUD showInfoWithStatus:strMsg];
    }];
}


- (void)justOpenLive:(BOOL)liveShoppingOn{
    kWeakSelf(self);

    AppJoinRoomVOModel *joinModel = [LiveManager liveInfo].roomModel;
    [HttpApiHttpLive openLive:@"" channelId:(int)joinModel.channelId city:@"" lat: -1 liveFunction:liveShoppingOn?1:0 lng:-1 province:@"" pull:@"" roomType:joinModel.roomType roomTypeVal:(joinModel.roomTypeVal.length > 0?joinModel.roomTypeVal:@"") shopRoomLabel:@"" title:joinModel.title callback:^(int code, NSString *strMsg, AppJoinRoomVOModel *model) {
        if (code == 1) {
            [LiveManager liveInfo].roomModel = model;
            [LiveComponentMsgMgr sendMsg:LM_ReloadFunBtn msgDic:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.tableV reloadData];
        });
    }];
    
}

@end
