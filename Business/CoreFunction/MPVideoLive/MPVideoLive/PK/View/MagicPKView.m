//
//  magicPKView.m
//  MPVideoLive
//
//  Created by admin on 2019/7/30.
//  Copyright © 2019 cat. All rights reserved.
//

#import "MagicPKView.h"
#import <LiveCommon/LiveManager.h>
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
int magicBloodLabBaseTag = 33730;
int magicMpLabBaseTag = 33790;

@interface MagicPKView ()

//血量 || 礼物
@property (nonatomic, strong)UIImageView *ownHpV;
@property (nonatomic, strong)UIImageView *otherHpV;

//魔力值
@property (nonatomic, strong)UIImageView *ownMpV;
@property (nonatomic, strong)UIImageView *otherMpV;

//时间
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UIView *timebgView;

@property (nonatomic, assign)BOOL isFinishPK;  //PK是否完成
@property (nonatomic, assign)BOOL isDefault;  //是否为默认pk  no:为带魔法

@property (nonatomic, strong)NSTimer *pkTimer;

@property (nonatomic, assign)int timeNum;   //时间显示数据
@property (nonatomic, strong)NSString *anchorId;  //视频的主播id


@end

@implementation MagicPKView

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
    [_pkTimer invalidate];
    _pkTimer = nil;
}

- (instancetype)initWithSuperView:(UIView *)superV dic:(NSDictionary *)dic anchorId:(NSString *)anchorId
{
    self = [super init];
    if (self) {
        self.frame = superV.bounds;
        _isFinishPK = NO;
        _isDefault = [dic[@"pktype"] intValue] == 2?NO:YES;
        // FIXME: 默认打开mp
//        _isDefault = NO;
        
        _anchorId = anchorId;
        self.userInteractionEnabled = NO;
        [self createHPUI];
        [self createTimeShowView];
        if (!_isDefault) {
            [self createMPUI];
        }
        [self updateUserBloodAndMagicValue:dic];
        [superV addSubview:self];
    }
    return self;
}

- (void)setPkTime:(NSString *)pkTime{
    _pkTime = pkTime;
    _timeNum = [pkTime intValue]?[pkTime intValue]:60*10;
    [self startTimer];
    _timebgView.hidden = NO;
}

#pragma mark - 视图显示
- (void)createHPUI{
    
    int initHp = 0;
    
    UIView *bloodBgView = [[UIView alloc] initWithFrame:CGRectMake(38, 0, self.frame.size.width-76, 20)];
    bloodBgView.backgroundColor = [UIColor blackColor];
    bloodBgView.layer.masksToBounds = YES;
    bloodBgView.layer.cornerRadius = 4.0;
    [self addSubview:bloodBgView];

    //闪电
    UIImageView *lightningImgV = [[UIImageView alloc] initWithFrame:CGRectMake(bloodBgView.frame.size.width/2.0 -(bloodBgView.frame.size.height/2.0), 0, bloodBgView.frame.size.height, bloodBgView.frame.size.height)];
    lightningImgV.image = [UIImage imageNamed:@"live_pk_shandian"];
    [bloodBgView addSubview:lightningImgV];
    
//    //竖线
//    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0, 0, 2.0, self.frame.size.height)];
//    line1.backgroundColor = [UIColor blackColor];
//    [self addSubview:line1];
    
    for (int  i = 0; i<2; i++) {  //0：我方。  1：敌方
        //上下横线
//        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, i?self.frame.size.height:-6, self.frame.size.width, 6)];
//        line.backgroundColor = [UIColor clearColor];
//        [self addSubview:line];
        
        UIView *oneBgV = [[UIView alloc] initWithFrame:CGRectMake(i*(bloodBgView.frame.size.width/2.0), 0, bloodBgView.frame.size.width/2.0, bloodBgView.frame.size.height)];
        oneBgV.backgroundColor = [UIColor blackColor];
        [bloodBgView insertSubview:oneBgV belowSubview:lightningImgV];
        
        UIImageView *hpImgV = [[UIImageView alloc] initWithFrame:oneBgV.bounds];
        hpImgV.image = [UIImage imageNamed:i?@"live_pk_fushumoli_hongfang":@"live_pk_lanfang"];
        [oneBgV addSubview:hpImgV];
        hpImgV.frame = CGRectMake(i?oneBgV.frame.size.width-(initHp?oneBgV.frame.size.width:0):0, 0, initHp?oneBgV.frame.size.width:0, oneBgV.frame.size.height);
        i?(_otherHpV = hpImgV):(_ownHpV = hpImgV);

        UILabel *ownName = [[UILabel alloc] init];
        ownName.text = i?kLocalizationMsg(@"对方"):kLocalizationMsg(@"我方");
        ownName.alpha = 0.8;
        ownName.textColor = [UIColor whiteColor];
        ownName.font = [UIFont systemFontOfSize:14];
        ownName.textAlignment = i?NSTextAlignmentRight:NSTextAlignmentLeft;
        [oneBgV addSubview:ownName];
        
        UILabel *hplab = [[UILabel alloc] init];
        hplab.text = [NSString stringWithFormat:@"%d",initHp];
        hplab.alpha = 0.8;
        hplab.textColor = [UIColor whiteColor];
        hplab.font = [UIFont systemFontOfSize:10];
        hplab.tag = magicBloodLabBaseTag+i;
        hplab.textAlignment = i?NSTextAlignmentLeft:NSTextAlignmentRight;
        [oneBgV addSubview:hplab];
        
        [hplab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(oneBgV);
            i?make.left.equalTo(oneBgV).offset(oneBgV.frame.size.height/2.0+3):make.right.equalTo(oneBgV).offset(-(oneBgV.frame.size.height/2.0+3));
        }];
        
        [ownName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(oneBgV);
            i?make.right.equalTo(oneBgV).offset(-6):make.left.equalTo(oneBgV).offset(6);
        }];
    }
}

