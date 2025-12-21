//
//  ConversationChatVC.m
//  Message
//
//  Created by klc_tqd on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import "ConversationChatVC.h"

#import <LibTools/LibTools.h>
#import <MJRefresh/MJRefresh.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiOOOLive.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/HttpApiChatRoomController.h>
#import <LibProjModel/HttpApiMessage.h>
#import <LibProjModel/NobLiveGiftModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/UserInfoHomeVOModel.h>
#import <LibProjModel/AppFamilyChatroomInfoVOModel.h>
#import <LibProjModel/HttpApiChatMsgController.h>
#import <LibProjView/AddWishView.h>
#import <LibProjView/GiftUserModel.h>
#import <LibProjView/ChoiceGiftView.h>
#import <LibProjView/WishShowFlowView.h>
#import <LibProjView/CustomPopUpAlert.h>
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjView/SendIMMessageObj.h>
#import <TXImKit/TXImKit.h>
#import <LibProjView/RedPacketSendView.h>
#import "ChatWishSocketTool.h"
#import "ChatGiftSocketTool.h"
#import "ChatFamilyMsgSocketTool.h"
#import <LibProjView/OneLiveCheckContactView.h>
#import "ChatSetUpVC.h"
#import "ChatGuardView.h"

#import <LibProjModel/HttpApiNobLiveGift.h>
#import "ChatHeaderView.h"
#import "ChatBottomView.h"
#import "ChatNaviView.h"
#import "CostBannerView.h"

#import "ChatMsgBottomView.h"

#import <LibProjView/BalanceLackPromptView.h>
#import <LibProjModel/HttpApiChatFamilyController.h>
#import <LibProjView/AddWishGiftView.h>
#import "MessageTool.h"
#import "ChatMsgInfoView.h"


@interface ConversationChatBgView : UIView
@end
@implementation ConversationChatBgView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == self) {
        return nil;
    }
    return hitV;
}
@end


@interface ConversationChatVC ()<ChatMsgBottomViewDelegate,UIScrollViewDelegate,ChatMsgInfoDelegate,ChatFamilyMsgSocketDelegate>

///对方数据(对方用户信息)
@property (nonatomic, strong)UserInfoHomeVOModel *otherUserInfoM;
///礼物socket
@property (nonatomic, copy)ChatGiftSocketTool *giftSocketTool;
///心愿单socket
@property (nonatomic, copy)ChatWishSocketTool *wishSocketTool;
///聊天其他的socket
@property (nonatomic, copy)ChatFamilyMsgSocketTool *chatMsgSocketTool;
///发送消息
@property (nonatomic, copy)SendIMMessageObj *sendMessageObj;
///头部视图
@property (nonatomic, weak)ChatHeaderView *headerV;
///聊天显示
@property (nonatomic, weak)ChatMsgInfoView *chatMsgV;
///导航栏
@property (nonatomic, weak)ChatNaviView *naviV;
///提示view
@property (nonatomic, weak)CostBannerView *bannerView;
///底部视图
@property (nonatomic, weak)ChatMsgBottomView *bottomV;
///聊天页面的背景view
@property (nonatomic, weak)ConversationChatBgView *chatShowBgView;
///群族族长ID
@property (nonatomic, assign)int64_t groupUid;
///消息工具
@property (nonatomic, copy)MessageTool *messageTool;


@end


@implementation ConversationChatVC

- (void)dealloc
{
   // NSLog(@"过滤文字聊天文件 dealloc %s"), __func__);
}

- (void)popViewController{
    [self deleteSocketAddDelegateAndNSNotificationCenter];
    [self.navigationController popViewControllerAnimated:YES];
    _otherUserInfoM = nil;
    _giftSocketTool = nil;
    _messageTool = nil;
    _sendMessageObj = nil;
    _wishSocketTool = nil;
    _chatMsgSocketTool = nil;
}


#pragma mark - 初始化与周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = kRGB_COLOR(@"#FAFAFA");
    ///显示基本UI
    [self creatShowView];
    
    if (self.navTitle.length > 0) {
        self.naviV.navTitleL.text = self.navTitle;
    }
    ///注册监听
    [self registSocketAddDelegateAndNSNotificationCenter];
    
    ///获取数据
    [self getMessageConfigInfo];
    
    if (self.chatType == ConversationChatForSignle) {
        ///获取对方信息
        [self getOtherUserInfoData];
        [self getOtherChatInfo];
    }else if (self.chatType == ConversationChatForFansGroup){
        ///向后台传递进入群聊
        [self getFansGroupInfoData];
    }else{
        ///向后台传递进入群聊
        [self getFamilyGroupInfoData];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IMSocketIns getIns] readConversationMsg:[NSString stringWithFormat:@"%lld",self.msgSendId] isGroup:self.chatType?YES:NO sucess:^{
    } fail:^(int code, NSString * _Nonnull desc) {
       // NSLog(@"过滤文字####【IM反馈】#### 阅读某聊天消息失败"));
    }];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IMSocketIns getIns] readConversationMsg:[NSString stringWithFormat:@"%lld",self.msgSendId] isGroup:self.chatType?YES:NO sucess:^{
    } fail:^(int code, NSString * _Nonnull desc) {
       // NSLog(@"过滤文字####【IM反馈】#### 阅读某聊天消息失败"));
    }];
    [self.chatMsgV stopPlayVoice];
}


