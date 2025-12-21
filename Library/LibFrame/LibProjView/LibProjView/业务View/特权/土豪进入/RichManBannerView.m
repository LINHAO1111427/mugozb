//
//  RichManBannerView.m
//  LiveCommon
//
//  Created by ssssssss on 2020/8/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "RichManBannerView.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/ApiSimpleMsgRoomModel.h>
#import <LibProjModel/AppJoinChatRoomMsgVOModel.h>

@interface RichManBannerView ()
@property (nonatomic, weak)UIImageView *userIcon;  ///用户图标
@property (nonatomic, weak)UILabel *showTextL;  ///显示文字
@end

@implementation RichManBannerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self createView];
    }
    return self;
}


- (void)createView{
    UIImageView *bannerView = [[UIImageView alloc] init];
    bannerView.layer.masksToBounds = YES;
    bannerView.image = [UIImage imageNamed:@"rich_man_join_room"];
    bannerView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:bannerView];
    
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(43);
        make.height.mas_equalTo(65);
    }];
    [bannerView layoutIfNeeded];
    bannerView.layer.cornerRadius = bannerView.height/2.0;

    ///用户
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:userIcon];
    _userIcon = userIcon;
    
    ///显示文字
    UILabel *showTextL = [[UILabel alloc] init];
    showTextL.font = [UIFont systemFontOfSize:12];
    showTextL.textColor = [UIColor whiteColor];
    [bannerView addSubview:showTextL];
    _showTextL = showTextL;

    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self);
    }];
    [_userIcon layoutIfNeeded];
    _userIcon.layer.cornerRadius = 20;
    _userIcon.clipsToBounds = YES;
    _userIcon.layer.borderColor = kRGB_COLOR(@"#D4B777").CGColor;
    _userIcon.layer.borderWidth = 1.0;
    
    [showTextL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bannerView);
        make.right.equalTo(bannerView).mas_offset(-90);
        make.left.equalTo(bannerView).mas_offset(30);
    }];

}


- (void)showRichModel:(ApiSimpleMsgRoomModel *)userMsg{
    NSString *user = [NSString stringWithFormat:@"【%@】",userMsg.userName];
    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"%@进入直播间"),user];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:showStr];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:kRGB_COLOR(@"#624305")} range:[showStr rangeOfString:user]];
     _showTextL.attributedText = attStr;
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:userMsg.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    
}


- (void)showRichForMsgModel:(AppJoinChatRoomMsgVOModel *)model{
    NSString *user = [NSString stringWithFormat:@"【%@】",model.userName];
    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"%@进入聊天室"),user];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:showStr];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:kRGB_COLOR(@"#624305")} range:[showStr rangeOfString:user]];
     _showTextL.attributedText = attStr;
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:model.userAvatar] placeholderImage:[ProjConfig getDefaultImage]];
}

@end
