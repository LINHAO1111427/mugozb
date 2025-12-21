//
//  MessageChatListVC.m
//  Message
//
//  Created by klc_tqd on 2020/5/9.
//  Copyright © 2020 . All rights reserved.
//

#import "MessageChatListVC.h"

#import "MessageChatLisCell.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/ZGQActionSheetView.h>
#import <LibProjView/EmptyView.h>
#import <LibProjModel/AppIdBOModel.h>
#import <LibProjModel/HttpApiMessage.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/AppUserAvatarModel.h>
 
 
#import <MJRefresh/MJRefresh.h>
#import <LibProjView/IMMessageObserver.h>
#import <LibProjModel/HttpApiChatMsgController.h>
#import <LibProjModel/ImExtraInfoModel.h>
#import <LibProjModel/UserGroupIdDtoModel.h>

#import "MessageChatFuncCell.h"
#import "MessageChatModel.h"
#import <LibProjModel/HttpApiChatFamilyController.h>
#import "MessageNoReadSocketTool.h"


@interface MessageChatListVC ()<UITableViewDelegate,UITableViewDataSource,IMObserverDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSArray <MessageChatModel *>*dataArray;
@property (nonatomic, strong)NSMutableDictionary *dataDic;

@property (nonatomic, strong)NSDictionary<NSString *, AppUserAvatarModel *> *userInfoDict;

@property (nonatomic, assign)int64_t nextSeq;

@property (nonatomic, weak)EmptyView *emptyV;

@property (nonatomic, assign)BOOL noFamily;  ///没有家族

@property (nonatomic, weak)MessageChatFuncCell *squareCell;
///广场总人数
@property (nonatomic, assign)int squareUserNum;

@end


@implementation MessageChatListVC

- (void)dealloc
{
    
    [IMMessageObserver removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [IMMessageObserver addDelegate:self];
    self.nextSeq = 0;
    [self createSubView];
    kWeakSelf(self);
    [MessageNoReadSocketTool share].reloadMsgListBlock = ^{
        [weakself getMsgListData:self.nextSeq];
    };
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getMsgListData:self.nextSeq];
    
}


-(void)createSubView{
    
    if (self.isFullScreen) {
        self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = kSafeAreaBottom;
    }
    
    [self.tableView registerClass:[MessageChatLisCell class] forCellReuseIdentifier:@"MessageChatLisCellID"];
    [self.tableView registerClass:[MessageChatFuncCell class] forCellReuseIdentifier:@"MessageChatFuncCellID"];
    
    //    EmptyView *empty = [[EmptyView alloc] init];
    //    empty.titleL.text = kLocalizationMsg(@"暂无消息哦"));
    //    [empty showInView:self.view andFrame:CGRectMake(0, 0, self.view.width, self.view.height - 100)];
    //    _emptyV = empty;
    
}