#pragma mark - UI
-(void)creatShowView{
    kWeakSelf(self);
    ///导航栏
    ChatNaviView *naviView = [[ChatNaviView alloc] initWithChatType:self.chatType];
    [naviView.backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    naviView.moreBtnClick = ^(ConversationChatForType chatType) {
        [weakself moreBtnEvent];
    };
    if (self.chatType == ConversationChatForSignle) {
        naviView.attenBtnClick = ^(BOOL isSelect) {
            [weakself attentionBtnEvent:isSelect];
        };
    }
    if (self.chatType == ConversationChatForFamilyGroup || self.chatType == ConversationChatForSquareGroup) {
        naviView.rankBtnClick = ^(BOOL isFamily) {
            [weakself rankBtnEvent:isFamily];
        };
    }
    
    [self.view addSubview:naviView];
    self.naviV = naviView;
    
    ///提示View
    CostBannerView *bannerView = [[CostBannerView alloc] initWithFrame:CGRectMake(0, naviView.maxY, kScreenWidth, 0)];
    bannerView.hidden = YES;
    [bannerView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bannerViewTap)]];
    bannerView.closeBtnClickBlock = ^{
        [weakself isShowCostBannerView:NO tips:@""];
    };
    [self.view addSubview:bannerView];
    self.bannerView = bannerView;
    
    ///聊天信息view
    ChatHeaderView *headerView = [[ChatHeaderView alloc] initWithFrame:CGRectMake(0, bannerView.maxY, kScreenWidth, 0.1) chatType:self.chatType];
    [self.view addSubview:headerView];
    if (self.chatType == ConversationChatForSignle) {
        self.headerV = headerView;
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bannerView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(headerView.height);
        }];
    }
    
    ///底部聊天view
    CGFloat bottomHeight = 90+40+(kISiPhoneXX ? 20.0 : 0);
    ChatMsgBottomView *bottomV = [[ChatMsgBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight-bottomHeight, kScreenWidth, bottomHeight) chatType:self.chatType msgSendId:self.msgSendId];
    bottomV.delegate = self;
    [self.view addSubview:bottomV];
    self.bottomV = bottomV;
    
    ///内容
    ChatMsgInfoView *chatMsgView = [[ChatMsgInfoView alloc] initWithMsgSendId:self.msgSendId chatType:self.chatType];
    chatMsgView.superVC = self;
    chatMsgView.msgDelegate = self;
    [self.view addSubview:chatMsgView];
    [self.view sendSubviewToBack:chatMsgView];
    self.chatMsgV = chatMsgView;
    [chatMsgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_bottom);
        make.bottom.equalTo(bottomV.mas_top);
        make.left.right.equalTo(self.view);
    }];
}

///app即将回来
- (void)viewControllerWillForeground{
    if (self.chatType == ConversationChatForFamilyGroup || self.chatType == ConversationChatForSquareGroup) {
        [self getFamilyGroupInfoData];
    }
}

-(void)registSocketAddDelegateAndNSNotificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewControllerWillForeground) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self.giftSocketTool chatSocketToolParInit:self.chatShowBgView sendMsgId:self.msgSendId chatType:self.chatType];
    if (self.chatType == ConversationChatForSignle) {
        [self.wishSocketTool chatSocketToolParInit];
    }else if (self.chatType == ConversationChatForFansGroup){
        
    }else{
        [self.chatMsgSocketTool chatSocketToolParInit:self.chatShowBgView groupId:self.msgSendId];
    }
    ///发信息初始化
    [self.sendMessageObj addMonitor:self.msgSendId isGroup:(self.chatType== ConversationChatForSignle)?NO:YES];
}

- (void)deleteSocketAddDelegateAndNSNotificationCenter{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [_sendMessageObj removeMonitor];
    _sendMessageObj = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[IMSocketIns getIns] removeReceiverByGroupID:socketGroupMessage];
    [_giftSocketTool removeMessageSocket];
    [_wishSocketTool removeMessageSocket];
    [_chatMsgSocketTool removeMessageSocket];
}


