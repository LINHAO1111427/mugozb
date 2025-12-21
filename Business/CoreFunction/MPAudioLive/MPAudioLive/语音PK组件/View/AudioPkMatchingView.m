//
//  AudioPkMatchingView.m
//  MPVoiceLive
//
//  Created by CH on 2019/12/19.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "AudioPkMatchingView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjBase/ProjConfig.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibProjModel/VoicePkVOModel.h>

@interface AudioPkMatchingView()

@end


@implementation AudioPkMatchingView

+ (instancetype)initWithMatchingResult:(VoicePkVOModel *)userInfo{
    
    AudioPkMatchingView *matchingV = [[AudioPkMatchingView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 240)];
    [matchingV showPkMatchingView:userInfo];
    [FunctionSheetBaseView showView:matchingV cover:NO];
    return matchingV;
}

- (void)dismissView{
    [FunctionSheetBaseView deletePopView:self];
}


- (void)showPkMatchingView:(VoicePkVOModel *)userInfo{
    
    UILabel *tipsLb = [[UILabel alloc] init];
    tipsLb.text = kLocalizationMsg(@"即将进入PK");
    tipsLb.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    tipsLb.textColor =kRGB_COLOR(@"#333333");
    [self addSubview:tipsLb];
    
    UIImageView *myAnchorIcon = [[UIImageView alloc] init];
    [myAnchorIcon setImage:[ProjConfig getDefaultImage]];
    myAnchorIcon.layer.cornerRadius = 35;
    myAnchorIcon.layer.masksToBounds = YES;
    myAnchorIcon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:myAnchorIcon];
    [myAnchorIcon sd_setImageWithURL:[NSURL URLWithString:userInfo.thisAvatar] placeholderImage:[ProjConfig getDefaultImage]];
    

    UILabel *myAnchorNameLb = [[UILabel alloc] init];
    myAnchorNameLb.textColor = kRGB_COLOR(@"#999999");
    myAnchorNameLb.font = [UIFont systemFontOfSize:14];
    myAnchorNameLb.attributedText = [userInfo.thisUsername attachmentForImage: [ProjConfig getAPPGenderImage:userInfo.thisSex hasAge:NO] bounds:CGRectMake(0, -2, 15, 15) before:NO];
    [self addSubview:myAnchorNameLb];
    
    
    UIImageView *enemyAnchorIcon = [[UIImageView alloc] init];
    [enemyAnchorIcon sd_setImageWithURL:[NSURL URLWithString:userInfo.otherAvatar] placeholderImage:[ProjConfig getDefaultImage]];
    enemyAnchorIcon.layer.cornerRadius = 35;
    enemyAnchorIcon.layer.masksToBounds = YES;
    enemyAnchorIcon.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:enemyAnchorIcon];
    
    UILabel *enemyAnchorNameLb = [[UILabel alloc] init];
    enemyAnchorNameLb.textColor = kRGB_COLOR(@"#999999");
    enemyAnchorNameLb.font = [UIFont systemFontOfSize:14];
    enemyAnchorNameLb.attributedText = [userInfo.otherUsername attachmentForImage:[ProjConfig getAPPGenderImage:userInfo.otherSex hasAge:NO] bounds:CGRectMake(0, -2, 15, 15) before:NO];
    [self addSubview:enemyAnchorNameLb];
    
    [tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-25);
    }];
    
    [myAnchorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tipsLb).offset(-5);
        make.right.equalTo(tipsLb.mas_left).offset(-19);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    [myAnchorNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myAnchorIcon.mas_bottom).offset(10);
        make.centerX.equalTo(myAnchorIcon);
    }];
    
    [enemyAnchorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tipsLb).offset(-5);
        make.left.equalTo(tipsLb.mas_right).offset(19);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    [enemyAnchorNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(enemyAnchorIcon.mas_bottom).offset(10);
        make.centerX.equalTo(enemyAnchorIcon);
    }];
    
}


 
 

@end