- (void)deleteAllConversations{
    kWeakSelf(self);
    [HttpApiMessage clearNoticeMsg:-1 type:0 callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            NSMutableArray *list = [NSMutableArray array];
            for (MessageChatModel *model in self.dataArray) {
                [list addObject:model.conversationID];
            }
            if (list.count == 0) {
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"没有任何会话哦~")];
                return;
            }
            [[IMSocketIns getIns] deleteAllConversation:list sucess:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakself.nextSeq = 0;
                    [weakself getMsgListData:weakself.nextSeq];
                });
            } fail:^(int code, NSString * _Nonnull desc) {
                [SVProgressHUD showInfoWithStatus:desc];
            }];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUpdateStatus object:@{}];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"忽略未读消息失败了~")];
        }
    }];
}
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section) {
        return self.dataArray.count;
    }else{
        if ([[ProjConfig shareInstence].baseConfig hasFamilyGroup]) {
            if (self.noFamily) {
                return 2;
            }else{
                return 1;
            }
        }else{
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ///1家族  2广场
        MessageChatFuncCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageChatFuncCellID" forIndexPath:indexPath];
        if (self.noFamily && indexPath.row == 0) {
            [cell showFuncType:1 userNumber:0];
        }else{
            [cell showFuncType:2 userNumber:self.squareUserNum];
            self.squareCell = cell;
        }
        return cell;
    }else{
        MessageChatLisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageChatLisCellID" forIndexPath:indexPath];
        if (self.dataArray.count > indexPath.row) {
            MessageChatModel *messageModel = self.dataArray[indexPath.row];
            [cell showUserInfo:messageModel];
            kWeakSelf(self);
            cell.cellLongTapBlock = ^{
                [weakself cellLongTabEvent:messageModel];
            };
        }
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (self.noFamily && indexPath.row == 0) { ///家族首页
            [RouteManager routeForName:RN_Family_CommentListVC currentC:self];
        }else{ ///广场
            [RouteManager routeForName:RN_Message_MsgSquareList currentC:self];
        }
    }else{
        if (self.dataArray.count > indexPath.row) {
            MessageChatModel *mModel = self.dataArray[indexPath.row];
            if (mModel.isGroupMsg) {
                [RouteManager routeForName:RN_Message_ConversationChatVC currentC:self parameters:@{@"chatType":mModel.groupMsg.groupType?@"3":@"1",@"msgSendId":@(mModel.groupMsg.groupId)}];
            }else{
                [RouteManager routeForName:RN_Message_ConversationChatVC currentC:self parameters:@{@"chatType":@"0",@"msgSendId":@(mModel.singleMsg.otherUid)}];
            }
        }
    }
}


//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self.view);
        }];
    }
    return _tableView;
}
- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
- (NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}
 

- (void)getMyFamilyInfo{
    kWeakSelf(self);
    [HttpApiChatFamilyController getMyChatFamilyInfoVO:^(int code, NSString *strMsg, AppHomeMyAllFamilyVOModel *model) {
        if (code == 1) {
            if (model.appHomeMyFamilyVOList.count > 0) {
                weakself.noFamily = NO;
            }else{
                weakself.noFamily = YES;
            }
            [weakself.tableView reloadData];
        }
    }];
}

- (void)getSquareUserNum{
    kWeakSelf(self);
    [HttpApiChatFamilyController getChatPlazaTotalNumber:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            weakself.squareUserNum = [model.no_use intValue];
            [weakself.tableView reloadData];
        }
    }];
}

- (void)getMsgListData:(uint64_t)data_nextSeq{
    if ([[ProjConfig shareInstence].baseConfig hasFamilyGroup]) {
        [self getMyFamilyInfo];
    }
    
    [self getSquareUserNum];
    kWeakSelf(self);
    
    [[IMSocketIns getIns]  getConversationList:500 idLessThan:data_nextSeq success:^(NSArray<V2TIMConversation *> * _Nonnull list, uint64_t nextSeq, BOOL isFinished) {
       
        if (data_nextSeq == 0) {
            [weakself.dataDic removeAllObjects];
        }
        if (isFinished) {
            weakself.nextSeq = 0;
            [weakself onConversationChanged:list];
        }else{
            [weakself getMsgListData:nextSeq];
        }
          
    } fail:^(int code, NSString * _Nonnull desc) {
        [SVProgressHUD showErrorWithStatus:desc];
    }];
    
}
 