- (void)createTimeShowView{
   
    UIImageView *timeBgImageV = [[UIImageView alloc] init];
    timeBgImageV.image = [UIImage imageNamed:@"live_pk_bisaishijian"];
    [self addSubview:timeBgImageV];
    timeBgImageV.hidden = YES;
    _timebgView = timeBgImageV;
    
    __weak typeof(self) weakSelf = self;
    [timeBgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).offset(25);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(150);
    }];
    
    UIView *centerV = [[UIView alloc] init];
    [timeBgImageV addSubview:centerV];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(timeBgImageV);
    }];
    
    UIImageView *clockImg = [[UIImageView alloc] init];
    clockImg.image = [UIImage imageNamed:@"live_pk_time"];
    clockImg.layer.masksToBounds = YES;
    clockImg.layer.cornerRadius = 10;
    [centerV addSubview:clockImg];
    
    UILabel *timeL = [[UILabel alloc] init];
    timeL.text = kLocalizationMsg(@"比赛时间 00:00");
    timeL.textColor = [UIColor whiteColor];
    timeL.font = [UIFont systemFontOfSize:13];
    [centerV addSubview:timeL];
    _timeLabel = timeL;
    
    [clockImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerY.equalTo(centerV);
        make.left.equalTo(centerV).mas_offset(10);
        make.right.equalTo(timeL.mas_left).mas_offset(-4);
    }];
    
    [timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerV);
        make.right.equalTo(centerV).mas_offset(-10);
        make.height.equalTo(clockImg);
    }];
    
}


- (void)createMPUI{

    int initMp = 0;
    

    for (int  i = 0; i<2; i++) {  //0：我方。  1：敌方
        UIView *oneBgV = [[UIView alloc] initWithFrame:CGRectMake(i*(self.frame.size.width/2.0)+6, self.frame.size.height-20, self.frame.size.width/2.0-12, 14)];
        oneBgV.layer.masksToBounds = YES;
        oneBgV.layer.cornerRadius = oneBgV.frame.size.height/2.0;
        oneBgV.backgroundColor = [UIColor clearColor];
        [self addSubview:oneBgV];
        
        UIView *coverView = [[UIView alloc] initWithFrame:oneBgV.bounds];
        coverView.backgroundColor = [UIColor blackColor];
        coverView.alpha = 0.5;
        [oneBgV addSubview:coverView];
        
        UIImageView *mpImgV = [[UIImageView alloc] init];
        mpImgV.image = [UIImage imageNamed:i?@"live_pk_mpyoubian":@"live_pk_mpzuobian"];
        [oneBgV addSubview:mpImgV];
        mpImgV.frame = CGRectMake(i?oneBgV.frame.size.width-(initMp?oneBgV.frame.size.width:0):0, 0, initMp?oneBgV.frame.size.width:0, oneBgV.frame.size.height);
        i?(_otherMpV = mpImgV):(_ownMpV = mpImgV);

        UILabel *ownName = [[UILabel alloc] init];
        ownName.text = @"MP";
        ownName.alpha = 0.8;
        ownName.textColor = [UIColor whiteColor];
        ownName.font = [UIFont systemFontOfSize:12];
        ownName.textAlignment = i?NSTextAlignmentRight:NSTextAlignmentLeft;
        [oneBgV addSubview:ownName];
        
        UILabel *mplab = [[UILabel alloc] init];
        mplab.alpha = 0.8;
        mplab.text = [NSString stringWithFormat:@"%d",initMp];
        mplab.textColor = [UIColor whiteColor];
        mplab.font = [UIFont systemFontOfSize:10];
        mplab.tag = magicMpLabBaseTag+i;
        mplab.textAlignment = i?NSTextAlignmentRight:NSTextAlignmentLeft;
        [oneBgV addSubview:mplab];
        
        //位置
        [ownName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(oneBgV);
            i?make.right.equalTo(oneBgV).mas_offset(-7):make.left.equalTo(oneBgV).mas_offset(7);
            i?make.left.equalTo(mplab.mas_right).mas_offset(4):make.right.equalTo(mplab.mas_left).mas_offset(-4);
        }];
        
        [mplab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ownName);
        }];
    }
}

