//
//  UserObtainTipView.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/31.
//  Copyright © 2020 . All rights reserved.
//

#import "UserObtainTipView.h"
#import <Masonry.h>
#import <libProjModel/ApiElasticFrameModel.h>
#import <SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibTools/LibTools.h>

@implementation UserObtainTipView

- (instancetype)initContentInfo:(ApiElasticFrameModel *)tipsModel
{
    self = [super initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 100)];
    if (self) {
        switch (tipsModel.type) {
            case 1:  ///1用戶升级
            {
                [self createUpgradeView:tipsModel];
            }
                break;
            case 2:  ///完成任务
            {
                [self createTaskView:tipsModel];
            }
                break;
            case 3:   ///获得勋章
            {
                [self createMedalView:tipsModel];
            }
                break;
            default:
                break;
        }
    }
    return self;
}

///MARK: 创建升级提示弹窗 type = 1
- (void)createUpgradeView:(ApiElasticFrameModel *)model{
    
    ///背景图标
    UIImageView *bgImageV = [[UIImageView alloc] init];
    [self addSubview:bgImageV];
    /// childType: 1:用户等级升级  2：主播等级升级  3：财富等级升级
    NSString *levelStr = @"";
    switch (model.childType) {
        case 1:   ///用户升级
        {
            levelStr = kLocalizationMsg(@"用户");
            bgImageV.image = [UIImage imageNamed:@"tips_upgrade_user"];
        }
            break;
        case 2:   ///主播等级
        {
            levelStr = kLocalizationMsg(@"主播");
            bgImageV.image = [UIImage imageNamed:@"tips_upgrade_user"];
        }
            break;
        case 3:   ///财富升级
        {
            levelStr = kLocalizationMsg(@"财富");
            bgImageV.image = [UIImage imageNamed:@"tips_upgrade_orangeBg"];
        }
            break;
        default:
        {
            bgImageV.image = [UIImage imageNamed:@"tips_upgrade_user"];
        }
            break;
    }
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(20);
        make.right.equalTo(self).mas_equalTo(-20);
        make.height.mas_equalTo(34);
        make.bottom.equalTo(self);
    }];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.text = kLocalizationMsg(@"恭喜");
    titleL.font = [UIFont systemFontOfSize:13];
    titleL.textColor = [UIColor whiteColor];
    [bgImageV addSubview:titleL];
    
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.layer.masksToBounds = YES;
    [userIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    [bgImageV addSubview:userIcon];
    
    UILabel *conenctL = [[UILabel alloc] init];
    conenctL.font = [UIFont systemFontOfSize:13];
    conenctL.text = [NSString stringWithFormat:kLocalizationMsg(@"%@ 升级到%@%@"),model.userName,levelStr,model.grade];
    conenctL.textColor = [UIColor whiteColor];
    [bgImageV addSubview:conenctL];

    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageV).mas_offset(20);
        make.centerY.equalTo(bgImageV);
        make.right.equalTo(userIcon.mas_left).mas_offset(-5);
        make.width.equalTo(@(30));
    }];
    
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(bgImageV);
        make.right.equalTo(conenctL.mas_left).mas_offset(-10);
    }];
    
    [conenctL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgImageV);
        make.right.equalTo(bgImageV).mas_offset(-10);
        
    }];
    
    [bgImageV layoutIfNeeded];
    bgImageV.layer.cornerRadius = 8.0;
    [userIcon layoutIfNeeded];
    userIcon.layer.cornerRadius = userIcon.frame.size.height/2.0;
}


///MARK: - 创建任务弹窗 -
- (void)createTaskView:(ApiElasticFrameModel *)model{
    
    ///背景图标
    
    UIImageView *bgImageV = [[UIImageView alloc] init];
    [self addSubview:bgImageV];
    bgImageV.image = [UIImage imageNamed:@"tips_task_white"];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(20);
        make.right.equalTo(self).mas_equalTo(-20);
        make.height.mas_equalTo(34);
        make.bottom.equalTo(self);
    }];
    
    ///childType: 1:用户任务（限时任务）  2：主播任务（累计任务）
    
    UILabel *conenctL = [[UILabel alloc] init];
    conenctL.font = [UIFont systemFontOfSize:13];
    conenctL.text = model.content;
    conenctL.textColor = [UIColor blackColor];
    
    NSAttributedString *taskStr = [[NSAttributedString alloc] initWithString:model.taskName attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14]}];
    
    NSString *taskPoint = [NSString stringWithFormat:@"+%d",model.taskPoint];
    NSAttributedString *experienceStr = [[NSAttributedString alloc] initWithString:taskPoint attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:kRGB_COLOR(@"#FF711C")}];
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:kLocalizationMsg(@" 获得经验 ") attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [muStr insertAttributedString:taskStr atIndex:0];
    [muStr appendAttributedString:experienceStr];
    
    conenctL.attributedText = muStr;
    
    [bgImageV addSubview:conenctL];
    [conenctL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bgImageV);
    }];

    [bgImageV layoutIfNeeded];
    bgImageV.layer.cornerRadius = 8.0;
}

