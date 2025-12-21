//
//  TotalRankHeader.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "TotalRankHeader.h"
#import <SDWebImage.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

@interface RankUserInfoHeaderView ()

- (instancetype)initWithFrame:(CGRect)frame rankNo:(int)rankNo;
///清除用户信息
- (void)clearUserInfo;

@end

@implementation RankUserInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame rankNo:(int)rankNo
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIAndRankNo:rankNo];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)clearUserInfo{
    _userId = 0;
    _userIconV.image = nil;
    _userNameL.text = kLocalizationMsg(@"暂无");
    _coinL.text = @"";
    _levelImgV.image = nil;
}

- (void)createUIAndRankNo:(int)rankNo{
    
    CGFloat viewW = self.width;
    NSString *userHeaderWare = @"";
    CGFloat userW = 0;
    CGFloat userY = 0;
    
    switch (rankNo) {
        case 1:
            userHeaderWare = @"icon_first_headerware";
            
            userW = viewW * 136/180.0;
            userY = viewW - (viewW *6/180.0)- userW;
            break;
        case 2:
            userHeaderWare = @"icon_second_headerware";
            
            userW = viewW * 133/180.0;
            userY = viewW - (viewW *6/180.0)- userW;
            break;
        case 3:
            userHeaderWare = @"icon_third_headerware";
            
            userW = viewW * 120/180.0;
            userY = viewW - (viewW *15/180.0)- userW;
            break;
        default:
            break;
    }
    
    UIImageView *userHeaderWareV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewW)];
    userHeaderWareV.backgroundColor = [UIColor clearColor];
    userHeaderWareV.centerX = self.width/2.0;
    userHeaderWareV.image = [UIImage imageNamed:userHeaderWare];
    [self addSubview:userHeaderWareV];
    [self addRotationAnimationOn:userHeaderWareV];
    
    UIImageView *userIconV =  [[UIImageView alloc]initWithFrame:CGRectMake(0, userY, userW, userW)];
    userIconV.contentMode = UIViewContentModeScaleAspectFill;
    userIconV.centerX = userHeaderWareV.centerX;
    userIconV.layer.masksToBounds = YES;
    userIconV.layer.cornerRadius = userIconV.height/2.0;
    userIconV.clipsToBounds = YES;
    [userHeaderWareV addSubview:userIconV];
    self.userIconV = userIconV;
    [userIconV cornerRadii:CGSizeMake(userIconV.height/2.0, userIconV.height/2.0) byRoundingCorners:UIRectCornerAllCorners];
    
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, userIconV.maxY+10, viewW, 20)];
    nameL.textAlignment = NSTextAlignmentCenter;
    nameL.font = [UIFont systemFontOfSize:14];
    nameL.centerX = userIconV.centerX;
    nameL.textColor = [UIColor whiteColor];
    nameL.text = kLocalizationMsg(@"暂缺");
    [self addSubview:nameL];
    self.userNameL = nameL;
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userIconV);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(userIconV.mas_bottom).offset(10);
    }];
    
    UILabel *coinL = [[UILabel alloc]initWithFrame:CGRectMake(0, nameL.maxY, viewW, 20)];
    coinL.textAlignment = NSTextAlignmentCenter;
    coinL.font = [UIFont systemFontOfSize:13];
    coinL.centerX = userIconV.centerX;
    coinL.textColor = [UIColor whiteColor];
    [self addSubview:coinL];
    self.coinL = coinL;
    [coinL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(nameL.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *levelImgV =  [[UIImageView alloc]initWithFrame:CGRectMake(0, userY, userW, userW)];
    levelImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:levelImgV];
    self.userIconV = userIconV;
    [levelImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameL.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(nameL);
    }];
    self.levelImgV = levelImgV;
    
    self.height = coinL.maxY;
}


- (void)addRotationAnimationOn:(UIView *)view{
    CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    momAnimation.fromValue = [NSNumber numberWithFloat:arc4random()%15];
    momAnimation.toValue = [NSNumber numberWithFloat:-arc4random()%15];
    momAnimation.duration = 2.1;
    momAnimation.repeatCount = CGFLOAT_MAX;
    momAnimation.fillMode = kCAFillModeForwards;
    momAnimation.autoreverses = YES;
    momAnimation.removedOnCompletion = NO;
    [view.layer addAnimation:momAnimation forKey:@"animateLayer"];
}