///显示banner的提示文字
-(void)isShowCostBannerView:(BOOL)isShow tips:(NSString *)tips{
    if (isShow && tips.length > 0) {
        self.bannerView.hidden = NO;
        self.bannerView.height = 20;
        self.bannerView.privateChatDeductionTips = tips;
    }else{
        self.bannerView.privateChatDeductionTips = @"";
        self.bannerView.hidden = YES;
        self.bannerView.height = 0;
    }
}


///常用标语接口
-(void)getMessageConfigInfo{
    int64_t toUserId = self.chatType == ConversationChatForSignle?self.msgSendId:0;
    kWeakSelf(self);
    [HttpApiChatRoomController getCommonWordsList:((self.chatType == ConversationChatForSignle)?1:2) toUserId:toUserId callback:^(int code, NSString *strMsg, CommonTipsDTOModel *model) {
        if (code == 1) {
            [weakself isShowCostBannerView:model.isShowTips tips:model.privateChatDeductionTips];
            if (model.commonWordsList.count > 0) {
                [weakself.bottomV showCommonWords:model.commonWordsList];
                //                [weakself.chatMsgV scrollMessageBottom];
            }else{
                [weakself.bottomV showCommonWords:@[]];
            }
        }else{
            [weakself.bottomV showCommonWords:@[]];
        }
    }];
}


//获取对方最近数据接口
-(void)getOtherChatInfo{
    if (self.chatType != 0) {
        return;
    }
    kWeakSelf(self);
    [HttpApiChatRoomController oooSendMsgText:self.msgSendId callback:^(int code, NSString *strMsg, OOOLiveTextChatDataModel *model) {
        if (code == 1) {
            weakself.headerV.chatDataInfo = model;
        }
    }];
}


///点击用户的头像
- (void)clickUserIcon:(int64_t)userId userName:(NSString *)userName userIcon:(NSString *)userIcon{
    kWeakSelf(self);
    if (self.chatType == ConversationChatForSignle) {
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(userId)}];
    }else if (self.chatType == ConversationChatForFansGroup){
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"送礼") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            GiftUserModel *userModel = [[GiftUserModel alloc]init];
            userModel.userId = userId;
            userModel.userName = userName;
            userModel.userIcon = userIcon;
            userModel.roomId = weakself.msgSendId;
            [ChoiceGiftView showGift:11 users:@[userModel] hasContinue:NO sendSuccess:^(NSArray<ApiGiftSenderModel *> * _Nonnull giftModelList) {
                [weakself sendGiftSuccess:giftModelList];
            }];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"查看资料") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [RouteManager routeForName:RN_user_userInfoVC currentC:weakself parameters:@{@"id":@(userId)}];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"私信") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [RouteManager routeForName:RN_Message_ConversationChatVC currentC:weakself parameters:@{@"chatType":@"0",@"msgSendId":@(userId)}];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:nil]];
        [weakself presentViewController:alertVC animated:YES completion:nil];
        
    }else{
        if (userId == [ProjConfig userId]) {
            [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(userId)}];
        }else{
            [HttpApiChatFamilyController getAppChatFamilyOptIntoVO:self.msgSendId toUserId:userId callback:^(int code, NSString *strMsg, AppChatFamilyOptIntoVOModel *model) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"送礼") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    GiftUserModel *userModel = [[GiftUserModel alloc]init];
                    userModel.userId = userId;
                    userModel.userName = userName;
                    userModel.userIcon = userIcon;
                    userModel.roomId = weakself.msgSendId;
                    [ChoiceGiftView showGift:8 users:@[userModel] hasContinue:NO sendSuccess:^(NSArray<ApiGiftSenderModel *> * _Nonnull giftModelList) {
                        [weakself sendGiftSuccess:giftModelList];
                    }];
                }]];
                [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"查看资料") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [RouteManager routeForName:RN_user_userInfoVC currentC:weakself parameters:@{@"id":@(userId)}];
                }]];
                [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"私信") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [RouteManager routeForName:RN_Message_ConversationChatVC currentC:weakself parameters:@{@"chatType":@"0",@"msgSendId":@(userId)}];
                }]];
                if (model.isSquareMute == 1) {
                    [alertVC addAction:[UIAlertAction actionWithTitle:model.muteStatus?kLocalizationMsg(@"解除禁言"):kLocalizationMsg(@"禁言") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        int handleType = model.muteStatus+1;
                        [HttpApiChatFamilyController addOrDelMuteUser:weakself.msgSendId optType:handleType userId:userId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                            [SVProgressHUD showInfoWithStatus:strMsg];
                        }];
                    }]];
                }
                [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:nil]];
                [weakself presentViewController:alertVC animated:YES completion:nil];
                
                if (code == 1) {
                    weakself.chatMsgSocketTool.chatGroupInfo.isSquareMute = model.isSquareMute;
                }
            }];
        }
    }
}