- (void)updateUserInfoList:(NSArray<ImMessage *> *)list  resultBlock:(void(^)(NSDictionary *extInfoDic))resultBlock{
    NSMutableArray *groupArr = [[NSMutableArray alloc] init];
    NSMutableArray *userArr = [[NSMutableArray alloc] init];
    for (ImMessage *message in list) {
        if (message.tx_message.elemType == V2TIM_ELEM_TYPE_GROUP_TIPS) {
            V2TIMGroupTipsElem *elem = message.tx_message.groupTipsElem;
            int64_t userId = [elem.memberList.firstObject.userID longLongValue];
            AppIdBOModel *idmodel = [[AppIdBOModel alloc]init];
            idmodel.id_field = userId;
            [userArr addObject:idmodel];
        }
        
        if (message.tx_message.groupID.length > 0 ) {
            int64_t groupId = [message.tx_message.groupID longLongValue];
            if (![groupArr containsObject:@(groupId)] && groupId > 0) {
                if (!message.userInfo_updateTime || ((message.userInfo_updateTime && [self judgeTime:message.userInfo_updateTime]))) {
                    AppIdBOModel *idmodel = [[AppIdBOModel alloc]init];
                    idmodel.id_field = groupId;
                    [groupArr addObject:idmodel];
                }
            }
        }else{
            int64_t userId = [message.tx_message.userID longLongValue];
            if (![userArr containsObject:@(userId)] && userId > 0) {
                if (!message.userInfo_updateTime || ((message.userInfo_updateTime && [self judgeTime:message.userInfo_updateTime]))) {
                    AppIdBOModel *idmodel = [[AppIdBOModel alloc]init];
                    idmodel.id_field = userId;
                    [userArr addObject:idmodel];
                }
            }
        }
        
    }
    
    ///获取用户头像
    if (groupArr.count > 0 || userArr.count > 0) {
        UserGroupIdDtoModel *model = [[UserGroupIdDtoModel alloc]init];
        model.groupIdList = groupArr;
        model.userIdList = userArr;
        [HttpApiChatMsgController getImExtraInfo1:model callback:^(int code, NSString *strMsg, NSArray<ImExtraInfoModel *> *arr) {
            if (code == 1 && arr.count) {
                NSMutableDictionary *extInfoDic = [[NSMutableDictionary alloc] init];
                for (ImExtraInfoModel *userInfoM in arr) {
                    if (userInfoM.name.length || userInfoM.avatar.length) {
                        NSDictionary *dict = [userInfoM modelToJSONObject];
                        [extInfoDic setObject:dict forKey:@(userInfoM.UGID)];
                        [[IMSocketIns getIns] setExtraInfo:userInfoM.UGID ditExtraInfo:dict];
                    }
                }
                resultBlock?resultBlock([extInfoDic copy]):nil;
            }else{
                resultBlock?resultBlock(@{}):nil;
            }
        }];
        
    }else{
        resultBlock?resultBlock(@{} ):nil;
    }
    
}

///设置或取消用户置顶消息
- (void)setUserTopInfo:(BOOL)isTop chatModel:(MessageChatModel *)chatModel{
    kWeakSelf(self);
    int64_t topUserOrGorupId = -1;
    if (chatModel.isGroupMsg) {
        topUserOrGorupId = [chatModel.imMessage.tx_message.groupID intValue];
    }else{
        topUserOrGorupId = [chatModel.imMessage.tx_message.userID intValue];
    }
    [[IMSocketIns getIns] putTopCoversation:chatModel.conversationID isPinned:isTop succ:^{
        [weakself getMsgListData:weakself.nextSeq];
    } fail:^(int code, NSString * _Nonnull desc) {
        [SVProgressHUD showInfoWithStatus:desc];
    }];
}



- (void)updateChatMsg{
    [self getMsgListData:self.nextSeq];
}


- (UIView *)listView {
    return self.view;
}


