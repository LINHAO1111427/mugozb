//
//  ApplyLinkUserList.m
//  LiveCommon
//
//  Created by CH on 2019/12/21.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "ApplyLinkUserList.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/PopupTool.h>
#import "ApplyUserListCell.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjModel/ApiLineVoiceModel.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/EmptyView.h>

@interface ApplyLinkUserList()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, weak) UITableView *tableV;
@property(nonatomic, copy) NSArray *items;

@property (nonatomic, assign)BOOL isApply;  ///是否申请中

@property (nonatomic, weak)UIButton *applyBtn; ///申请按钮

@property (nonatomic, strong)UIButton *priorityHeaderBtn;

@property (nonatomic, weak)EmptyView *emptyV;

@end

@implementation ApplyLinkUserList


+ (void)applyUserList{
    ApplyLinkUserList *linkV = [[ApplyLinkUserList alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 365+kSafeAreaBottom)];
    linkV.isApply = NO;
    [linkV createUI];
    [FunctionSheetBaseView showView:linkV cover:NO];
}


- (void)createUI{
    ///标题视图
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 65)];
    [self addSubview:headerV];
    
    ///关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake(headerV.width-12-30, 10,30,30);
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_gray"] forState:UIControlStateNormal];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [headerV addSubview:closeBtn];
    kWeakSelf(self);
    [closeBtn klc_whenTapped:^{
        [FunctionSheetBaseView deletePopView:weakself];
    }];
    
    ///标题
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerV.width-(closeBtn.width *2.0), 20)];
    titleL.text = kLocalizationMsg(@"连麦列表");
    titleL.font = [UIFont systemFontOfSize:15];
    titleL.textColor = [UIColor blackColor];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.centerY = closeBtn.centerY;
    titleL.centerX = headerV.width/2.0;
    [headerV addSubview:titleL];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,65, self.frame.size.width, self.frame.size.height-65-50) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelection = NO;
    [tableView registerClass:[ApplyUserListCell class] forCellReuseIdentifier:@"ApplyUserListCellID"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:tableView];
    _tableV = tableView;
    
    EmptyView *emptyView = [[EmptyView alloc] init];
    emptyView.iconImgV.image  = [UIImage imageNamed:@"home_guangchang_meiyouzhubo"];
    emptyView.titleL.text = kLocalizationMsg(@"～暂无人申请上麦，赶紧申请吧～");
    [emptyView showInView:tableView];
    _emptyV = emptyView;
     
    ///线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-60, self.width, 0.8)];
    lineView.backgroundColor =kRGB_COLOR(@"#DEDEDE");
//    [self addSubview:lineView];
    ///前排麦序
    UIButton *priorityHeaderBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 37, 100, 45)];
    priorityHeaderBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [priorityHeaderBtn setBackgroundImage:[UIImage imageNamed:@"live_connect_priority_back"] forState:UIControlStateNormal];
    [priorityHeaderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    priorityHeaderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [priorityHeaderBtn setTitle:kLocalizationMsg(@"   麦序优先") forState:UIControlStateNormal];
    [priorityHeaderBtn setTitleEdgeInsets:UIEdgeInsetsMake(16, 0, 9, 0)];
    _priorityHeaderBtn = priorityHeaderBtn;
    [self addSubview:priorityHeaderBtn];
    
    ///申请按钮
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    applyBtn.frame = CGRectMake((self.width-240)/2.0, self.height-11-38, 240, 38);
    applyBtn.layer.masksToBounds = YES;
    applyBtn.layer.cornerRadius = 19;
    [applyBtn setBackgroundImage:[UIImage createImageSize:applyBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#4BC9FF"),kRGB_COLOR(@"#00FFF4") ] percentage:@[@0.5,@1.0] gradientType:GradientFromLeftBottomToRightTop] forState:UIControlStateNormal];
    [applyBtn setTitle:kLocalizationMsg(@"申请连麦") forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [applyBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:applyBtn];
    _applyBtn = applyBtn;
    
    [self.tableV reloadData];
    [self getApplyList];
}

 

///获得用户申请列表
- (void)getApplyList{
    kWeakSelf(self);
    [HttpApiHttpVoice getWaitingUsers:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, NSArray<ApiLineVoiceModel *> *arr) {
        weakself.emptyV.hidden = arr.count;
        if (code == 1) {
            weakself.items = arr;
            ApiLineVoiceModel *voiceModel = arr.firstObject;
            weakself.priorityHeaderBtn.hidden = !voiceModel.mikePrivilege;
            [weakself.tableV reloadData];
            [arr enumerateObjectsUsingBlock:^(ApiLineVoiceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.uid == [ProjConfig userId]) {
                    weakself.isApply = YES;
                    [weakself.applyBtn setTitle:kLocalizationMsg(@"取消申请") forState:UIControlStateNormal];
                    *stop = YES;
                }
            }];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

// MARK: - Action
- (void)applyBtnClick{
    kWeakSelf(self);
    if (_isApply) {
        ///取消申请
        [HttpApiHttpVoice cancelUpAssistant:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code != 1) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }else{
                [weakself.applyBtn setTitle:kLocalizationMsg(@"申请连麦") forState:UIControlStateNormal];
                [SVProgressHUD showInfoWithStatus:strMsg];
                [FunctionSheetBaseView deletePopView:weakself];
                [weakself getApplyList];
            }
        }];
        
    }else{
        ///申请上麦
        [HttpApiHttpVoice authUpAssistan:-1 roomId:[LiveManager liveInfo].roomId callback:^(int code, NSString *strMsg, ApiUsersVoiceAssistanModel *model) {
            if (code != 1 && code != 0) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }else{
                [weakself.applyBtn setTitle:kLocalizationMsg(@"取消申请") forState:UIControlStateNormal];
                [SVProgressHUD showInfoWithStatus:strMsg];
                [FunctionSheetBaseView deletePopView:weakself];
                [weakself getApplyList];
            }
        }];
    }
}


// MARK: - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyUserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyUserListCellID" forIndexPath:indexPath];
    
    if (self.items.count > indexPath.row) {
        
        ApiLineVoiceModel *voiceM = _items[indexPath.row];
        cell.userId = voiceM.uid;
        [cell showIndex:indexPath.row userName:voiceM.userName avatar:voiceM.avatar iconFrame:voiceM.nobleAvatarFrame age:voiceM.age gender:voiceM.sex weathLevel:voiceM.wealthGrade nobleLevel:voiceM.nobleGrade];
        
        [cell showUserLinkList:voiceM.mikePrivilege];
        
    }

    return cell;
}

// MARK: - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
