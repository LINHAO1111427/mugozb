//
//  ChatMsgInfoView.m

//  MessageInfo
//
//  Created by klc_sl on 2021/8/9.
//

#import "ChatMsgInfoView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import "MessageChatModel.h"
#import "ConversationChatCell.h"
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import "MJChatHeader.h"
#import "TimeTool.h"
#import <TXImKit/TXImKit.h>
#import <LibProjView/OpenRedPacketView.h>
#import <LibProjView/OpenRedPacketResultView.h>
#import <LibProjModel/HttpApiChatMsgController.h>
#import <LibProjModel/AppIdBOModel.h>
 
#import <LibProjView/ChoiceGiftView.h>

@interface ChatMsgInfoView () <UITableViewDelegate,UITableViewDataSource,ConversationChatCellDelegate>

@property (nonatomic, weak)ConversationChatCell *chatPlayCell;

@property (nonatomic, weak)UITableView *chatTableView;
///消息列表
@property (nonatomic, strong)NSMutableArray<MessageChatModel *> *msgArray;
///第一条数据
@property (nonatomic, strong)V2TIMMessage *lastMsg;
//当前聊天页面的消息个数
@property (nonatomic, assign)NSInteger rowNum;
///送礼群组消息
@property (nonatomic,assign)int64_t msgSendId;

@property (nonatomic, assign)ConversationChatForType chatType;

///滑动到Y点    --数据缓存（一次行新消息过多，动画效果没完成，不能显示到底部）
@property (nonatomic, assign)CGFloat scrollPointY;

///是否为初始化滑动
@property (nonatomic, assign)BOOL isInitScrollBottom;

@end

@implementation ChatMsgInfoView

- (instancetype)initWithMsgSendId:(int64_t)msgSendId chatType:(ConversationChatForType)chatType
{
    self = [super init];
    if (self) {
        self.msgSendId = msgSendId;
        self.chatType = chatType;
        [self showView];
        self.isInitScrollBottom = NO;
        self.chatTableView.hidden = YES;
        [self getHistoryMessageIsMore:NO];
    }
    return self;
}

- (NSMutableArray *)msgArray{
    if (!_msgArray) {
        _msgArray = [NSMutableArray array];
    }
    return _msgArray;
}


///添加一条新消息
- (void)addShowIMMessage:(ImMessage *)message{
    if (!message) {
        return;
    }
    kWeakSelf(self);
    if (weakself.msgArray.count == 0) {
        weakself.lastMsg = message.tx_message;
    }
    
    [self updateUserInfoList:@[message] resultBlock:^(NSDictionary *extInfoDic) {
        MessageChatModel *mModel = [[MessageChatModel alloc] initWithChatMessage:message.tx_message];
        if (weakself.msgArray.count > 0) {
            MessageChatModel *lastMsg = weakself.msgArray.lastObject;
            mModel.isShowTime = [TimeTool isNewMessageShowTime:mModel.messageTimeDate compareMessageDate:lastMsg.messageTimeDate];
        }else{
            mModel.isShowTime = YES;
        }
        
        [weakself.msgArray addObject:mModel];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.chatTableView reloadData];
            [weakself scrollMsgToScrollBottom:YES animation:YES];
        });
    }];
      
}
- (void)updateUserInfoList:(NSArray<ImMessage *> *)list  resultBlock:(void(^)(NSDictionary *extInfoDic))resultBlock{
    NSMutableArray *groupArr = [[NSMutableArray alloc] init];
    NSMutableArray *userArr = [[NSMutableArray alloc] init];
    for (ImMessage *message in list) {
        if (message.tx_message.elemType == V2TIM_ELEM_TYPE_GROUP_TIPS) {
            V2TIMGroupTipsElem *elem = message.tx_message.groupTipsElem;
            int64_t userId = [elem.memberList.firstObject.userID longLongValue];
            AppIdBOModel *idModel = [[AppIdBOModel alloc]init];
            idModel.id_field = userId;
            [userArr addObject:idModel];
        }
        
        int64_t userId = [message.tx_message.sender longLongValue];
        if (![userArr containsObject:@(userId)]) {
            if (!message.senderUserInfo_updateTime || ((message.senderUserInfo_updateTime && [self judgeTime:message.senderUserInfo_updateTime]))) {
                AppIdBOModel *idModel = [[AppIdBOModel alloc]init];
                idModel.id_field = userId;
                [userArr addObject:idModel];
            }
        }
    }
    
    ///获取用户头像
    if (userArr.count > 0) {
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

- (void)updateMySendMsg:(ImMessage *)message{
    [self.msgArray enumerateObjectsUsingBlock:^(MessageChatModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.imMessage.tx_message.msgID isEqualToString:message.tx_message.msgID]) {
            MessageChatModel *mModel = [[MessageChatModel alloc] initWithChatMessage:message.tx_message];
            mModel.isShowTime = obj.isShowTime;
            [self.msgArray replaceObjectAtIndex:idx withObject:mModel];
            *stop = YES;
        }
    }];
    
    [self.chatTableView reloadData];
    [self scrollMsgToScrollBottom:YES animation:YES];
}
/// 消息被阅读
/// @param userOrGroupId ID
- (void)readMsg:(NSString *)userOrGroupId{
    if ([userOrGroupId intValue] == self.msgSendId) {
        for (MessageChatModel *model in self.msgArray) {
            model.imMessage.msgIsRead = YES;
        }
    }
    [self.chatTableView reloadData];
    [self scrollMsgToScrollBottom:YES animation:YES];
}


