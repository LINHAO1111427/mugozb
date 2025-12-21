//
//  CAuthorityTipView.m
//  MineCenter
//
//  Created by ssssssss on 2020/11/27.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "CAuthorityTipView.h"
@interface CAuthorityTipView ()
@property (nonatomic, strong)UIImageView *statusImageV;
@property (nonatomic, strong)UILabel *upTipL;
@property (nonatomic, strong)UILabel *downTipL;

@end
@implementation CAuthorityTipView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.statusImageV];
    [self addSubview:self.upTipL];
    [self addSubview:self.downTipL];
    [self addSubview:self.reApplayBtn];
}
- (void)setAStatus:(AuthorityStatus)aStatus{
    _aStatus = aStatus;
    self.reApplayBtn.hidden = YES;
    if (aStatus == AuthorityStatusPassed) {//已通过
        self.statusImageV.image = [UIImage imageNamed:@"icon_authority_review"];
        self.upTipL.text = kLocalizationMsg(@"审核已通过");
        self.downTipL.text = kLocalizationMsg(@"您现在已经是主播了哦~");
    }else if(aStatus == AuthorityStatusReview){//待审核
        self.statusImageV.image = [UIImage imageNamed:@"icon_authority_review"];
        self.upTipL.text = kLocalizationMsg(@"审核中，请耐心等待…");
        self.downTipL.text = kLocalizationMsg(@"预计1个工作日内审核完成");
    }else{//被拒绝
        self.statusImageV.image = [UIImage imageNamed:@"icon_authority_rejected"];
        self.upTipL.text = kLocalizationMsg(@"您的审核未通过");
        self.downTipL.text = self.model.anchorAuditReason;
        self.reApplayBtn.hidden = NO;
    }
}
#pragma mark - lazy
- (UIImageView *)statusImageV{
    if (!_statusImageV) {
        CGFloat y = (kScreenHeight-kNavBarHeight-kSafeAreaBottom-250)/3.0;
        _statusImageV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2.0, y, 150, 150)];
        _statusImageV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _statusImageV;
}
- (UILabel *)upTipL{
    if (!_upTipL) {
        _upTipL = [[UILabel alloc]initWithFrame:CGRectMake(10, _statusImageV.maxY+20, kScreenWidth-20, 20)];
        _upTipL.textAlignment = NSTextAlignmentCenter;
        _upTipL.font = [UIFont systemFontOfSize:14];
        _upTipL.textColor = kRGB_COLOR(@"#666666");
    }
    return _upTipL;
}
- (UILabel *)downTipL{
    if (!_downTipL) {
        _downTipL = [[UILabel alloc]initWithFrame:CGRectMake(10, _upTipL.maxY+10, kScreenWidth-20, 40)];
        _downTipL.numberOfLines = 0;
        _downTipL.textAlignment = NSTextAlignmentCenter;
        _downTipL.font = [UIFont systemFontOfSize:12];
        _downTipL.textColor = kRGB_COLOR(@"#999999");
    }
    return _downTipL;
}
- (UIButton *)reApplayBtn{
    if (!_reApplayBtn) {
        _reApplayBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, _downTipL.maxY + 40, 110, 40)];
        [_reApplayBtn setBackgroundImage:[UIImage createImageSize:_reApplayBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FF54A0"),kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateNormal];
        _reApplayBtn.centerX = self.centerX;
        [_reApplayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reApplayBtn.layer.cornerRadius = 20;
        _reApplayBtn.clipsToBounds = YES;
        _reApplayBtn.hidden = YES;
        _reApplayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_reApplayBtn setTitle:kLocalizationMsg(@"重新认证") forState:UIControlStateNormal];
    }
    return _reApplayBtn;
}
@end