#pragma mark - 消息发送及其处理
/// 发送消息
-(void)sendChatMessage:(IMMessageType)messageType andCustomContentDict:(NSDictionary *)customContentDict{
    [self hideKeyBoard];
    [self.sendMessageObj sendMessageType:messageType customDict:customContentDict muteMsg:((self.chatType == ConversationChatForSquareGroup)?YES:NO) sendResult:^(BOOL success) {
         
    }];
}


#pragma mark - 私有方法 -
///发送文字
- (void)sendMessageAtType:(NSString *)inputText andUserArr:(NSArray *)userArr andIsAtAll:(BOOL)isAtAll{
#warning @TA
    /*
     JMSGMessage *message = nil;
     JMSGGroup *group = (JMSGGroup *)self.conversation.target;
     JMSGTextContent *textContent = [[JMSGTextContent alloc] initWithText:inputText];
     if (isAtAll) {
     message = [JMSGMessage createGroupAtAllMessageWithContent:textContent groupId:group.gid];
     }else{
     message = [JMSGMessage createGroupMessageWithContent:textContent groupId:group.gid at_list:userArr];
     }
     JMSGOptionalContent *content = [JMSGOptionalContent new];
     content.noSaveNotification = NO;
     [self.conversation sendMessage:message optionalContent:content];
     */
    
    [self sendChatMessage:IMMessageTypeForText andCustomContentDict:@{@"txt":kStringFormat(@"@%@ %@",kLocalizationMsg(@"名字待修正"),inputText),@"isTop":kStringFormat(@"%d", NO)}];
}

//聊天 更多设置
-(void)moreBtnEvent{
    switch (self.chatType) {
        case 0:///单人聊天设置
            [RouteManager routeForName:RN_Message_ChatSettingsVC currentC:self parameters:@{@"chatType":@(self.chatType),@"msgId":@(self.msgSendId)}];
            break;
        case 1: ///家族信息
            [RouteManager routeForName:RN_Family_FamilyInfoVC currentC:self parameters:@{@"familyId":@(self.msgSendId),@"clickChatIsBack":@(YES)}];
            break;
        case 2:///广场
            [RouteManager routeForName:RN_Message_SquareUserList currentC:self parameters:@{@"groupId":@(self.msgSendId),@"isSquareMute":@(self.chatMsgSocketTool.chatGroupInfo.isSquareMute)}];
            break;
        case 3:///粉丝团
            [RouteManager routeForName:RN_Message_FansGroupUserList currentC:self parameters:@{@"anchorId":@(self.groupUid),@"groupId":@(self.msgSendId)}];
            break;
        default:
            break;
    }
}

///家族排行榜
- (void)rankBtnEvent:(BOOL)isFamily{
    if (isFamily) {
        [RouteManager routeForName:RN_center_FamilyRanking currentC:self parameters:@{@"familyId":@(self.msgSendId)}];
    }
}


