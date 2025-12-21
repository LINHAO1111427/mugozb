//
//  MyOrderV.m
//  Shopping
//
//  Created by kalacheng on 2020/6/24.
//  Copyright © 2020 klc. All rights reserved.
//

#import "MyOrderV.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
@interface MyOrderV ()
@property (nonatomic, strong)UILabel *wattingForPayRedL; ///代付款
@property (nonatomic, strong)UILabel *wattingForDeliverRedL; ///待发货
@property (nonatomic, strong)UILabel *wattingForRecevieRedL; ///待收货
@property (nonatomic, strong)UILabel *quitOrderRedL;  ///退货/退款
@end
@implementation MyOrderV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 100, 30)];
    titleL.text = kLocalizationMsg(@"我的订单");
    titleL.textColor = kRGB_COLOR(@"#333333");
    titleL.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:titleL];
    
    
    UILabel *lookL = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 145, 5, 130, 30)];
    lookL.text = kLocalizationMsg(@"查看全部订单");
    lookL.textColor = kRGB_COLOR(@"#999999");
    lookL.textAlignment = NSTextAlignmentRight;
    lookL.font = [UIFont systemFontOfSize:12];
    [self addSubview:lookL];
    lookL.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookLTap)];
    [lookL addGestureRecognizer:tap];
    
    
    
    UIView *linkView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.width, 0.3)];
    linkView.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self addSubview:linkView];
    
    [self updateFeaturesView];
     
}

- (void)updateFeaturesView{
    
    CGFloat width = (self.width-100)/4;
    CGFloat space = 20;
  
    NSInteger num = 4;
    NSArray *titleArr = @[kLocalizationMsg(@"待付款"),kLocalizationMsg(@"待发货"),kLocalizationMsg(@"待收货"),kLocalizationMsg(@"退货/退款")];
    
    NSArray *imageArr = @[@"shop_daifukuan",@"shop_daifahuo",@"shop_daishouhuo",@"shop_tuikuanshouhou"];
    
    
    UIView *featuresView = [[UIView alloc]initWithFrame:CGRectMake(20, 55, self.width - 40, self.height - 55)];
    featuresView.backgroundColor = [UIColor clearColor];
    [self addSubview:featuresView];
    
    for (int i = 0; i < num; i++) {
       
        NSInteger row = i/4;
        NSInteger col = i%4;
        UIView *subV = [[UIView alloc]initWithFrame:CGRectMake(col*(width+space), row*(width+20) , width, width + 14)];
        subV.backgroundColor = [UIColor whiteColor];
        [featuresView addSubview:subV];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 8, width - 30, width -30)];
        imageV.image = [UIImage imageNamed:imageArr[i]];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [subV addSubview:imageV];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.maxY, width, 30)];
        titleLabel.textColor = kRGB_COLOR(@"#333333");
        titleLabel.text = titleArr[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12];

        [subV addSubview:titleLabel];
        UIButton *btn = [[UIButton alloc]initWithFrame:subV.bounds];
        btn.tag = 10000+i;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(feastureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [subV addSubview:btn];
        
        UIView *pointBgV = [[UIView alloc] init];
        [subV addSubview:pointBgV];
        pointBgV.layer.borderColor = kRGB_COLOR(@"#FF5500").CGColor;
        pointBgV.layer.cornerRadius = 8;
        pointBgV.hidden = YES;
        pointBgV.layer.borderWidth = 1.0;
        pointBgV.clipsToBounds = YES;
        [pointBgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_right).offset(-5);
            make.bottom.equalTo(imageV.mas_top).offset(10);
            make.height.mas_equalTo(16);
            make.width.mas_greaterThanOrEqualTo(16);
        }];
        
        UILabel *redL = [[UILabel alloc]init];
        redL.textAlignment = NSTextAlignmentCenter;
        redL.textColor = kRGB_COLOR(@"#FF5500");
        redL.font = [UIFont systemFontOfSize:10];
        [pointBgV addSubview:redL];
        [redL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(pointBgV);
            make.left.right.equalTo(pointBgV).inset(3);
        }];
        if (i == 0) {
            self.wattingForPayRedL = redL;
        }else if(i == 1){
            self.wattingForDeliverRedL = redL;
        }else if(i == 2){
            self.wattingForRecevieRedL = redL;
        }else if(i == 3){
            self.quitOrderRedL = redL;
        }
    }
}
- (void)setModel:(ShopOrderNumDTOModel *)model{
    _model = model;
    
    ////待付款
    self.wattingForPayRedL.superview.hidden = !model.toBePayNum;
    if (model.toBePayNum > 0) {
        self.wattingForPayRedL.text =  [NSString stringWithFormat:@"%d",model.toBePayNum];
    }
    ///待发货
    self.wattingForDeliverRedL.superview.hidden = !model.toBeDeliveredNum;
    if (model.toBeDeliveredNum > 0) {
        self.wattingForDeliverRedL.text =  [NSString stringWithFormat:@"%d",model.toBeDeliveredNum];
    }
    ///待收货
    self.wattingForRecevieRedL.superview.hidden = !model.toBeReceivedNum;
    if (model.toBeReceivedNum > 0) {
        self.wattingForRecevieRedL.text =  [NSString stringWithFormat:@"%d",model.toBeReceivedNum];
    }
    ///退货
    self.quitOrderRedL.superview.hidden = !model.cancelGoodsNum;
    if (model.cancelGoodsNum > 0) {
        self.quitOrderRedL.text =  [NSString stringWithFormat:@"%d",model.cancelGoodsNum];
    }
}
  
-(void)feastureBtnClick:(UIButton *)sender{
   // NSLog(@"过滤文字BtnClick==%ld"),sender.tag - 10000);
    if ([self.delegate respondsToSelector:@selector(MyOrderVFunctionBtnClick:)]) {
        [self.delegate MyOrderVFunctionBtnClick:sender.tag - 10000];
    }
}

-(void)lookLTap{
    if (self.MyOrderVBlock) {
        self.MyOrderVBlock();
    }
 
}
@end
