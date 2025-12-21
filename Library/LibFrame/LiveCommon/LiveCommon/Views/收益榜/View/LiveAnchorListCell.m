//
//  LiveAnchorListCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/23.
//  Copyright © 2020 . All rights reserved.
//

#import "LiveAnchorListCell.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveComponentMsgMgr.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LibProjModel/RanksDtoModel.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjView/SWHTapImageView.h>
@interface LiveAnchorListCell ()

///占位视图
@property (nonatomic, weak) UIView *bgView;

@property (weak, nonatomic) UILabel *numberL;  ///排位

@property (weak, nonatomic) KlcAvatarView *userIcon;  ///用户头像
 
@property (weak, nonatomic) UILabel *titleL;  ///用户名称

@property (weak, nonatomic) UIImageView *level1ImgV;  ///用户等级1

@property (weak, nonatomic) UIImageView *level2ImgV;  ///用户等级2

@property (weak, nonatomic) UILabel *coinL;  ///金币数

@property (weak, nonatomic) SWHTapImageView *genderImgV;  ///性别

@end

@implementation LiveAnchorListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bgView.hidden = NO;
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _userIcon.layer.cornerRadius = _userIcon.height/2.0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        _bgView = bgView;
        
        ///排行
        UILabel *numberLab = [[UILabel alloc] init];
        numberLab.font = [UIFont boldSystemFontOfSize:15];
        numberLab.textColor = [UIColor darkGrayColor];
        numberLab.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:numberLab];
        _numberL = numberLab;
        
        ///用户头像
        KlcAvatarView *imgV = [[KlcAvatarView alloc] init];
        imgV.userInteractionEnabled = YES;
        [bgView addSubview:imgV];
        [imgV addTarget:self action:@selector(UserIconClick:) forControlEvents:UIControlEventTouchUpInside];
        _userIcon = imgV;
        
        ///用户名
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont boldSystemFontOfSize:13];
        titleL.textColor = [UIColor blackColor];
        [bgView addSubview:titleL];
        _titleL = titleL;
        
        ///性别
        SWHTapImageView *genderImgV = [[SWHTapImageView alloc] init];
        genderImgV.contentMode = UIViewContentModeScaleAspectFill;
        [bgView addSubview:genderImgV];
        genderImgV.layer.masksToBounds = YES;
        genderImgV.layer.cornerRadius = 7.5;
        _genderImgV = genderImgV;
        
        ///等级图标
        UIImageView *levelImg = [[UIImageView alloc] init];
        levelImg.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:levelImg];
        _level1ImgV = levelImg;
        
        UIImageView *level2Img = [[UIImageView alloc] init];
        level2Img.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:level2Img];
        _level2ImgV = level2Img;
        
        ///金币
        UILabel *coinLab = [[UILabel alloc] init];
        coinLab.font = [UIFont systemFontOfSize:12];
        coinLab.textColor = [UIColor blackColor];
        [bgView addSubview:coinLab];
        _coinL = coinLab;
        
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        ///图标
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView).mas_offset(48);
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.right.equalTo(titleL.mas_left).mas_offset(-10);
        }];
        
        ///金币lab
        [coinLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView).mas_offset(-12);
            make.centerY.equalTo(bgView);
        }];
        
        ///用户名称
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgV).offset(2);
        }];
        
        [genderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imgV).offset(-2);
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.left.equalTo(titleL);
            make.right.equalTo(levelImg.mas_left).offset(-5);
        }];

        ///等级
        [levelImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.centerY.equalTo(genderImgV);
            make.right.equalTo(level2Img.mas_left).offset(-5);
        }];
        
        [level2Img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.centerY.equalTo(genderImgV);
        }];
        
        ///排名
        [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView);
            make.right.equalTo(imgV.mas_left);
        }];
        
        [bgView layoutIfNeeded];
    }
    return _bgView;
    
}

- (void)UserIconClick:(UIButton *)btn{
    [LiveComponentMsgMgr sendMsg:LM_ShowUserInfo msgDic:@{@"userID":@(self.voterModel.userId),@"outLiveRoom":@(YES)}];
}


- (void)setVoterModel:(RanksDtoModel *)voterModel {
    _voterModel = voterModel;
    
    NSString *coin = [NSString stringWithFormat:@"%0.0lf",voterModel.delta];
    ///金币
    self.coinL.attributedText = [coin attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -5, 18, 18) before:YES];
    ///图标
    [self.userIcon showUserIconUrl:voterModel.avatar vipBorderUrl:voterModel.nobleAvatarFrame];
    ///用户信息
    self.titleL.text = voterModel.username.length?voterModel.username:@"";
    
    ///性别与角色
    UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:voterModel.sex age:voterModel.age role:voterModel.role];
    if (image) {
        self.genderImgV.image = image;
    }else{
        [self.genderImgV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    
    self.genderImgV.btnClick = ^(int type) {
        [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:voterModel.role];
    };
     
    
    if (voterModel.wealthGradeImg.length > 0) {
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:voterModel.wealthGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:voterModel.nobleGradeImg]];
    }else{
        [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:voterModel.nobleGradeImg]];
        [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
    }
    
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    
    [self showNumberLab:self.numberL number:index];
}


- (void)showNumberLab:(UILabel *)numberL number:(NSInteger)number{
    [numberL.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (number) {
        case 1:
        {
            [self createLeveView:numberL number:number imageName:@"live_list_no1"];
        }
            break;
        case 2:
        {
            [self createLeveView:numberL number:number imageName:@"live_list_no2"];
        }
            break;
        case 3:
        {
            [self createLeveView:numberL number:number imageName:@"live_list_no3"];
        }
            break;
        default:
        {
            numberL.text = [NSString stringWithFormat:@"%zi",number];
        }
            break;
    }
}

- (void)createLeveView:(UILabel *)lab number:(NSInteger)number imageName:(NSString *)imageName{
    lab.text = @"";
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [lab addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(lab);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    UILabel *numL = [[UILabel alloc] init];
    numL.textAlignment = NSTextAlignmentCenter;
    numL.textColor = [UIColor whiteColor];
    numL.font = [UIFont systemFontOfSize:10];
    numL.text = [NSString stringWithFormat:@"%zi",number];
    [imgV addSubview:numL];
    [numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgV);
        make.bottom.equalTo(imgV).mas_offset(-1);
    }];
    
}


@end
