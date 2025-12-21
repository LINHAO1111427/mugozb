//
//  TotalMyRankView.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "TotalMyRankView.h"
#import <SDWebImage.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/RanksDtoModel.h>
#import <LibProjView/SWHTapImageView.h>

@interface TotalMyRankView()

@property (nonatomic, strong)UIButton *indexBtn;
@property (nonatomic, strong)UIImageView *avaterImageV;
@property (nonatomic, strong)UILabel *nameL;
@property (nonatomic, strong)UILabel *numL;
@property (nonatomic, weak)UIView *levelBgV; ///等级背景

///性别
@property (nonatomic, weak)SWHTapImageView *sexImgV;

@end

@implementation TotalMyRankView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    self.backgroundColor = kRGB_COLOR(@"#FFFAFA");
    UIButton *indexBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 25, 25, 25)];
    indexBtn.backgroundColor = [UIColor clearColor];
    indexBtn.enabled = NO;
    [indexBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
    indexBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.indexBtn = indexBtn;

    [self addSubview:indexBtn];
    
    UIImageView *avaterImageV =[[UIImageView alloc]initWithFrame:CGRectMake(indexBtn.maxX+20, 0, 50, 50)];
    avaterImageV.centerY = indexBtn.centerY;
    avaterImageV.clipsToBounds = YES;
    avaterImageV.layer.cornerRadius = 25;
    avaterImageV.contentMode = UIViewContentModeScaleAspectFill;
    self.avaterImageV = avaterImageV;
    [self addSubview:avaterImageV];
    
    UIView *contentV = [[UIView alloc] init];
    [self addSubview:contentV];
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avaterImageV);
        make.left.equalTo(avaterImageV.mas_right).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *nameL = [[UILabel alloc] init];
    nameL.textAlignment = NSTextAlignmentLeft;
    nameL.font = [UIFont systemFontOfSize:14];
    nameL.textColor = kRGB_COLOR(@"#333333");
    [contentV addSubview:nameL];
    self.nameL = nameL;
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(contentV);
    }];

    SWHTapImageView *sexImgV = [[SWHTapImageView alloc] init];
    sexImgV.contentMode = UIViewContentModeScaleAspectFill;
    sexImgV.clipsToBounds = YES;
    sexImgV.layer.cornerRadius = 7.5;
    [contentV addSubview:sexImgV];
    self.sexImgV = sexImgV;
    [sexImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(contentV);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
    
    UILabel *numL = [[UILabel alloc]init];
    numL.textAlignment = NSTextAlignmentRight;
    numL.font = [UIFont systemFontOfSize:13];
    numL.textColor = kRGB_COLOR(@"#333333");
    [self addSubview:numL];
    self.numL = numL;
    [numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avaterImageV);
        make.right.equalTo(self).offset(-20);
        make.left.equalTo(contentV.mas_right).offset(0);
    }];
    
    UIView *levelBgV = [[UIView alloc] init];
    [contentV addSubview:levelBgV];
    self.levelBgV = levelBgV;
    [levelBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.left.equalTo(sexImgV.mas_right).inset(5);
        make.right.equalTo(numL.mas_left).inset(5);
        make.centerY.equalTo(sexImgV);
    }];
    
    [numL setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:(UILayoutConstraintAxisHorizontal)];
    [nameL setContentHuggingPriority:UILayoutPriorityRequired forAxis:(UILayoutConstraintAxisHorizontal)];
    
    ///抗压缩
    [numL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [nameL setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
 
}


- (void)setContributeModel:(RanksDtoModel *)contributeModel{
    _contributeModel = contributeModel;
    [self updateData:contributeModel.sort
              avater:contributeModel.avatar
            username:contributeModel.username
                 num:contributeModel.delta
                 sex:contributeModel.sex
                 age:contributeModel.age
         wealthLevel:contributeModel.wealthGradeImg
          nobleLevel:contributeModel.nobleGradeImg];
}



- (void)updateData:(int)index avater:(NSString *)avater username:(NSString *)username num:(CGFloat)num sex:(int)sex age:(int)age wealthLevel:(nonnull NSString *)wealthLevel nobleLevel:(nonnull NSString *)nobleLevel{
    [self.indexBtn setTitle:@"" forState:UIControlStateNormal];
    if (index == 0 || index > 99) {
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_rank_99"] forState:UIControlStateNormal];
    }else if(index == 1){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank1"] forState:UIControlStateNormal];
    }else if(index == 2){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank2"] forState:UIControlStateNormal];
    }else if(index == 3){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank3"] forState:UIControlStateNormal];
    }else{
        [self.indexBtn setImage:nil forState:UIControlStateNormal];
        [self.indexBtn setTitle:[NSString stringWithFormat:@"%d",index] forState:UIControlStateNormal];
    }
    
    
    [self.avaterImageV sd_setImageWithURL:[NSURL URLWithString:avater] placeholderImage:[ProjConfig getAppIcon]];
    
    self.nameL.text = username;

    NSString *numS = [NSString stringWithFormat:@"%.0f",num];
    self.numL.attributedText = [numS attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -3, 15, 15) before:YES];
    
    //性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:sex age:age role:0];
    if (image) {
        self.sexImgV.image = image;
    }else{
        [self.sexImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    
    self.sexImgV.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:0];
    };
    
    
    ///等级图标
    [self.levelBgV removeAllSubViews];
    CGFloat maxX = 0;
    ///财富等级
    if ([[ProjConfig shareInstence].baseConfig showWeathLevelImage] && wealthLevel.length > 0) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(maxX, 0, 30, 15)];
        [imgV sd_setImageWithURL:[NSURL URLWithString:wealthLevel]];
        [self.levelBgV addSubview:imgV];
        maxX = imgV.maxX+5;
    }
    if (nobleLevel.length > 0) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(maxX, 0, 30, 15)];
        [imgV sd_setImageWithURL:[NSURL URLWithString:nobleLevel]];
        [self.levelBgV addSubview:imgV];
        maxX = imgV.maxX+5;
    }
}


@end
