//
//  LivePraiseAnimationLayer.m
//  LiveCommon
//
//  Created by klc_sl on 2020/4/13.
//  Copyright © 2020 . All rights reserved.
//

#import "LivePraiseAnimationLayer.h"
#import <UIKit/UIKit.h>
#import <LibTools/LibTools.h>
#import <TXImKit/TXImKit.h>
#import <LiveCommon/LiveManager.h>
#import <LibProjModel/HttpApiTencentCloudImController.h>

@interface LivePraiseAnimationLayer ()

@property (nonatomic, weak)UIView *superView;
@property (nonatomic, assign)BOOL isMoreClick;

@property (nonatomic, weak)UIView *tapView;

@end

@implementation LivePraiseAnimationLayer

- (void)dealloc
{
    [_tapView removeFromSuperview];
    _tapView = nil;
}

- (instancetype)initWithSuperView:(UIView *)superView
{
    self = [super init];
    if (self) {
        _superView = superView;
        self.tapView.hidden = NO;
    }
    return self;
}

- (UIView *)tapView{
    if (!_tapView) {
        CGFloat topH = kNavBarHeight+50;
        UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, topH, _superView.width, kScreenHeight-topH- kSafeAreaBottom - 50)];
        [_superView addSubview:tapView];
        [_superView sendSubviewToBack:tapView];

        UITapGestureRecognizer *lightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickStar:)];
        [tapView addGestureRecognizer:lightTap];
        _tapView = tapView;
    }
    return _tapView;
}

- (void)clickStar:(UITapGestureRecognizer *)tapGes{
    [self sendLight];
//    [self emitterPraise];
    [self showTheApplauseInView:self.tapView];
}

- (void)sendLight{
    // 第一次点击
    if (!_isMoreClick) {
        _isMoreClick = YES;
        NSDictionary *msgDataDict = @{
            @"anchorId":@([LiveManager liveInfo].anchorId),
            @"type":@([LiveManager liveInfo].serviceLiveType)
            
        };
        [self handleScoket:msgDataDict type:@"LiveGift" subType:@"sendLight"];
    }
}


///发射一个点赞粒子动画
- (void)emitterPraise{

        // 添加星星动画
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"plane_heart_cyan.png",@"plane_heart_pink.png",@"plane_heart_red.png",@"plane_heart_yellow.png",@"plane_heart_heart.png", nil];
    
    CGFloat itemW = 50* ((arc4random()%5 + 5)*0.1);
    UIImageView *starImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:array[arc4random_uniform((uint32_t)array.count)]]];
    [_superView addSubview:starImageView];
    CGRect tempFrame = starImageView.frame;
    tempFrame.origin = CGPointMake(_superView.frame.size.width-42, _superView.frame.size.height-kSafeAreaBottom-50-20);
    tempFrame.size = CGSizeMake(itemW, itemW);
    starImageView.frame = tempFrame;

    CGFloat rotate1 = ((arc4random()%5 + 5)*0.1);
    CGFloat rotate2 = ((arc4random()%5 + 5)*0.1);
    int intervalH = kScreenHeight-20-300-kSafeAreaBottom;
    [UIView animateWithDuration:2 + arc4random_uniform(10)/10.0f animations:^{
        
        CGRect newTempFrame = starImageView.frame;
        newTempFrame.origin = CGPointMake(newTempFrame.origin.x - arc4random_uniform(200)+5,  newTempFrame.origin.y - 200 - arc4random_uniform(intervalH));
        starImageView.frame = newTempFrame;
        starImageView.alpha = 0.1;
        starImageView.transform = CGAffineTransformRotate(starImageView.transform, M_PI_2*rotate1-M_PI_2*rotate2);
        
    } completion:^(BOOL finished) {
        [starImageView removeFromSuperview];
    }];
}


//动画
- (void)showTheApplauseInView:(UIView *)bgView{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"plane_heart_cyan.png",@"plane_heart_pink.png",@"plane_heart_red.png",@"plane_heart_yellow.png",@"plane_heart_heart.png", nil];

    CGFloat itemW = 50* ((arc4random_uniform(6) + 5)*0.1);

    UIImageView *applauseView = [[UIImageView alloc]initWithFrame:CGRectMake(bgView.frame.size.width-50-itemW/2, bgView.frame.size.height-itemW, itemW, itemW)];//增大y值可隐藏弹出动画
    [bgView addSubview:applauseView];
    
    applauseView.image = [UIImage imageNamed:array[arc4random_uniform((uint32_t)array.count)]];
    
    CGFloat AnimH = kScreenHeight*0.5; //动画路径高度,
    applauseView.transform = CGAffineTransformMakeScale(0, 0);
    applauseView.alpha = 0;
    
    //弹出动画
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        applauseView.transform = CGAffineTransformIdentity;
        applauseView.alpha = 0.9;
    } completion:NULL];
    
    //随机偏转角度
    NSInteger i = arc4random_uniform(2);
    NSInteger rotationDirection = 1- (2*i);// -1 OR 1,随机方向
    NSInteger rotationFraction = arc4random_uniform(10); //随机角度
    //图片在上升过程中旋转
    [UIView animateWithDuration:4 animations:^{
        applauseView.transform = CGAffineTransformMakeRotation(rotationDirection * M_PI/(4 + rotationFraction*0.2));
    } completion:NULL];
    
    //动画路径
    UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
    [heartTravelPath moveToPoint:applauseView.center];
    
    //随机终点
    CGFloat ViewX = applauseView.center.x;
    CGFloat ViewY = applauseView.center.y;
    CGPoint endPoint = CGPointMake(bgView.width - (arc4random()%((int)kScreenWidth/3)), ViewY - AnimH + arc4random_uniform(5)-2.5);
    
    //随机control点
    NSInteger j = arc4random_uniform(2);
    NSInteger travelDirection = 1- (2*j);//随机放向 -1 OR 1
    
    NSInteger m1 = ViewX + travelDirection*(arc4random_uniform(20) + 50);
    NSInteger n1 = ViewY - 60 + travelDirection*arc4random_uniform(20);
    
    NSInteger m2 = ViewX - travelDirection*(arc4random_uniform(100) + 50);
    NSInteger n2 = ViewY - 90 + travelDirection*arc4random_uniform(100);
    CGPoint controlPoint1 = CGPointMake(m1, n1);//control根据自己动画想要的效果做灵活的调整
    CGPoint controlPoint2 = CGPointMake(m2, n2);
    //根据贝塞尔曲线添加动画
    [heartTravelPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    //关键帧动画,实现整体图片位移
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartTravelPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    keyFrameAnimation.duration = 3 ;//往上飘动画时长,可控制速度
    [applauseView.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];
    
    //消失动画
    [UIView animateWithDuration:3 animations:^{
        applauseView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [applauseView removeFromSuperview];
    }];
}
- (void)handleScoket:(NSDictionary *)contentDic type:(NSString *)type subType:(NSString *)subType{
    NSString *content = [contentDic convertToJsonData];
    [HttpApiTencentCloudImController handleListenSocket:content subType:subType type:type callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
       // NSLog(@"过滤文字点亮了"));
    }];
}
@end