/// 消息被撤回
/// @param msgId 消息ID
- (void)revokMsg:(NSString *)msgId{
    for (MessageChatModel *model in self.msgArray) {
        if ([model.imMessage.tx_message.msgID  isEqualToString:msgId]) {
            model.isCancelMsg = YES;
            break;
        }
    }
    [self.chatTableView reloadData];
    [self scrollMsgToScrollBottom:YES animation:YES];
}

///强制滚动到底部
- (void)scrollMessageBottom{
    [self scrollMsgToScrollBottom:NO animation:YES];
}

///新消息是否滚动到最下面
/// @param isNewMsg 是否是新消息
/// @param animation 动画
- (void)scrollMsgToScrollBottom:(BOOL)isNewMsg animation:(BOOL)animation{
    //table数目
    [self layoutIfNeeded];
    [self.chatTableView layoutIfNeeded];
    NSInteger sectionNum = [_chatTableView numberOfSections];
    if (sectionNum<1) return;
    NSInteger rowNum = [_chatTableView numberOfRowsInSection:sectionNum-1];
    if (rowNum <= 1) return;
    // 检查当前是否在最后一行的最后位置 并判断是否是页面无变化回退
    if (!isNewMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //动画滚到最后一个
            [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(rowNum - 1) inSection:sectionNum-1] atScrollPosition:UITableViewScrollPositionBottom animated:animation];
        });
    }else{
        
        UITableViewCell *lastCell = self.chatTableView.visibleCells.lastObject;
        NSIndexPath *lastPath = [self.chatTableView indexPathForCell:lastCell];
//       // NSLog(@"过滤文字========%.3lf====%.3lf=============%.3lf"),self.scrollPointY, self.chatTableView.contentSize.height, (self.chatTableView.contentSize.height-self.chatTableView.frame.size.height));
        if (lastPath.row >= (rowNum-5) || self.scrollPointY > (self.chatTableView.contentSize.height-self.chatTableView.frame.size.height)) {

            self.scrollPointY = [self.chatTableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:rowNum-1 inSection:sectionNum-1]].origin.y;
        
            dispatch_async(dispatch_get_main_queue(), ^{
                //滚到倒数第二个迅速的
//                [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(rowNum - 2) inSection:sectionNum-1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                //动画滚到最后一个
                [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(rowNum - 1) inSection:sectionNum-1] atScrollPosition:UITableViewScrollPositionBottom animated:animation];
            });
        }
    }
}


