//
//  AllUserBannerView.m
//  LiveCommon
//
//  Created by kalacheng on 2020/9/2.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "AllUserBannerView.h"

#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/ApiSimpleMsgRoomModel.h>

#define kMargin 5
#define kTextHeight 14

@interface AllUserBannerView() 

@property(nonatomic, weak)UIImageView *wealthGradeIv;// 财富等级图片
@property(nonatomic, weak)UILabel *userNameLb;// 用户名称
@property(nonatomic, weak)UILabel *joinRoomLb;// 进入房间

@end


@implementation AllUserBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0.9f;
        self.backgroundColor = kRGB_COLOR(@"#8A7FF8");
        self.layer.cornerRadius = 10;

        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    UIImageView *wealthGradeIv = [[UIImageView alloc] init];
    wealthGradeIv.layer.masksToBounds = YES;
    [self addSubview:wealthGradeIv];
    self.wealthGradeIv = wealthGradeIv;
    
    UILabel *userNameLb = [[UILabel alloc] init];
    userNameLb.font = [UIFont systemFontOfSize:12];
    userNameLb.textColor = kRGB_COLOR(@"#C7FFF4");
    userNameLb.textAlignment = NSTextAlignmentLeft;
    userNameLb.numberOfLines = 1;
    userNameLb.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:userNameLb];
    self.userNameLb = userNameLb;
    
    UILabel *joinRoomLb = [[UILabel alloc] init];
    joinRoomLb.font = [UIFont systemFontOfSize:12];
    joinRoomLb.textColor = kRGB_COLOR(@"#FFFFFF");
    joinRoomLb.textAlignment = NSTextAlignmentRight;
    joinRoomLb.numberOfLines = 1;
    [self addSubview:joinRoomLb];
    self.joinRoomLb = joinRoomLb;
    
    [wealthGradeIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(kMargin);
        make.width.mas_equalTo(31);
        make.height.mas_equalTo(kTextHeight);
    }];
    
    [joinRoomLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-(kMargin * 2));
        make.width.mas_equalTo([self defaultTextWidth]);
        make.height.mas_equalTo(kTextHeight);
    }];
    
    [userNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.equalTo(wealthGradeIv.mas_right).mas_equalTo(kMargin);
        make.right.equalTo(joinRoomLb.mas_left).mas_equalTo(-kMargin);
        make.height.mas_equalTo(kTextHeight);
    }];
}

- (void)showAllUserModel:(ApiSimpleMsgRoomModel *)msgRoomModel {
    NSString *grandeImageStr = @"";
    if (msgRoomModel.role == 1) {
        grandeImageStr = msgRoomModel.anchorGradeImg;
    }else{
        grandeImageStr = msgRoomModel.userGradeImg;
    }
    [_wealthGradeIv sd_setImageWithURL:[NSURL URLWithString:grandeImageStr]];
    _userNameLb.text = msgRoomModel.userName;
    _joinRoomLb.text = msgRoomModel.content;
}

// 默认六个字符的宽度
- (CGFloat)defaultTextWidth {
    CGSize size =[kLocalizationMsg(@"进入了直播间") sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
    return size.width;
}

@end
