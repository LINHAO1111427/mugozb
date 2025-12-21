//
//  CostBannerView.m
//  Message
//
//  Created by klc_tqd on 2020/6/5.
//  Copyright © 2020 . All rights reserved.
//

#import "CostBannerView.h"

#import <SDWebImage.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/KLCAppConfig.h>
 
@interface CostBannerView ()
@property(nonatomic,strong) UILabel *decLabel;
@end
@implementation CostBannerView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
       if (self) {
           self.alpha = 0.8;
           self.clipsToBounds = YES;
           self.backgroundColor = kRGB_COLOR(@"#DC92F5");
           [self creatSubView];
       }
       return self;
   
}

-(void)creatSubView{
    
    self.decLabel = [[UILabel alloc] init];
    self.decLabel.textColor = [UIColor whiteColor];
    self.decLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.decLabel];
    [self.decLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.bottom.equalTo(self);
    }];
    

    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-40, 0, 40, self.height)];
    [closeBtn setTitle:@"" forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"dynamic_close"] forState:UIControlStateNormal];
    [closeBtn setContentEdgeInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
    [self addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self);
        make.right.equalTo(self);
        make.left.equalTo(self.decLabel.mas_right).offset(2);
    }];
    
}

-(void)closeBtnClick{
    if (self.closeBtnClickBlock) {
        self.closeBtnClickBlock();
    }
}

- (void)setPrivateChatDeductionTips:(NSString *)privateChatDeductionTips{
    _privateChatDeductionTips = privateChatDeductionTips;
    self.decLabel.text = privateChatDeductionTips.length?privateChatDeductionTips:@"";
}

@end