//送礼物
-(void)sendGift{
    kWeakSelf(self);
    switch (self.chatType) {
        case ConversationChatForSignle:{
            GiftUserModel *userModel = [[GiftUserModel alloc]init];
            userModel.userId = self.otherUserInfoM.userInfo.userId;
            userModel.userName = self.otherUserInfoM.userInfo.username;
            userModel.userIcon = self.otherUserInfoM.userInfo.avatar;
            userModel.roomId = -1;
            [ChoiceGiftView showGift:7 users:@[userModel] hasContinue:NO sendSuccess:^(NSArray<ApiGiftSenderModel *> * _Nonnull giftModelList) {
                [weakself sendGiftSuccess:giftModelList];
            }];
        }break;
        case ConversationChatForFamilyGroup:
        case ConversationChatForSquareGroup:{
            
            [HttpApiChatFamilyController getFamilyUserList:self.msgSendId pageIndex:0 pageSize:200 callback:^(int code, NSString *strMsg, NSArray<AppHomeFamilyUserVOModel *> *arr) {
                if (code == 1) {
                    NSMutableArray *userListArr = [NSMutableArray arrayWithCapacity:arr.count];
                    for (AppHomeFamilyUserVOModel *voModel in arr) {
                        GiftUserModel *userModel = [[GiftUserModel alloc]init];
                        userModel.userId = voModel.userId;
                        userModel.userName = voModel.userName;
                        userModel.userIcon = voModel.userAvatar;
                        if (voModel.userId == self.groupUid) {
                            userModel.isAnchor = YES;
                        }
                        userModel.roomId = self.msgSendId;
                        [userListArr addObject:userModel];
                    }
                    ///显示送礼人
                    [ChoiceGiftView showGift:8 users:userListArr hasContinue:NO sendSuccess:^(NSArray<ApiGiftSenderModel *> * _Nonnull giftModelList) {
                        [weakself sendGiftSuccess:giftModelList];
                    }];
                }else{
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
            }];
            
        }break;
        case ConversationChatForFansGroup:
        {
            [HttpApiAnchorController getFansByGroupId:self.msgSendId callback:^(int code, NSString *strMsg, NSArray<FansInfoModel *> *arr) {
                if (code == 1) {
                    NSMutableArray *userListArr = [NSMutableArray arrayWithCapacity:arr.count];
                    for (FansInfoModel *voModel in arr) {
                        GiftUserModel *userModel = [[GiftUserModel alloc]init];
                        userModel.userId = voModel.userId;
                        userModel.userName = voModel.username;
                        userModel.userIcon = voModel.avatar;
                        if (voModel.userId == self.groupUid) {
                            userModel.isAnchor = YES;
                        }
                        userModel.roomId = self.msgSendId;
                        [userListArr addObject:userModel];
                    }
                    ///显示送礼人
                    [ChoiceGiftView showGift:11 users:userListArr hasContinue:NO sendSuccess:^(NSArray<ApiGiftSenderModel *> * _Nonnull giftModelList) {
                        [weakself sendGiftSuccess:giftModelList];
                    }];
                }else{
                    [SVProgressHUD showInfoWithStatus:strMsg];
                }
            }];
            
        }break;
        default:
            break;
    }
}

- (void)sendGiftSuccess:(NSArray<ApiGiftSenderModel *> *)giftModelList {
    for (ApiGiftSenderModel *giftModel in giftModelList) {
        NSDictionary *param = @{
            @"giftIcon":giftModel.gifticon,
            @"giftCount":[NSString stringWithFormat:@"%d",giftModel.giftNumber],
            @"ownIcon":giftModel.userAvatar,
            @"otherIcon":giftModel.anchorAvatar,
            @"ownUid":@(giftModel.userId),
            @"otherUid":@(giftModel.anchorId),
            @"giftName":giftModel.giftName,};
        [self sendChatMessage:IMMessageTypeForGift andCustomContentDict:param];
    }
}


//守护
-(void)clickChatGuardView{
    [self hideKeyBoard];
    [RouteManager routeForName:RN_center_userGuard currentC:self parameters:@{@"userId":@(KLCUserInfo.getUserId)}];
}


// 隐藏键盘
- (void)hideKeyBoard{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bottomV hideKeyBoard];
    });
}

#pragma mark - ChatMsgInfoDelegate -
- (void)chatMsgInfoScrollForHideKeyBorad:(ChatMsgInfoView *)msgInfoView{
    [self hideKeyBoard];
}

///点击用户信息显示具体操作
- (void)chatMsgInfo:(ChatMsgInfoView *)msgInfoView userInfoHandle:(SendMsgUserInfoObj *)userInfo{
    if (self.chatType == ConversationChatForSignle) {///如果是单聊
        [RouteManager routeForName:RN_user_userInfoVC currentC:self parameters:@{@"id":@(userInfo.userId)}];
    }else{
        [self clickUserIcon:userInfo.userId userName:userInfo.userName userIcon:userInfo.avatar];
    }
}

///消息重发
- (void)chatMsgInfo:(ChatMsgInfoView *)msgInfoView sendMsg:(nonnull NSDictionary *)sendMsg messageType:(IMMessageType)messageType{
    [self sendChatMessage:messageType andCustomContentDict:sendMsg];
}

///求赏礼物
- (void)chatMsgInfo:(ChatMsgInfoView *)msgInfoView sendAskGift:(nonnull MessageAskGiftModel *)askGift userInfo:(nonnull SendMsgUserInfoObj *)userInfo{
    GiftUserModel *userModel = [[GiftUserModel alloc]init];
    userModel.userId = userInfo.userId;
    userModel.userName = userInfo.userName;
    userModel.userIcon = userInfo.avatar;
    if (self.chatType != ConversationChatForSignle) {
        userModel.roomId = self.msgSendId;
    }
    kWeakSelf(self);
    [ChoiceGiftView showGift:7 giftType:askGift.giftType giftId:askGift.giftId users:@[userModel] hasContinue:YES sendSuccess:^(NSArray<ApiGiftSenderModel *> * _Nonnull giftModelList) {
        [weakself sendGiftSuccess:giftModelList];
    }];
}

#pragma mark - ChatMsgBottomViewDelegate -

