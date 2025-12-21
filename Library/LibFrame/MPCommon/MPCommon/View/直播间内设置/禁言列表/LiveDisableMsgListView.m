//
//  LiveDisableMsgListView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveDisableMsgListView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/ApiShutUpModel.h>
#import "DisableMsgItemCell.h"
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/HttpApiPublicLive.h>

@interface LiveDisableMsgListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;
@property (nonatomic, copy)NSArray<ApiShutUpModel *> *itemArr;

@end

@implementation LiveDisableMsgListView


+ (void)showDisableMsgUserList{
    [self loadDisableMsgListAndSuccessBlock:^(NSArray<ApiShutUpModel *> *arr) {
        LiveDisableMsgListView *msgList = [[self alloc] init];
        [msgList showView:arr];
    }];
}


+ (void)loadDisableMsgListAndSuccessBlock:(void(^)(NSArray<ApiShutUpModel *> *arr))block{
    [HttpApiPublicLive shutupList:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, NSArray<ApiShutUpModel *> *arr) {
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
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"禁言用户") detailView:self cover:NO btnImage:[UIImage imageNamed:@"back_fanhui_gray"] isLeft:YES clickBlock:^{
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
        [tableV registerClass:[DisableMsgItemCell class] forCellReuseIdentifier:@"DisableMsgItemCellIdentifier"];
        [self addSubview:tableV];
        _tableV = tableV;
    }
    return _tableV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApiShutUpModel *model= _itemArr[indexPath.item];
    DisableMsgItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DisableMsgItemCellIdentifier" forIndexPath:indexPath];
    [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    cell.titleL.attributedText = [model.username attachmentForImage:[ProjConfig getAPPGenderImage:model.sex hasAge:NO] bounds:CGRectMake(0, 0, 15, 15) before:NO];
    cell.detailL.text = model.signature;
    kWeakSelf(self);
    [cell.functionBtn klc_whenTapped:^{
        [weakself enableSendMsgUser:model];
    }];
    return cell;
}


- (void)enableSendMsgUser:(ApiShutUpModel *)userModel{
    kWeakSelf(self);
    [HttpApiPublicLive addShutup:[LiveManager liveInfo].anchorId liveType:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId touid:userModel.userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
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
