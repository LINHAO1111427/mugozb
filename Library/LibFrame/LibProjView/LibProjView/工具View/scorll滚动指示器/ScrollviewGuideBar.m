//
//  ScrollviewGuideBar.m
//  HomePage
//
//  Created by klc on 2020/6/6.
//  Copyright © 2020 klc. All rights reserved.
//

#import "ScrollviewGuideBar.h"
#import <LibProjView/ScrollviewGuideBar.h>
#import <LibTools/LibTools.h>

@interface ScrollviewGuideBar ()
@property(nonatomic,strong)UIColor *barClolor;
@property(nonatomic,strong)UIColor *backColor;
@property(nonatomic,assign)UIView *bar;
@end

@implementation ScrollviewGuideBar

- (void)dealloc{
    [_relationScrollV removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [_relationScrollV removeObserver:self forKeyPath:@"contentSize" context:nil];
}

- (instancetype)initWithFrame:(CGRect)frame barColor:(UIColor *)barClolor backColor:(UIColor *)backColor{
    self = [super initWithFrame:frame];
    if (self) {
        self.barClolor = barClolor;
        self.backgroundColor = backColor;
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.height/2.0;
        self.rate = 0.5;
        self.value = 0;
        [self creatUI];
    }
    return self;
}
- (void)setRate:(CGFloat)rate{
    _rate = rate;
    self.bar.width = rate*self.width;
}

- (void)creatUI{
    UIView *bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.rate*self.width, self.height)];
    bar.backgroundColor = self.barClolor;
    bar.clipsToBounds = YES;
    bar.layer.masksToBounds = YES;
    bar.layer.cornerRadius = self.height/2.0;
    self.bar = bar;
    [self addSubview:self.bar];
}

- (void)setValue:(CGFloat)value{
    _value =  value;
    self.bar.x = value*(1-self.rate)*self.width;
}


- (void)setRelationScrollV:(UIScrollView *)relationScrollV{
    _relationScrollV = relationScrollV;
    
    [relationScrollV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [relationScrollV addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}



#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (object == self.relationScrollV) {
    
        if ([keyPath isEqualToString:@"contentOffset"]) {
            CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
            CGFloat scrollW = self.relationScrollV.width;
            CGFloat contentW = self.relationScrollV.contentSize.width;
            CGFloat x = contentOffset.x;
            CGFloat y = (contentW -scrollW);
            CGFloat value = x/(y!=0?y:1);
            self.value = value;
        }
        
        if ([keyPath isEqualToString:@"contentSize"]) {
            CGSize contentSize = [change[NSKeyValueChangeNewKey] CGSizeValue];
            self.rate = self.relationScrollV.width/contentSize.width;
        }
        
    }else{
        
    }
    
}


@end
