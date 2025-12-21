//
//  HostLevelView.m
//  MineCenter
//
//  Created by klc on 2020/7/29.
//

#import "HostLevelView.h"
#import "TipsArrow.h"
#import <LibProjModel/ApiGradeReWarReModel.h>

@interface HostLevelView ()

kStrong(UILabel, titleLab)
kStrong(UILabel, levelLab)

kStrong(UILabel, currentExpLab)
kStrong(UILabel, remainExpLab)
kStrong(UIStackView, gifStackView)

kStrong(TipsArrow, tipsArrow)
kStrong(UIImageView, progressView)
kStrong(UIView, progressBack)
@end

@implementation HostLevelView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
       
        [self setupSubViews];
        
    }
    return self;
}

-(void)setupSubViews{
    
    _titleLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:kLocalizationMsg(@"主播等级") textColor:[UIColor blackColor] font:kFont(14) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
        make.left.equalTo(self).offset(14);
        make.top.equalTo(self).offset(10);
    }];
    
    UIView *progressBack = [Maker viewWithShadow:NO backColor:kRGB_COLOR(@"#EFEFEF") superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
        make.left.equalTo(self).offset(28);
        make.top.equalTo(self).offset(84);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(6);
    }];
    progressBack.layer.cornerRadius = 3;
    _progressBack = progressBack;
    
    _progressView = [Maker Imv:ImgNamed(@"mine_task_exp_progress") layerCorner:0 superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.top.bottom.equalTo(progressBack);
        make.width.equalTo(progressBack).multipliedBy(0.1);
    }];
    _tipsArrow = [[TipsArrow alloc] initWithFrame:CGRectZero];
    [self addSubview:_tipsArrow];
    [_tipsArrow mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(SIZE(100, 30));
        make.centerX.equalTo(self);
        make.bottom.equalTo(progressBack.mas_top).inset(5);
    }];
    
    
   /*
    UILabel *tipsView= [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:kLocalizationMsg(@"解锁更高等级 获得更高收益") textColor:kRGB_COLOR(@"#BBBBBB") font:kFont(11) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.equalTo(progressBack);
        make.top.equalTo(progressBack.mas_bottom).offset(5);
    }];
    */
    
    _remainExpLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentRight backColor:[UIColor clearColor] text:kLocalizationMsg(@"距离升级：555") textColor:kRGB_COLOR(@"#BBBBBB") font:kFont(11) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.right.equalTo(progressBack);
        make.top.equalTo(progressBack.mas_bottom).offset(5);
    }];
    
}

- (void)setModel:(ApiGradeReWarReModel *)model{
    
    _titleLab.text = kStringFormat(kLocalizationMsg(@"主播等级（LV%d）"),model.currLevel);
    _remainExpLab.text = kStringFormat(kLocalizationMsg(@"距离升级：%d"),model.nextLevelEmpirical);
    _tipsArrow.text = kStringFormat(kLocalizationMsg(@"当前经验：%d"),model.nextLevelTotalEmpirical-model.nextLevelEmpirical);
    
    CGFloat muliple = (CGFloat)(model.nextLevelTotalEmpirical-model.nextLevelEmpirical)/model.nextLevelTotalEmpirical;
    muliple = MIN(muliple, 1);
    [_progressView mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.left.top.bottom.equalTo(_progressBack);
        make.width.equalTo(_progressBack).multipliedBy(muliple);
    }];
}

@end
