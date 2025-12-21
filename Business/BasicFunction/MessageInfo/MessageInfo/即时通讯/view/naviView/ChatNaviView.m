//
//  ChatNaviView.m
//  Message
//
//  Created by klc_sl on 2021/7/28.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "ChatNaviView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <LibProjBase/LibProjBase.h>
#import <SDWebImage/SDWebImage.h>

@interface ChatNaviView ()
///关注按钮
@property (nonatomic, weak)UIButton *attenBtn;
///排行榜
@property (nonatomic, weak)UIImageView *rankSeatV;
///更多按钮
@property (nonatomic, weak)UIButton *moreBtn;
///排行榜按钮
@property (nonatomic, weak)UIButton *rankBtn;

@property (nonatomic, assign)ConversationChatForType chatType;
///排位第一名
@property (nonatomic, weak)UIImageView *seatImgV;

@end

@implementation ChatNaviView

- (instancetype)initWithChatType:(ConversationChatForType)chatType
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI:chatType];
    }
    return self;
}

- (void)createUI:(ConversationChatForType)chatType{
    self.chatType = chatType;
    
    UIView *bgColorView = [[UIView alloc] initWithFrame:self.bounds];
    bgColorView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self addSubview:bgColorView];
    ///返回
    UIButton *backBtn = [UIButton buttonWithType:0];
    backBtn.frame = CGRectMake(5, kStatusBarHeight, 40, 44);
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(14, 14, 14, 14);
    [backBtn setImage:[UIImage imageNamed:@"main_navbar_back_black"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:backBtn];
    self.backBtn = backBtn;
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.textAlignment = NSTextAlignmentCenter;
    titleL.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    [self addSubview:titleL];
    self.navTitleL = titleL;
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self);
        make.left.equalTo(backBtn.mas_right).offset(10);
        make.centerX.equalTo(self);
    }];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(kScreenWidth-50, kStatusBarHeight, 40, 44);
    moreBtn.contentEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    switch (chatType) {
        case ConversationChatForSignle:
            [moreBtn setImage:[UIImage imageNamed:@"message_liaotian_gengduo"] forState:UIControlStateNormal];
            break;
        case ConversationChatForFamilyGroup:
            [moreBtn setImage:[UIImage imageNamed:@"message_liaotian_gengduo"] forState:UIControlStateNormal];
            break;
        case ConversationChatForSquareGroup:
            [moreBtn setImage:[UIImage imageNamed:@"family_info_userlist"] forState:UIControlStateNormal];
            break;
        case ConversationChatForFansGroup:
            [moreBtn setImage:[UIImage imageNamed:@"family_info_userlist"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [moreBtn addTarget:self action:@selector(moreBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    ///如果是群聊
    if (chatType == ConversationChatForFamilyGroup || chatType == ConversationChatForSquareGroup) {
        UIButton *rankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rankBtn.frame = CGRectMake(moreBtn.x-54, kStatusBarHeight, 44, 44);
        rankBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:rankBtn];
        [rankBtn addTarget:self action:@selector(rankBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        self.moreBtn = rankBtn;
        
        UIImageView *seatImgV = [[UIImageView alloc] init];
        seatImgV.image = [UIImage imageNamed:@"message_rank_seat"];
        seatImgV.layer.masksToBounds = YES;
        seatImgV.layer.cornerRadius = 12.5;
        [rankBtn addSubview:seatImgV];
        self.seatImgV = seatImgV;
        [seatImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.center.equalTo(rankBtn);
        }];
        
        UIImageView *crownImgV = [[UIImageView alloc] init];
        crownImgV.image = [UIImage imageNamed:@"message_rank_crown"];
        [rankBtn addSubview:crownImgV];
        [crownImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.bottom.equalTo(seatImgV).offset(0);
            make.left.equalTo(seatImgV).offset(-0);
        }];
    }
}

- (UIButton *)attenBtn{
    if (!_attenBtn) {
        UIButton *attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        attentionBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        attentionBtn.layer.cornerRadius = 13;
        attentionBtn.layer.masksToBounds = YES;
        [attentionBtn addTarget:self action:@selector(attentionBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:attentionBtn];
        _attenBtn = attentionBtn;
        [attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.moreBtn.mas_left).offset(-10);
            make.centerY.equalTo(self.moreBtn);
            make.size.mas_equalTo(CGSizeMake(60, 26));
        }];
    }
    return _attenBtn;
}


- (void)setUserAtten:(BOOL)isAtten{
    if (isAtten) {
        [self.attenBtn setTitle:kLocalizationMsg(@"已关注") forState:UIControlStateNormal];
        [self.attenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.attenBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#CDCDCD")] forState:UIControlStateNormal];
    }else{
        [self.attenBtn setTitle:kLocalizationMsg(@"关注") forState:UIControlStateNormal];
        [self.attenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.attenBtn setBackgroundImage:[UIImage imageWithColor:[ProjConfig normalColors]] forState:UIControlStateNormal];
    }
}

- (void)reloadSeatUser:(NSString *)userIcon{
    [self.seatImgV sd_setImageWithURL:[NSURL URLWithString:userIcon] placeholderImage:[UIImage imageNamed:@"message_rank_seat"]];
}


- (void)attentionBtnEvent:(UIButton *)btn{
    btn.selected = !btn.selected;
    [self setUserAtten:btn.selected];
    if (self.attenBtnClick) {
        self.attenBtnClick(btn.selected);
    }
}

- (void)moreBtnEvent:(UIButton *)btn{
    if (self.moreBtnClick) {
        self.moreBtnClick(self.chatType);
    }
}

- (void)rankBtnEvent:(UIButton *)btn{
    if (self.rankBtnClick) {
        self.rankBtnClick(self.chatType==0?NO:YES);
    }
}

@end
