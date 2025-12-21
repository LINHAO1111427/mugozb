//
//  TiUISubMenuOneViewCell.m
//  XTSDKDemo
//
//  Created by iMacA1002 on 2019/12/4.
//  Copyright © 2019 Tillusory Tech. All rights reserved.
//

#import "TiUISubMenuOneViewCell.h"
#import "TIButton.h"


@interface TiUISubMenuOneViewCell ()

@property(nonatomic ,strong)TIButton *cellButton;

@end

@implementation TiUISubMenuOneViewCell
-(TIButton *)cellButton{
    if (_cellButton==nil) {
        _cellButton = [[TIButton alloc]initWithScaling:0.9];
        _cellButton.userInteractionEnabled = NO;
    }
    return _cellButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.cellButton];
        [self.cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_left).offset(6);
            make.right.equalTo(self.mas_right).offset(-6);
        }];
                
        
    }
    return self;
}

- (void)setSubMod:(TIMenuMode *)subMod{
    if (subMod) {
        _subMod = subMod;
        
[self.cellButton setTitle:[NSString stringWithFormat:@"%@",subMod.name]
                        withImage:[UIImage imageNamed:subMod.normalThumb]
                    withTextColor:TI_Color_Default_Text_Black
                         forState:UIControlStateNormal];
        
[self.cellButton setTitle:[NSString stringWithFormat:@"%@",subMod.name]
                withImage:[UIImage imageNamed:subMod.selectedThumb]
            withTextColor:TI_Color_Default_Background_Pink
                 forState:UIControlStateSelected];

    [self.cellButton setSelected:subMod.selected]; 
    }
}

-(void)setCellTypeBorderIsShow:(BOOL)show{
   
    if (show) {
        [self.cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self.cellButton setBorderWidth:1.f BorderColor:TI_Color_Default_Background_Pink forState:UIControlStateSelected];
    }else{
        [self.cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self.cellButton setBorderWidth:0.f BorderColor:[UIColor clearColor] forState:UIControlStateSelected];
    }
       
}

@end
