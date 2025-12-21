//
//  AudioLinkUserListView.m
//  MPAudioLive
//
//  Created by klc_sl on 2021/8/27.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "AudioLinkUserListView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/EmptyView.h>
#import "ApplyUserListCell.h"
#import <LibProjModel/HttpApiHttpVoice.h>

@interface AudioLinkUserListView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak)UITableView *tableV;

@property (nonatomic, strong)NSMutableArray *userListArr;

@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation AudioLinkUserListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        
        ///连麦管理
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
- (void)getOnlineMicUserList{
    kWeakSelf(self);
    [HttpApiHttpVoice getAssistantUserInfoList:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, NSArray<AssistantUserInfoVOModel *> *arr) {
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
        AssistantUserInfoVOModel *userM = _userListArr[indexPath.row];
        kWeakSelf(self);
        cell.userId = userM.userId;
        [cell showIndex:indexPath.row userName:userM.userName avatar:userM.userAvatar iconFrame:userM.nobleAvatarFrame age:userM.age gender:userM.sex weathLevel:userM.wealthGradeImg nobleLevel:userM.nobleGradeImg];
        [cell showLinkUserMicStatus:userM.noTalking micHandle:^{
            [weakself setUserMicForUserId:userM.userId];
        } below:^{
            [weakself letUsetDownSeatForUserId:userM.userId];
        }];
    }
    return cell;
}


///设置用户禁麦接麦
- (void)setUserMicForUserId:(int64_t)uid{
    kWeakSelf(self);
    [HttpApiHttpVoice addNoTalking:[LiveManager liveInfo].anchorId roomId:[LiveManager liveInfo].roomId touid:uid callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [weakself getOnlineMicUserList];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

///让用户下麦位
- (void)letUsetDownSeatForUserId:(int64_t)uid{
    kWeakSelf(self);
    [HttpApiHttpVoice kickOutAssistan:[LiveManager liveInfo].roomId userId:uid callback:^(int code, NSString *strMsg, ApiUsersVoiceAssistanModel *model) {
        if (code == 1) {
            [weakself getOnlineMicUserList];
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
    [self getOnlineMicUserList];
}



@end