///功能按钮
- (void)chatMsgBottomView:(ChatMsgBottomView *)bottomView featuresBtnClick:(int64_t)featuresId{
    
    kWeakSelf(self);
    switch (featuresId) {
        case 1:{
            //电话
            NSMutableDictionary *muDict = [[NSMutableDictionary alloc] initWithCapacity:1];
            [muDict setObject:@(self.msgSendId) forKey:@"userId"];
            [muDict setObject:@(NO) forKey:@"isVideo"];
            [RouteManager routeForName:RN_live_LaunchOneLive currentC:self parameters:muDict];
        } break;
        case 2:{
            //视频
            NSMutableDictionary *muDict = [[NSMutableDictionary alloc] initWithCapacity:1];
            [muDict setObject:@(self.msgSendId) forKey:@"userId"];
            [muDict setObject:@(YES) forKey:@"isVideo"];
            [RouteManager routeForName:RN_live_LaunchOneLive currentC:self parameters:muDict];
        } break;
        case 3:{
            //图片
            [self hideKeyBoard];
            [self.messageTool selectPhoto:^(NSString * _Nonnull picUrl, BOOL isOnce) {
                if (isOnce) {
                    [weakself sendChatMessage:IMMessageTypeForShowOncePic andCustomContentDict:@{@"picUrlStr":picUrl}];
                }else{
                    [weakself sendChatMessage:IMMessageTypeForPicture andCustomContentDict:@{@"picUrlStr":picUrl}];
                }
            }];
        }break;
        case 4:
            //礼物
            [self hideKeyBoard];
            [self sendGift];
            break;
        case 5:{
            //心愿单
            [self hideKeyBoard];
            int64_t roomId = -1;
            int64_t touid = -1;
            if (self.chatType == ConversationChatForSignle) {
                roomId = -1;
                touid = self.msgSendId;
            }else{
                roomId = self.msgSendId;
                touid = -1;
            }
            [AddWishView addMineWishAndRoomId:roomId touid:touid hasCover:YES Block:^(NSArray<ApiUsersLiveWishModel *> * _Nonnull wishList) {
                if (wishList.count > 0) {
                    ApiUsersLiveWishModel *wishModel = wishList.firstObject;
                    if (wishModel.uid == self.otherUserInfoM.userInfo.userId || wishModel.uid == [ProjConfig userId]) {
                        weakself.headerV.wishList = wishList;
                    }
                }
            }];
            
        } break;
        case 6:{
            ///红包
            [self hideKeyBoard];
            int64_t touid = 0;
            int64_t groupId = 0;
            int sendType = 0;
            if (self.chatType == ConversationChatForSignle) {
                touid = self.msgSendId;
                groupId = 0;
                sendType = 9;
            }else if (self.chatType == ConversationChatForFansGroup){
                touid = self.groupUid;
                groupId = self.msgSendId;
                sendType = 10;
            }else{
                touid = self.groupUid;
                groupId = self.msgSendId;
                sendType = 8;
            }
            [RedPacketSendView showChatMsgRedPt:touid groupId:groupId sendType:sendType];
        } break;
        case 7:{
            ///私信
            [self hideKeyBoard];
            [OneLiveCheckContactView showContact:self.msgSendId hasBgColor:YES];
            
        } break;
        case 8:{
            ///求赏
            [self hideKeyBoard];
            [AddWishGiftView addWishGift:NO sureTitle:kLocalizationMsg(@"求赏") selectGiftBack:^(NobLiveGiftModel * _Nonnull giftModel, int selectNum) {
                [HttpApiNobLiveGift sendAskForAReward:2 nobGiftId:giftModel.id_field roomId:0 toUserId:self.msgSendId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                    if (code == 1) {
                    }else{
                        [SVProgressHUD showInfoWithStatus:strMsg];
                    }
                }];
            }];
            
        } break;
        default:
            break;
    }
}

///keyboard是否显示
- (void)chatMsgBottomView:(ChatMsgBottomView *)bottomView showKeyBoard:(BOOL)show{
    if (show) {
        [self.chatMsgV scrollMessageBottom];
    }
}

///发送文字
- (void)chatMsgBottomView:(ChatMsgBottomView *)bottomView sendInputText:(nonnull NSString *)inputText isTopMsg:(BOOL)isTopMsg{
    kWeakSelf(self);
    [self keyWordTransform:inputText resultBack:^(NSString *transFormValue) {
        if (isTopMsg) {
            [HttpApiChatMsgController sendFamilyTopMsg:self.msgSendId topMsgContent:transFormValue callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
                if (code == 1) {
                    [weakself sendChatMsg:transFormValue isTopMsg:isTopMsg];
                }else if (code == 7101){  ///余额不足
                    [BalanceLackPromptView gotoRecharge:nil];
                }else{
                    [SVProgressHUD showErrorWithStatus:strMsg];
                }
            }];
        }else{
            [weakself sendChatMsg:transFormValue isTopMsg:isTopMsg];
        }
    }];
}

