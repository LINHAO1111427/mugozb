//
//  LiveBroadcastDataCell.m
//  UserInfo
//
//  Created by klc on 2020/3/20.
//

#import "LiveBroadcastDataCell.h"
#import <LibProjModel/AppUsersLiveDataVOModel.h>

NSString *const LiveBroadcastDataCellIdentifier = @"LiveBroadcastDataCellIdentifier";
@implementation LiveBroadcastDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.sortLabel.textColor =kRGB_COLOR(@"#8E76CD");
    
    [self.coinBtn setTitle:kLocalizationMsg(@"本场收益  0") forState:UIControlStateNormal];
    [self setColorWithCoinBtn];
    
    [self setViewColorWith:self.lookNumView andFrontColor: kRGB_COLOR(@"#F3ECFD") andAfterColor: kRGB_COLOR(@"#DECFFB")];
    self.lookNumLabel.textColor =kRGB_COLOR(@"#AF7CF7");
    self.lookNumTitleL.textColor =kRGB_COLOR(@"#D7A5F9");

    
    [self setViewColorWith:self.addFollowView andFrontColor: kRGB_COLOR(@"#FBECDE") andAfterColor: kRGB_COLOR(@"#F6D3C2")];
     self.addFollowNumL.textColor =kRGB_COLOR(@"#FF7A38");
      self.addFollowNumTitleL.textColor =kRGB_COLOR(@"#F0A27C");
 
    [self setViewColorWith:self.rewardNumView andFrontColor: kRGB_COLOR(@"#EBFAFE") andAfterColor: kRGB_COLOR(@"#C2EEFD")];
    self.rewardNumL.textColor =kRGB_COLOR(@"#36C2F0");
      self.rewardNumTitleL.textColor =kRGB_COLOR(@"#7FDEFF");
//    
    [self setViewColorWith:self.addFansNumView andFrontColor: kRGB_COLOR(@"#FDF7E4") andAfterColor: kRGB_COLOR(@"#F4E7BB")];
    self.addFansNumL.textColor =kRGB_COLOR(@"#F5C828");
      self.addFansNumTitleL.textColor =kRGB_COLOR(@"#F4D668");
    
    [self setViewColorWith:self.giveGiftView andFrontColor: kRGB_COLOR(@"#FBECFD") andAfterColor: kRGB_COLOR(@"#ECCCF4")];
    self.giveGiftNumL.textColor =kRGB_COLOR(@"#DA4DF9");
    self.giveGiftNumTitleL.textColor =kRGB_COLOR(@"#E491F6");
    
    
}

//设置CoinBtn
-(void)setColorWithCoinBtn{
        CGFloat coinBtnW = (kScreenWidth - 20)*0.6;
        self.coinBtn.layer.masksToBounds = YES;
        self.coinBtn.layer.cornerRadius = 18;
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors     = @[(__bridge id) kRGB_COLOR(@"#FB72E2").CGColor, (__bridge id) kRGB_COLOR(@"#9C58FE").CGColor];
        gradientLayer.locations  = @[@0.5, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint   = CGPointMake(1.0, 0);
        gradientLayer.frame      = CGRectMake(0, 0, coinBtnW, 36);
        gradientLayer.cornerRadius = 18;
        [self.coinBtn.layer addSublayer:gradientLayer];
    
}


-(void)setViewColorWith:(UIView *)view andFrontColor:(UIColor *)frontColor andAfterColor:(UIColor *)afterColor{
    
    CGFloat viewW = (kScreenWidth - 58)/3;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 8;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors     = @[(__bridge id)frontColor.CGColor, (__bridge id)afterColor.CGColor];
    gradientLayer.locations  = @[@0.4, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(1.0, 0);
    gradientLayer.frame      = CGRectMake(0, 0, viewW, 65);
    gradientLayer.cornerRadius = 8;
    [view.layer addSublayer:gradientLayer];
     [view.layer insertSublayer:gradientLayer atIndex:0];
}


- (void)setModel:(AppUsersLiveDataVOModel *)model {
    _model = model;
    self.sortLabel.text = [NSString stringWithFormat:@"%d",self.model.number];
   
    [self.coinBtn setTitle: [NSString stringWithFormat:kLocalizationMsg(@"本场收益   %.0f"),self.model.profit] forState:UIControlStateNormal];
    self.durationTimeL.text = [NSString stringWithFormat:@"%lld",self.model.liveTime];
    self.roomNumL.text = [NSString stringWithFormat:@"%lld",self.model.roomId];
    
  
    self.dateLabel.text = [model.startTime timeStringWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.lookNumLabel.text = [NSString stringWithFormat:@"%d",self.model.audienceNumber];
    self.addFollowNumL.text = [NSString stringWithFormat:@"%d",self.model.addFollow];
    self.rewardNumL.text =[NSString stringWithFormat:@"%d",self.model.rewardNumber];
    self.addFansNumL.text =[NSString stringWithFormat:@"%d",self.model.addFansGroup];
    self.giveGiftNumL.text =[NSString stringWithFormat:@"%d",self.model.addGiftNumber];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
