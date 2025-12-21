//
//  SVImageScrollV.m
//  ShortVideo
//
//  Created by klc_sl on 2021/5/21.
//  Copyright © 2021 KLC. All rights reserved.
//

#import "SVImageScrollV.h"
#import <LibProjView/MultiGestureScrollView.h>

@interface SVImageScrollV ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, weak)MultiGestureScrollView *imageScrollV;

@property (nonatomic, weak)UILabel *segmentLabel;//图片指示

@property (nonatomic, assign)int currentIndex;
@property (nonatomic, assign)int totalNum;


@end

@implementation SVImageScrollV

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentIndex = 1;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (MultiGestureScrollView *)imageScrollV{
    if (!_imageScrollV) {
        MultiGestureScrollView *imageScrollV = [[MultiGestureScrollView alloc]initWithFrame:self.bounds];
        imageScrollV.backgroundColor = [UIColor clearColor];
        imageScrollV.showsHorizontalScrollIndicator = NO;
        imageScrollV.pagingEnabled = YES;
        imageScrollV.delegate = self;
        [self addSubview:imageScrollV];
        _imageScrollV = imageScrollV;
    }
    return _imageScrollV;
}

- (UILabel *)segmentLabel{
    if (!_segmentLabel) {
        UILabel *segmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width-52,(kNavBarHeight+10), 40, 24)];
        segmentLabel.backgroundColor = kRGBA_COLOR(@"#000000", 0.49);
        segmentLabel.layer.cornerRadius = 12;
        segmentLabel.clipsToBounds = YES;
        segmentLabel.font = kFont(12);
        segmentLabel.textAlignment = NSTextAlignmentCenter;
        segmentLabel.textColor = [UIColor whiteColor];
        [self addSubview:segmentLabel];
        _segmentLabel = segmentLabel;
    }
    return _segmentLabel;
}


- (void)showImages:(NSString *)images{
    NSArray *arr = [images componentsSeparatedByString:@","];
    
    [self.imageScrollV removeFromSuperview];
    self.imageScrollV = nil;
    [self.segmentLabel removeFromSuperview];
    self.segmentLabel = nil;
    
    int totalCount = 0;
    for (int i = 0; i < arr.count; i++) {
        NSString *url = arr[i];
        if (url.length > 0) {
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.bounds];
            imageV.x = i * self.width;
            imageV.clipsToBounds = YES;
            imageV.contentMode = UIViewContentModeScaleAspectFit;
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
            [self.imageScrollV addSubview:imageV];
            totalCount += 1;
//            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                CGSize imgSize = image.size;
//
//                if (kISiPAD) {
//                    imageV.contentMode = UIViewContentModeScaleAspectFit;
//                }else{
//                    CGFloat tempH = imgSize.width*imageV.height/(imageV.width?imageV.width:1);
//                    if (tempH > imgSize.height) {
//                        imageV.contentMode = UIViewContentModeScaleAspectFit;
//                    }else{
//                        imageV.contentMode = UIViewContentModeScaleAspectFill;
//                    }
//                }
//            }];
        }
    }
    self.totalNum = totalCount;
    self.imageScrollV.contentSize = CGSizeMake(totalCount*self.width, self.height);
    self.segmentLabel.text = [NSString stringWithFormat:@"%d/%d",self.currentIndex,self.totalNum];
}


#pragma mark - scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    BOOL vcCanScroll = YES;
    if (scrollView.contentOffset.x <= 0) {
        vcCanScroll = NO;
    }else if(scrollView.contentOffset.x >= self.width *(self.totalNum-1)){
        if (self.totalNum >= 1) {
            vcCanScroll = NO;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shortViewCanScroll" object:@(!vcCanScroll)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.imageScrollV) {
        int index;
        if (scrollView.contentOffset.x <= 0) {
            index = 0;
        }else{
            index =  scrollView.contentOffset.x/self.width;
        }
        self.currentIndex = index+1;
        self.segmentLabel.text = [NSString stringWithFormat:@"%d/%d",self.currentIndex,self.totalNum];
    }
}

@end
