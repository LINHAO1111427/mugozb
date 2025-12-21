//
//  PkProgressView.m
//  MPVoiceLive
//
//  Created by CH on 2019/12/17.
//  Copyright © 2019 Orely. All rights reserved.
//

#import "PkProgressView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <LiveCommon/LiveComponentMsgListener.h>
#import <LiveCommon/LiveComponentMsgMgr.h>

@interface PkProgressView()
/// 总进度条
@property(nonatomic,strong) UIView *progressBgView;
/// 进度条中间分割
@property(nonatomic,strong) UIImageView *progressCenterImg;
/// 我方进度条
@property(nonatomic,strong) UIView *myProgressView;
/// 我方进度条数值
@property(nonatomic,strong) UILabel *myProgressValueLb;
/// 敌方进度条
@property(nonatomic,strong) UIView *enemyProgressView;
/// 敌方进度条数值
@property(nonatomic,strong) UILabel *enemyProgressValueLb;

@end

@implementation PkProgressView


- (instancetype)init
{
    self = [super init];
    if (self) {

        [self addSubview:self.progressBgView];
        
        [_progressBgView addSubview:self.myProgressView];
        [_progressBgView addSubview:self.enemyProgressView];
        [_progressBgView addSubview:self.myProgressValueLb];
        [_progressBgView addSubview:self.enemyProgressValueLb];
        [_progressBgView addSubview:self.progressCenterImg];

        [_progressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).mas_offset(12);
            make.right.equalTo(self).mas_offset(-12);
            make.bottom.equalTo(self);
        }];
        
        [_progressCenterImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_progressBgView.mas_centerX).multipliedBy(2 * 0.5).priorityMedium();
            make.centerY.equalTo(_progressBgView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(27, 22));
        }];
        
        [_myProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(_progressBgView);
            make.right.equalTo(_progressCenterImg.mas_centerX);
        }];
        
        [_enemyProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(_progressBgView);
            make.left.equalTo(_progressCenterImg.mas_centerX);
        }];
        
        [_myProgressValueLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_progressBgView);
            make.left.equalTo(_progressBgView).offset(5);
        }];
        
        [_enemyProgressValueLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_progressBgView);
            make.right.equalTo(_progressBgView).offset(-5);
        }];
        
        [_progressBgView layoutIfNeeded];
        _progressBgView.layer.cornerRadius = 4.0;
        
        _myProgressValueLb.text = kLocalizationMsg(@"红方 520");
        _enemyProgressValueLb.text = kLocalizationMsg(@"400 蓝方");
    }
    return self;
}


// MARK: - Public
- (void)updateMyTotal:(NSInteger)myTotal enemyTotal:(NSInteger)enemyTotal{
    
    _myProgressValueLb.text = [NSString stringWithFormat:kLocalizationMsg(@"红方 %zi"),myTotal];
    _enemyProgressValueLb.text = [NSString stringWithFormat:kLocalizationMsg(@"%zi 蓝方"),enemyTotal];
    
    CGFloat multiplid;
    if (myTotal == 0 && enemyTotal == 0) {
        multiplid = 0.5;
    }
    else if (myTotal == 0){
        multiplid = 0.000001;
    }
    else if (enemyTotal == 0){
        multiplid = 1;
    }
    else{
        multiplid = myTotal / (CGFloat)(myTotal + enemyTotal);
    }
    
    kWeakSelf(self);
    [UIView animateWithDuration:0.3 animations:^{
        //        [_progressCenterImg mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.centerX.equalTo(_progressBgView.mas_centerX).multipliedBy(2 * multiplid).priorityMedium();
        //        }];
        [weakself.progressCenterImg mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakself.progressBgView.mas_centerX).multipliedBy(2 * multiplid);
            make.centerY.equalTo(weakself.progressBgView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(27, 22));
            
        }];
        [weakself.progressBgView layoutIfNeeded];
        [weakself.progressBgView layoutSubviews];
        
        
    }];
}


// MARK: - Lazy
- (UIView *)progressBgView{
    if (_progressBgView == nil) {
        _progressBgView = [[UIView alloc] init];
        _progressBgView.layer.masksToBounds = YES;
    }
    return _progressBgView;
}


- (UIImageView *)progressCenterImg{
    if (_progressCenterImg == nil) {
        _progressCenterImg = [[UIImageView alloc] init];
        _progressCenterImg.image = [UIImage imageNamed:@"voice_progress_center"];
    }
    return _progressCenterImg;
}

- (UIView *)myProgressView{
    if (_myProgressView == nil) {
        _myProgressView = [[UIView alloc] init];
        _myProgressView.backgroundColor = kRGB_COLOR(@"#D779D8");
    }
    return _myProgressView;
}

- (UIView *)enemyProgressView{
    if (_enemyProgressView == nil) {
        _enemyProgressView = [[UIView alloc] init];
        _enemyProgressView.backgroundColor =kRGB_COLOR(@"#0C8DDF");
    }
    return _enemyProgressView;
}

- (UILabel *)myProgressValueLb{
    if (_myProgressValueLb == nil) {
        _myProgressValueLb = [[UILabel alloc] init];
        _myProgressValueLb.textAlignment = NSTextAlignmentLeft;
        _myProgressValueLb.font = [UIFont systemFontOfSize:11];
        _myProgressValueLb.textColor = [UIColor whiteColor];
    }
    return _myProgressValueLb;
}

- (UILabel *)enemyProgressValueLb{
    if (_enemyProgressValueLb == nil) {
        _enemyProgressValueLb = [[UILabel alloc] init];
        _enemyProgressValueLb.textAlignment = NSTextAlignmentRight;
        _enemyProgressValueLb.font = [UIFont systemFontOfSize:11];
        _enemyProgressValueLb.textColor = [UIColor whiteColor];
    }
    return _enemyProgressValueLb;
}


@end
