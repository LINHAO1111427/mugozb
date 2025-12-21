//
//  InviteRecordTableViewCell.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/10.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "InviteRecordTableViewCell.h" 
#import <LibProjModel/UserInvitationVOModel.h>

@interface InviteRecordTableViewCell ()
@property (nonatomic, strong)UIImageView *avterImageV;
@property (nonatomic, strong)UILabel *nameL;//昵称
@property (nonatomic, strong)UILabel *timeL;//时间
@property (nonatomic, strong)UILabel *totalL;//累计
@property (nonatomic, strong)UILabel *getL;//获得
@end
@implementation InviteRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    UIImageView *avterImageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 50, 50)];
    avterImageV.contentMode = UIViewContentModeScaleAspectFill;
    avterImageV.layer.cornerRadius = 25;
    avterImageV.clipsToBounds = YES;
    self.avterImageV= avterImageV;
    [self.contentView addSubview:avterImageV];
    
    CGFloat priceW = 150;
    UILabel *totalL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-priceW-20, avterImageV.y+3, priceW, 20)];
    totalL.textColor = kRGB_COLOR(@"#666666");
    totalL.font = [UIFont boldSystemFontOfSize:14];
    totalL.textAlignment = NSTextAlignmentRight;
    self.totalL = totalL;
    [self.contentView addSubview:totalL];
    
    UILabel *getL = [[UILabel alloc]initWithFrame:CGRectMake(totalL.x, avterImageV.maxY-23, priceW, 20)];
    getL.textColor = kRGB_COLOR(@"#666666");
    getL.font = [UIFont boldSystemFontOfSize:14];
    getL.textAlignment = NSTextAlignmentRight;
    self.getL = getL;
    [self.contentView addSubview:getL];
    
    
    UILabel *nameL = [[UILabel alloc]initWithFrame:CGRectMake(avterImageV.maxX+10, totalL.y, totalL.x-(avterImageV.maxX+10), 20)];
    nameL.textColor = kRGB_COLOR(@"#333333");
    nameL.font = [UIFont boldSystemFontOfSize:15];
    nameL.textAlignment = NSTextAlignmentLeft;
    self.nameL = nameL;
    [self.contentView addSubview:nameL];
    
    UILabel *timeL = [[UILabel alloc]initWithFrame:CGRectMake(nameL.x, getL.y, nameL.width, 20)];
    timeL.textColor = kRGB_COLOR(@"#999999");
    timeL.font = [UIFont boldSystemFontOfSize:14];
    timeL.textAlignment = NSTextAlignmentLeft;
    self.timeL = timeL;
    [self.contentView addSubview:timeL];
    
}

- (void)setModel:(UserInvitationVOModel *)model{
    _model = model;
    [self.avterImageV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getAppIcon]];
    self.nameL.text = model.username;
    NSString *timeStr = [model.createTime timeStringWithDateFormat:@"yyyy-MM-dd"];
    self.timeL.text = timeStr;
    
    NSString *toalMoney = [NSString stringWithFormat:@"¥%.1f",model.totalCharge];
    NSString *totalStr = [NSString stringWithFormat:kLocalizationMsg(@"累计充值 %@"),toalMoney];
    NSMutableAttributedString *totalAtt = [[NSMutableAttributedString alloc]initWithString:totalStr];
    [totalAtt addAttributes:@{NSForegroundColorAttributeName:kRGB_COLOR(@"#333333"),NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:[totalStr rangeOfString:toalMoney]];
    [totalAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]} range:[totalStr rangeOfString:@"¥"]];
    self.totalL.attributedText = totalAtt;
    
    NSString *getMoney = [NSString stringWithFormat:@"¥%.1f",model.totalAmount];
    NSString *getStr = [NSString stringWithFormat:kLocalizationMsg(@"获得佣金 %@"),getMoney];
    NSMutableAttributedString *getAtt = [[NSMutableAttributedString alloc]initWithString:getStr];
    [getAtt addAttributes:@{NSForegroundColorAttributeName:[ProjConfig normalColors],NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:[getStr rangeOfString:getMoney]];
    [getAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9],NSForegroundColorAttributeName:[ProjConfig normalColors]} range:[getStr rangeOfString:@"¥"]];
    self.getL.attributedText = getAtt;
}
@end