///MARK: 创建勋章提示弹窗
- (void)createMedalView:(ApiElasticFrameModel *)model{
    ///背景图标
    UIImageView *bgImageV = [[UIImageView alloc] init];
    [self addSubview:bgImageV];
    [bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(12);
        make.right.equalTo(self).mas_equalTo(-12);
        make.height.mas_equalTo(80);
        make.bottom.equalTo(self);
    }];
    
    UIImageView *userIcon = [[UIImageView alloc] init];
    userIcon.layer.masksToBounds = YES;
    [userIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getDefaultImage]];
    [bgImageV addSubview:userIcon];
    
    UIView *centerV = [[UIView alloc] init];
    [bgImageV addSubview:centerV];
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.text = [NSString stringWithFormat:kLocalizationMsg(@"恭喜【%@】"),model.userName];
    titleL.font = [UIFont systemFontOfSize:13];
    titleL.textColor = [UIColor whiteColor];
    [centerV addSubview:titleL];
    
    ///type = 3时 childType: 1:普通勋章  2：财富勋章  3：贵族勋章
    switch (model.childType) {
        case 1:   ///普通
        {
            bgImageV.image = [UIImage imageNamed:@"tips_medal_normal"];
            titleL.textColor = kRGB_COLOR(@"#FFCC5D");
        }
            break;
        case 2:   ///财富
        {
            bgImageV.image = [UIImage imageNamed:@"tips_medal_orangeBg"];
            titleL.textColor = [UIColor whiteColor];
        }
            break;
        case 3:   ///VIp
        {
            bgImageV.image = [UIImage imageNamed:@"tips_medal_VIP"];
            titleL.textColor = kRGB_COLOR(@"#FFCC5D");
        }
            break;
        default:
        {
            bgImageV.image = [UIImage imageNamed:@"tips_medal_normal"];
            titleL.textColor = kRGB_COLOR(@"#FFCC5D");
        }
            break;
    }
    
    UILabel *conenctL = [[UILabel alloc] init];
    conenctL.font = [UIFont systemFontOfSize:13];
    conenctL.text = [NSString stringWithFormat:kLocalizationMsg(@"获得 %@"),model.medalName.length>0?model.medalName:@""];
    conenctL.textColor = [UIColor whiteColor];
    [centerV addSubview:conenctL];
    
    UIImageView *medalImgV = [[UIImageView alloc] init];
    medalImgV.contentMode = UIViewContentModeScaleAspectFit;
    [medalImgV sd_setImageWithURL:[NSURL URLWithString:model.medalLogo] placeholderImage:[ProjConfig getDefaultImage]];
    [bgImageV addSubview:medalImgV];

    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.equalTo(bgImageV);
        make.left.equalTo(bgImageV).mas_offset(18);
        make.right.equalTo(centerV.mas_left).mas_offset(-15);
    }];
    
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(medalImgV.mas_left).mas_offset(-15);
        make.centerY.equalTo(bgImageV);
    }];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(centerV);
        make.bottom.equalTo(conenctL.mas_top).mas_offset(-8);
    }];

    [conenctL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(centerV);
    }];
    
    [medalImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImageV).mas_offset(5);
        make.bottom.equalTo(bgImageV).mas_offset(-5);
        make.right.equalTo(bgImageV).mas_offset(-30);
        make.width.equalTo(medalImgV.mas_height);
    }];
    
    [bgImageV layoutIfNeeded];
    bgImageV.layer.cornerRadius = 8.0;
    [userIcon layoutIfNeeded];
    userIcon.layer.cornerRadius = userIcon.frame.size.height/2.0;
}


@end
