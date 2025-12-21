//
//  CommodityStandardView.m
//  Shopping
//
//  Created by klc on 2020/7/7.
//  Copyright © 2020 klc. All rights reserved.
//

#import "CommodityStandardView.h"
@interface CommodityStandardView()
@property (nonatomic, strong)UILabel *standardLabel;
@end

@implementation CommodityStandardView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{

   self.num = 1;
   UIView *subV = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.width, self.height-20)];
   subV.backgroundColor = [UIColor whiteColor];
   [self addSubview:subV];
   
   UILabel *selectedLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 15, 40, 20)];
   selectedLabel.text = kLocalizationMsg(@"选择");
   selectedLabel.textColor = kRGB_COLOR(@"#999999");
   selectedLabel.textAlignment = NSTextAlignmentLeft;
   selectedLabel.font = [UIFont systemFontOfSize:14];
   selectedLabel.centerY = subV.height/2.0;
   [subV addSubview:selectedLabel];
   
   _standardLabel = [[UILabel alloc]initWithFrame:CGRectMake(52, 15, self.width-104, 20)];
   _standardLabel.textColor = kRGB_COLOR(@"#333333");
   _standardLabel.textAlignment = NSTextAlignmentLeft;
   _standardLabel.centerY = selectedLabel.centerY;
   _standardLabel.font = [UIFont systemFontOfSize:14.0];
   [subV addSubview:self.standardLabel];
   
   UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-24, 0, 11*14/18.0, 14)];
   imageV.centerY = selectedLabel.centerY;
   imageV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
   [subV addSubview:imageV];
   
   UIButton *btn = [UIButton buttonWithType:0];
   btn.backgroundColor = [UIColor clearColor];
   [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
   [subV addSubview:btn];
   [btn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(subV);
   }];
   
}

- (void)btnClick:(UIButton *)btn{
   if (self.delegate && [self.delegate respondsToSelector:@selector(CommodityStandardViewClick:)]) {
      [self.delegate CommodityStandardViewClick:self];
   }
}

- (void)setNum:(int)num{
   _num = num;
   self.standardLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"%d件"),num];
}
- (void)setModel:(ShopAttrComposeModel *)model{
   _model = model;
   if (model) {
      if (model.name2.length > 0) {
         self.standardLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"%@ %@,1件"),model.name1,model.name2];
      }else{
         self.standardLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"%@,1件"),model.name1];
      }
   }else{
     self.standardLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"1件")];
   }
    
}
- (void)setSelectedAttriModel:(ShopAttrComposeModel *)selectedAttriModel{
   _selectedAttriModel = selectedAttriModel;
   if (selectedAttriModel) {
      if (selectedAttriModel.name2.length > 0) {
         self.standardLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"%@ %@,%d件"),selectedAttriModel.name1,selectedAttriModel.name2,self.num];
      }else{
         self.standardLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"%@,%d件"),selectedAttriModel.name1,self.num];
      }
   }else{
      self.standardLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"%d件"),self.num];
   }
    
}
 
@end
