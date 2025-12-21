//
//  ApplyLinkAudienceListView.m
//  LiveCommon
//
//  Created by CH on 2019/12/20.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "ApplyLinkAudienceListView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LibProjModel/ApiLineVoiceModel.h>
#import <LibProjView/EmptyView.h>
#import "ApplyUserListCell.h"

@interface ApplyLinkAudienceListView()<UITableViewDelegate , UITableViewDataSource>

@property(nonatomic, weak) UITableView *applyListTableView;

@property(nonatomic, copy) NSArray *items;

@property (nonatomic, weak)UISwitch *switchBar;

@property (nonatomic, strong)UIButton *priorityHeaderBtn;

@property (nonatomic, weak)EmptyView *emptyV;
@end


@implementation ApplyLinkAudienceListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    ///自动上下麦开关
    UISwitch *automaticSwitch = [[UISwitch alloc] init];
    [automaticSwitch setOnTintColor:[ProjConfig normalColors]];
//    automaticSwitch.transform = CGAffineTransformMakeScale(0.6, 0.6);//缩放
    [automaticSwitch setTintColor:kRGB_COLOR(@"#999999")];
    automaticSwitch.on = YES;
    [automaticSwitch addTarget:self action:@selector(swichAutomaticLink:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:automaticSwitch];
    _switchBar = automaticSwitch;
    [automaticSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(5);
        make.size.mas_equalTo(CGSizeMake(51, 31));
    }];

    ///名称
    UILabel *automaticLinkMicLb = [[UILabel alloc] init];
    automaticLinkMicLb.textColor = kRGB_COLOR(@"#999999");
    automaticLinkMicLb.text = kLocalizationMsg(@"自动上麦");
    automaticLinkMicLb.font = [UIFont systemFontOfSize:12];
    automaticLinkMicLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:automaticLinkMicLb];
    [automaticLinkMicLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(automaticSwitch);
        make.right.equalTo(automaticSwitch.mas_left).offset(-10);
    }];
    
    ///列表
    UITableView *applyListTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    applyListTableView.delegate = self;
    applyListTableView.dataSource = self;
    [applyListTableView registerClass:[ApplyUserListCell class] forCellReuseIdentifier:@"ApplyUserListCellID"];
    applyListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:applyListTableView];
    _applyListTableView = applyListTableView;
    [applyListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(automaticSwitch.mas_bottom).offset(5);
    }];
    
    
    //前排麦序
    UIButton *priorityHeaderBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 67, 100, 45)];
    priorityHeaderBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [priorityHeaderBtn setBackgroundImage:[UIImage imageNamed:@"live_connect_priority_back"] forState:UIControlStateNormal];
    [priorityHeaderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    priorityHeaderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [priorityHeaderBtn setTitle:kLocalizationMsg(@"   麦序优先") forState:UIControlStateNormal];
    [priorityHeaderBtn setTitleEdgeInsets:UIEdgeInsetsMake(16, 0, 9, 0)];
    _priorityHeaderBtn = priorityHeaderBtn;
    [self addSubview:priorityHeaderBtn];
    [priorityHeaderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.bottom.equalTo(applyListTableView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 45));
    }];
    
    
    //空
    EmptyView *emptyView = [[EmptyView alloc] init];
    emptyView.iconImgV.image  = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
    emptyView.titleL.text = kLocalizationMsg(@"～暂无主播申请上麦，赶紧去邀请吧～");
    [emptyView showInView:applyListTableView];
    _emptyV = emptyView;

    
    [self getAutoUpSwitch];
    
}

// MARK: - Action

- (void)getLinkMicList{
    kWeakSelf(self);
    ///查看申请上麦
    [HttpApiHttpVoice getWaitingUsers:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, NSArray<ApiLineVoiceModel *> *arr) {
        weakself.emptyV.hidden = arr.count;
        if (code == 1) {
            weakself.items = arr;
            ApiLineVoiceModel *voiceModel = arr.firstObject;
            weakself.priorityHeaderBtn.hidden = !voiceModel.mikePrivilege;
            [weakself.applyListTableView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)getAutoUpSwitch{
    kWeakSelf(self);
    [HttpApiHttpVoice getAutoUpAssistant:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1 && [model.no_use validPureInt]) {
            weakself.switchBar.on = [model.no_use intValue];
        }else{
            weakself.switchBar.on = NO;
        }
    }];
}


- (void)swichAutomaticLink:(UISwitch *)sender{
    kWeakSelf(self);
    [HttpApiHttpVoice setAutoUpAssistant:(self.switchBar.on)?1:0 roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code != 1) {
            weakself.switchBar.on = !weakself.switchBar.on;
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


// MARK: - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyUserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyUserListCellID" forIndexPath:indexPath];
    kWeakSelf(self);
    if (self.items.count > indexPath.row) {
        ApiLineVoiceModel *voiceM = _items[indexPath.row];
        cell.userId = voiceM.uid;
        [cell showIndex:indexPath.row userName:voiceM.userName avatar:voiceM.avatar iconFrame:voiceM.nobleAvatarFrame age:voiceM.age gender:voiceM.sex weathLevel:voiceM.wealthGrade nobleLevel:voiceM.nobleGrade];
        [cell showApplyUser:voiceM.mikePrivilege handle:^(BOOL isAgree) {
            [weakself replyUserUpAssistan:voiceM isAgree:isAgree];
        }];
    }
    
    return cell;
}

///回复用户是否同意上麦
- (void)replyUserUpAssistan:(ApiLineVoiceModel *)model isAgree:(BOOL)isAgree{
    kWeakSelf(self);
    [HttpApiHttpVoice dealUpAssistantAsk:model.no isAgree:isAgree?1:0 roomId:[LiveManager liveInfo].roomId userId:model.uid callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code > 0) {
            [weakself getLinkMicList];
            [SVProgressHUD showSuccessWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


#pragma mark -JXCategoryListContentViewDelegate-

- (UIView *)listView{
    return self;
}


- (void)listWillAppear{
    [self getLinkMicList];
}

@end
