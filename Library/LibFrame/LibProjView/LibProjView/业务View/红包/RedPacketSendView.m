//
//  RedPacketSendView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/17.
//  Copyright © 2020 . All rights reserved.
//

#import "RedPacketSendView.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/HttpApiPublicLive.h>
#import <LibProjModel/HttpApiRedPacketController.h>
#import <Masonry.h>
#import <LibProjView/BalanceLackPromptView.h>

@interface RedPacketSendView () <UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (nonatomic, weak)UILabel *totalCoinL;
///数量
@property (nonatomic, weak)UITextField *redNumTextF;
///红包金额
@property (nonatomic, weak)UITextField *redCoinTextF;

@property (nonatomic, assign)BOOL isGroup;
/**在房间红包时必填,其他填-1*/
@property (nonatomic, assign) int64_t anchorId;
/**直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态*/
@property (nonatomic, assign) int liveType;
/**房间号*/
@property (nonatomic, assign) int64_t roomId;
/**直播标识*/
@property (nonatomic, copy) NSString * showId;
///对方用户ID
@property (nonatomic, assign) int64_t otherUserId;
///红包发送的范围
@property (nonatomic, assign)int sendType;

@end

@implementation RedPacketSendView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (void)showChatMsgRedPt:(int64_t)importUid groupId:(int64_t)groupId sendType:(int)sendType {
    
    RedPacketSendView *redBag = [[RedPacketSendView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 268)];
    redBag.isGroup = groupId>0?YES:NO;
    if (redBag.isGroup > 0) {
        redBag.sendType = 1;
        redBag.anchorId = importUid;
        redBag.roomId = groupId;
        redBag.showId = kStringFormat(@"%lld",groupId);
        redBag.otherUserId = -1;
    }else{
        redBag.sendType = 2;
        redBag.anchorId = -1;
        redBag.roomId = 0;
        redBag.showId = @"";
        redBag.otherUserId = importUid;
    }
    redBag.liveType = sendType;
    [redBag createUI];
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"发红包") detailView:redBag cover:YES btnImage:nil isLeft:NO clickBlock:nil cancelBack:nil];
}

+ (void)showLiveRedPtForAnchorId:(int64_t)anchorId liveType:(int)liveType roomId:(int64_t)roomId liveShowId:(NSString *)liveShowId {
    
    RedPacketSendView *redBag = [[RedPacketSendView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 268)];
    redBag.isGroup = YES;
    redBag.anchorId = anchorId;
    redBag.liveType = liveType;
    redBag.roomId = roomId;
    redBag.showId = liveShowId;
    [redBag createUI];
    redBag.sendType = 1;
    redBag.otherUserId = -1;
    [FunctionSheetBaseView showTitle:kLocalizationMsg(@"发红包") detailView:redBag cover:NO btnImage:nil isLeft:NO clickBlock:nil cancelBack:nil];
}

- (void)clickContentView:(UIGestureRecognizer *)tap{
    [self endEditing:YES];
}


- (void)createUI{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContentView:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    CGFloat pointY = 6;
    CGFloat space = 25;
    CGFloat itemHeight = 50;
    
    if (self.isGroup) {
        ///红包个数
        UIView *numBgV = [[UIView alloc] initWithFrame:CGRectMake(space, pointY, self.width-space*2, itemHeight)];
        numBgV.layer.masksToBounds = YES;
        numBgV.layer.cornerRadius = 25;
        numBgV.backgroundColor = kRGBA_COLOR(@"#F6F6F6", 1.0);
        [self addSubview:numBgV];
        
        UILabel *numTitleL = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 90, 20)];
        numTitleL.font = [UIFont systemFontOfSize:14];
        numTitleL.textColor = [UIColor blackColor];
        numTitleL.text = kLocalizationMsg(@"红包个数");
        [numBgV addSubview:numTitleL];
        
        UILabel *numUnitL = [[UILabel alloc] initWithFrame:CGRectMake(numBgV.width-20-15, 15, 15, 20)];
        numUnitL.font = [UIFont systemFontOfSize:14];
        numUnitL.textColor = [UIColor blackColor];
        numUnitL.text = kLocalizationMsg(@"个");
        [numBgV addSubview:numUnitL];
        
        UITextField *numTextF = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, numUnitL.x-130-10, 30)];
        numTextF.placeholder = kLocalizationMsg(@"填写数量");
        numTextF.font = [UIFont systemFontOfSize:14];
        numTextF.delegate = self;
        [numTextF addTarget:self action:@selector(textFChange:) forControlEvents:UIControlEventEditingChanged];
        numTextF.textAlignment = NSTextAlignmentRight;
        numTextF.keyboardType = UIKeyboardTypeNumberPad;
        [numBgV addSubview:numTextF];
        _redNumTextF = numTextF;
        
        pointY = numBgV.maxY+15;
    }

    
    ///单个红包金额
    {
        UIView *coinBgV = [[UIView alloc] initWithFrame:CGRectMake(space, pointY, kScreenWidth-space*2, itemHeight)];
        coinBgV.layer.masksToBounds = YES;
        coinBgV.layer.cornerRadius = 25;
        coinBgV.backgroundColor = kRGBA_COLOR(@"#F6F6F6", 1.0);
        [self addSubview:coinBgV];
        
        UILabel *coinTitleL = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 90, 20)];
        coinTitleL.font = [UIFont systemFontOfSize:14];
        coinTitleL.textColor = [UIColor blackColor];
        if (self.isGroup) {
            coinTitleL.text = kLocalizationMsg(@"单个红包金额");
        }else{
            coinTitleL.text = kLocalizationMsg(@"红包金额");
        }
        [coinBgV addSubview:coinTitleL];
        
        UILabel *coinUnitL = [[UILabel alloc] initWithFrame:CGRectMake(coinBgV.width-20-30, 15, 30, 20)];
        coinUnitL.font = [UIFont systemFontOfSize:14];
        coinUnitL.textColor = [UIColor blackColor];
        coinUnitL.text = kLocalizationMsg(@"金币");
        [coinBgV addSubview:coinUnitL];
        
        UITextField *coinTextF = [[UITextField alloc] initWithFrame:CGRectMake(130, 10, coinUnitL.x-130-10, 30)];
        coinTextF.placeholder = @"0";
        coinTextF.delegate = self;
        coinTextF.font = [UIFont systemFontOfSize:14];
        coinTextF.textAlignment = NSTextAlignmentRight;
        [coinTextF addTarget:self action:@selector(textFChange:) forControlEvents:UIControlEventEditingChanged];
        coinTextF.keyboardType = UIKeyboardTypeNumberPad;
        [coinBgV addSubview:coinTextF];
        _redCoinTextF = coinTextF;
        
        pointY = coinBgV.maxY+15;
    }
    
    if (self.isGroup) {
        UILabel *totalCoinL = [[UILabel alloc] initWithFrame:CGRectMake(space, pointY, self.width-space*2, itemHeight)];
        totalCoinL.textColor = kRGBA_COLOR(@"#333333", 1.0);
        totalCoinL.font = [UIFont systemFontOfSize:30 weight:UIFontWeightSemibold];
        totalCoinL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:totalCoinL];
        _totalCoinL = totalCoinL;
        
        pointY = totalCoinL.maxY+25;
    }

    UIButton *sendBtn = [UIButton buttonWithType:0];
    sendBtn.layer.masksToBounds = YES;
    sendBtn.layer.cornerRadius = 25;
    sendBtn.frame = CGRectMake(space, pointY, self.width-space*2, itemHeight);
    [sendBtn setTitle:kLocalizationMsg(@"发送红包") forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_pink"] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendBtn];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameWillChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameWillChange:) name:UIKeyboardWillHideNotification object:nil];
    
    self.frame = CGRectMake(0, 0, kScreenWidth, sendBtn.maxY+20);
    [self showTotalNum];
}


