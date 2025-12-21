//
//  MyInviteBottomView.m
//  MineCenter
//
//  Created by shirley on 2021/12/30.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "MyInviteBottomView.h"
#import <LibProjModel/AppUserIncomeRankingDtoModel.h>

@implementation MyInviteBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self create];
    }
    return self;
}

- (void)create{
    self.backgroundColor = kRGB_COLOR(@"#FFFAFA");

    UIView *contentBgV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-kSafeAreaBottom)];
    [self addSubview:contentBgV];
    
    UIButton *indexBtn = [[UIButton alloc]init];
    indexBtn.backgroundColor = [UIColor clearColor];
    indexBtn.enabled = NO;
    [indexBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
    indexBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.indexBtn = indexBtn;
    [contentBgV addSubview:indexBtn];
    [indexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentBgV).inset(20);
        make.centerY.equalTo(contentBgV);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    UIImageView *avaterImageV =[[UIImageView alloc]init];
    avaterImageV.centerY = indexBtn.centerY;
    avaterImageV.clipsToBounds = YES;
    avaterImageV.layer.cornerRadius = 25;
    avaterImageV.contentMode = UIViewContentModeScaleAspectFill;
    self.avaterImgV = avaterImageV;
    [contentBgV addSubview:avaterImageV];
    [avaterImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(indexBtn.mas_right).inset(20);
        make.centerY.equalTo(indexBtn);
    }];
    
    
    UILabel *nameL = [[UILabel alloc] init];
    nameL.textAlignment = NSTextAlignmentLeft;
    nameL.font = [UIFont systemFontOfSize:14];
    nameL.textColor = kRGB_COLOR(@"#333333");
    nameL.centerY =avaterImageV.centerY;
    [nameL setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [nameL setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    self.nameL = nameL;
    [contentBgV addSubview:nameL];
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avaterImageV.mas_right).inset(20);
        make.centerY.equalTo(avaterImageV);
    }];
    
    UIView *centerV = [[UIView alloc] init];
    [contentBgV addSubview:centerV];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameL.mas_right).inset(5);
        make.right.equalTo(contentBgV).inset(20);
        make.centerY.equalTo(avaterImageV);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *numL = [[UILabel alloc]init];
    numL.textAlignment = NSTextAlignmentRight;
    [numL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [numL setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    numL.font = [UIFont systemFontOfSize:13];
    numL.textColor = kRGB_COLOR(@"#333333");
    self.inviteNumL = numL;
    [centerV addSubview:numL];
    [numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(centerV);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *moneyL = [[UILabel alloc]init];
    moneyL.textAlignment = NSTextAlignmentRight;
    moneyL.font = [UIFont systemFontOfSize:13];
    [moneyL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [moneyL setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    moneyL.textColor = kRGB_COLOR(@"#999999");
    self.getNumL = moneyL;
    [centerV addSubview:moneyL];
    [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(centerV);
        make.height.mas_equalTo(20);
    }];
}

- (void)setMyInviteInfoM:(AppUserIncomeRankingDtoModel *)myInviteInfoM{
    _myInviteInfoM = myInviteInfoM;
    
    if (myInviteInfoM.serialNumber < 1|| myInviteInfoM.serialNumber >= 99) {
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_rank_99"] forState:UIControlStateNormal];
    }else if(myInviteInfoM.serialNumber == 1){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank1"] forState:UIControlStateNormal];
    }else if(myInviteInfoM.serialNumber == 2){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank2)"] forState:UIControlStateNormal];
    }else if(myInviteInfoM.serialNumber == 3){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank3"] forState:UIControlStateNormal];
    }else{
        [self.indexBtn setTitle:[NSString stringWithFormat:@"%d",myInviteInfoM.serialNumber] forState:UIControlStateNormal];
    }
    
    [self.avaterImgV sd_setImageWithURL:[NSURL URLWithString:myInviteInfoM.avatar] placeholderImage:[ProjConfig getAppIcon]];
    self.getNumL.text = [NSString stringWithFormat:kLocalizationMsg(@"获得%.2f元"),myInviteInfoM.totalAmount];
    
    NSString *numS = [NSString stringWithFormat:@"%d",myInviteInfoM.numberOfInvitations];
    NSString *numStr = [NSString stringWithFormat:kLocalizationMsg(@"邀请%@人"),numS];
    NSMutableAttributedString *numAtt = [[NSMutableAttributedString alloc]initWithString:numStr];
    [numAtt addAttributes:@{NSForegroundColorAttributeName:[ProjConfig normalColors],NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:[numStr rangeOfString:numS]];
    self.inviteNumL.attributedText = numAtt;
    
    self.nameL.text = myInviteInfoM.username;
}

@end
