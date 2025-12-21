//
//  ChatBottomView.m
//  Message
//
//  Created by klc_tqd on 2020/5/11.
//  Copyright © 2020 . All rights reserved.
//

#import "ChatBottomView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiChatRoomController.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/AppCommonWordsModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/ApiUserInfoLoginModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>
#import "SquareGroupMsgMemberVC.h"

#define kATRegular @"@[\\u4e00-\\u9fa5\\w\\-\\_]+ "

@interface ChatBottomView ()<UITextViewDelegate>

@property(nonatomic, strong)UIView *featuresView;

@property(nonatomic, strong)NSMutableArray *targetNameArray;

@property(nonatomic, assign)BOOL isAtAll;

@property (nonatomic, assign)BOOL pushControl;  ///跳转到下一个页面控制

@property (nonatomic, assign)ConversationChatForType chatType;

@end


@implementation ChatBottomView

- (instancetype)initWithFrame:(CGRect)frame chatType:(ConversationChatForType)chatType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.chatType = chatType;
        [self creatSubview];
    }
    return self;
}

-(void)creatSubview{
    
    UIView *chatView = [[UIView alloc] initWithFrame:CGRectMake(30, 4, kScreenWidth - 60, 40)];
    chatView.layer.cornerRadius = 20;
    chatView.backgroundColor =  kRGB_COLOR(@"#FAFAFA");
    chatView.layer.masksToBounds = YES;
    chatView.layer.borderColor = kRGBA(221, 221, 221, 1).CGColor;
    chatView.layer.borderWidth = 1;
    [self addSubview:chatView];
    
    ///切换表情包按钮
    CGFloat pointX = 12;
    
    UIButton *faceBtn = [[UIButton alloc] initWithFrame:CGRectMake(chatView.width-30-pointX, 5, 30, 30)];
    [chatView addSubview:faceBtn];
    [faceBtn setImage:[UIImage imageNamed:@"message_liaotian_biaoqing"] forState:UIControlStateNormal];
    faceBtn.selected = NO;
    [faceBtn addTarget:self action:@selector(clickFaceBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.faceBtn = faceBtn;
    
    
    if (self.chatType == ConversationChatForFamilyGroup || self.chatType == ConversationChatForSquareGroup) {
        UIButton *topBtn = [UIButton buttonWithType:0];
        [topBtn setImage:[UIImage imageNamed:@"message_liaotian_topclose"] forState:UIControlStateNormal];
        [topBtn setImage:[UIImage imageNamed:@"message_liaotian_topopen"] forState:UIControlStateSelected];
        topBtn.frame = CGRectMake(2, 2, 36*(82/50.0), 36);
        [topBtn addTarget:self action:@selector(topTextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [chatView addSubview:topBtn];
        pointX = topBtn.maxX+5;
    }
    
    UITextView *chatTextView = [[UITextView alloc] initWithFrame:CGRectMake(pointX, 3, faceBtn.x-pointX, 34)];
    chatTextView.font = [UIFont systemFontOfSize:15];
    chatTextView.backgroundColor = [UIColor clearColor];
    chatTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    chatTextView.delegate = self;
    chatTextView.returnKeyType = UIReturnKeySend;
    chatTextView.placeholder = kLocalizationMsg(@"输入新消息");
    chatTextView.placeholderColor = kRGB_COLOR(@"#cccccc");
    [chatView addSubview:chatTextView];
    self.chatTextView = chatTextView;
    
    self.featuresView = [[UIView alloc] initWithFrame:CGRectMake(0, chatView.maxY, kScreenWidth, 50)];
    [self addSubview:self.featuresView];
    
    self.isAtAll = NO;
}

- (void)topTextBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.isTopMsg = btn.selected;
    self.chatTextView.placeholder = self.isTopMsg?[NSString stringWithFormat:kLocalizationMsg(@"置顶消息：%.0lf%@/每条"),self.topMsgCoin,kUnitStr]:kLocalizationMsg(@"输入新消息");
}

- (void)setTopMsgCoin:(double)topMsgCoin{
    _topMsgCoin = topMsgCoin;
    self.chatTextView.placeholder = self.isTopMsg?[NSString stringWithFormat:kLocalizationMsg(@"置顶消息：%.0lf%@/每条"),self.topMsgCoin,kUnitStr]:kLocalizationMsg(@"输入新消息");
}


- (void)setChatOtherUid:(int64_t)otherUid otherRole:(int)otherRole{

    ///0:音频 1.1v1视频 2.1v1电话 3.图片 4.礼物 5.心愿单 6.红包
    NSMutableArray *btnArr = [NSMutableArray array];
    switch (self.chatType) {
        case ConversationChatForSignle:
        {
            NSArray *bottomBtnArr = [[ProjConfig shareInstence].businessConfig getSingleChatFuncTypeArray];
            AdminLiveConfigModel *configModel = [KLCAppConfig appConfig].adminLiveConfig;
           
            ///0:音频 1.1v1视频 2.1v1电话 3.图片 4.礼物 5.心愿单 6.红包
            for (NSDictionary *dict in bottomBtnArr) {
                int typeId = [dict[@"id"] intValue];
                ///我主播&对方主播
                if (KLCUserInfo.getRole == 1 && otherRole == 1) {
                    if (typeId == 0 || typeId == 3 || typeId == 4 || typeId == 6|| typeId == 7) {
                        [btnArr addObject:dict];
                    }
                    if (configModel.anchorToAnchor == 0) {
                        if (typeId == 1|| typeId == 2) {
                            [btnArr addObject:dict];
                        }
                    }
                ///我用户&对方用户
                }else if(KLCUserInfo.getRole == 0 && otherRole == 0){
                    if (typeId == 0 || typeId == 3 || typeId == 4 || typeId == 6 || typeId == 7) {
                        [btnArr addObject:dict];
                    }
                    if (configModel.userToUser == 0) {
                        if (typeId == 1|| typeId == 2) {
                            [btnArr addObject:dict];
                        }
                    }
                ///我主播&对方用户
                }else if(KLCUserInfo.getRole == 1 && otherRole == 0){
                    if (typeId == 0 || typeId == 1|| typeId == 2 || typeId == 3 || typeId == 5 || typeId == 6 || typeId == 7 || typeId == 8) {
                        [btnArr addObject:dict];
                    }
                ///其他
                }else{
                    if (typeId == 0 || typeId == 1|| typeId == 2 || typeId == 3 || typeId == 4 || typeId == 6 || typeId == 7) {
                        [btnArr addObject:dict];
                    }
                }
            }
            [self creatFeaturesBtn:btnArr];
        }
            break;
        case ConversationChatForFansGroup:
        {
            NSArray *bottomBtnArr = [[ProjConfig shareInstence].businessConfig getGroupChatFuncTypeArray];

            for (NSDictionary *dict in bottomBtnArr) {
                int typeId = [dict[@"id"] intValue];
                ///群组族长 = 自己
                if (otherUid == [ProjConfig userId]) {
                    if (typeId == 0 || typeId == 3|| typeId == 4 || typeId == 6) {
                        [btnArr addObject:dict];
                    }
                }else{
                    if (typeId == 0 || typeId == 3|| typeId == 4 || typeId == 6) {
                        [btnArr addObject:dict];
                    }
                }
            }
            
            [self creatFeaturesBtn:btnArr];
        }
            break;
        default:
        {
            NSArray *bottomBtnArr = [[ProjConfig shareInstence].businessConfig getGroupChatFuncTypeArray];

            for (NSDictionary *dict in bottomBtnArr) {
                int typeId = [dict[@"id"] intValue];
                ///群组族长 = 自己
                if (otherUid == [ProjConfig userId]) {
                    if (typeId == 0 || typeId == 3|| typeId == 4 || typeId == 6) {
                        [btnArr addObject:dict];
                    }
                }else{
                    if (typeId == 0 || typeId == 3|| typeId == 4 || typeId == 6) {
                        [btnArr addObject:dict];
                    }
                }
            }
            
            [self creatFeaturesBtn:btnArr];
        }
            break;
    }
}


///获的聊天底部功能按钮
-(void)creatFeaturesBtn:(NSArray *)featuresArr{
    [self.featuresView removeAllSubViews];
    CGFloat width = 40;
    CGFloat magin = (kScreenWidth - featuresArr.count*width)/(featuresArr.count+1);
    CGFloat x = magin;
    for (int i = 0; i < featuresArr.count; i++) {
        NSDictionary *dict = featuresArr[i];
        UIButton *featuresBtn  = [[UIButton alloc]initWithFrame:CGRectMake(x, (self.featuresView.height-width)/2.0, width , width)];
        x += magin+width;
        featuresBtn.tag = [dict[@"id"] intValue];
        [featuresBtn setImage:[UIImage imageNamed:dict[@"image"]] forState:UIControlStateNormal];
        [featuresBtn setContentEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
        [featuresBtn addTarget:self action:@selector(featuresBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.featuresView addSubview:featuresBtn];
    }
}



-(void)clickFaceBtn:(UIButton *)sender{
    self.faceBtn.selected = !self.faceBtn.selected;
    if (self.faceBtn.selected) {
        [self.faceBtn setImage:[UIImage imageNamed:@"chat_change_keyboard"] forState:UIControlStateNormal];
    }else{
        [self.faceBtn setImage:[UIImage imageNamed:@"message_liaotian_biaoqing"] forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(clickFaceBtn:)]) {
        [self.delegate clickFaceBtn:sender];
    }
}

-(void)clickSendBtn{
   // NSLog(@"过滤文字发送"));
    
    if (kStringIsEmpty(self.chatTextView.text)) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"发送的消息不能为空")];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(sendMessageToOther:)]) {
        [self.delegate sendMessageToOther:self.chatTextView.text];
        self.chatTextView.text = @"";
    }
}


-(void)featuresBtnClick:(UIButton *)sender{
   // NSLog(@"过滤文字功能%ld"),(long)sender.tag);
    if ([self.delegate respondsToSelector:@selector(featuresBtnClick:)]) {
        [self.delegate featuresBtnClick:sender.tag];
    }
}

//-(void)addUserNotice:(JMSGUser *)user andIsAtAll:(BOOL)isAtAll{
//    self.isAtAll = isAtAll;
//    if (!self.isAtAll) {
//        [self.targetNameArray addObject:user];
//    }
//}


-(void)sendTextMessage{
    [self sendContentMessage];
}


-(void)seleGroupMember{
    return;
    if (self.pushControl == YES) {
        return;
    }
    self.pushControl = YES;
    SquareGroupMsgMemberVC *listVc = [[SquareGroupMsgMemberVC alloc] init];
    listVc.groupId = self.groupId;
    kWeakSelf(self);
//    listVc.seleGroupMemberBlock = ^(JMSGUser * _Nonnull user, BOOL isAll) {
//        weakself.pushControl = NO;
//        NSString *nicknameStr = user.nickname;
//        if (kStringIsEmpty(user.nickname)) {
//            nicknameStr = user.username;
//        }
//        if (isAll) {
//            [weakself.chatTextView insertText:[NSString stringWithFormat:@"%@ ",@"all"]];
//        }else{
//            [weakself.chatTextView insertText:[NSString stringWithFormat:@"%@ ",nicknameStr]];
//        }
////        [weakself addUserNotice:user andIsAtAll:isAll];
//    };

    [[ProjConfig currentVC].navigationController pushViewController:listVc animated:YES];
}

///发送私信
-(void)sendContentMessage{
    if (self.isAtAll && self.chatType != ConversationChatForSignle) {
        NSMutableString *string = [NSMutableString stringWithString:self.chatTextView.text];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kATRegular options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *matches = [regex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, [string length])];
        
        if (matches.count > 0 && [self.chatTextView.text rangeOfString:@"@all "].location != NSNotFound) {
            if ([self.delegate respondsToSelector:@selector(sendMessageToOtherNoti:andUserArr:andIsAtAll:)]) {
                [self.delegate sendMessageToOtherNoti:self.chatTextView.text andUserArr:@[] andIsAtAll:YES];
                self.chatTextView.text = @"";
                [self.targetNameArray removeAllObjects];
                self.isAtAll  = NO;
            }
        }else{
            if ([self.delegate respondsToSelector:@selector(sendMessageToOther:)]) {
                [self.delegate sendMessageToOther:self.chatTextView.text];
                self.chatTextView.text = @"";
                [self.targetNameArray removeAllObjects];
                self.isAtAll  = NO;
            }
            
        }
        
    }else if (self.chatType != ConversationChatForSignle && self.targetNameArray.count>0) {
        
        NSMutableString *string = [NSMutableString stringWithString:self.chatTextView.text];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kATRegular options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *matches = [regex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, [string length])];
        if (matches.count > 0) {
            NSMutableArray *mutArr = [NSMutableArray array];
            for (int i=0; i< self.targetNameArray.count; i++) {
//                JMSGUser *user = self.targetNameArray[i];
//                NSString *userStr = [NSString stringWithFormat:@"@%@ ",user.nickname];
//                if ([self.chatTextView.text rangeOfString:userStr].location != NSNotFound) {
//                    [mutArr addObject:user];
//                }
            }
            
            if (mutArr.count > 0) {
                if ([self.delegate respondsToSelector:@selector(sendMessageToOtherNoti:andUserArr:andIsAtAll:)]) {
                    [self.delegate sendMessageToOtherNoti:self.chatTextView.text andUserArr:mutArr andIsAtAll:NO];
                    self.chatTextView.text = @"";
                    [self.targetNameArray removeAllObjects];
                }
            }else{
                [self.targetNameArray removeAllObjects];
                if ([self.delegate respondsToSelector:@selector(sendMessageToOther:)]) {
                    [self.delegate sendMessageToOther:self.chatTextView.text];
                    self.chatTextView.text = @"";
                }
            }
            
        }else{
            [self.targetNameArray removeAllObjects];
            if ([self.delegate respondsToSelector:@selector(sendMessageToOther:)]) {
                [self.delegate sendMessageToOther:self.chatTextView.text];
                self.chatTextView.text = @"";
            }
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(sendMessageToOther:)]) {
            [self.delegate sendMessageToOther:self.chatTextView.text];
            self.chatTextView.text = @"";
        }
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (textView == self.chatTextView) {
        if ([self.delegate respondsToSelector:@selector(keyBoardWillShow:)]) {
            [self.delegate keyBoardWillShow:NO];
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.chatType != ConversationChatForSignle && textView.text.length > 0) {
        NSString *lastStr = [textView.text substringFromIndex:textView.text.length-1];
        if ([lastStr isEqualToString:@"@"]) {
           // NSLog(@"过滤文字@事件"));
            [self seleGroupMember];
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //[textView endEditing:YES];
        //在这里做你响应return键的代码
       // NSLog(@"过滤文字发送"));
        if (kStringIsEmpty(self.chatTextView.text)) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"发送的消息不能为空")];
            return NO;
        }
        
        [self sendContentMessage];
        
        
        return NO;
    }
    if ([text isEqualToString:@""] && textView.text.length > 0) {
        NSString *lastStr = [textView.text substringFromIndex:textView.text.length-1];
        if ([lastStr isEqualToString:@"]"]) {
            for (NSInteger j = textView.text.length; j>1; j--) {
                //对应的字符串
                NSString *correStr = [textView.text substringWithRange:NSMakeRange(j-2, 1)];
                if ([correStr isEqualToString:@"["]) {
                    textView.text = [textView.text substringToIndex:j-2];
                    return NO;
                }
            }
        }
    }
    if ([text isEqualToString:@""]){
        
        // 判断删除的是一个@中间的字符就整体删除
        NSMutableString *string = [NSMutableString stringWithString:textView.text];
        //        NSArray *matches = [self getMatchsWithStr:string];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kATRegular options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *matches = [regex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, [string length])];
        
        
        BOOL inAt = NO;
        NSInteger index = range.location;
        for (NSTextCheckingResult *match in matches)
        {
            NSRange newRange = NSMakeRange(match.range.location + 1, match.range.length - 1);
            if (NSLocationInRange(range.location, newRange))
            {
                inAt = YES;
                index = match.range.location;
                [textView.textStorage replaceCharactersInRange:match.range withString:@""];
                textView.selectedRange = NSMakeRange(index, 0);
                //                [self textViewDidChange:textView];
                return NO;
                break;
            }
        }
        if (inAt)
        {
            textView.text = string;
            textView.selectedRange = NSMakeRange(index, 0);
            return NO;
        }
    }
    
    return YES;
}



