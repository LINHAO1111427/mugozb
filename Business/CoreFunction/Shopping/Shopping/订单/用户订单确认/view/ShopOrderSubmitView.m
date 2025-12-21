//
//  ShopOrderSubmitView.m
//  Shopping
//
//  Created by klc on 2020/7/20.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ShopOrderSubmitView.h"
#import <LibProjModel/ShopCarModel.h>

@interface ShopOrderSubmitView()

@property (nonatomic, strong)UILabel *amountLabel;//金额
@end
@implementation ShopOrderSubmitView
 - (instancetype)initWithFrame:(CGRect)frame{
     self = [super initWithFrame:frame];
     if (self) {
         [self createUI];
     }
     return self;
 }
 - (void)createUI{
     self.backgroundColor = [UIColor whiteColor];
     
     UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-kSafeAreaBottom)];
     [self addSubview:contentV];
     
     //提交订单
     UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width-112, 0, 100, 40)];
     submitBtn.centerY = contentV.height/2.0;
     submitBtn.layer.cornerRadius = 20;
     submitBtn.clipsToBounds = YES;
     submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
     [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [submitBtn setTitle:kLocalizationMsg(@"提交订单") forState:UIControlStateNormal];
     [submitBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#FF5500")] forState:UIControlStateNormal];
     [submitBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#DEDEDE")] forState:UIControlStateDisabled];
     [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:submitBtn];
     
     _amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, self.width-24-100-25, 20)];
     _amountLabel.centerY = contentV.height/2.0;
     _amountLabel.textAlignment = NSTextAlignmentRight;
     _amountLabel.font = [UIFont systemFontOfSize:14];
     _amountLabel.textColor = kRGB_COLOR(@"#666666");
     [self addSubview:_amountLabel];
     
     UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 1.0)];
     line.backgroundColor = kRGB_COLOR(@"#F6F6F6");
     [self addSubview:line];
 }


- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    CGFloat money = 0.0f;
    NSInteger num = 0;
    for (NSDictionary *dict in dataArr) {
        NSArray *commodityList = dict[@"commodityList"];
        for (ShopCarModel *model in commodityList) {
            money += model.goodsPrice *model.goodsNum;
            num += 1;
        }
    }
    
    NSMutableAttributedString *attri;
       NSTextAttachment *attach = [[NSTextAttachment alloc]init];
       attach.image = [UIImage imageNamed:@"shop_icon_rmb"];
       attach.bounds = CGRectMake(0, 0, 10, 10);
       NSAttributedString *attImg = [NSAttributedString attributedStringWithAttachment:attach];
       NSString *preStr = [NSString stringWithFormat:kLocalizationMsg(@"共%ld件,合计:"),(long)num];
       NSString *lastStr = [NSString stringWithFormat:@"%.2f",money];
       NSString *str = [NSString stringWithFormat:@"%@%@",preStr,lastStr];
       attri = [[NSMutableAttributedString alloc]initWithString:str];
       [attri insertAttributedString:attImg atIndex:preStr.length];
       [attri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:kRGB_COLOR(@"#FB0035")} range:NSMakeRange(preStr.length+1, lastStr.length)];
       self.amountLabel.attributedText = attri;
}

- (void)submitBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ShopOrderSubmitViewSubmitBtnClick)]) {
        [self.delegate ShopOrderSubmitViewSubmitBtnClick];
    }
}



@end
