//
//  PrivacyAndSafeVC.m
//  MineCenter
//
//  Created by klc_sl on 2021/9/3.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "PrivacyAndSafeVC.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import "PrivacyAndSafeCell.h"
#import <LibProjModel/HttpApiUserController.h>

@interface PrivacyAndSafeVC ()<PrivacyAndSafeCellDelegate>

@property (nonatomic, copy)NSArray *itemArr;

@property (nonatomic, strong)UserSettingInfoVOModel *settingInfo;

@end

@implementation PrivacyAndSafeVC

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kLocalizationMsg(@"隐私设置");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.itemArr = [[ProjConfig shareInstence].businessConfig getSafeAndPrivacyListArray];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PrivacyAndSafeCell class] forCellReuseIdentifier:@"PrivacyAndSafeCell"];
    
    [self getUserSettingInfo];
}

- (void)getUserSettingInfo{
    kWeakSelf(self);
    [HttpApiUserController getUserSettingInfo:^(int code, NSString *strMsg, UserSettingInfoVOModel *model) {
        if (code == 1) {
            weakself.settingInfo = model;
            [weakself.tableView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivacyAndSafeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrivacyAndSafeCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.dict = self.itemArr[indexPath.row];
    switch ([cell.dict[@"tag"] intValue]) {
        case 4001: ///是否隐藏位置
        {
            cell.switchBtn.on = self.settingInfo.whetherEnablePositioningShow;
        }
            break;
        case 4002:  ///送礼是否全局广播
        {
            cell.switchBtn.on = self.settingInfo.giftGlobalBroadcast;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


#pragma mark -PrivacyAndSafeCellDelegate-

- (void)privacyAndSafeCell:(PrivacyAndSafeCell *)cell switchBarStatus:(BOOL)isOpen{
    kWeakSelf(self);
    switch ([cell.dict[@"tag"] intValue]) {
        case 4001: ///是否隐藏位置
        {
            //更新状态  0:未开启 1:开启
            [HttpApiUserController upPositioningShow:(isOpen?1:0) callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                if (code != 1) {
                    [SVProgressHUD showInfoWithStatus:strMsg];
                    weakself.settingInfo.whetherEnablePositioningShow = !isOpen;
                    [weakself.tableView reloadData];
                } else {
                    weakself.settingInfo.whetherEnablePositioningShow = isOpen;
                }
            }];
        }
            break;
        case 4002:  ///送礼是否全局广播
        {
            /// 0:关闭 1：开启
            [HttpApiUserController upGiftGlobalBroadcast:(isOpen?1:0) callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                if (code != 1) {
                    [SVProgressHUD showInfoWithStatus:strMsg];
                    weakself.settingInfo.giftGlobalBroadcast = !isOpen;
                    [weakself.tableView reloadData];
                } else {
                    weakself.settingInfo.giftGlobalBroadcast = isOpen;
                }
            }];
        }
            break;
        default:
            break;
    }

}

@end
