//
//  UserContributeRankHeader.m
//  Ranking
//
//  Created by ssssssss on 2020/12/26.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserContributeRankHeader.h"
#import <SDWebImage.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/RanksDtoModel.h>

@interface UserContributeRankHeader()
@property (nonatomic, strong)UIImageView *bgImageV;
//第一名
@property (nonatomic, strong)UIButton *firstBtn;
@property (nonatomic, strong)UILabel *firstNameL;
@property (nonatomic, strong)UILabel *firstCoinL;

//第二名
@property (nonatomic, strong)UIButton *secondBtn;
@property (nonatomic, strong)UILabel *secondNameL;
@property (nonatomic, strong)UILabel *secondCoinL;

//第三名
@property (nonatomic, strong)UIButton *thirdBtn;
@property (nonatomic, strong)UILabel *thirdNameL;
@property (nonatomic, strong)UILabel *thirdCoinL;
@end
@implementation UserContributeRankHeader
- (instancetype)init{
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
    bgImageV.userInteractionEnabled = YES;
    bgImageV.image = [UIImage imageNamed:@"icon_rank_anchor_header"];
    [self addSubview:bgImageV];
    
    CGFloat pt = kScreenWidth/375.0;
    UIImageView *starImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 108*pt, kScreenWidth, 100*kScreenWidth/375.0)];
    starImageV.image = [UIImage imageNamed:@"icon_rank_anchor_header_star"];
    starImageV.userInteractionEnabled = YES;
    [bgImageV addSubview:starImageV];
     
    CGFloat firstW = 100*pt;
    CGFloat otherW = 90*pt;
    {//第一名
        UIImageView *firstBgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 130*pt, firstW, firstW)];
        firstBgImageV.backgroundColor = [UIColor clearColor];
        firstBgImageV.centerX = self.width/2.0;
        firstBgImageV.userInteractionEnabled = YES;
        firstBgImageV.image = [UIImage imageNamed:@"icon_rank_anchor_avater_no.1"];
        [self addSubview:firstBgImageV];
        [self addRotationAnimationOn:firstBgImageV];
        
        UIImageView *headerWareImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, -22*pt, 60*pt, 35*pt)];
        headerWareImageV.image = [UIImage imageNamed:@"icon_rank_anchor_first"];
        headerWareImageV.userInteractionEnabled = YES;
        headerWareImageV.centerX = firstW/2.0;
        [firstBgImageV addSubview:headerWareImageV];
        
        UIButton *firstBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, firstW-90*pt-5, 90*pt, 90*pt)];
        firstBtn.layer.cornerRadius = 90*pt/2.0;
        firstBtn.backgroundColor = [UIColor clearColor];
        firstBtn.clipsToBounds = YES;
        firstBtn.centerX = firstBgImageV.width/2.0;
        firstBtn.tag = 0;
        [firstBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.firstBtn = firstBtn;
        [firstBgImageV addSubview:firstBtn];
        
        
        
        UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, firstBgImageV.maxY+20, firstW, 20)];
        nameL.textAlignment = NSTextAlignmentCenter;
        nameL.font = [UIFont systemFontOfSize:14];
        nameL.centerX = firstBgImageV.centerX;
        nameL.textColor = [UIColor whiteColor];
        nameL.text = kLocalizationMsg(@"暂缺");
        self.firstNameL = nameL;
        [self addSubview:nameL];
        UILabel *coinL = [[UILabel alloc]initWithFrame:CGRectMake(0, nameL.maxY+10, firstW, 20)];
        coinL.textAlignment = NSTextAlignmentCenter;
        coinL.font = [UIFont systemFontOfSize:13];
        coinL.centerX = firstBgImageV.centerX;
        coinL.textColor = [UIColor whiteColor];
        self.firstCoinL = coinL;
        [self addSubview:coinL];
        
    }
    
    {//第二名
        UIImageView *secondBgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(25*pt, 160*pt, otherW, otherW)];
        secondBgImageV.backgroundColor = [UIColor clearColor];
        secondBgImageV.userInteractionEnabled = YES;
        secondBgImageV.image = [UIImage imageNamed:@"icon_rank_anchor_avater_no.2"];
        [self addSubview:secondBgImageV];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addRotationAnimationOn:secondBgImageV];
        });
        
        UIButton *secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, otherW-80*pt-5, 80*pt, 80*pt)];
        secondBtn.layer.cornerRadius = 80*pt/2.0;
        secondBtn.backgroundColor = [UIColor clearColor];
        secondBtn.clipsToBounds = YES;
        secondBtn.tag = 1;
        secondBtn.centerX = secondBgImageV.width/2.0;
        [secondBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.secondBtn = secondBtn;
        [secondBgImageV addSubview:secondBtn];
        
        
        UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, secondBgImageV.maxY+20, otherW, 20)];
        nameL.textAlignment = NSTextAlignmentCenter;
        nameL.font = [UIFont systemFontOfSize:14];
        nameL.centerX = secondBgImageV.centerX;
        nameL.textColor = [UIColor whiteColor];
        nameL.text = kLocalizationMsg(@"暂缺");
        self.secondNameL = nameL;
        [self addSubview:nameL];
        UILabel *coinL = [[UILabel alloc]initWithFrame:CGRectMake(0, nameL.maxY+10, otherW, 20)];
        coinL.textAlignment = NSTextAlignmentCenter;
        coinL.font = [UIFont systemFontOfSize:13];
        coinL.centerX = secondBgImageV.centerX;
        coinL.textColor = [UIColor whiteColor];
        self.secondCoinL = coinL;
        [self addSubview:coinL];
        
    }
    
    {//第三名
        UIImageView *thirdBgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-otherW-25*pt, 160*pt, otherW, otherW)];
        thirdBgImageV.backgroundColor = [UIColor clearColor];
        thirdBgImageV.userInteractionEnabled = YES;
        thirdBgImageV.image = [UIImage imageNamed:@"icon_rank_anchor_avater_no.3"];
        [self addSubview:thirdBgImageV];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addRotationAnimationOn:thirdBgImageV];
        });
        
        UIButton *thirdBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, otherW-75*pt-7.5, 75*pt, 75*pt)];
        thirdBtn.layer.cornerRadius = 75*pt/2.0;
        thirdBtn.backgroundColor = [UIColor clearColor];
        thirdBtn.clipsToBounds = YES;
        thirdBtn.centerX = thirdBgImageV.width/2.0;
        thirdBtn.tag = 2;
        [thirdBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.thirdBtn = thirdBtn;
        [thirdBgImageV addSubview:thirdBtn];
        
        
        UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, thirdBgImageV.maxY+20, otherW, 20)];
        nameL.textAlignment = NSTextAlignmentCenter;
        nameL.font = [UIFont systemFontOfSize:14];
        nameL.centerX = thirdBgImageV.centerX;
        nameL.textColor = [UIColor whiteColor];
        nameL.text = kLocalizationMsg(@"暂缺");
        self.thirdNameL = nameL;
        [self addSubview:nameL];
        UILabel *coinL = [[UILabel alloc]initWithFrame:CGRectMake(0, nameL.maxY+10, otherW, 20)];
        coinL.textAlignment = NSTextAlignmentCenter;
        coinL.font = [UIFont systemFontOfSize:13];
        coinL.centerX = thirdBgImageV.centerX;
        coinL.textColor = [UIColor whiteColor];
        self.thirdCoinL = coinL;
        [self addSubview:coinL];
        
    }
    
}
- (void)addRotationAnimationOn:(UIView *)view{
    CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    momAnimation.fromValue = [NSNumber numberWithFloat:0];
    momAnimation.toValue = [NSNumber numberWithFloat:14];
    momAnimation.duration = 2.1;
    momAnimation.repeatCount = CGFLOAT_MAX;
    momAnimation.fillMode = kCAFillModeForwards;
    momAnimation.autoreverses = YES;
    momAnimation.removedOnCompletion = NO;
    [view.layer addAnimation:momAnimation forKey:@"animateLayer"];
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    if (dataArray.count == 0) {
        NSString *avater = @"";
        NSString *username = @"";
        NSString *numS  =@"";
        
        [self.firstBtn  setImage:[UIImage imageNamed:avater] forState:UIControlStateNormal];
        self.firstNameL.text  =  username;
        self.firstCoinL.text = numS;
        
        [self.secondBtn  setImage:[UIImage imageNamed:avater] forState:UIControlStateNormal];
        self.secondNameL.text  =  username;
        self.secondCoinL.text = numS;
        
        [self.thirdBtn  setImage:[UIImage imageNamed:avater] forState:UIControlStateNormal];
        self.thirdNameL.text  =  username;
        self.thirdCoinL.text = numS;
        
        return;
    }
    for (int i = 0; i < dataArray.count; i++) {
        NSString *avater,*username,*numS;
        RanksDtoModel *model = self.dataArray[i];
        avater = model.avatar;
        username = model.username;
        numS = [NSString stringWithFormat:@" %.0f",model.delta];
        
        NSMutableAttributedString *numAtt = [[NSMutableAttributedString alloc]initWithString:numS];
        NSTextAttachment *attachMent = [[NSTextAttachment alloc]init];
        attachMent.image = [ProjConfig getCoinImage];
        attachMent.bounds = CGRectMake(0, -2, 12, 12);
        NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attachMent];
        [numAtt insertAttributedString:stringImage atIndex:0];
        if (i == 0) {//第一名
            [self.firstBtn sd_setImageWithURL:[NSURL URLWithString:avater] forState:UIControlStateNormal placeholderImage:[ProjConfig getAppIcon]];
            self.firstNameL.text  =  username;
            self.firstCoinL.attributedText = numAtt;
        }else if(i == 1){//第二名
            [self.secondBtn sd_setImageWithURL:[NSURL URLWithString:avater] forState:UIControlStateNormal placeholderImage:[ProjConfig getAppIcon]];
            self.secondNameL.text  =  username;
            self.secondCoinL.attributedText = numAtt;
        }else{//第三名
            [self.thirdBtn sd_setImageWithURL:[NSURL URLWithString:avater] forState:UIControlStateNormal placeholderImage:[ProjConfig getAppIcon]];
            self.thirdNameL.text  =  username;
            self.thirdCoinL.attributedText = numAtt;
        }
         
    }
    
}
- (void)btnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(UserContributeRankHeaderBtnClickWith:)]) {
        [self.delegate UserContributeRankHeaderBtnClickWith:btn.tag];
    }
}
 
 
@end
