//
//  InviteAttentionAnchorList.m
//  LiveCommon
//
//  Created by CH on 2019/12/21.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "InviteAttentionAnchorList.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/PopupTool.h>
#import "ApplyUserListCell.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjModel/AppUserDtoModel.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjBase/LibProjBase.h>

@interface InviteAttentionAnchorList()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, weak) UITableView *tableV;
@property(nonatomic, copy) NSArray *items;

@end

@implementation InviteAttentionAnchorList


+ (void)inviteAttentionAnchor{
    
    InviteAttentionAnchorList *linkV = [[InviteAttentionAnchorList alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    [linkV createUI];
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"主播") detailView:linkV cover:NO];
    
}

- (void)createUI{
    [self getInviteAnchorList];
}

- (void)getInviteAnchorList{
    kWeakSelf(self);
    [HttpApiHttpVoice enableInvtVoice:1 roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, NSArray<AppUserDtoModel *> *arr) {
        if (code == 1) {
            weakself.items = arr;
            [weakself.tableV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


- (UITableView *)tableV{
    if (!_tableV) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[ApplyUserListCell class] forCellReuseIdentifier:@"ApplyUserListCellID"];
        [self addSubview:tableView];
        _tableV = tableView;
    }
    return _tableV;
}


// MARK: - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyUserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyUserListCellID" forIndexPath:indexPath];
    if (self.items.count > indexPath.row) {
        AppUserDtoModel *userM = _items[indexPath.row];
        kWeakSelf(self);
        cell.userId = userM.userid;
        [cell showIndex:indexPath.row userName:userM.username avatar:userM.avatar iconFrame:userM.nobleAvatarFrame age:userM.age gender:userM.sex weathLevel:userM.wealthGradeImg nobleLevel:userM.nobleGradeImg];
        [cell showOnlineMicStatus:0 inviteBlock:^{
            [weakself inviteAnchor:userM];
        }];
    }
    return cell;
}

// MARK: - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)inviteAnchor:(AppUserDtoModel *)userModel{
    kWeakSelf(self);
    [HttpApiHttpVoice inviteUserUpAssitant:userModel.userid roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [FunctionSheetBaseView deletePopView:weakself];
            [SVProgressHUD showSuccessWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

@end