- (void)textViewDidChangeSelection:(UITextView *)textView {
    // 光标不能点落在@词中间
    NSRange range = textView.selectedRange;
    if (range.length > 0)
    {
        // 选择文本时可以
        return;
    }
    
    //    NSArray *matches = [self getMatchsWithStr:textView.text];
    //
    //    for (NSTextCheckingResult *match in matches)
    //    {
    //        NSRange newRange = NSMakeRange(match.range.location + 1, match.range.length - 1);
    //        if (NSLocationInRange(range.location, newRange))
    //        {
    //            if (range.location == match.range.location + 1) {
    //                textView.selectedRange = NSMakeRange(match.range.location + match.range.length, 0);
    //            } else {
    //                textView.selectedRange = NSMakeRange(match.range.location , 0);
    //            }
    //            break;
    //        }
    //    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    self.faceBtn.selected = NO;
    [self.faceBtn setImage:[UIImage imageNamed:@"message_liaotian_biaoqing"] forState:UIControlStateNormal];
    
    if (textView == self.chatTextView) {
        if ([self.delegate respondsToSelector:@selector(keyBoardWillShow:)]) {
            [self.delegate keyBoardWillShow:YES];
        }
    }
    
    return YES;
    
}



- (NSArray *) getMatchsWithStr:(NSString *) text {
    // 找到文本中所有的@
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kATRegular options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matches = [regex matchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, [text length])];
    return matches;
}

-(NSMutableArray *)targetNameArray{
    if (!_targetNameArray) {
        _targetNameArray = [NSMutableArray array];
    }
    return _targetNameArray;
}


@end
