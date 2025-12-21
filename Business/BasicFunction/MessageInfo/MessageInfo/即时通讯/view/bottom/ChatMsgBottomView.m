//
//  ChatMsgBottomView.m
//  Message
//
//  Created by klc_sl on 2021/7/28.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "ChatMsgBottomView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/AppCommonWordsModel.h>
#import <LibProjModel/HttpApiChatRoomController.h>
#import "ChatAudioView.h"
#import <LibProjView/EmojiKeyboardView.h>
#import "ChatBottomView.h"

@interface ChatCommonWordsView : UIView

@property (nonatomic, weak)UIScrollView *scrView;
@property (nonatomic, copy)NSArray *commonWordsArr;

@property (nonatomic, copy)void(^selectWordsBlock)(NSString *word);

@end


@implementation ChatCommonWordsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}
- (void)createView{
    UIScrollView *scrView = [[UIScrollView alloc] init];
    scrView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrView];
    self.scrView = scrView;
    [scrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)setCommonWordsArr:(NSArray *)commonWordsArr{
    _commonWordsArr = commonWordsArr;
    [self.scrView removeAllSubViews];
    if (commonWordsArr.count == 0) {
        return;
    }
    CGFloat magin = 12;
    CGFloat x = 12;
    for (int i = 0; i < commonWordsArr.count; i++) {
        AppCommonWordsModel *model = commonWordsArr[i];
        CGFloat width = 50;
        CGSize size = [model.name boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        if (size.width+10 >= 40) {
            width = size.width+10;
        }
        UIButton *commonWordsBtn  = [[UIButton alloc]initWithFrame:CGRectMake(x, 5, width + 10, 30)];
        x += magin+width + 10;
        commonWordsBtn.layer.cornerRadius = 15;
        commonWordsBtn.clipsToBounds = YES;
        commonWordsBtn.layer.borderColor = [ProjConfig normalColors].CGColor;
        commonWordsBtn.layer.borderWidth = 1.0;
        commonWordsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [commonWordsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [commonWordsBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
        commonWordsBtn.tag = 9978+i;
        
        [commonWordsBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [commonWordsBtn setBackgroundImage:[UIImage imageWithColor:[ProjConfig normalColors]] forState:UIControlStateSelected];
        [commonWordsBtn setTitle:model.name forState:UIControlStateNormal];
        [commonWordsBtn addTarget:self action:@selector(commonWordsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrView addSubview:commonWordsBtn];
    }
    self.scrView.contentSize = CGSizeMake(x, 0);
    
}

-(void)commonWordsBtnClick:(UIButton *)sender{
    AppCommonWordsModel *model = self.commonWordsArr[sender.tag-9978];
   // NSLog(@"过滤文字标签%ld~~~~%@"),(long)sender.tag, model.name);
    if (self.selectWordsBlock) {
        self.selectWordsBlock(model.name);
    }
}


@end




@interface ChatMsgBottomView ()<ChatBottomViewDelegate,ChatAudioViewDelegate>

@property (nonatomic, weak)ChatCommonWordsView *commonView;

@property (nonatomic, weak)ChatAudioView *audioView;

@property (nonatomic, weak)EmojiKeyboardView *emojiV;
///底部视图
@property (nonatomic, weak)ChatBottomView *functionView;

@property (nonatomic, assign)ConversationChatForType chatType;
///chatType=0时 msgId是对方用户ID        chatType=1时，msgId是群组ID
@property (nonatomic, assign)int64_t msgSendId;

@property (nonatomic, assign)CGFloat baseViewHeight;

@end



@implementation ChatMsgBottomView

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame chatType:(ConversationChatForType)chatType msgSendId:(int64_t)msgSendId
{
    self = [super initWithFrame:frame];
    if (self) {
        self.chatType = chatType;
        self.msgSendId = msgSendId;
        self.backgroundColor = [UIColor whiteColor];
        self.baseViewHeight = frame.size.height;
        [self createUI];
    }
    return self;
}

- (void)createUI{

    kWeakSelf(self);
    ChatCommonWordsView *commonView = [[ChatCommonWordsView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    commonView.selectWordsBlock = ^(NSString *word) {
        [weakself sendMessageToOther:word];
    };
    [self addSubview:commonView];
    self.commonView = commonView;
    
    ChatBottomView *functionView = [[ChatBottomView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 90) chatType:self.chatType];
    functionView.delegate = self;
    functionView.groupId = self.msgSendId;
    [self addSubview:functionView];
    self.functionView = functionView;
    [functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commonView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(94);
    }];
}

- (void)registerKeyboardNotify{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowChat:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)removeKeyboardNotify{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)setTopMsgCoin:(double)topMsgCoin{
    _topMsgCoin = topMsgCoin;
    self.functionView.topMsgCoin = topMsgCoin;
}

- (void)setChatOtherUid:(int64_t)otherUid otherRole:(int)otherRole{
    [self.functionView setChatOtherUid:otherUid otherRole:otherRole];
}


- (void)showCommonWords:(NSArray *)array{
    if (array.count == 0) {
        self.height -= self.commonView.height;
        self.y += self.commonView.height;
    }
    self.commonView.height = (array.count?40:0);
    self.commonView.commonWordsArr = array;
    self.baseViewHeight = self.height;
}


#pragma mark - 懒加载 -
- (ChatAudioView *)audioView{
    if (!_audioView) {
        ChatAudioView *audioView = [[ChatAudioView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, EmojiHeight + kSafeAreaBottom)];
        audioView.hidden = YES;
        audioView.delegate = self;
        [self addSubview:audioView];
        _audioView = audioView;
        [audioView layoutIfNeeded];
    }
    return _audioView;
}

- (EmojiKeyboardView *)emojiV{
    if (!_emojiV) {
        EmojiKeyboardView *emojiV = [[EmojiKeyboardView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, EmojiHeight+kSafeAreaBottom)];
        emojiV.hidden = YES;
        [self addSubview:emojiV];
        _emojiV = emojiV;
        [emojiV layoutIfNeeded];
    }
    return _emojiV;
}


#pragma mark - ChatBottomViewDelegate -
- (void)sendMessageToOther:(NSString *)inputText{
    if (self.delegate && inputText.length > 0) {
        [self.delegate chatMsgBottomView:self sendInputText:inputText isTopMsg:self.functionView.isTopMsg];
    }
}

- (void)sendMessageToOtherNoti:(NSString *)inputText andUserArr:(NSArray *)userArr andIsAtAll:(BOOL)isAtAll{
}

- (void)featuresBtnClick:(int64_t )featuresId{
    if (featuresId == 0) { ///语音
        /// 音频
        if (self.audioView.hidden) {
            [self endEditing:YES];
            self.emojiV.hidden = YES;
            self.audioView.hidden = NO;
            self.audioView.frame =  CGRectMake(0, self.height, kScreenWidth, EmojiHeight+kSafeAreaBottom);
            [self viewFrameUpdata:0 andkeyboardRect:self.audioView.frame];
        }else{
            [self hideKeyBoard];
        }
    }else{
        if (self.delegate) {
            [self.delegate chatMsgBottomView:self featuresBtnClick:featuresId];
        }
    }
}

- (void)clickFaceBtn:(UIButton *)sender{
    if (sender.selected) {
        [self keyBoardChange];
        [self endEditing:YES];
        self.emojiV.hidden = NO;
        self.audioView.hidden = YES;
        self.emojiV.frame =  CGRectMake(0, self.height, kScreenWidth, EmojiHeight+kSafeAreaBottom);
        [self viewFrameUpdata:2 andkeyboardRect:self.emojiV.frame];
    }else{
        self.emojiV.hidden = YES;
        self.audioView.hidden = YES;
        [self.functionView.chatTextView becomeFirstResponder];
    }
}

- (void)keyBoardWillShow:(BOOL)isShow{
    if (isShow) {
        [self registerKeyboardNotify];
    }else{
        [self hideKeyBoard];
    }
}


#pragma mark - ChatAudioViewDelegate -
- (void)sendMessageRecordUrlToOther:(NSString *)recordUrl andTimeStr:(NSString *)timeStr{
    if (self.delegate) {
        [self.delegate chatMsgBottomView:self sendRecord:recordUrl andTimeStr:timeStr];
    }
}

#pragma mark - action -

//获取键盘高度
- (void)keyboardWillShowChat:(NSNotification *)aNotification{
    //获取键盘的高度
    CGRect keyboardRect = [[aNotification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self viewFrameUpdata:1 andkeyboardRect:keyboardRect];
}

// 隐藏键盘
- (void)hideKeyBoard{
    [self removeKeyboardNotify];
    [self endEditing:YES];
    self.emojiV.hidden = YES;
    self.audioView.hidden = YES;
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakself.height = weakself.baseViewHeight;
        weakself.y = kScreenHeight-weakself.height;
    } completion:^(BOOL finished) {
    }];
    
    if (weakself.delegate) {
        [weakself.delegate chatMsgBottomView:self showKeyBoard:NO];
    }
}

//type 0 音频 1键盘  2表情
-(void)viewFrameUpdata:(NSInteger )type andkeyboardRect:(CGRect)keyboardRect{
    kWeakSelf(self);
    [UIView animateWithDuration:0.25 animations:^{
        switch (type) {
            case 0:
                weakself.audioView.y = weakself.functionView.maxY;
                break;
            case 1:
                ///键盘不需要管尺寸
                break;
            case 2:
                weakself.emojiV.y = weakself.functionView.maxY;
                break;
            default:
                break;
        }
        weakself.height = weakself.functionView.maxY+keyboardRect.size.height;
        weakself.y = kScreenHeight-weakself.height;
    }];
    if (weakself.delegate) {
        [weakself.delegate chatMsgBottomView:self showKeyBoard:YES];
    }
}


//表情键盘
- (void)keyBoardChange{
    kWeakSelf(self);
    self.emojiV.clickHandle = ^(EmojiKeyboardForKeyType type, NSString *emoji) {
        switch (type) {
            case EmojiKeyboardForStr:
            {
                [emoji changeTextForCostomEmojiAndBounds:CGRectMake(0, -5, 21, 21)];
                [weakself.functionView.chatTextView insertText:emoji];
                [weakself.functionView.chatTextView scrollRectToVisible:CGRectMake(0, weakself.functionView.chatTextView.contentSize.height - 5, weakself.functionView.chatTextView.contentSize.width, 10) animated:YES];
            }
                break;
            case EmojiKeyboardForDelete:
            {
                if (weakself.functionView.chatTextView.text.length>0) {
                    NSString *lastStr = [weakself.functionView.chatTextView.text substringFromIndex:weakself.functionView.chatTextView.text.length-1];
                    if ([lastStr isEqualToString:@"]"]) {
                        for (NSInteger j = weakself.functionView.chatTextView.text.length; j>1; j--) {
                            //对应的字符串
                            NSString *correStr = [weakself.functionView.chatTextView.text substringWithRange:NSMakeRange(j-2, 1)];
                            if ([correStr isEqualToString:@"["]) {
                                weakself.functionView.chatTextView.text = [weakself.functionView.chatTextView.text substringToIndex:j-2];
                                break;
                            }
                        }
                    }else{
                        [weakself.functionView.chatTextView deleteBackward];
                    }
                }else{
                    [weakself.functionView.chatTextView deleteBackward];
                }
            }
                break;
            case EmojiKeyboardForSend:{
                [weakself.functionView sendTextMessage];
            }
                break;
            default:
                break;
        }
    };
}


@end
