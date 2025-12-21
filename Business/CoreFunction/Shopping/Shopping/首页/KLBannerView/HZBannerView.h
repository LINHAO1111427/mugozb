//
//  HZBannerView.h
//
//  Created by sssssssss on 2020/8/11.
//  Copyright © 2020 . All rights reserved.
//
 

#import <UIKit/UIKit.h>
#import "HZBannerModel.h"

@class KLBannerView;

@protocol HZBannerViewDelegate <NSObject>

@optional
/**
 该方法用来处理item的点击，会返回item在moxing数组中的索引

 @param bannerView  控件本身
 @param index       索引
 */
- (void)HZBannerView:(KLBannerView *)bannerView didSelectedAt:(NSInteger)index;

@end

@interface KLBannerView : UIView

#pragma mark - 属性
/**  
 *  模型数组
 */
@property (nonatomic, strong) NSArray<HZBannerModel *> *models;
/**
 *  代理，用来处理图片的点击
 */
@property (nonatomic, weak) id <HZBannerViewDelegate> delegate;
/**
 *  每一页停留时间，默认为3s，最少1s
 *  当设置的值小于1s时，则为默认值
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

#pragma mark - 方法
/**
 *  开启定时器
 *  默认已开启，调用该方法会重新开启
 */
- (void)startTimer;
/**
 *  停止定时器
 *  停止后，如果手动滚动图片，定时器会重新开启
 */
- (void)stopTimer;

@end