- (void)sendChatMsg:(NSString *)msgStr isTopMsg:(BOOL)isTopMsg{
    [self sendChatMessage:IMMessageTypeForText andCustomContentDict:@{@"txt":msgStr,@"isTop":kStringFormat(@"%d",isTopMsg)}];
}

///群聊@信息文字
- (void)sendMessageToOtherNoti:(NSString *)inputText andUserArr:(NSArray *)userArr andIsAtAll:(BOOL)isAtAll{
    kWeakSelf(self);
    [self keyWordTransform:inputText resultBack:^(NSString *transFormValue) {
        [weakself sendMessageAtType:transFormValue andUserArr:userArr andIsAtAll:isAtAll];
    }];
}


//发送录音
- (void)chatMsgBottomView:(ChatMsgBottomView *)bottomView sendRecord:(NSString *)recordUrl andTimeStr:(NSString *)timeStr{
    [self sendChatMessage:IMMessageTypeForAudio andCustomContentDict:@{
        @"recordUrl":recordUrl,
        @"time":timeStr}];
}

#pragma mark  - ChatFamilyMsgSocketDelegate -
- (void)chatFamilyMsg:(ChatFamilyMsgSocketTool *)socketTool updateTopUser:(NSString *)topUserIconStr{
    [self.naviV reloadSeatUser:topUserIconStr];
}

- (void)chatFamilyMsg:(ChatFamilyMsgSocketTool *)socketTool userInfoClick:(AppChatFamilyMsgTopVOModel *)topMsg{
    [self clickUserIcon:topMsg.userId userName:topMsg.userName userIcon:topMsg.userAvatar];
}