#pragma mark IImHander
//会话有变 新会话或者会话更新
- (void)onConversationChanged:(NSArray<V2TIMConversation *> *)conversationList {
    NSMutableArray *arr = [NSMutableArray array];
    for (V2TIMConversation *conversation in conversationList) {
        ImMessage *message = [[ImMessage alloc]initWith:conversation.lastMessage];
        [arr addObject:message];
    }
    //更新用户信息
    [self updateUserInfoList:arr resultBlock:^(NSDictionary *extInfoDic) {
        for (V2TIMConversation *conv in conversationList) {
            MessageChatModel *chatModel = [[MessageChatModel alloc] initWithChatMessage:conv.lastMessage];
            chatModel.unReadNum = conv.unreadCount;
            chatModel.isTop = conv.isPinned;
            chatModel.conversationID = conv.conversationID;
            chatModel.orderKey = conv.orderKey;
            [self.dataDic setObject:chatModel forKey:conv.conversationID];
        }
        NSMutableArray *newDataList = [NSMutableArray arrayWithArray:self.dataDic.allValues];
        //排序reload
        [self sortDataList:newDataList];
        self.dataArray = newDataList;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)sortDataList:(NSMutableArray<MessageChatModel *> *)dataList{
    [dataList sortUsingComparator:^NSComparisonResult(MessageChatModel *obj1, MessageChatModel *obj2) {
        return obj1.orderKey < obj2.orderKey;
    }];
}
 

-(void)cellLongTabEvent:(MessageChatModel *)msgModel{
    
    
    NSMutableArray *optionArray = [[NSMutableArray alloc] init];
    if (msgModel.isTop) {
        [optionArray addObject:@{@"type":@(2),@"title":kLocalizationMsg(@"取消置顶")}];
    }else{
        [optionArray addObject:@{@"type":@(1),@"title":kLocalizationMsg(@"置顶")}];
    }
    if (!msgModel.isGroupMsg) {
        [optionArray addObject:@{@"type":@(3),@"title":kLocalizationMsg(@"备注")}];
    }
    [optionArray addObject:@{@"type":@(4),@"title":kLocalizationMsg(@"已读")}];
    [optionArray addObject:@{@"type":@(5),@"title":kLocalizationMsg(@"删除")}];
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in optionArray) {
        [titles addObject:dic[@"title"]];
    }
    
    NSString *msgId;
    if (msgModel.isGroupMsg) {
        msgId = msgModel.imMessage.tx_message.groupID;
    }else{
        msgId = msgModel.imMessage.tx_message.userID;
    }
    kWeakSelf(self);
    ZGQActionSheetView *sheetView = [[ZGQActionSheetView alloc] initWithOptions:titles completion:^(NSInteger index) {
        
        NSDictionary *subDic = optionArray[index];
        switch ([subDic[@"type"] intValue]) {
                
            case 1:///置顶
            {
                [self setUserTopInfo:YES chatModel:msgModel];
            }
                break;
            case 2: ///取消置顶
            {
                [self setUserTopInfo:NO chatModel:msgModel];
            }
                break;
            case 3: ///备注
            {
                [RouteManager routeForName:RN_user_setUserRemark currentC:self parameters:@{@"id":msgModel.imMessage.tx_message.userID,@"remark":msgModel.showName.length > 0?msgModel.showName:@""}];
            }
                break;
            case 4: ///已读
            {
                [[IMSocketIns getIns]  readConversationMsg:msgId isGroup:msgModel.isGroupMsg sucess:^{
                    [weakself getMsgListData:weakself.nextSeq];
                } fail:^(int code, NSString * _Nonnull desc) {
                   // NSLog(@"过滤文字####【IM反馈】#### 阅读某条会话失败"));
                }];
            }
                
                break;
            case 5: ///删除
            {
                [[IMSocketIns getIns] deleteCoversation:msgModel.conversationID sucess:^{
                    [weakself getMsgListData:weakself.nextSeq];
                } fail:^(int code, NSString * _Nonnull desc) {
                   // NSLog(@"过滤文字####【IM反馈】#### 删除某条会话失败"));
                }];
            }
                
                break;
            default:
                break;
        }
    } cancel:^{
       // NSLog(@"过滤文字取消"));
    }];
    [sheetView show];
}


///判断时间和现在时间是否相差半个小时
- (BOOL)judgeTime:(NSDate *)updateDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    // NSCalendarUnit 枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:updateDate toDate:currentDate options:0];
    if (!cmps.year && !cmps.month && !cmps.day && !cmps.hour) {
        if (cmps.minute<30) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

@end
