//
//  PictureSharingVC.m
//  MineCenter
//
//  Created by klc on 2020/3/31.
//

#import "PictureSharingVC.h"
#import "KlcCardCollectionViewFlowLayout.h"
#import "InvitePictureCollectionViewCell.h"
 
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/InviteDtoModel.h>
#import <LibProjModel/AppInviteImgModel.h>
 
@interface PictureSharingVC ()<UICollectionViewDelegate,UICollectionViewDataSource,KlcCollectionViewFlowLayoutDelegate>

@property(nonatomic,strong)UIView *pageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *imageMutArr;
@property (nonatomic,strong)UIImageView *bgImageV;
@property (nonatomic,strong)UIButton *saveBtn;
@property (nonatomic,strong)UIButton *btnCopy;
@property (nonatomic, assign)NSInteger selectedIndex;

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation PictureSharingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = kLocalizationMsg(@"图片分享");
    [self.view addSubview:self.bgImageV];
    [self.view addSubview:self.saveBtn];//保存
    [self.view addSubview:self.btnCopy];//复制
    [self.pageView addSubview:self.collectionView];
    [self.pageView addSubview:self.pageControl];
    [self.bgImageV addSubview:self.pageView];
}

- (void)setInviteModel:(InviteDtoModel *)inviteModel{
    _inviteModel = inviteModel;
    self.dataArray = inviteModel.shareBackgroundImgList;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.imageMutArr removeAllObjects];
    for (AppInviteImgModel *model in dataArray) {
        if (model.isTip) {
            [self.imageMutArr addObject:model];
        }
    }
    self.pageControl.numberOfPages = self.imageMutArr.count;
    [self.collectionView reloadData];
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}
#pragma mark - 按钮
-(void)clickSaveBtn:(UIButton *)sender{
    //制作图片
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
    InvitePictureCollectionViewCell *cell = (InvitePictureCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        UIImage *saveImage = [self makeImageWithView:cell];
        [self loadImageFinished: saveImage];
    }
}
- (UIImage *)makeImageWithView:(UIView *)view{
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)clickCopyBtn:(UIButton *)sender{
    NSString *url = self.inviteModel.inviteUrl;
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = url;
    if (url.length == 0 || url == nil || url == NULL) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"复制失败")];
    }else{
        [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"复制成功")];
    }
}
//保存到相册
- (void)loadImageFinished:(UIImage *)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
         [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"保存失败")];
    }else {
         [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"图片已经保存到相册中")];
    }
}
#pragma makr - collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageMutArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InvitePictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"InvitePictureCollectionViewCellId" forIndexPath:indexPath];
    AppInviteImgModel *model;
    if (indexPath.item < self.imageMutArr.count) {
        model = self.imageMutArr[indexPath.item];
    }
    cell.inviteModel = self.inviteModel;
    cell.model = model;
    return cell;
}

// 点击item的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CGPoint pInUnderView = [self.pageView convertPoint:collectionView.center toView:collectionView];
    // 获取中间的indexpath
    NSIndexPath *indexpathNew = [collectionView indexPathForItemAtPoint:pInUnderView];
    if (indexPath.row == indexpathNew.row){
       // NSLog(@"过滤文字点击了同一个"));
        return;
    }else{
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}
#pragma mark - KlcCollectionViewFlowLayoutDelegate
- (void)collectioViewScrollToIndex:(NSInteger)index{
    self.selectedIndex = index;
    self.pageControl.currentPage = index;
}



#pragma mark - lazy
- (UIImageView *)bgImageV{
    if (!_bgImageV) {
        _bgImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
        _bgImageV.userInteractionEnabled = YES;
        _bgImageV.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageV.image = [UIImage imageNamed:@"icon_invite_picture_bg"];
    }
    return _bgImageV;
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, kScreenHeight - 80-kSafeAreaBottom-kNavBarHeight, (kScreenWidth-40*3)/2, 40)];
        _saveBtn.layer.cornerRadius = 20;
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.backgroundColor = [UIColor whiteColor];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _saveBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [_saveBtn setTitle:kLocalizationMsg(@"保存到手机") forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
        [_saveBtn setImage:[UIImage imageNamed:@"icon_invite_picture_save"] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(clickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (UIButton *)btnCopy{
    if (!_btnCopy) {
        _btnCopy = [[UIButton alloc] initWithFrame:CGRectMake(self.saveBtn.maxX+40, kScreenHeight - 80-kSafeAreaBottom-kNavBarHeight, (kScreenWidth-40*3)/2, 40)];
        _btnCopy.layer.cornerRadius = 20;
        _btnCopy.layer.masksToBounds = YES;
        _btnCopy.backgroundColor = [UIColor whiteColor];
        _btnCopy.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnCopy.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [_btnCopy setTitle:kLocalizationMsg(@"复制链接") forState:UIControlStateNormal];
        [_btnCopy setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
        [_btnCopy setImage:[UIImage imageNamed:@"icon_invite_copy_link"] forState:UIControlStateNormal];
        [_btnCopy  addTarget:self action:@selector(clickCopyBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCopy;
}
- (NSMutableArray *)imageMutArr{
    if (!_imageMutArr) {
        _imageMutArr = [NSMutableArray array];
    }
    return _imageMutArr;
}
- (UIView *)pageView{
    if (!_pageView) {
        CGFloat scale = 400/300.0;
        CGFloat width = kScreenWidth*300/375.0;
        CGFloat height = width*scale+30;
        CGFloat marginV = (kScreenHeight-80-kSafeAreaBottom-kNavBarHeight-height)/2.0;
        if (marginV < 0) {
            marginV = 0;
        }
        _pageView = [[UIView alloc]initWithFrame:CGRectMake(0, marginV, kScreenWidth, height)];
        _pageView.backgroundColor = [UIColor clearColor];
    }
    return _pageView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        CGFloat scale = 400/300.0;
        CGFloat width = kScreenWidth*300/375.0;
        CGFloat height = width*scale;
         
        KlcCardCollectionViewFlowLayout *flow = [[KlcCardCollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.itemSize = CGSizeMake(width/1.45, height/1.45);
        CGFloat oneX = width/2.9;
        flow.minimumLineSpacing = oneX*0.45;
//        flow.minimumInteritemSpacing = 30;
        flow.delegate = self;
        flow.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.pageView.bounds.size.width, height) collectionViewLayout:flow];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[InvitePictureCollectionViewCell class] forCellWithReuseIdentifier:@"InvitePictureCollectionViewCellId"];
    }
    return _collectionView;
}
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.pageView.height-18, kScreenWidth-24, 8)];
        _pageControl.currentPageIndicatorTintColor = kRGB_COLOR(@"#FFE400");
        _pageControl.centerX = self.pageView.width/2.0;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

 
@end