- (void)stopPlayVoice{
    if (self.chatPlayCell) {
        [self.chatPlayCell stopRotateAnimating];
        self.chatPlayCell.isPlayingVoice = NO;
        self.chatPlayCell = nil;
    }
}


- (void)showView{
    UITableView *chatTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    chatTableView.delegate = self;
    chatTableView.dataSource = self;
    [chatTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    chatTableView.userInteractionEnabled = YES;
    chatTableView.backgroundColor = kRGB_COLOR(@"#FAFAFA");
    if (kiOS11) {
        chatTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        chatTableView.scrollIndicatorInsets = chatTableView.contentInset;
    }
    [chatTableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)]];
    [self addSubview:chatTableView];
    chatTableView.mj_header = [MJChatHeader headerWithRefreshingBlock:^{
        [self getHistoryMessageIsMore:YES];
    }];
    
    [chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.chatTableView = chatTableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isInitScrollBottom) {
        self.isInitScrollBottom = NO;
        if (self.msgArray.count) {
            kWeakSelf(self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.chatTableView numberOfRowsInSection:0]-1) inSection:0];
                [weakself.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                ///先滚动，再延迟显示。
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakself.chatTableView.hidden = NO;
                });
            });
        }else{
            self.chatTableView.hidden = NO;
        }
    }
    return self.msgArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageChatModel *mModel = self.msgArray[indexPath.row];
    return mModel.messageCellHeight + mModel.messageTimeHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConversationChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationChatCellID"];
    if (!cell){
        cell = [[ConversationChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConversationChatCellID"];
    }
    cell.chatType = self.chatType;
    cell.mModel = self.msgArray[indexPath.row];
  
    cell.clickHeaderImageBlock = ^(int64_t uid) {
        [RouteManager routeForName:RN_user_userInfoVC currentC:[ProjConfig currentVC] parameters:@{@"id":@(uid)}];
    };
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    [self hideKeyBoard];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UITableViewCell *lastCell = _chatTableView.visibleCells.lastObject;
    NSIndexPath *lastPath = [_chatTableView indexPathForCell:lastCell];
    self.scrollPointY = [self.chatTableView rectForRowAtIndexPath:lastPath].origin.y;
}

#pragma mark -  ConversationChatCellDelegate
/// 重发消息
- (void)conversationChatCell:(ConversationChatCell *)cell resendMessage:(BOOL)resend {
    if (self.msgDelegate) {
        [self.msgDelegate chatMsgInfo:self sendMsg:cell.mModel.customDict messageType:cell.mModel.messageType];
    }
}

/// 购物消息
- (void)conversationChatCell:(ConversationChatCell *)cell shopChat:(MessageChatModel *)model{
    if (model.shoppingMsg.orderId > 0) {
        int type = 0;
        if (model.shoppingMsg.buyerId == [ProjConfig userId]) {
            type = 0;
        }else if(model.shoppingMsg.sellerId == [ProjConfig userId]){
            type = 1;
        }
        [RouteManager routeForName:RN_Shopping_Order_DetailInfoVC currentC:self.superVC parameters:@{@"id":@(model.shoppingMsg.orderId),@"type":@(type)}];
    }
}

/// 邀请订单
- (void)conversationChatCell:(ConversationChatCell *)cell invitOrder:(InviteOrderModel *)model {
    if (model) {
        [RouteManager routeForName:RN_Seek_InviteInfoVC currentC:self.superVC parameters:@{@"orderId":model.orderId}];
    }
}


// 播放录音
- (void)conversationChatCell:(ConversationChatCell *)cell voicePlayStatus:(BOOL)isPlay {
    if (self.chatPlayCell) {
        if (cell == self.chatPlayCell) {
            cell.isPlayingVoice = !cell.isPlayingVoice;
        }else{
            self.chatPlayCell.isPlayingVoice = NO;
            cell.isPlayingVoice = YES;
        }
    }else{
        cell.isPlayingVoice = YES;
    }
    self.chatPlayCell = cell;
}

///用户信息
- (void)conversationChatCell:(ConversationChatCell *)cell userInfoClick:(SendMsgUserInfoObj *)model{
    if (self.msgDelegate) {
        [self.msgDelegate chatMsgInfo:self userInfoHandle:model];
    }
}

///欢迎
- (void)conversationChatCell:(ConversationChatCell *)cell welcomeUser:(GroupUserJoinFamilyObj *)model {
    if (self.msgDelegate) {
        if (model.userId != [ProjConfig userId]) {
            NSDictionary *param = @{@"txt":kStringFormat(kLocalizationMsg(@"@%@ 欢迎加入大家庭"),model.userName),@"isTop":kStringFormat(@"%d", NO)};
            [self.msgDelegate chatMsgInfo:self sendMsg:param messageType:IMMessageTypeForText];
        }
    }
}
///红包
- (void)conversationChatCell:(ConversationChatCell *)cell redPacket:(MessageRedPacketModel *)model{
    kWeakSelf(self);
    if (model.redPtStatus > 0) {
        [OpenRedPacketResultView showRedPtInfo:model.redPacket.redPacketId resultHandle:^(int openStatus) {
            [weakself changeRedPtStatus:openStatus reloadCell:cell];
        }];
    }else{
        if (model.redPacket.redPacketRange == 2 && model.redPacket.sendUserId == [ProjConfig userId]) {
            [OpenRedPacketResultView showRedPtInfo:model.redPacket.redPacketId resultHandle:^(int openStatus) {
                [weakself changeRedPtStatus:openStatus reloadCell:cell];
            }];
        }else{
            int sendType = 10;
            switch (self.chatType) {
                case ConversationChatForSignle:
                    sendType = 9;
                    break;
                case ConversationChatForFansGroup:
                    sendType = 10;
                    break;
                default:
                    sendType = 8;
                    break;
            }
            [OpenRedPacketView showRedPicket:model.redPacket openType:sendType openHandle:^(int openStatus) {
                [weakself changeRedPtStatus:openStatus reloadCell:cell];
            }];
        }
    }
}

///阅后即焚
- (void)conversationChatCell:(ConversationChatCell *)cell showOncePic:(MessageShowOncePicModel *)model{
    MessageChatModel *chatModel = cell.mModel;
    chatModel.oncePicMsg.readStatus = 1;
    NSDictionary *readStatusDic = @{@"readStatus":@(1)};
    NSData *readdata = [NSJSONSerialization dataWithJSONObject:readStatusDic options:NSJSONWritingPrettyPrinted error:nil];
    chatModel.imMessage.tx_message.localCustomData = readdata;
    cell.mModel = chatModel;
}

///撤回
- (void)conversationChatCell:(ConversationChatCell *)cell cancelMsg:(MessageChatModel *)model{
    kWeakSelf(self);
    [[IMSocketIns getIns] cancelImMsg:model.imMessage.tx_message sucess:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself getHistoryMessageIsMore:NO];
        });
    } fail:^(int code, NSString * _Nonnull desc) {
        [SVProgressHUD showErrorWithStatus:desc];
    }];
}