#pragma mark  - 群聊 -
- (void)getFamilyGroupInfoData{
    kWeakSelf(self);
    [HttpApiChatFamilyController getAppFamilyChatroomInfoVO:self.msgSendId callback:^(int code, NSString *strMsg, AppFamilyChatroomInfoVOModel *model) {
        if (code == 1) {
            
            weakself.groupUid = model.patriarchId;
            [weakself.chatMsgSocketTool showJoinInfo:model];
            
            weakself.naviV.navTitleL.text = model.familyName;
            [weakself.naviV reloadSeatUser:model.contributionFirstAvatar];
            weakself.bottomV.topMsgCoin = model.sendTopMsgCoin;
            [weakself.bottomV setChatOtherUid:model.patriarchId otherRole:0];
            
        }else if(code == 3){
//            weakself.bottomV.userInteractionEnabled = NO;
            weakself.naviV.navTitleL.text = kLocalizationMsg(@"家族已经解散");
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"家族已经解散")];
        }else{
            [weakself.bottomV setChatOtherUid:weakself.msgSendId otherRole:0];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}

#pragma mark  - 粉丝团 -
- (void)getFansGroupInfoData{
    kWeakSelf(self);
    [HttpApiAnchorController liveFansTeamInfoByGroupId:self.msgSendId callback:^(int code, NSString *strMsg, FansInfoDtoModel *model) {
        if (code == 1) {
            
            weakself.groupUid = model.anchorId;
            weakself.naviV.navTitleL.text = model.fansTeamName;
            [weakself.bottomV setChatOtherUid:model.anchorId otherRole:0];
            
        }else{
            [weakself.bottomV setChatOtherUid:weakself.msgSendId otherRole:0];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}

#pragma mark  - 单聊 -
//获取对方信息接口
- (void)getOtherUserInfoData{
    if (self.chatType != 0) {
        return;
    }
    kWeakSelf(self);
    [HttpApiUserController getUserInfoHome:self.msgSendId callback:^(int code, NSString *strMsg, UserInfoHomeVOModel *model) {
        if (code == 1) {
            
            ApiUserInfoModel *userInfo = model.userInfo;
            weakself.naviV.navTitleL.text = userInfo.username;
            [weakself.naviV setUserAtten:model.isAttentionUser];
            weakself.headerV.userInfo = userInfo;
            weakself.otherUserInfoM = model;
            [weakself.bottomV setChatOtherUid:userInfo.userId otherRole:userInfo.role];
            
        }else{
            [weakself.bottomV setChatOtherUid:weakself.msgSendId otherRole:0];
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


// 敏感词过滤
-(void)keyWordTransform:(NSString *)keyWords resultBack:(void(^)(NSString *transFormValue))block{
    [HttpApiMessage keywordTransform:keyWords callback:^(int code, NSString *strMsg, SingleStringModel *model) {
        if (code == 1) {
            if (block) {
                block(model.value);
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


//关注、取消关注
-(void)attentionBtnEvent:(BOOL)isAtten{
    kWeakSelf(self);
    [HttpApiUserController setAtten:isAtten?1:0 touid:self.msgSendId callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.otherUserInfoM.isAttentionUser = isAtten?1:0;
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
        [weakself.naviV setUserAtten:weakself.otherUserInfoM.isAttentionUser];
    }];
}


//开通贵族
-(void)bannerViewTap{
    [RouteManager routeForName:RN_User_buyVIP currentC:self parameters:nil];
}


#pragma mark  - 懒加载 -

- (ChatGiftSocketTool *)giftSocketTool {
    if (!_giftSocketTool) {
        _giftSocketTool = [[ChatGiftSocketTool alloc] init];
    }
    return _giftSocketTool;
}

-(ChatWishSocketTool *)wishSocketTool{
    if (!_wishSocketTool) {
        _wishSocketTool = [[ChatWishSocketTool alloc] init];
        kWeakSelf(self);
        _wishSocketTool.ChatWishListBlock = ^(NSMutableArray<ApiUsersLiveWishModel *> * _Nonnull list) {
            if (list.count > 0) {
                ApiUsersLiveWishModel *wishModel = list.firstObject;
                if (wishModel.uid == self.otherUserInfoM.userInfo.userId || wishModel.uid == [ProjConfig userId]) {
                    weakself.headerV.wishList = list;
                }
            }
        };
    }
    return _wishSocketTool;
}

- (ChatFamilyMsgSocketTool *)chatMsgSocketTool{
    if (!_chatMsgSocketTool) {
        _chatMsgSocketTool = [[ChatFamilyMsgSocketTool alloc] init];
        _chatMsgSocketTool.delegate = self;
    }
    return _chatMsgSocketTool;
}

- (ConversationChatBgView *)chatShowBgView{
    if (!_chatShowBgView) {
        ConversationChatBgView *chatBgView = [[ConversationChatBgView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:chatBgView];
        _chatShowBgView = chatBgView;
    }
    return _chatShowBgView;
}

- (SendIMMessageObj *)sendMessageObj{
    if (!_sendMessageObj) {
        kWeakSelf(self);
        _sendMessageObj = [[SendIMMessageObj alloc] init];
        _sendMessageObj.onReceiveIMMessage = ^(ImMessage * _Nonnull message) {
            [weakself dealReceiveMessage:message];
        };
        _sendMessageObj.onSendIMMessage = ^(ImMessage * _Nonnull message) {
            [SVProgressHUD dismiss];
            [weakself.chatMsgV addShowIMMessage:message];
            [weakself getOtherChatInfo];
        };
        _sendMessageObj.onUpdateIMMessage = ^(IMMessageUpDateType type, NSString * _Nonnull idStr, ImMessage * _Nonnull message) {
            [SVProgressHUD dismiss];
            if (type == IMMessageUpDateTypeForRead) {
                [weakself.chatMsgV readMsg:idStr];
            }else if(type == IMMessageUpDateTypeForRevoke){
                [weakself.chatMsgV revokMsg:idStr];
            }else if(type == IMMessageUpDateTypeForStatus){
                [weakself.chatMsgV updateMySendMsg:message];
            }else{
               // NSLog(@"过滤文字####【IM反馈】####  其他消息状态未处理  == %d"),message.sendStatus);
            }
        };
         
    }
    return _sendMessageObj;
}
 
- (MessageTool *)messageTool{
    if (!_messageTool) {
        _messageTool = [[MessageTool alloc] initWithChatType:self.chatType];
    }
    return _messageTool;
}
- (void)dealReceiveMessage:(ImMessage *)message{
    //如果是群聊且在当前页面
    if (message.tx_message.groupID.length > 0 && [message.tx_message.groupID intValue] != self.msgSendId) {
        return;
    }
    //如果是单聊且在当前页面
    if (message.tx_message.userID.length > 0 && [message.tx_message.userID intValue] != self.msgSendId) {
        return;
    }
    [self.chatMsgV addShowIMMessage:message];
    [self getOtherChatInfo];
    if (message.tx_message.groupID.length == 0) {//阅读某条消息
        [[IMSocketIns getIns] readConversationMsg:message.tx_message.userID isGroup:NO sucess:^{
             
        } fail:^(int code, NSString * _Nonnull desc) {
           // NSLog(@"过滤文字####【IM反馈】####  单聊收到消息阅读失败"));
        }];
    }
}

 
@end

