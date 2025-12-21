//
//  LiveUserListView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveManagerUserListView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/HttpApiPublicLive.h>
 
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/ApiUsersLiveManagerModel.h>
#import "ManagerUserItemCell.h"
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/AdminLiveConfigModel.h>

@interface LiveManagerUserListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;
@property (nonatomic, copy)NSArray<ApiUsersLiveManagerModel *> *itemArr;

@end

@implementation LiveManagerUserListView


+ (void)showManagerUserList{

    [self loadManagerListAndSuccessBlock:^(NSArray<ApiUsersLiveManagerModel *> *arr) {
        LiveManagerUserListView *managerList = [[self alloc] init];
        [managerList showView:arr];
    }];
}


+ (void)loadManagerListAndSuccessBlock:(void(^)(NSArray<ApiUsersLiveManagerModel *> *arr))block{
    
    [HttpApiPublicLive getLiveManagerList:[ProjConfig userId] liveType:[LiveManager liveInfo].serviceLiveType callback:^(int code, NSString *strMsg, NSArray<ApiUsersLiveManagerModel *> *arr) {
        if (code == 1) {
            if (block) {
                block(arr);
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}

- (void)showView:(NSArray *)itemArr{
    self.itemArr = itemArr;
    self.frame = CGRectMake(0, 0, kScreenWidth, self.tableV.height+20);
    [self.tableV reloadData];
    kWeakSelf(self);
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"管理员列表") detailView:self cover:NO btnImage:[UIImage imageNamed:@"back_fanhui_gray"] isLeft:YES clickBlock:^{
        [FunctionSheetBaseView deletePopView:weakself];
    } cancelBack:nil];
}

- (UITableView *)tableV{
    if (!_tableV) {
        UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 320) style:UITableViewStyleGrouped];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.backgroundColor = [UIColor whiteColor];
        tableV.separatorInset = UIEdgeInsetsMake(0.5, 0, 0, 0);
        tableV.tableFooterView = [UIView new];
        [tableV registerClass:[ManagerUserItemCell class] forCellReuseIdentifier:@"ManagerUserItemCellIdentifier"];
        [self addSubview:tableV];
        _tableV = tableV;
    }
    return _tableV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApiUsersLiveManagerModel *model= _itemArr[indexPath.item];
    ManagerUserItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManagerUserItemCellIdentifier" forIndexPath:indexPath];
    [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    cell.titleL.attributedText = [model.username attachmentForImage:[ProjConfig getAPPGenderImage:model.sex hasAge:NO] bounds:CGRectMake(0, 0, 15, 15) before:NO];
    cell.detailL.text = model.signature;
    kWeakSelf(self);
    [cell.functionBtn klc_whenTapped:^{
        [weakself deleteLiveManagerUser:model];
    }];
    return cell;
}


- (void)deleteLiveManagerUser:(ApiUsersLiveManagerModel *)userModel{
    kWeakSelf(self);
    [HttpApiPublicLive cancelLivemanager:[LiveManager liveInfo].serviceLiveType touid:userModel.uid callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            NSMutableArray *muArr = [weakself.itemArr mutableCopy];
            [muArr removeObject:userModel];
            weakself.itemArr = muArr;
            [weakself.tableV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgV= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 17)];
    lab.centerY = bgV.centerY;
    
    int maxNum = 5;
    switch ([LiveManager liveInfo].liveType) {
        case LiveTypeForMPVideoLive:
        case LiveTypeForShoppingLive:
            maxNum = [KLCAppConfig appConfig].liveManagerLimit;
            break;
        case LiveTypeForMPAudioLive:
            maxNum = [KLCAppConfig appConfig].voiceManagerLimit;
            break;
        default:
            break;
    }
    
    lab.text = [NSString stringWithFormat:kLocalizationMsg(@"当前管理员(%zi/%d)"),_itemArr.count,maxNum];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor darkGrayColor];
    [bgV addSubview:lab];
    return bgV;
}

@end
