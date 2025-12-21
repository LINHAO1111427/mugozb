//
//  UserLevelView.m
//  MineCenter
//
//  Created by klc on 2020/7/29.
//

#import "UserLevelView.h"
#import <LibProjModel/ApiGradeReListModel.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/ApiGradeReWarReModel.h>

@interface GiftView : UIControl

kStrong(UIImageView, giftImv)
kStrong(UILabel, nameLab)
@end

@implementation GiftView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _giftImv = [Maker Imv:nil layerCorner:0 superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
           
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(10, 13, 30, 13));
        }];
        
        _nameLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:kLocalizationMsg(@"小汉堡") textColor:kRGB_COLOR(@"#98A1B4") font:kFont(12) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
            
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).inset(10);
        }];
    }
    return self;
}

@end



@interface UserLevelView ()

kStrong(UILabel, titleLab)
kStrong(UILabel, levelLab)

kStrong(UILabel, currentExpLab)
kStrong(UILabel, remainExpLab)
kStrong(UIStackView, gifStackView)

kStrong(UIImageView, progressView)
kStrong(UIView, progressBack)

@end

@implementation UserLevelView



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews{
    
    _titleLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:kLocalizationMsg(@"完成任务获得大礼包") textColor:[UIColor blackColor] font:kFont(14) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.equalTo(self).offset(14);
        make.top.equalTo(self).offset(10);
    }];
    
    _levelLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:kLocalizationMsg(@"当前：lV1") textColor:[UIColor grayColor] font:kFont(12) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.right.equalTo(self).inset(14);
        make.centerY.equalTo(_titleLab);
    }];
    
    UIView *progressBack = [Maker viewWithShadow:NO backColor:kRGB_COLOR(@"#EFEFEF") superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.equalTo(self).offset(24);
        make.top.equalTo(self).offset(44);
        make.right.equalTo(self).inset(24);
        make.height.mas_equalTo(6);
    }];
    progressBack.layer.cornerRadius = 3;
    _progressBack = progressBack;
    
    _progressView = [Maker Imv:ImgNamed(@"mine_task_exp_progress") layerCorner:0 superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.top.bottom.equalTo(progressBack);
        make.width.equalTo(progressBack).multipliedBy(0.6);
    }];
    
    _currentExpLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:kLocalizationMsg(@"经验值：555") textColor:kRGB_COLOR(@"#BBBBBB") font:kFont(11) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.left.equalTo(progressBack);
        make.top.equalTo(progressBack.mas_bottom).offset(5);
    }];
    _remainExpLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentRight backColor:[UIColor clearColor] text:kLocalizationMsg(@"距离升级：555") textColor:kRGB_COLOR(@"#BBBBBB") font:kFont(11) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.right.equalTo(progressBack);
        make.top.equalTo(progressBack.mas_bottom).offset(5);
    }];
    
    _gifStackView = [Maker stackViewAxis:UILayoutConstraintAxisHorizontal distribution:UIStackViewDistributionEqualSpacing alignment:UIStackViewAlignmentCenter space:30 superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
       

        make.centerX.equalTo(progressBack);
        make.top.equalTo(progressBack.mas_bottom).offset(36);
        make.bottom.equalTo(self).inset(14);
        make.width.mas_equalTo(70);
    }];
    
}

-(void)setModel:(ApiGradeReWarReModel *)model{
    
    _model = model;
    _titleLab.hidden = !model.apiGradeReList.count;
    _titleLab.text = kStringFormat(kLocalizationMsg(@"完成任务获得LV%d大礼包"),model.nextLevel);
    _levelLab.text = kStringFormat(kLocalizationMsg(@"当前：LV%d"),model.currLevel);
    CGFloat muliple = (CGFloat)(model.nextLevelTotalEmpirical-model.nextLevelEmpirical)/model.nextLevelTotalEmpirical;
    muliple = MIN(muliple, 1);
    [_progressView mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.left.top.bottom.equalTo(_progressBack);
        make.width.equalTo(_progressBack).multipliedBy(muliple);
    }];
    _currentExpLab.text = kStringFormat(kLocalizationMsg(@"经验值：%d"),(model.nextLevelTotalEmpirical-model.nextLevelEmpirical));
    _remainExpLab.text = kStringFormat(kLocalizationMsg(@"距离升级：%d"),model.nextLevelEmpirical);
    _gifStackView.hidden = !model.apiGradeReList.count;
    [_gifStackView removeAllSubViews];
    if (model.apiGradeReList.count > 0) {
        for (ApiGradeReListModel *giftModel in model.apiGradeReList) {
            
            GiftView *giftView = [[GiftView alloc] initWithFrame:CGRectZero];
            giftView.backgroundColor = kRGB_COLOR(@"#F6F7F9");
            giftView.layer.cornerRadius = 4;
            [_gifStackView addArrangedSubview:giftView];
            
            
            NSString *giftName = nil;
            if (giftModel.type != 1) {
                
                giftName = giftModel.title;
                [giftView.giftImv sd_setImageWithURL:[NSURL URLWithString:giftModel.img]];
            }else{
                
                giftName = kStringFormat(@"%@*%d",kUnitStr,giftModel.number);
                giftView.giftImv.image = [ProjConfig getCoinImage];
            }
            giftView.nameLab.text = giftName;
        }
        if (model.apiGradeReList.count>0) {
            
            [_gifStackView mas_updateConstraints:^(MASConstraintMaker *make) {
               
                make.width.mas_equalTo(70+100*(model.apiGradeReList.count-1));
            }];
        }
    }
}
@end
