//
//  MessageUserInfoView.m

//  MessageInfo
//
//  Created by klc_sl on 2021/8/23.
//

#import "MessageUserInfoView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import "MessageChatModel.h"
#import <LibProjBase/ProjConfig.h>
#import <SDWebImage/SDWebImage.h>

@implementation MessageUserInfoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    KlcAvatarView *avatarV = [[KlcAvatarView alloc] initWithFrame:CGRectMake(10, 8, 40, 40)];
    [self addSubview:avatarV];
    _avatarV = avatarV;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUser)];
    [avatarV addGestureRecognizer:tap];
    
   
    UILabel *userNameL = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 10, 13)];
    userNameL.textColor = [UIColor lightGrayColor];
    userNameL.font = [UIFont systemFontOfSize:12];
    [self addSubview:userNameL];
    _userNameL = userNameL;
    
    SWHTapImageView *sexImgV = [[SWHTapImageView alloc] initWithFrame:CGRectMake(userNameL.maxX+5, 8, 26, 13)];
    sexImgV.contentMode = UIViewContentModeScaleAspectFit;
    sexImgV.clipsToBounds = YES;
    sexImgV.layer.cornerRadius = 6.5;
    [self addSubview:sexImgV];
    self.sexImgV = sexImgV;
    
    UIImageView *level1ImgV = [[UIImageView alloc] initWithFrame:CGRectMake(sexImgV.maxX+5, 8, 26, 13)];
    level1ImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:level1ImgV];
    self.level1ImgV = level1ImgV;
    
    UIImageView *level2ImgV = [[UIImageView alloc] initWithFrame:CGRectMake(level1ImgV.maxX+5, 8, 26, 13)];
    level2ImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:level2ImgV];
    self.level2ImgV = level2ImgV;
    
}


- (void)showUserInfoIsOwner:(BOOL)isOwner isGroup:(BOOL)isGroup userInfo:(nonnull SendMsgUserInfoObj *)sendUserInfo{
    
    [self.avatarV showUserIconUrl:sendUserInfo.avatar vipBorderUrl:sendUserInfo.nobleFrameStr];
    
    if (isGroup) {
        self.userNameL.text = sendUserInfo.userName;
        UIImage *image = [[ProjConfig shareInstence].baseConfig imageGender:sendUserInfo.gender age:sendUserInfo.age role:0];
        if (image) {
            self.sexImgV.image = image;
        }else{
            self.sexImgV.width = 0;
        }
         
        if (sendUserInfo.wealthLevelStr.length > 0) {
            [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:sendUserInfo.wealthLevelStr]];
            [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:sendUserInfo.nobleLevelStr]];
        }else{
            [self.level1ImgV sd_setImageWithURL:[NSURL URLWithString:sendUserInfo.nobleLevelStr]];
            [self.level2ImgV sd_setImageWithURL:[NSURL URLWithString:@""]];
        }
        
    }
    
    CGFloat nameWidth = [self.userNameL.text sizeWithAttributes:@{NSFontAttributeName:self.userNameL.font}].width+5;
    if (isOwner) {
        self.avatarV.x = kScreenWidth - 10 - self.avatarV.width;
        self.userNameL.textAlignment = NSTextAlignmentRight;
        self.userNameL.frame = CGRectMake(kScreenWidth-60-nameWidth, self.avatarV.y, nameWidth, 12);
        self.sexImgV.x = self.userNameL.x-self.sexImgV.width;
        self.level1ImgV.x = self.sexImgV.x-self.level1ImgV.width-5;
        self.level2ImgV.x = self.level1ImgV.x- self.level2ImgV.width-5;
    }else{
        self.avatarV.x = 10;
        self.userNameL.frame = CGRectMake(60, self.avatarV.y, nameWidth, 12);
        self.userNameL.textAlignment = NSTextAlignmentLeft;
        self.sexImgV.x = self.userNameL.maxX;
        self.level1ImgV.x = self.sexImgV.maxX+5;
        self.level2ImgV.x = self.level1ImgV.maxX+5;
    }
    if (self.sexImgV.width != 0) {
        self.sexImgV.btnClick = ^(int type) {
            [[ProjConfig shareInstence].businessConfig showAuthAlertView:[ProjConfig currentVC].view role:0];
        };
    }
     
    self.msgY = self.avatarV.y + (isGroup?(8+15):4);
    self.msgLeftX = 60;
    
}

- (CGFloat)getNameWidth:(NSString *)name{
    UILabel *userNameL = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 10, 12)];
    userNameL.text = name;
    userNameL.font = [UIFont systemFontOfSize:10];
    [self addSubview:userNameL];
    [userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.avatarV.mas_left).offset(-10);
        make.top.equalTo(self.avatarV).offset(0);
    }];
    [userNameL layoutIfNeeded];
    CGFloat width = userNameL.width;
    [userNameL removeFromSuperview];
    return width;
}


- (void)clickUser{
    self.userAvatarClick?self.userAvatarClick():nil;
}

@end
