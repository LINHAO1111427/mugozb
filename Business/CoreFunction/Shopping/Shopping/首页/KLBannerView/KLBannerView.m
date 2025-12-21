//
//  HZBannerView.m
//
//  Created by sssssssss on 2020/8/11.
//  Copyright © 2020 . All rights reserved.
//

#import "KLBannerView.h"
#import "KLBannerViewFlowLayout.h"
#import "KLBannerCell.h"
#import <LibProjModel/ShopLiveAnnouncementDetailDTOModel.h>

//居中卡片宽度与据屏幕宽度比例
static CGFloat const CardWidthScale = 200/360.0f;
 

static NSString * const reusedID = @"KLBannerCellID";

@interface KLBannerView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSInteger _currentIndex;
    CGFloat _dragStartX;
    CGFloat _dragEndX;
}
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UIImageView *imageView;//虚化背景
@property (nonatomic, strong) NSTimer *timer;//定时器

@end

@implementation KLBannerView

#pragma mark - 懒加载
- (UIImageView *)imageView{
    ///加模糊且变化的背景图
    return _imageView = _imageView ?: ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
        /*
         UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
         UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
         effectView.frame = imageView.bounds;
         [imageView addSubview:effectView];
         */
        imageView;
    });
}

- (KLBannerViewFlowLayout *)flowLayout{
    CGFloat width = self.bounds.size.width * CardWidthScale;
    KLBannerViewFlowLayout *flowLayout = [[KLBannerViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(width+12,width)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumLineSpacing:12];
    return flowLayout;
}

- (UICollectionView *)collection{
    return _collection = _collection ?: ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[self flowLayout]];
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[KLBannerCell class] forCellWithReuseIdentifier:reusedID];
        [collectionView setUserInteractionEnabled:YES];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:collectionView];
        collectionView;
    });
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setModels:(NSArray<ShopLiveAnnouncementDetailDTOModel *> *)models {
    
    if (models.count == 0) {
        return;
    }
    //处理模型 实现无限滚动
    NSMutableArray *modelsM = @[].mutableCopy;
    [modelsM addObjectsFromArray:models];
    if (modelsM.count >= 3) {
    
        ShopLiveAnnouncementDetailDTOModel *first = modelsM.firstObject;
        ShopLiveAnnouncementDetailDTOModel *seconed = modelsM[1];
        ShopLiveAnnouncementDetailDTOModel *last = modelsM.lastObject;
        ShopLiveAnnouncementDetailDTOModel *lastTwo = modelsM[models.count - 2];
        
        [modelsM insertObject:last atIndex:0];
        [modelsM insertObject:lastTwo atIndex:0];
        
        [modelsM addObject:first];
        [modelsM addObject:seconed];
    }else if (modelsM.count == 2) {
        
        ShopLiveAnnouncementDetailDTOModel *first = modelsM.firstObject;
        ShopLiveAnnouncementDetailDTOModel *seconed = modelsM.lastObject;
        ShopLiveAnnouncementDetailDTOModel *last = modelsM.lastObject;
        ShopLiveAnnouncementDetailDTOModel *lastTwo = modelsM.firstObject;
        
        [modelsM insertObject:last atIndex:0];
        [modelsM insertObject:lastTwo atIndex:0];
        
        [modelsM addObject:first];
        [modelsM addObject:seconed];
    }else if (modelsM.count == 1) {
        
        ShopLiveAnnouncementDetailDTOModel *first = modelsM.firstObject;
        ShopLiveAnnouncementDetailDTOModel *seconed = modelsM.firstObject;
        ShopLiveAnnouncementDetailDTOModel *last = modelsM.lastObject;
        ShopLiveAnnouncementDetailDTOModel *lastTwo = models.lastObject;
        
        [modelsM insertObject:last atIndex:0];
        [modelsM insertObject:lastTwo atIndex:0];
        
        [modelsM addObject:first];
        [modelsM addObject:seconed];
    }
    
    _models = modelsM;
    
    //设置初始位置
    if (models.count > 0) {
        /*
         ShopLiveAnnouncementModel *model = _models.firstObject;
         [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.posterStickers] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
         */
        _currentIndex = 2;
        [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        //开启定时器
        [self startTimer];
    }
}

#pragma mark - scroll to
- (void)fixCellToLeft {
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width/10.0f;
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _currentIndex -= 1;//向右
    }else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _currentIndex += 1;//向左
    }
    NSInteger maxIndex = [self.collection numberOfItemsInSection:0] - 1;
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= maxIndex ? maxIndex : _currentIndex;
    
    [self scrollToLeft:NO isDrag:YES];
}


- (void)scrollToLeft:(BOOL)isLast isDrag:(BOOL)isDrag{
   
    [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    if (_currentIndex == self.models.count - 2) {//如果是最后一张图
        _currentIndex = 1;
        [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
       // NSLog(@"过滤文字最后"));
        _currentIndex = 2;
        [self scrollToLeft:YES isDrag:isDrag];
        return;
    }else if (_currentIndex == 1) {//第一张图
        _currentIndex = self.models.count - 3;
        [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
       // NSLog(@"过滤文字第一"));
        return;
    }else{
        if (isDrag) {
            [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:!isLast];
        }else{
            [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        }
        return;
    }
    /*
     ShopLiveAnnouncementModel *model = _models[_currentIndex];
     [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.posterStickers] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
     
     */
    
}

#pragma mark - CollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KLBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedID forIndexPath:indexPath];
    cell.model = _models[indexPath.row];
    return cell;
}

#pragma mark 设置定时器时间
- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    [self startTimer];
}

- (void)startTimer {
    //如果只有一张图片，则直接返回，不开启定时器
    if (_models.count <= 1) return;
    //如果定时器已开启，先停止再重新开启
    if (self.timer){
        [self stopTimer];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage {
    _currentIndex += 1;
    [self scrollToLeft:NO isDrag:NO];
}

#pragma mark - UIScrollViewDelegate
//手指拖动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _dragStartX = scrollView.contentOffset.x;
    [self stopTimer];
}

//手指拖动停止
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToLeft];
    });
    [self startTimer];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentIndex = indexPath.row;
    [self scrollToLeft:NO isDrag:NO];
    ShopLiveAnnouncementDetailDTOModel *model = _models[indexPath.row];
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(KLBannerView:didSelectedAt:)]) {
        [self.delegate KLBannerView:self didSelectedAt:model];
    }
}




@end
