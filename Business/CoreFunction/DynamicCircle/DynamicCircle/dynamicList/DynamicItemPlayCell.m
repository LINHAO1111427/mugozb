//
//  DynamicPlayCell.m
//  DynamicCircle
//
//  Created by ssssssss on 2020/7/28.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "DynamicItemPlayCell.h"
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>
#import "DynamicInterfaceView.h"
#import <LibProjBase/HttpClient.h>
#import <LibProjBase/LibProjBase.h>

#import <LibProjView/PlayVideoView.h>

@interface DynamicItemPlayCell()<UIGestureRecognizerDelegate,DynamicInterfaceViewDelagte>
///图片
@property (nonatomic, strong)UIScrollView *imageScrollV;
@property (nonatomic, strong)UILabel *segmentLabel;//图片指示
@property (nonatomic, assign)int totalNum;

@property (nonatomic, strong)DynamicInterfaceView *faceView;

///视频
@property (nonatomic, strong)PlayVideoView *playVideoView;

@property(nonatomic,assign)BOOL isPlaying;

@end


@implementation DynamicItemPlayCell


- (UIScrollView *)imageScrollV{
    if (!_imageScrollV) {
        _imageScrollV = [[UIScrollView alloc]initWithFrame:self.bounds];
        _imageScrollV.backgroundColor = [UIColor clearColor];
        _imageScrollV.showsHorizontalScrollIndicator = NO;
        _imageScrollV.scrollEnabled = NO;
        _imageScrollV.pagingEnabled = YES;
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(scrollDirection:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [_imageScrollV addGestureRecognizer:swipeRight];
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(scrollDirection:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [_imageScrollV addGestureRecognizer:swipeLeft];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [_imageScrollV addGestureRecognizer:tap];
    }
    return _imageScrollV;
}

- (void)scrollDirection:(UISwipeGestureRecognizer *)swipe{
    if (_imageScrollV) {
       // NSLog(@"过滤文字%zi"),swipe.direction);
        CGPoint point = CGPointMake(0, 0);
        switch (swipe.direction) {
            case UISwipeGestureRecognizerDirectionRight:
            {
                point = CGPointMake(MAX(0, _imageScrollV.contentOffset.x-_imageScrollV.width), 0);
            }
                break;
            case UISwipeGestureRecognizerDirectionLeft:
            {
                point = CGPointMake(MIN(_imageScrollV.contentSize.width-_imageScrollV.width, _imageScrollV.contentOffset.x+_imageScrollV.width), 0);
            }
                break;
            default:
                break;
        }
        [_imageScrollV setContentOffset:point animated:YES];
        int index = point.x/self.width+1;
        self.segmentLabel.text = [NSString stringWithFormat:@"%d/%d",index,self.totalNum];
    }
}

- (void)imageTap:(UITapGestureRecognizer *)tap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicItemPlayCell:didSelectDynamicImage:)]) {
        [self.delegate dynamicItemPlayCell:self didSelectDynamicImage:self.model];
    }
}

- (PlayVideoView *)playVideoView{
    if (!_playVideoView) {
        _playVideoView = [[PlayVideoView alloc] initWithFrame:self.bounds];
        _playVideoView.clipsToBounds = YES;
    }
    return _playVideoView;
}

- (UILabel *)segmentLabel{
    if (!_segmentLabel) {
        _segmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width-52,kStatusBarHeight+(kNavBarHeight-kStatusBarHeight)/2.0-12, 40, 24)];
        _segmentLabel.backgroundColor = kRGBA_COLOR(@"#000000", 0.49);
        _segmentLabel.layer.cornerRadius = 12;
        _segmentLabel.clipsToBounds = YES;
        _segmentLabel.font = [UIFont systemFontOfSize:12];
        _segmentLabel.textAlignment = NSTextAlignmentCenter;
        _segmentLabel.textColor = [UIColor whiteColor];
    }
    return _segmentLabel;
}
- (DynamicInterfaceView *)faceView{
    if (!_faceView) {
        _faceView = [[DynamicInterfaceView alloc]initWithFrame:self.bounds];
        _faceView.delegate = self;
    }
    return _faceView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor blackColor];
    [self.contentView insertSubview:self.faceView atIndex:8];
}

- (void)setModel:(ApiUserVideoModel *)model{
    _model = model;
    self.faceView.model = model;
    [self.faceView removeFromSuperview];
    [self.contentView insertSubview:self.faceView atIndex:8];
    if (model.type ==  1) {
        [self.contentView insertSubview:self.playVideoView belowSubview:self.faceView];
        if (model.width <= 0 && model.height <= 0 && model.href.length > 0) {
            kWeakSelf(self);
            [self getVideoSize:model callback:^(BOOL success) {
                [weakself showThumb];
            }];
        }else{
            [self showThumb];
        }
        
    }else{
        [self.imageScrollV removeFromSuperview];
        [self.contentView insertSubview:self.imageScrollV belowSubview:self.faceView];
        [self showImageV];
    }
    
}
- (void)showThumb{
    if (self.model.thumb.length > 0) {
        //           // NSLog(@"过滤文字动态视频尺寸 ########## w = %d h = %d ########## "),model.width,model.height);
        if (_model.width >= _model.height) {
            self.playVideoView.imageModeAspectFill = NO;
        }else{
            if ([[ProjConfig getAppVerticalVideoGravity] isEqualToString:@"AVLayerVideoGravityResizeAspectFill"]) {
                self.playVideoView.imageModeAspectFill = YES;
            }else{
                self.playVideoView.imageModeAspectFill = NO;
            }
        }
        self.playVideoView.preview = _model.thumb;
    }
}

