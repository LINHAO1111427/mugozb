//
//  userGuradDetailTableCell.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/16.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "userGuradDetailTableCell.h"
#import <LibProjModel/GuardUserVOModel.h>

@interface userGuradDetailTableCell ()
@property (nonatomic, strong)UIImageView *bgImageV;
@property (nonatomic, strong)UIImageView *bigImageV;
@property (nonatomic, strong)UIImageView *smallImageV;
@property (nonatomic, strong)UIImageView *connectImageV;// 中间星星
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *dayL;
@property (nonatomic, strong)UILabel *giftL;
@property (nonatomic, strong)UIButton *renewBtn;//续费按钮
@end

@implementation userGuradDetailTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
}
- (void)creatUI{
    CGFloat pt = kScreenWidth/375.0;
    CGFloat height = 150*pt;
    UIImageView *bgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    bgImageV.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImageV = bgImageV;
    bgImageV.userInteractionEnabled = YES;
    [self.contentView addSubview:bgImageV];

    CGFloat big_imageW = 86;
    CGFloat small_imageW = 40;
    UIImageView *bigImageV = [[UIImageView alloc]initWithFrame:CGRectMake(32*pt, 0, big_imageW, big_imageW)];
    bigImageV.layer.cornerRadius = big_imageW/2.0;
    bigImageV.clipsToBounds = YES;
    bigImageV.layer.borderWidth = 1.0;
    bigImageV.layer.borderColor = [UIColor whiteColor].CGColor;
    bigImageV.centerY = bgImageV.height/2.0;
    self.bigImageV = bigImageV;
    [self.contentView addSubview:bigImageV];
    
    UIImageView *smallImageV = [[UIImageView alloc]initWithFrame:CGRectMake(bigImageV.maxX-20, 0, small_imageW, small_imageW)];
    smallImageV.y = bigImageV.maxY-40;
    smallImageV.layer.cornerRadius = small_imageW/2.0;
    smallImageV.clipsToBounds = YES;
    smallImageV.layer.borderWidth = 1.0;
    smallImageV.layer.borderColor = [UIColor whiteColor].CGColor;
    self.smallImageV = smallImageV;
    [self.contentView addSubview:smallImageV];
    
    UIImageView *connectImageV = [[UIImageView alloc]initWithFrame:CGRectMake(bigImageV.maxX-15*pt-25, smallImageV.maxY-10-25, 50, 50)];
    connectImageV.contentMode = UIViewContentModeScaleAspectFit;
    self.connectImageV = connectImageV;
    [self.contentView addSubview:connectImageV];
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(bigImageV.maxX, bigImageV.y, kScreenWidth-180, 20)];
    titleL.textColor = [UIColor whiteColor];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentCenter;
    self.titleL = titleL;
    [self.contentView addSubview:titleL];
    
    UILabel *dayL = [[UILabel alloc]initWithFrame:CGRectMake(bigImageV.maxX, titleL.maxY+3, kScreenWidth-180, 40)];
    dayL.textColor = [UIColor whiteColor];
    dayL.font= [UIFont systemFontOfSize:12];
    dayL.textAlignment = NSTextAlignmentCenter;
    self.dayL = dayL;
    [self.contentView addSubview:dayL];
    
    UILabel *giftL = [[UILabel alloc]initWithFrame:CGRectMake(bigImageV.maxX, dayL.maxY+3, kScreenWidth-180, 20)];
    giftL.textColor = kRGB_COLOR(@"#FF8164");
    giftL.font= [UIFont boldSystemFontOfSize:12];
    giftL.textAlignment = NSTextAlignmentCenter;
    self.giftL = giftL;
    [self.contentView addSubview:giftL];
    
}
- (void)setGuardModel:(GuardUserVOModel *)guardModel{
    _guardModel = guardModel;
    // 时间
    NSString *dayStr = [NSString stringWithFormat:kLocalizationMsg(@"%@%lld 天"),kLocalizationMsg(@"守护Ta"),guardModel.guardDay];
    NSMutableAttributedString *dayAtt= [[NSMutableAttributedString alloc]initWithString:dayStr];
    [dayAtt addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:25],NSForegroundColorAttributeName:guardModel.isOverdue?kRGB_COLOR(@"#666666"):kRGB_COLOR(@"#FF5E5E")} range:[dayStr rangeOfString:[NSString stringWithFormat:@"%lld",guardModel.guardDay]]];
    self.dayL.attributedText = dayAtt;
    
    //礼物
    NSString *giftStr = [NSString stringWithFormat:kLocalizationMsg(@"赠送礼物 %.0f %@"),guardModel.consumptionAmount,kUnitStr];
    self.giftL.textColor = guardModel.isOverdue?kRGB_COLOR(@"#999999"):kRGB_COLOR(@"#FF8164");
    self.giftL.text  =giftStr;

    if (guardModel.isOverdue) {//过期
        self.bgImageV.image = [UIImage imageNamed:@"icon_mine_guard_cell_fail"];
        self.connectImageV.image = [UIImage imageNamed:@"icon_mine_guard_fail"];
        self.renewBtn.hidden = NO;
    }else{
        self.bgImageV.image = [UIImage imageNamed:@"icon_mine_guard_cell_normal"];
        self.connectImageV.image = [UIImage imageNamed:@"icon_mine_guard_normal"];
        self.renewBtn.hidden = YES;
    }
    self.titleL.text = [NSString stringWithFormat:@"%@",guardModel.username];
    [self.bigImageV sd_setImageWithURL:[NSURL URLWithString:guardModel.userHeadImg] placeholderImage:[ProjConfig getAppIcon]];
    [self.smallImageV sd_setImageWithURL:[NSURL URLWithString:guardModel.anchorIdImg] placeholderImage:[ProjConfig getAppIcon]];
     
     
    [self setNeedsLayout];
}
 
@end
