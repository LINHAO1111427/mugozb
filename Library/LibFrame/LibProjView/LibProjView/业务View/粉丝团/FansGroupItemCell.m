//
//  FansGroupItemCell.m
//  LiveCommon
//
//  Created by klc_sl on 2020/3/19.
//  Copyright © 2020 . All rights reserved.
//

#import "FansGroupItemCell.h"
#import <Masonry/Masonry.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjModel/RanksDtoModel.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>

@implementation FansGroupItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bgView.hidden = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (UIView *)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc] init];
        [self.contentView addSubview:bgView];
        _bgView = bgView;
        
        ///用户头像
        KlcAvatarView *userIcon = [[KlcAvatarView alloc] init];
        [bgView addSubview:userIcon];
        _userIcon = userIcon;
        
        UIView *centerV = [[UIView alloc] init];
        [bgView addSubview:centerV];
        
        ///用户名
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        titleL.textColor = [UIColor blackColor];
        [centerV addSubview:titleL];
        _titleL = titleL;
        
        ///用户等级
        UIImageView *userLevelImgV = [[UIImageView alloc] init];
        [centerV addSubview:userLevelImgV];
        _userLevelImgV = userLevelImgV;
        
        ///财富等级
        UIImageView *wealthLevelImgV = [[UIImageView alloc] init];
        [centerV addSubview:wealthLevelImgV];
        _wealthLevelImgV = wealthLevelImgV;
        
        ///说明
        UILabel *detailL = [[UILabel alloc] init];
        detailL.font = [UIFont systemFontOfSize:12];
        detailL.textColor = [UIColor darkGrayColor];
        [bgView addSubview:detailL];
        _detailL = detailL;
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
            
        [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView).mas_offset(12);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.right.equalTo(centerV.mas_left).mas_offset(-25);
        }];
        [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(userIcon.mas_right).mas_offset(15);
        }];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(centerV);
            make.height.mas_equalTo(20);
            make.bottom.equalTo(userLevelImgV.mas_top).mas_offset(-5);
        }];
        [userLevelImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 15));
            make.left.bottom.equalTo(centerV);
            make.right.equalTo(wealthLevelImgV.mas_left).mas_offset(5);
        }];
        [wealthLevelImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(centerV);
            make.size.mas_equalTo(CGSizeMake(30, 15));
        }];
        
        [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(userIcon);
            make.right.equalTo(self.contentView).mas_offset(-25);
        }];
        
        [bgView layoutIfNeeded];
    }
    
    return _bgView;
    
}

- (void)setUserModel:(RanksDtoModel *)userModel{

    [_userIcon showUserIconUrl:userModel.avatar vipBorderUrl:@""];
    _titleL.text = userModel.username;
    
    NSString *showStr = [NSString stringWithFormat:kLocalizationMsg(@"亲密值 %.0lf"),userModel.delta];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:showStr];
    [muStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:[ProjConfig normalColors]} range:NSMakeRange(0, 3)];
    [_userLevelImgV sd_setImageWithURL:[NSURL URLWithString:((userModel.role > 0)?userModel.anchorGradeImg:userModel.userGradeImg)]];
    [_wealthLevelImgV sd_setImageWithURL:[NSURL URLWithString:userModel.wealthGradeImg]];
    _wealthLevelImgV.hidden = (userModel.wealthGradeImg.length > 0)?NO:YES;
    _detailL.attributedText = muStr;
}


@end