- (void)getVideoSize:(ApiUserVideoModel *)model callback:(void(^)(BOOL success))callback{
    [HttpClient requestGETWithPath:[NSString stringWithFormat:@"%@?avinfo",model.href] Param:nil success:^(id  _Nonnull dataBody) {
        if (![dataBody isKindOfClass:[NSError class]]) {
            NSDictionary *dic = dataBody;
            NSArray *arr = dic[@"streams"];
            NSDictionary *streamDic = arr.firstObject;
            CGFloat width = [streamDic[@"coded_width"] floatValue];
            CGFloat height = [streamDic[@"coded_height"] floatValue];
            NSDictionary *tags = streamDic[@"tags"];
            int rotate = [tags[@"rotate"] intValue];
            int direction = rotate/90;
            if (direction % 2 == 0) {
                model.width = width;
                model.height = height;
            }else{
                model.width = height;
                model.height = width;
            }
            callback(YES);
        }else{
            callback(NO);
        }
    } failed:^(NSString * _Nonnull error) {
        callback(NO);
    }];
}


#pragma mark - 播放状态
- (void)changePlayStaus{
    if (self.model.type == 1) {
        if (self.playVideoView.isPlaying) {
            [self pauseVideo];
        }else{
            [self resumeVideo];
        }
    }
}

- (void)startPlayVideo{
    if (self.model.type == 1) {
        [self playVideo];
    }
    
}
- (void)pauseVideo{
    if (self.model.type == 1) {
        self.isPausePlay = YES;
        [self.playVideoView pause];
    }
}
- (void)resumeVideo{
    if (self.model.type == 1) {
        [self.playVideoView resume];
        self.isPausePlay = NO;
    }
}
- (void)stopPlayVideo{
    if (self.model.type == 1) {//视频
        self.isPausePlay = YES;
        [self.playVideoView stop];
    }
}

#pragma mark - 可显示控制
///图片
- (void)showImageV{
    [self.imageScrollV removeAllSubViews];
    NSArray *arr = [self.model.images componentsSeparatedByString:@","];
    for (int i = 0; i < arr.count; i++) {
        NSString *url = arr[i];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.bounds];
        imageV.x = i * self.width;
        imageV.clipsToBounds = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        [self.imageScrollV addSubview:imageV];
    }
    self.totalNum = (int)arr.count;
    self.imageScrollV.contentSize = CGSizeMake(arr.count*self.width, self.height);
    
    int index = _imageScrollV.contentOffset.x/self.width + 1;
    self.segmentLabel.text = [NSString stringWithFormat:@"%d/%d",index,self.totalNum];
    [self.contentView addSubview:self.segmentLabel];
}
///视频
- (void)playVideo{
    if (self.playVideoView.isPlaying) {
        [self stopPlayVideo];
    }
    if (self.model.href.length == 0) {
        return;
    }
    
   // NSLog(@"过滤文字播放视频====%@"),self.model.href);
    [self.playVideoView playVideo:self.model.href];
    
    self.isPausePlay = NO;
}

#pragma mark - DynamicInterFaceViewDelagte
- (void)dynamicInterfaceViewBtnClick:(DynamicInterfaceView *)faceView dynamicModel:(ApiUserVideoModel *)model index:(NSInteger)index{
    switch (index) {
        case 0://点赞
            
            break;
        case 1://评论
            
            break;
        case 2://转发
            
            break;
        case 3://头像
            if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicItemPlayCellAvaterBtnClick:model:)]) {
                [self.delegate dynamicItemPlayCellAvaterBtnClick:self model:model];
            }
            break;
        case 4://关注
            
            break;
            
        default:
            break;
    }
}
- (void)dynamicInterfaceViewBtnClick:(DynamicInterfaceView *)faceView userInfoJump:(int64_t)user_id{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicItemPlayCellCommentAvaterBtnClick:user_id:)]) {
        [self.delegate dynamicItemPlayCellCommentAvaterBtnClick:self user_id:user_id];
    }
}
- (void)dynamicInterfaceViewBtnClick:(DynamicInterfaceView *)faceView reportDyanamic:(ApiUserVideoModel *)model{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicItemPlayCellReportBtnClick:model:)]) {
        [self.delegate dynamicItemPlayCellReportBtnClick:self model:model];
    }
}

- (void)dealloc{
    [self stopPlayVideo];
   // NSLog(@"过滤文字DynamicPlayCell delloc"));
}

@end