///求赏送礼
- (void)conversationChatCell:(ConversationChatCell *)cell sendAskGift:(MessageAskGiftModel *)model{
    self.msgDelegate?[self.msgDelegate chatMsgInfo:self sendAskGift:model userInfo:cell.mModel.sendUserInfo]:nil;
}

///删除当前消息
- (void)conversationChatCell:(ConversationChatCell *)cell deleteMsg:(MessageChatModel *)model{
    kWeakSelf(self);
    [[IMSocketIns getIns] deleteOneImMsg:model.imMessage.tx_message sucess:^{
        [weakself.msgArray enumerateObjectsUsingBlock:^(MessageChatModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.imMessage.tx_message.msgID == model.imMessage.tx_message.msgID) {
                if (obj.isShowTime) {
                    NSUInteger nextIdx = idx+1;
                    if (weakself.msgArray.count > nextIdx) {
                        MessageChatModel *nextM = weakself.msgArray[nextIdx];
                        if (idx > 0) {
                            MessageChatModel *beforeM = weakself.msgArray[idx-1];
                            nextM.isShowTime = [TimeTool isNewMessageShowTime:nextM.messageTimeDate compareMessageDate:beforeM.messageTimeDate];
                        }else{
                            nextM.isShowTime = YES;
                        }
                    }
                }
                [weakself.msgArray removeObjectAtIndex:idx];
                *stop = YES;
            }
        }];
        [self.chatTableView reloadData];
    } fail:^(int code, NSString * _Nonnull desc) {
        [SVProgressHUD showErrorWithStatus:desc];
    }];
      
}