@end






@interface TotalRankHeader()

//第一名
@property (nonatomic, weak)RankUserInfoHeaderView *firstUserInfoV;

//第二名
@property (nonatomic, weak)RankUserInfoHeaderView *secondUserInfoV;

//第三名
@property (nonatomic, weak)RankUserInfoHeaderView *thirdUserInfoV;

@end

@implementation TotalRankHeader

- (void)dealloc
{
    [_firstUserInfoV removeFromSuperview];
    [_secondUserInfoV removeFromSuperview];
    [_thirdUserInfoV removeFromSuperview];
    
    _firstUserInfoV = nil;
    _secondUserInfoV = nil;
    _thirdUserInfoV = nil;
}


- (instancetype)init
{
    CGFloat scale = 868.0/750;
    CGFloat height = kScreenWidth*scale;
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    CGFloat scale = 868.0/750;
    CGFloat height = kScreenWidth*scale;
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:self.bounds];
    bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    bgImageV.clipsToBounds = YES;
    [self addSubview:bgImageV];
    self.bgImageV = bgImageV;
}


- (void)setDataArray:(NSArray *)dataArray{
    
    [self.firstUserInfoV clearUserInfo];
    [self.secondUserInfoV clearUserInfo];
    [self.thirdUserInfoV clearUserInfo];
    
    _dataArray = dataArray;
    if (dataArray.count == 0) {
        
        return;
    }
    for (int i = 0; i < dataArray.count; i++) {
        if (i == 0) {//第一名
            if (self.delegate) {
                [self.delegate showUserInfo:self.dataArray[i] userHeaderView:self.firstUserInfoV];
            }
        }else if(i == 1){//第二名
            if (self.delegate) {
                [self.delegate showUserInfo:self.dataArray[i] userHeaderView:self.secondUserInfoV];
            }
        }else{//第三名
            if (self.delegate) {
                [self.delegate showUserInfo:self.dataArray[i] userHeaderView:self.thirdUserInfoV];
            }
        }
    }
}

- (void)btnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TotalRankHeader:clickIndex:)]) {
        [self.delegate TotalRankHeader:self clickIndex:btn.tag];
    }
}


- (RankUserInfoHeaderView *)firstUserInfoV{
    if (!_firstUserInfoV) {
        CGFloat pt = kScreenWidth/375.0;
        CGFloat firstW = 100*pt;
        RankUserInfoHeaderView *firstUserInfoV = [[RankUserInfoHeaderView alloc] initWithFrame:CGRectMake(0, 80*pt, firstW, firstW) rankNo:1];
        firstUserInfoV.tag = 0;
        [firstUserInfoV addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:firstUserInfoV];
        firstUserInfoV.centerX = self.width/2.0;
        _firstUserInfoV = firstUserInfoV;
    }
    return _firstUserInfoV;
}

- (RankUserInfoHeaderView *)secondUserInfoV{
    if (!_secondUserInfoV) {
        CGFloat pt = kScreenWidth/375.0;
        CGFloat otherW = 90*pt;
        RankUserInfoHeaderView *secondUserInfoV = [[RankUserInfoHeaderView alloc] initWithFrame:CGRectMake(25*pt, 120*pt, otherW, otherW) rankNo:2];
        secondUserInfoV.tag = 1;
        [secondUserInfoV addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:secondUserInfoV];
        _secondUserInfoV = secondUserInfoV;
    }
    return _secondUserInfoV;
}

- (RankUserInfoHeaderView *)thirdUserInfoV{
    if (!_thirdUserInfoV) {
        CGFloat pt = kScreenWidth/375.0;
        CGFloat otherW = 90*pt;
        RankUserInfoHeaderView *thirdUserInfoV = [[RankUserInfoHeaderView alloc] initWithFrame:CGRectMake(kScreenWidth-otherW-25*pt, 140*pt, otherW, otherW) rankNo:3];
        thirdUserInfoV.tag = 2;
        [thirdUserInfoV addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:thirdUserInfoV];
        _thirdUserInfoV = thirdUserInfoV;
    }
    return _thirdUserInfoV;
}

@end
