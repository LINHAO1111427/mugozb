//
//  KLCAvatarsView.m
//  LibProjView
//
//  Created by klc_sl on 2020/12/9.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "KLCAvatarsView.h"
#import <Masonry/Masonry.h>
#import <LibProjBase/LibProjBase.h>
#import <SDWebImage/SDWebImage.h>

@interface KLCAvatarsView ()

@property (nonatomic, weak)UIImageView *userIcon;
@property (nonatomic, weak)UIImageView *borderImg;

@end


@implementation KLCAvatarsView

- (void)layoutIfNeeded{
    [super layoutIfNeeded];
    self.userIcon.layer.cornerRadius = self.userIcon.height/2.0;
}

- (UIImageView *)userIcon{
    if (!_userIcon) {
        UIImageView *userIcon = [[UIImageView alloc] initWithFrame:self.bounds];
        userIcon.contentMode = UIViewContentModeScaleAspectFill;
        userIcon.layer.masksToBounds = YES;
        [self addSubview:userIcon];
        _userIcon = userIcon;
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        UIImageView *borderImg = [[UIImageView alloc] initWithFrame:self.bounds];
        borderImg.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:borderImg];
        _borderImg = borderImg;
        [borderImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).multipliedBy(1.2);
            make.center.equalTo(userIcon);
        }];
    }
    return _userIcon;
}

- (void)showUserIconUrl:(NSString *)iconUrl vipLevel:(int)level {
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[ProjConfig getDefaultImage]];
    if (level > 0) {
        self.borderImg.image = [ProjConfig getVIPBorder:level];
    }
}



@end