#pragma mark - 获取聊天数据
// 获取历史消息
- (void)getHistoryMessageIsMore:(BOOL)isloadMore{
    if (!isloadMore) {
        self.lastMsg = nil;
    }
    BOOL isGroup  = self.chatType > ConversationChatForSignle?YES:NO;
    kWeakSelf(self);
    [[IMSocketIns getIns] getImMsg:30 groupOrUid:self.msgSendId isGroupMsg:isGroup lastMsg:self.lastMsg success:^(NSArray<V2TIMMessage *> * _Nonnull msgs) {
        if (!isloadMore) {
            [weakself.msgArray removeAllObjects];
            weakself.isInitScrollBottom = YES;
        }
         
        if (msgs.count > 0) {
           weakself.lastMsg = msgs.lastObject;
           NSArray *messages = [weakself reverseObject:msgs];
            __block NSMutableArray *dataArray = [NSMutableArray array];
            NSMutableArray *immessageArray = [NSMutableArray array];
            for (V2TIMMessage *message in messages) {
                ImMessage *msg = [[ImMessage alloc]initWith:message];
                [immessageArray addObject:msg];
            }
            //获取用户信息
            [weakself updateUserInfoList:immessageArray resultBlock:^(NSDictionary *extInfoDic) {
                for (ImMessage *msg in immessageArray) {
                    MessageChatModel *model = [[MessageChatModel alloc] initWithChatMessage:msg.tx_message];
                    [dataArray addObject:model];
                }
                [weakself.msgArray insertObjects:dataArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, dataArray.count)]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.chatTableView.mj_header endRefreshing];
                    [weakself reloadTableTo:msgs.count];
                });
                
            }];
             
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.chatTableView.mj_header endRefreshing];
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"没有更多历史数据了")];
                [weakself reloadTableTo:msgs.count];
            });
        }
         
    } fail:^(int code, NSString * _Nonnull desc) {
        [SVProgressHUD showErrorWithStatus:desc];
    }];
      
}
- (void)reloadTableTo:(NSInteger)row{
    [self.chatTableView reloadData];
    ///滚动
    NSIndexPath *ip = [NSIndexPath indexPathForRow:row inSection:0];
    if (ip.row < self.msgArray.count) {
        [self.chatTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

///消息数据倒叙
- (NSArray<V2TIMMessage *> *)reverseObject:(NSArray<V2TIMMessage *> *)sortArr{
    if ([sortArr isKindOfClass:[NSNull class]] || sortArr.count == 0) {
        return @[];
    }
    NSArray *resultArr = [[sortArr reverseObjectEnumerator] allObjects];
    return resultArr;
}


#pragma mark - handle -
///隐藏键盘
- (void)hideKeyBoard{
    if (self.msgDelegate) {
        [self.msgDelegate chatMsgInfoScrollForHideKeyBorad:self];
    }
}

///变更红包信息
- (void)changeRedPtStatus:(int)status reloadCell:(ConversationChatCell *)cell{
    MessageChatModel *chatModel = cell.mModel;
    chatModel.redPacketMsg.redPtStatus = status;
    NSDictionary *redStatusDic = @{@"redPtStatus":@(status)};
    NSData *redPdata = [NSJSONSerialization dataWithJSONObject:redStatusDic options:NSJSONWritingPrettyPrinted error:nil];
    chatModel.imMessage.tx_message.localCustomData = redPdata;
    cell.mModel = chatModel;
}


///判断时间和现在时间是否想查两个小时
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
