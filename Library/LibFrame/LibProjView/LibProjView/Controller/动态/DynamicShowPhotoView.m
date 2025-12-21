//
//  DynamicShowPhotoView.m
//  TCDemo
//
//  Created by admin on 2019/10/29.
//  Copyright © 2019 CH. All rights reserved.
//

#import "DynamicShowPhotoView.h"
#import <LibProjView/SDPhotoBrowser.h>
#import <LibTools/LibTools.h>
#import <SDWebImage.h>

@interface DynamicShowPhotoView () <SDPhotoBrowserDelegate>

@end

@implementation DynamicShowPhotoView
- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    [self reloadPhotos];
}

- (void)reloadPhotos{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    kWeakSelf(self);
    CGFloat space = 5;
    CGFloat imageW = (self.frame.size.width-(2*space))/3;
    UIView *lastV;
    for (int i = 0; i< self.imageArr.count; i++) {
        int col = i%3;
        int row = i/3;
        UIImageView *imgV = [self createImageView:CGRectMake(col * (imageW+space), row * (imageW+space), imageW, imageW)];
        imgV.userInteractionEnabled = YES;
        [self addSubview:imgV];
         
        if (_imageArr.count == 1) {//只有一张图
            CGRect imgRc = imgV.frame;
            imgRc.size.height = 160;
            imgV.frame = imgRc;
            [imgV sd_setImageWithURL:[NSURL URLWithString:self.imageArr[i]] placeholderImage:[UIImage imageNamed:kLocalizationMsg(@"加载失败大图")] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                CGRect rc = imgV.frame;
                if (imgV.image && image) {
                    rc.size.width = image.size.width /image.size.height * (160);
                }else{
                    rc.size.width = 160 * (kScreenWidth/kScreenHeight);
                }
                imgV.frame = rc;
            }];
        }else{
            [imgV sd_setImageWithURL:[NSURL URLWithString:self.imageArr[i]]];
        }
        lastV = imgV;
        [imgV klc_whenTapped:^{
            [weakself clickImageView:i];
        }];
    }
    
    CGRect rc = self.frame;
    rc.size.height = CGRectGetMaxY(lastV.frame);
    self.frame = rc;
}

 

- (UIImageView *)createImageView:(CGRect)frame{
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:frame];
    imgV.layer.masksToBounds = YES;
    imgV.layer.cornerRadius = 4;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    imgV.userInteractionEnabled = YES;
    return imgV;
}


- (void)clickImageView:(NSInteger)imageTag{
    if (_isShowBig && self.imageArr.count>imageTag) {
       // NSLog(@"过滤文字点击第一个图片%zi"),imageTag);
        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
        browser.currentImageIndex = imageTag;
        browser.sourceImagesContainerView = self;
        browser.imageCount = self.imageArr.count;
        browser.delegate = self;
        [browser show];
    }
}

#pragma mark - SDPhotoBrowserDelegate -
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [self.imageArr[index] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSURL URLWithString:urlStr];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *img = self.subviews[index];
    return img.image;
}
@end
