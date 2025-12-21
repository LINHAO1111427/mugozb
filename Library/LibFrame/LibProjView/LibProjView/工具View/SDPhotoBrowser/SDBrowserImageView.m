//
//  SDBrowserImageView.m
//  SDPhotoBrowser
//
//  Created by aier on 15-2-6.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDBrowserImageView.h"
#import <LibTools/LibTools.h>
#import "SDPhotoBrowserConfig.h"

#import <SDWebImage.h>

@interface SDBrowserImageView ()

@property (nonatomic, weak)UIImageView *scrollImageView;

@end

@implementation SDBrowserImageView
{
    __weak SDWaitingView *_waitingView;
    BOOL _didCheckSize;
    UIScrollView *_scroll;
    UIScrollView *_zoomingScroolView;
    UIImageView *_zoomingImageView;
    CGFloat _totalScale;
    UIPinchGestureRecognizer *_recognizer;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFit;
        _totalScale = 1.0;
        
        // 捏合手势缩放图片
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImage:)];
        pinch.delegate = self;
        [self addGestureRecognizer:pinch];
        
        
   
    }
    return self;
}

- (BOOL)isScaled
{
    return  1.0 != _totalScale;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _waitingView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    CGSize imageSize = self.image.size;
    
    if (self.bounds.size.width * (imageSize.height / imageSize.width) > self.bounds.size.height) {
        if (!_scroll) {
            UIScrollView *scroll = [[UIScrollView alloc] init];
            scroll.backgroundColor = [UIColor whiteColor];
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = self.image;
            _scrollImageView = imageView;
            [scroll addSubview:imageView];
            scroll.backgroundColor = SDPhotoBrowserBackgrounColor;
            _scroll = scroll;
            [self addSubview:scroll];
            if (_waitingView) {
                [self bringSubviewToFront:_waitingView];
            }
        }
        _scroll.frame = self.bounds;

        CGFloat imageViewH = self.bounds.size.width * (imageSize.height / imageSize.width);

        _scrollImageView.bounds = CGRectMake(0, 0, _scroll.frame.size.width, imageViewH);
        _scrollImageView.center = CGPointMake(_scroll.frame.size.width * 0.5, _scrollImageView.frame.size.height * 0.5);
        _scroll.contentSize = CGSizeMake(0, _scrollImageView.bounds.size.height);
        
    } else {
        if (_scroll) [_scroll removeFromSuperview]; // 防止旋转时适配的scrollView的影响
    }
  
}



- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _waitingView.progress = progress;

}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    SDWaitingView *waiting = [[SDWaitingView alloc] init];
    waiting.bounds = CGRectMake(0, 0, 100, 100);
    waiting.mode = SDWaitingViewProgressMode;
    _waitingView = waiting;
    [self addSubview:waiting];
    
    
    __weak typeof(SDBrowserImageView *) imageViewWeak = self;
    [self sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        imageViewWeak.progress = (CGFloat)receivedSize / expectedSize;
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [imageViewWeak removeWaitingView];
               
               if (error) {
                   /*
                   UILabel *label = [[UILabel alloc] init];
                   label.bounds = CGRectMake(0, 0, 160, 30);
                   label.center = CGPointMake(imageViewWeak.bounds.size.width * 0.5, imageViewWeak.bounds.size.height * 0.5);
                   label.text = kLocalizationMsg(@"图片加载失败");
                   label.font = [UIFont systemFontOfSize:16];
                   label.textColor = [UIColor whiteColor];
                   label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
                   label.layer.cornerRadius = 5;
                   label.clipsToBounds = YES;
                   label.textAlignment = NSTextAlignmentCenter;
                   [imageViewWeak addSubview:label];
                    */
//                   [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"获取图片失败"))];
               } else {
                   imageViewWeak.scrollImageView.image = image;
                   [imageViewWeak.scrollImageView setNeedsDisplay];
               }
    }];

}

- (void)zoomImage:(UIPinchGestureRecognizer *)recognizer
{
    [self prepareForImageViewScaling];
    /*
    CGFloat scale = recognizer.scale;
    CGFloat temp = _totalScale + (scale - 1);

    [self adjustAnchorPointForGestureRecognizer:recognizer];
    
    _recognizer = recognizer;
    if ([gestureRecognizerstate] ==UIGestureRecognizerStateBegan || [gestureRecognizerstate] ==UIGestureRecognizerStateChanged)
    {
        [recognizer view].transform =CGAffineTransformScale([[recognizer view]transform], [recognizer scale], [recognizer scale]);
    
        
    }

    [self setTotalScale:temp];
    recognizer.scale = 1.0;
     */
}