- (void)createResultView:(int)win{
    
    if (win >=2) {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:@"live_pk_pingju"];
        [self addSubview:imgV];
        __weak typeof(self) weakSelf = self;
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf).mas_offset(-52);
            make.size.mas_equalTo(CGSizeMake(77, 40));
        }];
    }else{
        
        for (int i = 0; i<2; i++) {
            UIImageView *imgV = [[UIImageView alloc] init];
            imgV.image = ((win == i)?[UIImage imageNamed:@"live_pk_win"]:[UIImage imageNamed:@"live_pk_lose"]);
            [self addSubview:imgV];
            __weak typeof(self) weakSelf = self;
            [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                i?make.right.equalTo(weakSelf).mas_offset(-20):make.left.equalTo(weakSelf).mas_offset(20);
                i?make.left.equalTo(weakSelf.timebgView.mas_right).mas_offset(20):make.right.equalTo(weakSelf.timebgView.mas_left).mas_offset(-20);
                make.bottom.equalTo(weakSelf).mas_offset(-52);
                make.height.equalTo(imgV.mas_width).multipliedBy(0.6);// 高/宽=0.6
            }];
        }
    }

}

- (void)updateOwnHP:(NSString *)ownHP otherHP:(NSString *)otherHP{
    if(!_ownHpV || !_otherHpV){
        return;
    }
    NSInteger ownhpNum = [ownHP integerValue];
    _ownHpV.image = [UIImage imageNamed:(ownhpNum>0)?@"live_pk_lanfang":@"live_pk_fuzhi"];
    
    NSInteger otherhpNum = [otherHP integerValue];
    _otherHpV.image = [UIImage imageNamed:(otherhpNum>0)?@"live_pk_fushumoli_hongfang":@"live_pk_fuzhi"];
    
    //最大血量
    NSInteger maxNum = MAX(1000, MAX(ABS(ownhpNum), ABS(otherhpNum)));
    
    //自己
    float ownHpMultiple = ABS(ownhpNum/(maxNum*1.0));
    CGRect ownRc = _ownHpV.frame;
    ownRc.size.width = _ownHpV.superview.frame.size.width * ownHpMultiple;
    _ownHpV.frame = ownRc;
    
    //对方
    float otherHpMultiple = ABS(otherhpNum/(maxNum*1.0));
    CGRect otherRc = _otherHpV.frame;
    otherRc.size.width = _otherHpV.superview.frame.size.width * otherHpMultiple;
    otherRc.origin.x = _otherHpV.superview.frame.size.width - (_otherHpV.superview.frame.size.width * otherHpMultiple);
    _otherHpV.frame = otherRc;
    
    //文字显示
    UILabel *ownHPLab = [_ownHpV.superview viewWithTag:magicBloodLabBaseTag];
    ownHPLab.text = kString(ownHP);
    UILabel *otherHPLab = [_otherHpV.superview viewWithTag:magicBloodLabBaseTag+1];
    otherHPLab.text = kString(otherHP);
    
    
}
- (void)updateOwnMP:(NSString *)ownMP otherMP:(NSString *)otherMP{
    if(!_ownMpV || !_otherMpV){
        return;
    }
    NSInteger ownMpNum = [ownMP integerValue];
    NSInteger otherMpNum =  [otherMP integerValue];
    
    _ownMpV.image = [UIImage imageNamed:(ownMpNum>0)?@"live_pk_mpzuobian":@"live_pk_fushumoli_you"];
    _otherMpV.image = [UIImage imageNamed:(otherMpNum>0)?@"live_pk_mpyoubian":@"live_pk_fushumoli_zuo"];

    //最大MP
    NSInteger maxNum = MAX(1000, MAX(ABS(ownMpNum), ABS(otherMpNum)));
   // NSLog(@"过滤文字%zi"),maxNum);
    
    //自己mp
    float ownMpMultiple = ABS(ownMpNum/(maxNum*1.0));
    CGRect ownRc = _ownMpV.frame;
    ownRc.size.width = _ownMpV.superview.frame.size.width * ownMpMultiple;
    _ownMpV.frame = ownRc;

    //对方mp
    float otherMpMultiple = ABS(otherMpNum/(maxNum*1.0));
    CGRect otherRc = _otherMpV.frame;
    otherRc.size.width = _otherMpV.superview.frame.size.width * otherMpMultiple;
    otherRc.origin.x = _otherMpV.superview.frame.size.width - (_otherMpV.superview.frame.size.width * otherMpMultiple);
    _otherMpV.frame = otherRc;
    
    //文字显示
    UILabel *ownMPLab = [_ownMpV.superview viewWithTag:magicMpLabBaseTag];
    ownMPLab.text = kString(ownMP);
    UILabel *otherMPLab = [_otherMpV.superview viewWithTag:magicMpLabBaseTag+1];
    otherMPLab.text = kString(otherMP);
}

