//
//  InviteRollTableView.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/10.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "InviteRollTableView.h"
#import <LibProjModel/AppUserIncomeRankingDtoModel.h>
#import <LibTools/LibTools.h>

@interface InviteRollUserInfoV : UIView

@property (nonatomic, weak)UIImageView *avterImageV;
@property (nonatomic, weak)UILabel *nameL;

@end

@implementation InviteRollUserInfoV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIImageView *avterImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, (self.height-35)/2.0, 35, 35)];
    avterImageV.contentMode = UIViewContentModeScaleAspectFill;
    avterImageV.layer.cornerRadius = 17.5;
    avterImageV.clipsToBounds = YES;
    avterImageV.layer.masksToBounds = YES;
    avterImageV.layer.borderColor = kRGBA_COLOR(@"#FFF839", 1.0).CGColor;
    avterImageV.layer.borderWidth = 0.8;
    [self addSubview:avterImageV];
    self.avterImageV = avterImageV;

    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(avterImageV.maxX+10, 0, self.width-avterImageV.maxX-20, 20)];
    nameL.textColor = kRGB_COLOR(@"#C70034");
    nameL.centerY = avterImageV.centerY;
    nameL.font = [UIFont systemFontOfSize:12];
    nameL.textAlignment = NSTextAlignmentLeft;
    [self addSubview:nameL];
    self.nameL = nameL;
}

@end


@interface InviteRollTableView ()

@property (nonatomic, strong)InviteRollUserInfoV *oneUserInfoV;

@property (nonatomic, strong)InviteRollUserInfoV *twoUserInfoV;

@end

@implementation InviteRollTableView


- (void)showInfoData:(NSArray<AppUserIncomeRankingDtoModel *> *)infoData{

    self.oneUserInfoV.hidden = YES;
    self.twoUserInfoV.hidden = YES;
    
    if (infoData.count > 0) {
        self.oneUserInfoV.hidden = NO;
        AppUserIncomeRankingDtoModel *firstModel = infoData.firstObject;
        [self.oneUserInfoV.avterImageV sd_setImageWithURL:[NSURL URLWithString:firstModel.avatar] placeholderImage:[ProjConfig getAppIcon]];
        NSString *nameStr = [NSString stringWithFormat:kLocalizationMsg(@"%@  成功邀请%d位好友 / 获得¥%.1f"),firstModel.username,firstModel.numberOfInvitations,firstModel.totalAmount];
        NSMutableAttributedString *att1 = [[NSMutableAttributedString alloc]initWithString:nameStr];
        [att1 addAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#944200"),NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} range:[nameStr rangeOfString:firstModel.username]];
        self.oneUserInfoV.nameL.attributedText = att1;
        
        ///第二个人
        if (infoData.count == 2) {
            AppUserIncomeRankingDtoModel *secondModel = infoData[1];
            if (secondModel) {
                self.twoUserInfoV.hidden = NO;
                [self.twoUserInfoV.avterImageV sd_setImageWithURL:[NSURL URLWithString:secondModel.avatar] placeholderImage:[ProjConfig getAppIcon]];
                NSString *nameStr = [NSString stringWithFormat:kLocalizationMsg(@"%@  成功邀请%d位好友 / 获得¥%.1f"),secondModel.username,secondModel.numberOfInvitations,secondModel.totalAmount];
                NSMutableAttributedString *att2 = [[NSMutableAttributedString alloc]initWithString:nameStr];
                [att2 addAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#944200"),NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} range:[nameStr rangeOfString:secondModel.username]];
                self.twoUserInfoV.nameL.attributedText = att2;
            }
        }
    }
}

- (InviteRollUserInfoV *)oneUserInfoV{
    if (!_oneUserInfoV) {
        _oneUserInfoV = [[InviteRollUserInfoV alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 50, 50)];
        [self addSubview:_oneUserInfoV];
    }
    return _oneUserInfoV;
}

- (InviteRollUserInfoV *)twoUserInfoV{
    if (!_twoUserInfoV) {
        _twoUserInfoV = [[InviteRollUserInfoV alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth - 50, 50)];
        [self addSubview:_twoUserInfoV];
    }
    return _twoUserInfoV;
}


@end