///键盘弹起降下
- (void)keyBoardFrameWillChange:(NSNotification *)notify{
    UIView *superV = self.superview;
    CGRect keyBoardRc = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval time = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time animations:^{
        CGRect rc = superV.frame;
        rc.origin.y = (keyBoardRc.origin.y < kScreenHeight)?(keyBoardRc.origin.y-(self.maxY)):(kScreenHeight-rc.size.height);
        superV.frame = rc;
    }];
}



- (void)textFChange:(UITextField *)textF{
   // NSLog(@"过滤文字textFChange:%@"),textF.text);
    if (textF.text.length > 6) {
        NSString *subStr = [textF.text substringToIndex:6];
        textF.text = subStr;
    }
    [self showTotalNum];
}


- (void)showTotalNum{
    if ([_redCoinTextF.text validPureLongLong] && [_redNumTextF.text validPureLongLong]) {
        int64_t totalNum = [_redCoinTextF.text integerValue] * [_redNumTextF.text integerValue];
        _totalCoinL.attributedText = [kStringFormat(@"%lld",totalNum) attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -2, 13, 13) before:NO];
    }else{
        _totalCoinL.attributedText = [@"0" attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -2, 13, 13) before:NO];
    }
}



#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSRange range = NSMakeRange(textField.text.length,0);
    
    UITextPosition *start = [textField positionFromPosition:[textField beginningOfDocument]offset:range.location];
    
    UITextPosition *end = [textField positionFromPosition:start offset:range.length];
    
    [textField setSelectedTextRange:[textField textRangeFromPosition:start toPosition:end]];
    
    return YES;
}


- (void)sendBtnClick:(UIButton *)btn{

    int redNum = [self.redNumTextF.text intValue];
    int oneCount = [self.redCoinTextF.text intValue];
    
    if (self.isGroup) {
        if (redNum == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入红包数量")];
            return;
        }
    }else{
        redNum = 1;
    }
    if ( oneCount == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入单个红包金额")];
        return;
    }
    [self endEditing:YES];
    btn.userInteractionEnabled = NO;
    int64_t anchorId = self.anchorId;
    int liveType = self.liveType;
    int64_t roomId = self.roomId;
    NSString *showId = self.showId;
    NSString *otherUserId = kStringFormat(@"%lld",self.otherUserId);
    int redPacketAmount = redNum;
    int redPacketRange = self.sendType;
    int redPacketType = 1;
    double totalValue = (redNum*oneCount);
    int currencyType = 1;
    kWeakSelf(self);
    [HttpApiRedPacketController sendRedPacket:anchorId currencyType:currencyType liveType:liveType otherUserId:otherUserId redPacketAmount:redPacketAmount redPacketRange:redPacketRange redPacketType:redPacketType roomId:roomId showId:showId totalValue:totalValue callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        btn.userInteractionEnabled = YES;
        if (code == 1) {
            weakself.redNumTextF.text = @"0";
            weakself.redCoinTextF.text = @"0";
            [FunctionSheetBaseView deletePopView:weakself];
        }else if (code == 7101){  ///余额不足
            [BalanceLackPromptView gotoRecharge:nil];
        } else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}


@end
