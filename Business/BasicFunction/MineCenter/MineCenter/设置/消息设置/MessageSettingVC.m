//
//  MessageSettingVC.m
//  klcProject
//
//  Created by ssssssss on 2020/7/25.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "MessageSettingVC.h"

#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserIndexNodeModel.h>

#import <LibProjBase/LibProjBase.h>


#import <LibProjView/ForceAlertController.h>
#import <LibProjView/AppVersion.h>
#import <LibTools/LibTools.h>
#import <TXImKit/TXImKit.h>
#import <LibProjBase/ProjBaseData.h>
#import "MineSettingItemCell.h"
#import "AboutUsViewController.h"
#import <LibProjModel/HttpApiMessage.h>
#import <LibProjModel/HttpApiUserManagerController.h>
#import <LibProjModel/MsgNotifySwitchVOModel.h>
#import <LibProjBase/ApplePushManager.h>


@interface MessageSettingVC ()<UITableViewDelegate,UITableViewDataSource,MineSettingItemCellDelegate>

@property (nonatomic, weak) UITableView *weakTableV;
@property (nonatomic, strong)NSArray *settingArray;
@property (nonatomic, assign)BOOL switchMessageNotice;

@property (nonatomic, strong)MsgNotifySwitchVOModel *settingModel;

@end

@implementation MessageSettingVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kLocalizationMsg(@"消息设置");
    self.view.backgroundColor = [UIColor whiteColor];

    _settingArray = [[ProjConfig shareInstence].businessConfig getNotifyMessageSettingArray];
    
    [self endBackground];
    [self getUserSetting];
    
    [self createUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endBackground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)getUserSetting{
    kWeakSelf(self);
    [HttpApiUserManagerController getMsgNotifySwitch:^(int code, NSString *strMsg, MsgNotifySwitchVOModel *model) {
        if (code == 1) {
            [ProjBaseData share].enableNotifyVoice = model.toneSwitch;
            weakself.settingModel = model;
            [weakself.weakTableV reloadData];
        }
    }];
}



- (void)endBackground{
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    _switchMessageNotice = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    [self.weakTableV reloadData];
}


- (void)createUI{
    UITableView *tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableV registerClass:[MineSettingItemCell class] forCellReuseIdentifier:@"MineSettingItemCell"];
    [self.view addSubview:tableV];
    _weakTableV = tableV;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.settingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineSettingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSettingItemCell" forIndexPath:indexPath];
    cell.delegate = self;
    NSDictionary *dict = self.settingArray[indexPath.row];
    int type = [dict[@"type"] intValue];
    int tag = [dict[@"tag"] intValue];
    NSString *title = dict[@"title"];
    cell.funcTag = tag;
    switch (tag) {
        case 9031://消息提示音
        {
            if (self.settingModel) {
                cell.swithStatus = self.settingModel.toneSwitch?YES:NO;
            }else{
                cell.swithStatus = [ProjBaseData share].enableNotifyVoice;
            }
        }
            break;
        case 9032://消息推送
        {
            cell.swithStatus = _switchMessageNotice;
        }
            break;
        default:
            break;
    }
    [cell showInfoType:type titleStr:title contentStr:@""];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}



#pragma mark - MineSettingItemCellDelegate
- (void)MineSettingItemCell:(MineSettingItemCell *)cell switchBarStatus:(BOOL)isOpen{
    //更新状态
    switch (cell.funcTag) {
        case 9031://消息提示音
        {
            [self updateUsetSetInfo:isOpen];
        }
            break;
        case 9032://消息推送
        {
            [self goToAppSystemSetting];
        }
            break;
        default:
            break;
    }
}

- (void)goToAppSystemSetting {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:url options:@{} completionHandler:nil];
        } else {
            [application openURL:url];
        }
    }
}

- (void)updateUsetSetInfo:(BOOL)isOpen{
    BOOL isSetOpen = isOpen?1:0;
    int oldSet = self.settingModel.toneSwitch;
    self.settingModel.toneSwitch = isSetOpen;
    [self.weakTableV reloadData];
    kWeakSelf(self);
    [HttpApiUserManagerController upMsgNotifySwitch:isSetOpen callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            weakself.settingModel.toneSwitch = oldSet;
            [weakself.weakTableV reloadData];
        }else{
            [ProjBaseData share].enableNotifyVoice = isSetOpen;
        }
    }];
}


@end