- (void)setTotalScale:(CGFloat)totalScale
{
    if ((_totalScale < 0.5 && totalScale < _totalScale) || (_totalScale > 2.0 && totalScale > _totalScale)) return; // 最大缩放 2倍,最小0.5倍
    
    [self zoomWithScale:totalScale];
}

- (void)zoomWithScale:(CGFloat)scale
{
    _totalScale = scale;
    

    
    _zoomingImageView.transform = CGAffineTransformMakeScale(scale, scale);

    if (scale > 1) {
        CGFloat contentW = _zoomingImageView.frame.size.width;
        CGFloat contentH = MAX(_zoomingImageView.frame.size.height, self.frame.size.height);
        
        _zoomingImageView.center = CGPointMake(contentW * 0.5, contentH * 0.5);
        _zoomingScroolView.contentSize = CGSizeMake(contentW, contentH);

        
        CGPoint offset = _zoomingScroolView.contentOffset;
        offset.x = (contentW - _zoomingScroolView.frame.size.width) * 0.5;
//        offset.y = (contentH - _zoomingImageView.frame.size.height) * 0.5;
        _zoomingScroolView.contentOffset = offset;
        
    } else {
        
        _zoomingScroolView.contentSize = _zoomingScroolView.frame.size;
        _zoomingScroolView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _zoomingImageView.center = _zoomingScroolView.center;
    }
   
}

- (void)doubleTapToZommWithScale:(CGFloat)scale
{
    [self prepareForImageViewScaling];
    [UIView animateWithDuration:0.5 animations:^{
        [self zoomWithScale:scale];
    } completion:^(BOOL finished) {
        if (scale == 1) {
            [self clear];
        }
    }];
}

- (void)prepareForImageViewScaling
{
    if (!_zoomingScroolView) {
        _zoomingScroolView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _zoomingScroolView.backgroundColor = SDPhotoBrowserBackgrounColor;
        _zoomingScroolView.contentSize = self.bounds.size;
        _zoomingScroolView.delegate = self;
        _zoomingScroolView.maximumZoomScale = 3;
        _zoomingScroolView.minimumZoomScale = 1;
        UIImageView *zoomingImageView = [[UIImageView alloc] initWithImage:self.image];
   
        CGSize imageSize = zoomingImageView.image.size;
        CGFloat imageViewH = self.bounds.size.height;
        if (imageSize.width > 0) {
            imageViewH = self.bounds.size.width * (imageSize.height / imageSize.width);
        }
        zoomingImageView.bounds = CGRectMake(0, 0, self.bounds.size.width, imageViewH);
        zoomingImageView.center = _zoomingScroolView.center;
        zoomingImageView.contentMode = UIViewContentModeScaleAspectFit;
        _zoomingImageView = zoomingImageView;
        [_zoomingScroolView addSubview:zoomingImageView];
        [self addSubview:_zoomingScroolView];
    }
}

- (void)scaleImage:(CGFloat)scale
{
    [self prepareForImageViewScaling];
    [self setTotalScale:scale];
}

// 清除缩放
- (void)eliminateScale
{
    [self clear];
    _totalScale = 1.0;
}

- (void)clear
{
    [_zoomingScroolView removeFromSuperview];
    _zoomingScroolView = nil;
    _zoomingImageView = nil;

}

- (void)removeWaitingView
{
    [_waitingView removeFromSuperview];
}


- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    //UIGestureRecognizerStateBegan意味着手势已经被识别
    if (gestureRecognizer.state ==UIGestureRecognizerStateBegan)
    {
        //手势发生在哪个view上
        UIView *piece = gestureRecognizer.view;
        //获得当前手势在view上的位置。
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        
        piece.layer.anchorPoint =CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        //根据在view上的位置设置锚点。
        //防止设置完锚点过后，view的位置发生变化，相当于把view的位置重新定位到原来的位置上。
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        piece.center = locationInSuperview;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _zoomingImageView;
    
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}



//- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
//
//
//
//}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(double)scale{

    if (scale < 1) {
        view.center = scrollView.center;
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    
    zoomRect.size.height = [_zoomingScroolView frame].size.height / scale;
    zoomRect.size.width  = [_zoomingScroolView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


/** 计算点击点所在区域frame */
- (CGRect)getRectWithScale:(CGFloat)scale andCenter:(CGPoint)center{
    CGRect newRect = CGRectZero;
    newRect.size.width =  _zoomingScroolView.frame.size.width/scale;
    newRect.size.height = _zoomingScroolView.frame.size.height/scale;
    newRect.origin.x = center.x - newRect.size.width * 0.5;
    newRect.origin.y = center.y - newRect.size.height * 0.5;
    
    return newRect;
}



@end
