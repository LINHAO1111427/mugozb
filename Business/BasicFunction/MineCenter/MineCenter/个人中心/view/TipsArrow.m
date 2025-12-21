//
//  TipsArrow.m
//  MineCenter
//
//  Created by klc on 2020/7/30.
//

#import "TipsArrow.h"

@interface TipsArrow ()


kStrong(CAShapeLayer, maskLayer)
kStrong(CAGradientLayer, gLayer)
kStrong(UIBezierPath, path)

kStrong(UILabel, textLab)

@end

@implementation TipsArrow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _maskLayer = [CAShapeLayer layer];
        [self.layer setMask:_maskLayer];
        _path = [UIBezierPath bezierPath];
        
        CAGradientLayer *gLayer  = [CAGradientLayer layer];
        gLayer.colors = @[(id)kRGB_COLOR(@"#FFA6ED").CGColor,(id)kRGB_COLOR(@"#CAA8FF").CGColor];
        gLayer.startPoint = POINT(0.5, 0);
        gLayer.endPoint = POINT(0.5, 1);
        gLayer.locations = @[@0,@1];
        _gLayer = gLayer;
        [self.layer addSublayer:gLayer];
        
        _textLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentCenter backColor:[UIColor clearColor] text:kLocalizationMsg(@"当前经验：") textColor:[UIColor whiteColor] font:kFont(11) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
           
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 5, 0));
        }];
        
    }
    return self;
}
-(void)setText:(NSString *)text{
    
    _text = text;
    _textLab.text = text;
}


- (void)layoutSubviews{
    
    self.maskLayer.frame = self.bounds;
    _gLayer.frame = self.bounds;
    [self.path removeAllPoints];
    
    CGSize size = self.bounds.size;
    
    CGFloat _arrowHeight = 5;
    
    CGFloat cornerRadius = size.height/2;
    CGFloat length = _arrowHeight*1.4;
    
    CGPoint p_ctr0 = POINT(0, 0);
    CGPoint p_ctr1 = POINT(size.width, 0);
    CGPoint p_ctr2 = POINT(size.width, size.height-_arrowHeight);
    CGPoint p_ctr3 = POINT(0, size.height-_arrowHeight);
    
    
    CGPoint p0 = POINT(cornerRadius, 0);
    CGPoint p1 = POINT(size.width-cornerRadius, 0);
    CGPoint p2 = POINT(size.width, cornerRadius);
    CGPoint p3 = POINT(size.width, size.height-cornerRadius);
    CGPoint p4 = POINT(size.width-cornerRadius, size.height-_arrowHeight);
    CGPoint p5 = POINT(size.width/2+length/2, size.height-_arrowHeight);//箭头右侧
    CGPoint p6 = POINT(size.width/2, size.height);//箭头
    CGPoint p7 = POINT(size.width/2-length/2, size.height-_arrowHeight);//箭头左侧
    CGPoint p8 = POINT(cornerRadius, size.height-_arrowHeight);
    CGPoint p9 = POINT(0, size.height-_arrowHeight-cornerRadius);
    CGPoint p10= POINT(0, cornerRadius);


    [_path moveToPoint:p0];
    [_path addLineToPoint:p1];
    [_path addQuadCurveToPoint:p2 controlPoint:p_ctr1];
    [_path addLineToPoint:p3];
    [_path addQuadCurveToPoint:p4 controlPoint:p_ctr2];
    [_path addLineToPoint:p5];
    [_path addLineToPoint:p6];
    [_path addLineToPoint:p7];
    [_path addLineToPoint:p8];
    [_path addQuadCurveToPoint:p9 controlPoint:p_ctr3];
    [_path addLineToPoint:p10];
    [_path addQuadCurveToPoint:p0 controlPoint:p_ctr0];
    [_path closePath];
    
    
    self.maskLayer.path = _path.CGPath;
    
}

@end
