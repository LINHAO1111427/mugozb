//
//  DynamicPhotoView.m
//  TCDemo
//
//  Created by admin on 2019/10/29.
//  Copyright © 2019 CH. All rights reserved.
//

#import "BrowserPhotoView.h"
#import <LibProjView/SDPhotoBrowser.h>
#import <LibTools/LibTools.h>
#import <SDWebImage.h>

@interface BrowserPhotoView () <SDPhotoBrowserDelegate>

@end

@implementation BrowserPhotoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isAdd = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isAdd = NO;
    }
    return self;
}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *lastV = nil;
    kWeakSelf(self);
    int count = 3;
    CGFloat space = 5;
    NSInteger maxNum =_isAdd?(imageArr.count<9?imageArr.count+1:imageArr.count):imageArr.count;
    CGFloat imageW = (self.frame.size.width-((count-1)*space))/count;
    for (int i = 0; i< maxNum; i++) {
        UIImageView *imgV = [self createImageView:CGRectMake(i%count*(imageW+space), i/count*(imageW+space), imageW, imageW)];
        [imgV klc_whenTapped:^{
            [weakself clickImageView:i];
        }];
        [self addSubview:imgV];
        lastV = imgV;
        if (imageArr.count > i) {
            if (_isAdd) {
                imgV.image = imageArr[i];
                UIButton *deleteBtn = [UIButton buttonWithType:0];
                [deleteBtn setImage:[UIImage imageNamed:@"dynamic_photo_delete"] forState:UIControlStateNormal];
                deleteBtn.frame = CGRectMake(imgV.frame.size.width-25, 0, 25, 25);
                deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
                kWeakSelf(self);
                [deleteBtn klc_whenTapped:^{
                    if (weakself.deleteBtnClick) {
                        weakself.deleteBtnClick(i);
                    }
                }];
                [imgV addSubview:deleteBtn];
            }else{
                [imgV sd_setImageWithURL:[NSURL URLWithString:imageArr[i]]];
                ///不是添加，并且就一张图片
                if (_imageArr.count == 1) {
                    CGRect imgRc = imgV.frame;
                    imgRc.size.height = 160;
                    imgV.frame = imgRc;
                    [imgV sd_setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:[UIImage imageNamed:kLocalizationMsg(@"加载失败大图")] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        CGRect rc = imgV.frame;
                        if (imgV.image && image) {
                            rc.size.width = image.size.width /image.size.height * (160);
                        }else{
                            rc.size.width = 160 * (kScreenWidth/kScreenHeight);
                        }
                        imgV.frame = rc;
                    }];
                }
            }
        }else{
            imgV.image = [UIImage imageNamed:@"dynamic_add_photo"];
        }
    }
    
    CGRect rc = self.frame;
    rc.size.height = CGRectGetMaxY(lastV.frame);
    self.frame = rc;
    
}

- (UIImageView *)createImageView:(CGRect)frame{
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:frame];
    imgV.layer.masksToBounds = YES;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    imgV.layer.cornerRadius = 4;
    imgV.userInteractionEnabled = YES;
    return imgV;
}


- (void)clickImageView:(NSInteger)imageTag{
    if (self.selectPhoto) {
        self.selectPhoto((self.imageArr.count > imageTag)?NO:YES, imageTag);
    }
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
    if (_isAdd) {
        return nil;
    }else{
        NSString *urlStr = [self.imageArr[index] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [NSURL URLWithString:urlStr];
    }
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    if (_isAdd) {
        return self.imageArr[index];
    }else{
        UIImageView *img = self.subviews[index];
        return img.image;
    }
}
@end
