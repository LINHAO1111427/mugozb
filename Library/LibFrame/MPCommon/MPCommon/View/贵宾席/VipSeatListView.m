//
//  VipSeatListView.m
//  LiveCommon
//
//  Created by klc on 2020/6/9.
//  Copyright © 2020 . All rights reserved.
//

#import "VipSeatListView.h"
#import "LibTools/LibTools.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import "VIPSeatUserCell.h"
#import <LibProjModel/HttpApiPublicLive.h>
#import <LiveCommon/LiveManager.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjView/EmptyView.h>


@interface VipSeatListView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, copy)NSArray *items;

@property (nonatomic, weak)EmptyView *emtpyV;

@end

@implementation VipSeatListView

///显示贵宾席
+ (void)showVIPSeatList{
    VipSeatListView *listView = [[VipSeatListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    [listView getUserList];
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"豪华贵宾席") detailView:listView cover:NO];
}

- (void)getUserList{
    kWeakSelf(self);
    [HttpApiPublicLive userVIPSeatsList:[LiveManager liveInfo].anchorId liveType:[LiveManager liveInfo].serviceLiveType roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, NSArray<ApiUserBasicInfoModel *> *arr) {
        if (code == 1) {
            weakself.items = arr;
            [weakself.tableV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        self.emtpyV.hidden = arr.count;
    }];
}

- (EmptyView *)emtpyV{
    if (!_emtpyV) {
        EmptyView *emptyView = [[EmptyView alloc] init];
        emptyView.iconImgV.image  = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
        emptyView.titleL.text = kLocalizationMsg(@"暂无贵宾");
        [emptyView showInView:self];
        _emtpyV = emptyView;
    }
    return _emtpyV;
}

- (UITableView *)tableV{
    if (!_tableV) {
        UITableView *tableV = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableV.dataSource = self;
        tableV.delegate = self;
        tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableV registerClass:[VIPSeatUserCell class] forCellReuseIdentifier:@"VIPSeatUserCellIdentifier"];
        [self addSubview:tableV];
        _tableV = tableV;
    }
    return _tableV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VIPSeatUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VIPSeatUserCellIdentifier" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ApiUserBasicInfoModel *seatModel = self.items[indexPath.row];
    cell.model = seatModel;
    cell.numL.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    kWeakSelf(seatModel);
    [cell.userIcon klc_whenTapped:^{
        [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(weakseatModel.uid)}];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
