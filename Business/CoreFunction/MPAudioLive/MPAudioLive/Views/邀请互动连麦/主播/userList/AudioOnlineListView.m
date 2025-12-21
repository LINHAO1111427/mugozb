//
//  AudioOnlineListView.m
//  MPAudioLive
//
//  Created by klc_sl on 2021/8/27.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "AudioOnlineListView.h"

#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/EmptyView.h>
#import "ApplyUserListCell.h"
#import <SDWebImage/SDWebImage.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/HttpApiHttpVoice.h>

@interface AudioOnlineListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, strong)NSMutableArray *userListArr;

@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation AudioOnlineListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    ///列表
    UITableView *applyListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    applyListTableView.delegate = self;
    applyListTableView.dataSource = self;
    [applyListTableView registerClass:[ApplyUserListCell class] forCellReuseIdentifier:@"ApplyUserListCellID"];
    applyListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:applyListTableView];
    _tableV = applyListTableView;
    [applyListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //空
    EmptyView *emptyView = [[EmptyView alloc] init];
    emptyView.iconImgV.image  = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
    emptyView.titleL.text = kLocalizationMsg(@"～没人～");
    [emptyView showInView:applyListTableView];
    _emptyV = emptyView;
}

///获得用户申请列表
- (void)onlineUserList{
    kWeakSelf(self);
    [HttpApiPublicLive getLiveUser:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, NSArray<ApiUserBasicInfoModel *> *arr) {
        if (code == 1) {
            weakself.userListArr = [NSMutableArray arrayWithArray:arr];
            [weakself.tableV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


#pragma mark -UITableViewDelegate,UITableViewDataSource-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyUserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyUserListCellID" forIndexPath:indexPath];
    if (self.userListArr.count > indexPath.row) {
        kWeakSelf(self);
        ApiUserBasicInfoModel *userM = _userListArr[indexPath.row];
        cell.userId = userM.uid;
        [cell showIndex:indexPath.row userName:userM.username avatar:userM.avatar iconFrame:userM.nobleAvatarFrame age:userM.age gender:userM.sex weathLevel:userM.wealthGradeImg nobleLevel:userM.nobleGradeImg];
        [cell showOnlineMicStatus:userM.isInAssistant inviteBlock:^{
            [weakself inviteUser:userM];
        }];
    }
    return cell;
}

///邀请用户
- (void)inviteUser:(ApiUserBasicInfoModel *)userInfo{
    kWeakSelf(self);
    [HttpApiHttpVoice inviteLiveUserUpAssistant:userInfo.uid roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            userInfo.isInAssistant = -1;
            [weakself.tableV reloadData];
            [SVProgressHUD showSuccessWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

// MARK: - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark -JXCategoryListContentViewDelegate-
- (UIView *)listView{
    return self;
}


- (void)listWillAppear{
    [self onlineUserList];
}


@end
