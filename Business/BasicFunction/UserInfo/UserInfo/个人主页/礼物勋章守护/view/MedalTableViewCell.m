//
//  MedalTableViewCell.m
//  UserInfo
//
//  Created by ssssssss on 2020/1/3.
//

#import "MedalTableViewCell.h"
#import <LibProjModel/AppMedalModel.h>
@interface MedalTableViewCell()
@property(nonatomic,strong)UIImageView *medalImageV;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *tipLabel;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation MedalTableViewCell
 
- (void)layoutSubviews{
    [super layoutSubviews];
    self.tipLabel.center = self.center;
    self.tipLabel.hidden = self.medalsArr.count;
    
}
- (instancetype)initWithIndexPath:(NSIndexPath *)indexpath{
    self = [super init];
    self.indexPath = indexpath;
    if (!self.medalsArr) {
        self.medalsArr = [NSArray array];
    }
    if (self) {
        [self updateUI];
    }
    return self;
}
- (void)setMedalsArr:(NSArray *)medalsArr{
    _medalsArr = medalsArr;
    [self updateUI];
}

- (void)updateUI{
    [self.contentView removeAllSubViews];
    CGFloat scale = 68/51.0;
    CGFloat width =  (kScreenWidth - 24-60)/4.0;
    CGFloat height = width/scale;
    if (self.medalsArr.count > 0) {
        self.tipLabel.hidden = YES;
        for (int i = 0; i < self.medalsArr.count; i++) {
            AppMedalModel *medal = self.medalsArr[i];
            NSInteger row = i/4;
            NSInteger col = i % 4;
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(12+(width+20)*col, 10+row*(height+10+20), width, height)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:medal.medalLogo] placeholderImage:PlaholderImage];
            imageV.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:imageV];
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,imageV.maxY , width, 20)];
            titleLabel.textColor =kRGB_COLOR(@"#333333");
            titleLabel.centerX = imageV.centerX;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:13];
            titleLabel.text = medal.name;
            [self.contentView addSubview:titleLabel];
        }
    }else{
        UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 20)];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:13];
        tipLabel.textColor =kRGB_COLOR(@"#666666");
        if (self.indexPath.section == 0) {
            tipLabel.text = kLocalizationMsg(@"未获得勋章，快去提升等级吧！");
        }else if (self.indexPath.section == 1){
            tipLabel.text = kLocalizationMsg(@"已经获得全部用户勋章");
        }else if (self.indexPath.section == 2){
            tipLabel.text = kLocalizationMsg(@"已经获得全部财富勋章");
        }else if (self.indexPath.section == 3){
            tipLabel.text = kLocalizationMsg(@"已经获得全部贵族勋章");
        }
        self.tipLabel = tipLabel;
        self.tipLabel.hidden = NO;
        [self.contentView addSubview:self.tipLabel];
    }
    [self setNeedsLayout];
    
}

@end
