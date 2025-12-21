//
//  LiveKickingUserListView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveKickingUserListView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/HttpApiPublicLive.h>
 
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/ApiKickModel.h>
#import "KickingUserItemCell.h"
#import <SDWebImage/SDWebImage.h>

@interface LiveKickingUserListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;
@property (nonatomic, copy)NSArray<ApiKickModel *> *itemArr;

@end

@implementation LiveKickingUserListView


+ (void)showKickingUserList{

    [self loadManagerListAndSuccessBlock:^(NSArray<ApiKickModel *> *arr) {
        LiveKickingUserListView *userList = [[self alloc] init];
        [userList showView:arr];
    }];
}


+ (void)loadManagerListAndSuccessBlock:(void(^)(NSArray<ApiKickModel *> *arr))block{
    [HttpApiPublicLive getKickList:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, NSArray<ApiKickModel *> *arr) {
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
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"已踢用户") detailView:self cover:NO btnImage:[UIImage imageNamed:@"back_fanhui_gray"] isLeft:YES clickBlock:^{
        [FunctionSheetBaseView deletePopView:weakself];
    } cancelBack:nil];
}

- (UITableView *)tableV{
    if (!_tableV) {
        UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 320) style:UITableViewStylePlain];
        tableV.delegate = self;
        tableV.dataSource = self;
        tableV.separatorInset = UIEdgeInsetsMake(0.5, 0, 0, 0);
        tableV.tableFooterView = [UIView new];
        [tableV registerClass:[KickingUserItemCell class] forCellReuseIdentifier:@"KickingUserItemCellIdentifier"];
        [self addSubview:tableV];
        _tableV = tableV;
    }
    return _tableV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApiKickModel *model= _itemArr[indexPath.item];
    KickingUserItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KickingUserItemCellIdentifier" forIndexPath:indexPath];
    [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    cell.titleL.attributedText = [model.username attachmentForImage:[ProjConfig getAPPGenderImage:model.sex hasAge:NO] bounds:CGRectMake(0, 0, 15, 15) before:NO];
    cell.detailL.text = model.signature;
    kWeakSelf(self);
    [cell.functionBtn klc_whenTapped:^{
        [weakself removeKickingUser:model];
    }];
    return cell;
}


- (void)removeKickingUser:(ApiKickModel *)userModel{
    kWeakSelf(self);
    [HttpApiPublicLive delKick:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId touid:userModel.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
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

@end
