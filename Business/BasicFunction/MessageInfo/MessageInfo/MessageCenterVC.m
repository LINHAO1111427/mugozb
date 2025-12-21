//
//  MessageVC.m
//  Message
//
//  Created by klc_tqd on 2020/5/9.
//  Copyright © 2020 . All rights reserved.

#import "MessageCenterVC.h"
#import "MessageChatListVC.h"

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiMessage.h>

#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/BaseNavBarItem.h>

#import <LibTools/LibTools.h>
#import <LibProjView/ForceAlertController.h>

@interface MessageCenterVC ()

@property (nonatomic, strong)NSMutableArray *titles;

@property(nonatomic, weak)UIButton *noReadSysBtn;//系统通知

@property(nonatomic, strong)MessageChatListVC *listVc;
 
@property(nonatomic, weak)UIButton *noReadDyBtn;//评论

@property(nonatomic, weak)UIButton *noReadOfficialBtn;//官方消息

@end

@implementation MessageCenterVC


- (UIView *)listView{
    return self.view;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
}


#pragma mark - 初始化
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getAppSystemNoReadData];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self createUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotificationUpdateStatusNoti:) name:NotificationUpdateStatus object:nil];
    
    self.navigationItem.title = kLocalizationMsg(@"消息");

}


- (void)createUI{

    UIView *headerBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 95)];
    [self.view addSubview:headerBgV];
    headerBgV.backgroundColor = kRGB_COLOR(@"#F5F5F5");
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerBgV.width, headerBgV.height-10)];
    [headerBgV addSubview:whiteView];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    
    NSArray *itemArr = [[ProjConfig shareInstence].businessConfig getMessageCenterArray];
    
    NSMutableArray *funcBtnArr = [[NSMutableArray alloc] init];
    
    for (NSDictionary *subDict in itemArr) {
                
        int funcId = [subDict[@"funcId"] intValue];
        
        UIButton *commitBtn = [UIButton buttonWithType:0];
        [commitBtn setImage:[UIImage imageNamed:subDict[@"image"]] forState:UIControlStateNormal];
        [commitBtn setTitle:subDict[@"title"] forState:UIControlStateNormal];
        commitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        commitBtn.frame = CGRectMake(0, 0, 64, 84);
        [commitBtn btnSetUpImgDownForSpace:10];
        commitBtn.tag = 9931+funcId;
        [commitBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [funcBtnArr addObject:commitBtn];

        if (funcId == 1 || funcId == 2 || funcId == 3) {
            
            UIButton *noReadDyBtn = [UIButton buttonWithType:0];
            noReadDyBtn.titleLabel.font = [UIFont systemFontOfSize:8];
            noReadDyBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
            [noReadDyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            noReadDyBtn.backgroundColor = [UIColor redColor];
            noReadDyBtn.layer.masksToBounds = YES;
            noReadDyBtn.layer.cornerRadius = 6.0;
            noReadDyBtn.hidden = YES;
            [noReadDyBtn setTitle:@"0" forState:UIControlStateNormal];
            [commitBtn addSubview:noReadDyBtn];
            [noReadDyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(12);
                make.width.mas_greaterThanOrEqualTo(12);
                make.left.equalTo(commitBtn.imageView.mas_right).inset(-7);
                make.top.equalTo(commitBtn.imageView).inset(-4);
            }];
            
            switch (funcId) {
                case 1: ///评论
                    _noReadDyBtn = noReadDyBtn;
                    break;
                case 2: ///系统通知
                    _noReadSysBtn = noReadDyBtn;
                    break;
                case 3: ///官方消息
                    _noReadOfficialBtn = noReadDyBtn;
                    break;
                    
                default:
                    break;
            }

        }
        
    }
   
    UIStackView *stackV = [[UIStackView alloc] initWithArrangedSubviews:funcBtnArr];
    stackV.frame = whiteView.bounds;
    stackV.axis = UILayoutConstraintAxisHorizontal;
    stackV.alignment = UIStackViewAlignmentFill;
    stackV.distribution = UIStackViewDistributionFillEqually;
    stackV.spacing = 5;
    stackV.backgroundColor = [UIColor whiteColor];
    [whiteView addSubview:stackV];
    
    MessageChatListVC *list = [[MessageChatListVC alloc] init];
    self.listVc = list;
    if ([ProjConfig currentNVCList].count > 1) {
        list.isFullScreen = YES;
    }
    UIView *listV = [list listView];
    listV.frame = CGRectMake(0, headerBgV.height, kScreenWidth, kScreenHeight-kTabBarHeight-headerBgV.height);
    [self.view addSubview:listV];
    [self addChildViewController:list];
    [listV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).inset(headerBgV.height);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)functionBtnClick:(UIButton *)btn{
    switch (btn.tag - 9931) {
        case 1: ///评论
            [RouteManager routeForName:RN_Message_MyDynamicComment currentC:self];
            break;
        case 2: ///系统通知
            [RouteManager routeForName:RN_Message_SystemNotice currentC:self];
            break;
        case 3: ///官方消息
            [RouteManager routeForName:RN_Message_OfficialNotice currentC:self];
            break;
        case 4: ///在线客服
            [RouteManager routeForName:RN_center_setting_onLineService currentC:self];
            break;
        case 5: ///投诉
            break;
        case 6: ///求聊
            [RouteManager routeForName:RN_activity_otoSeekChatOrder currentC:self];
            break;
        default:
            break;
    }
}

- (void)NotificationUpdateStatusNoti:(NSNotification *)aNotification{
    [self reloadNoticeNumber];
}


#pragma mark - 其他
- (void)clearConversations{
    if (self.listVc) {
        [self.listVc deleteAllConversations];
    }
}
//获取系统化未读消息
-(void)getAppSystemNoReadData{
    kWeakSelf(self);
    [HttpApiMessage getAppSystemNoRead:^(int code, NSString *strMsg, ApiNoReadModel *model) {
        if (code== 1) {
            if (model.videoNoRead > 0 || model.shortVideoNoRead > 0) {//评论
                weakself.noReadDyBtn.hidden = NO;
            }else{
                weakself.noReadDyBtn.hidden = YES;
            }
            weakself.noReadSysBtn.hidden = model.systemNoRead>0?NO:YES;//系统消息
            weakself.noReadOfficialBtn.hidden = model.officialNewsNoRead>0?NO:YES;// 官方消息
        
            ///显示数据
            [weakself.noReadDyBtn setTitle:[NSString stringWithFormat:@"%lld",model.videoNoRead+model.shortVideoNoRead] forState:UIControlStateNormal];
            [weakself.noReadSysBtn setTitle:[NSString stringWithFormat:@"%lld",model.systemNoRead] forState:UIControlStateNormal];
            [weakself.noReadOfficialBtn setTitle:[NSString stringWithFormat:@"%lld",model.officialNewsNoRead] forState:UIControlStateNormal];
        }
    }];
}

-(void)reloadNoticeNumber{
    [self getAppSystemNoReadData];
}


@end