#pragma mark - 数据操作
//更新视图数据显示
- (void)updateShowData:(NSDictionary *)dic{
    [self updateUserBloodAndMagicValue:dic];
    int reduceTime = [dic[@"pk_change_time"] intValue];
    if (reduceTime <= _timeNum) {
        _timeNum -= reduceTime;
        [self updateShowTime];
    }
}

- (void)updateUserBloodAndMagicValue:(NSDictionary *)dic{

    NSString *ownNum;  //自己
    NSString *otherNum;   //对方
    
    NSString *ownMpNum;  //自己魔力值
    NSString *otherMpNum;  //对方魔力值
    
    if (_isDefault) {  //普通pk
        if ([kString(dic[@"pkuid1"]) isEqual:_anchorId]) {  //是主播id
            ownNum = kString(dic[@"pktotal1"]);
            otherNum = kString(dic[@"pktotal2"]);
        }else{
            otherNum = kString(dic[@"pktotal1"]);
            ownNum = kString(dic[@"pktotal2"]);
        }
    }else{
        if ([kString(dic[@"pkuid1"]) isEqual:_anchorId]) {  //是主播id
            ownNum = kString(dic[@"pk_blood_liveuid"]);
            otherNum = kString(dic[@"pk_blood_pkuid"]);
            
            ownMpNum = kString(dic[@"pk_mp_liveuid"]);
            otherMpNum = kString(dic[@"pk_mp_pkuid"]);
        }else{
            ownNum = kString(dic[@"pk_blood_pkuid"]);
            otherNum = kString(dic[@"pk_blood_liveuid"]);
            
            ownMpNum = kString(dic[@"pk_mp_pkuid"]);
            otherMpNum = kString(dic[@"pk_mp_liveuid"]);
        }
    }
    
    [self updateOwnHP:ownNum otherHP:otherNum];
    [self updateOwnMP:ownMpNum otherMP:otherMpNum];
}

//更新时间
- (void)updateShowTime{
    _timeLabel.text = [NSString stringWithFormat:@"%@ %@",(_isFinishPK)?kLocalizationMsg(@"惩罚时间"):kLocalizationMsg(@"比赛时间"),[self seconds:_timeNum]];
}

- (void)resetPkView{
    
    // 关闭定时器
    [_pkTimer invalidate];
    _pkTimer = nil;
    _timeNum = 0;
    [self removeFromSuperview];
}

- (void)startTimer{
    if (!_pkTimer) {
        [self updateShowTime];
        _pkTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTimeL) userInfo:nil repeats:YES];
    }
}

- (void)changeTimeL{
   // NSLog(@"过滤文字开始倒计时了 ---- %@"),self);
    _timeNum --;
    [self updateShowTime];
    if (_timeNum <= 0) {
        [_pkTimer invalidate];
        _pkTimer = nil;
        if (_resultFinish != nil && _isFinishPK) {
            _resultFinish();
        }
    }
}

//显示pk结果
- (void)showPkResult:(NSDictionary *)dic{
   // NSLog(@"过滤文字显示结果了 ---- %@"),self);
    _isFinishPK = YES;
    [_pkTimer invalidate];
    _pkTimer = nil;
    _timeNum = [dic[@"punishTime"] intValue];
//    _timeNum = [[Config myProfile].punish_time intValue];
   // NSLog(@"过滤文字惩罚时间  === %d"),_timeNum);
    
    int win;
    if ([dic[@"iswin"] intValue] == 0) {
        win = 999;  //平局
        [self startTimer];

//        kWeakSelf(self);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (weakself.resultFinish != nil) {
//                weakself.resultFinish();
//            }
//        });
        
    }else if ([dic[@"iswin"] intValue] == 1) {
        win = 0;  //自己赢
        [self startTimer];
    }else{
        win = 1;  //对方赢
        [self startTimer];
    }
    [self createResultView:win];
  
}

#pragma mark - 时间操作

- (NSString *)seconds:(int)num{
    NSString *str;
    str = [NSString stringWithFormat:@"%02d:%02d",num/60,num%60];
    return str;
}

@end

