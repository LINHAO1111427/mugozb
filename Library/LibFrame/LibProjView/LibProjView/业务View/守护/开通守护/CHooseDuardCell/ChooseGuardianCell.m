//
//  MGCoinCollectionViewCell.m
//  MPVideoLive
//
//  Created by CH on 2019/7/16.
//  Copyright © 2019 cat. All rights reserved.
//

#import "ChooseGuardianCell.h"
#import <LibTools/LibTools.h>
#import <Masonry/Masonry.h>
#import <LibProjModel/ApiGuardModel.h>
#import <LibProjModel/KLCAppConfig.h>


@interface ChooseGuardianCell()

@property (weak, nonatomic) UIView *bgView;

/** 充值的金币数量 */
@property (weak, nonatomic) UILabel *timeL;

@property (weak, nonatomic) UILabel *coinL;

@end

@implementation ChooseGuardianCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.bgView.hidden = NO;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (UIView *)bgView{
    if (!_bgView) {
        UIView *bgV = [[UIView alloc] init];
        [self.contentView addSubview:bgV];
        _bgView = bgV;
        
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.font = [UIFont boldSystemFontOfSize:14];
        titleLab.textColor = [UIColor blackColor];
        [bgV addSubview:titleLab];
        _timeL = titleLab;
        
        UILabel *detailLab = [[UILabel alloc] init];
        detailLab.font = [UIFont systemFontOfSize:10];
        detailLab.textColor = [UIColor darkGrayColor];
        detailLab.textAlignment = NSTextAlignmentCenter;
        [bgV addSubview:detailLab];
        _coinL = detailLab;
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(bgV);
            make.bottom.equalTo(detailLab.mas_top).mas_offset(-5);
        }];
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(bgV);
        }];
        
        [bgV layoutIfNeeded];
    }
    return _bgView;
}

-(void)setGuardModel:(ApiGuardModel *)guardModel{
    _guardModel = guardModel;
    

    NSString *unit = kLocalizationMsg(@"天");
    ///0天，1月，2年
    switch (guardModel.lengthType) {
        case 1:
            unit = kLocalizationMsg(@"月");
            break;
        case 2:
           unit = kLocalizationMsg(@"年");
            break;
        default:
            break;
    }
    NSString *timeStr = [NSString stringWithFormat:@" %d%@",guardModel.length,unit];
    self.timeL.attributedText = [timeStr attachmentForImage:[UIImage imageNamed:@"live_shouhu_pink"] bounds:CGRectMake(0, -6, 20, 20) before:YES];
    self.coinL.text = [NSString stringWithFormat:@"%0.0lf%@",_guardModel.coin,[KLCAppConfig  unitStr]];

}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    self.backgroundColor = selected?[UIColor whiteColor]:[UIColor groupTableViewBackgroundColor];
    self.layer.borderColor = selected?kRGB(250, 117, 181).CGColor:[UIColor groupTableViewBackgroundColor].CGColor;
    
}




@end
