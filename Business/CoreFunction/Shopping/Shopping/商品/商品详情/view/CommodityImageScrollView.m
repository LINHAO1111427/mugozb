//
//  CommodityImageScrollView.m
//  Shopping
//
//  Created by klc on 2020/7/7.
//  Copyright © 2020 klc. All rights reserved.
//

#import "CommodityImageScrollView.h"
#import <LibProjView/SDPhotoBrowser.h>

@interface CommodityImageScrollView()<UIScrollViewDelegate,SDPhotoBrowserDelegate>
@property (nonatomic, strong)UIScrollView *imageScrollV;
@property (nonatomic, strong)NSArray *images;
@property (nonatomic, strong)UILabel *segmentLabel;//图片指示
@property (nonatomic, assign)int currentIndex;
@property (nonatomic, assign)int totalNum;
@end
@implementation CommodityImageScrollView
- (UIScrollView *)imageScrollV{
    if (!_imageScrollV) {
        _imageScrollV = [[UIScrollView alloc]initWithFrame:self.bounds];
        _imageScrollV.delegate = self;
        _imageScrollV.pagingEnabled = YES;
    }
    return _imageScrollV;
}
- (UILabel *)segmentLabel{
    if (!_segmentLabel) {
        _segmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width-52,self.height-30, 40, 24)];
        _segmentLabel.backgroundColor = kRGBA_COLOR(@"#000000", 0.49);
        _segmentLabel.layer.cornerRadius = 12;
        _segmentLabel.clipsToBounds = YES;
        _segmentLabel.font = [UIFont systemFontOfSize:12];
        _segmentLabel.textAlignment = NSTextAlignmentCenter;
        _segmentLabel.textColor = [UIColor whiteColor];
        _segmentLabel.hidden = YES;
    }
    return _segmentLabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self insertSubview:self.imageScrollV atIndex:0];
        [self insertSubview:self.segmentLabel atIndex:1];
        self.currentIndex = 0;
    }
    return self;
}
- (void)reloadData{
    [self.imageScrollV removeAllSubViews];
    self.imageScrollV.contentSize = CGSizeMake(self.width*self.images.count, self.height);
    for (int i = 0; i<self.images.count; i++) {
        NSString *url = self.images[i];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.width, 0, self.width, self.height)];
        imageV.userInteractionEnabled = YES;
        imageV.clipsToBounds = YES;
        imageV.userInteractionEnabled = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        imageV.tag = 6600+i;
        [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageBrowser:)]];
        [self.imageScrollV addSubview:imageV];
    }
    
}
- (void)imageBrowser:(UIGestureRecognizer *)gesture{
    NSInteger tag = gesture.view.tag;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = tag-6600;
    browser.sourceImagesContainerView = self.imageScrollV;
    browser.imageCount = self.images.count;
    browser.delegate = self;
    [browser show];
}
- (void)setDetailModel:(ShopGoodsDetailDTOModel *)detailModel{
    _detailModel = detailModel;
    NSArray *arr = [detailModel.shopGoods.goodsPicture componentsSeparatedByString:@","];
    self.segmentLabel.hidden = !arr.count;
    self.totalNum = (int)arr.count;
    if (arr.count > 0) {
        self.images = arr;
        self.currentIndex =1;
        self.segmentLabel.text = [NSString stringWithFormat:@"%d/%d",self.currentIndex,self.totalNum];
    }else{
        self.currentIndex = 0;
    }
    [self reloadData];
}

- (void)setImages:(NSArray *)images{
    _images = images;
}
#pragma mark - UIScrollViewDelegate
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
#pragma mark - SDPhotoBrowserDelegate -
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    NSString *urlStr = @"";
    urlStr = [self.images[index] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSURL URLWithString:urlStr];
}


- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.images[index]]]];
}
@end
