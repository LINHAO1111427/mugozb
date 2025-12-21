//
//  ChangeBgImageVC.m
//  LiveCommon
//
//  Created by klc on 2020/5/23.
//  Copyright © 2020 . All rights reserved.
//

#import "ChangeBgImageVC.h"
#import <LibProjView/FunctionSheetBaseView.h>
#import <LibTools/LibTools.h>
#import <LibProjModel/AppVoiceThumbModel.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjModel/HttpApiHttpVoice.h>
#import <LibProjModel/OpenAuthDataVOModel.h>

@interface ChatBgImageCell : UICollectionViewCell

@property (nonatomic, weak)UIImageView *imageV;

@end

@implementation ChatBgImageCell

- (UIImageView *)imageV{
    if (!_imageV) {
        UIImageView *image = [[UIImageView alloc] init];
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.layer.masksToBounds = YES;
        image.layer.borderWidth = 1.0;
        image.layer.borderColor = [UIColor clearColor].CGColor;
        [self addSubview:image];
        _imageV = image;
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _imageV;
}

@end



@interface ChangeBgImageVC () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy)NSArray *items;
@property (nonatomic, weak)UICollectionView *collV;
@property (nonatomic, weak)UIImageView *bgImageV;  ///显示背景图

@property (nonatomic,assign)NSInteger selectIndex;

@property (nonatomic, copy)void (^changeBlock)(int64_t, NSString * _Nonnull);

@property (nonatomic, assign)int liveType;///0多人语音1一对一语音

@end

@implementation ChangeBgImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor blackColor];
    [self createUI];
    
    self.bgImageV.image = [ProjConfig getLiveBgImage];
    
}


- (void)selectLiveBgThumb:(int)type resultBlock:(void (^)(int64_t, NSString * _Nonnull))block{
    _changeBlock = block;
    _liveType = type;

    [self getThumbList:type];
}



- (void)getThumbList:(int)type{
    kWeakSelf(self);
    [HttpApiHttpVoice voiceThumbList:type callback:^(int code, NSString *strMsg, NSArray<AppVoiceThumbModel *> *arr) { 
        if (code == 1) {
            weakself.items = arr;
            
            OpenAuthDataVOModel *openModel = [LiveManager liveInfo].openData;
            [arr enumerateObjectsUsingBlock:^(AppVoiceThumbModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.thumb isEqualToString:openModel.voiceThumb]) {
                    weakself.selectIndex = idx;
                    *stop = YES;
                }
            }];
            [weakself.collV reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)createUI{
    
    UIImageView *showImgV = [[UIImageView alloc] initWithFrame:CGRectMake(-2, -5, kScreenWidth+4, kScreenHeight+10)];
    showImgV.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:showImgV];
    _bgImageV = showImgV;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-kSafeAreaBottom - 75 - (160), kScreenWidth, (160))];
    [self.view addSubview:bgView];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 100, 15)];
    titleL.text = kLocalizationMsg(@"背景图");
    titleL.textColor = [UIColor whiteColor];
    titleL.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:titleL];
    
    self.collV.frame = CGRectMake(0, titleL.maxY+20, bgView.width, 125);
    [bgView addSubview:self.collV];
    
    [self.view addSubview:bgView];
    
}

- (UICollectionView *)collV{
    if (!_collV) {
        int lineNum = 4;
        CGFloat viewW = ( self.view.frame.size.width-24-(lineNum-1)*6.5)/(lineNum * 1.0);
        CGFloat viewH = 123;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(viewW, viewH);
        flowLayout.sectionInset = UIEdgeInsetsMake(1, 12, 1, 12);
        flowLayout.minimumLineSpacing = 6;
        flowLayout.minimumInteritemSpacing = 6;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 35, kScreenWidth, viewH+2) collectionViewLayout:flowLayout];
        collV.delegate = self;
        collV.dataSource = self;
        collV.backgroundColor = [UIColor clearColor];
        [collV registerClass:[ChatBgImageCell class] forCellWithReuseIdentifier:@"ChatBgImageCellIdentifier"];
        [self.view addSubview:collV];
        _collV = collV;
    }
    return _collV;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AppVoiceThumbModel *thumbModel = _items[indexPath.item];
    ChatBgImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChatBgImageCellIdentifier" forIndexPath:indexPath];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:thumbModel.thumb]];
    if (self.selectIndex == indexPath.item) {
        cell.imageV.layer.borderColor = [ProjConfig normalColors].CGColor;
        [self setThumb:thumbModel];
    }else{
        cell.imageV.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.item;
    AppVoiceThumbModel *thumbModel = _items[indexPath.item];
    [self setThumb:thumbModel];
    [collectionView reloadData];
}

- (void)setThumb:(AppVoiceThumbModel *)thumbModel{
    [_bgImageV sd_setImageWithURL:[NSURL URLWithString:thumbModel.thumb]];
    if (self.changeBlock && thumbModel) {
        self.changeBlock(thumbModel.id_field, thumbModel.thumb);
    }
}


- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [BaseNavBarItem navBarBgClear:self foregroundColor:nil];
    return [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navBackBtnImage:[UIImage imageNamed:@"main_navbar_back"] target:self action:@selector(popViewController)]];
    
}


- (void)popViewController{
    [self sendUserData];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)sendUserData{
    if (self.selectIndex < _items.count) {
        AppVoiceThumbModel *thumbModel = _items[self.selectIndex];
        int64_t roomId = [LiveManager liveInfo].roomId > 0?[LiveManager liveInfo].roomId:0;
        [HttpApiHttpVoice updateLiveBackground:roomId voiceThumbId:thumbModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code != 1) {
                [SVProgressHUD showInfoWithStatus:strMsg];
            }else{
                OpenAuthDataVOModel *openModel = [LiveManager liveInfo].openData;
                openModel.voiceThumb = thumbModel.thumb;
                [LiveManager liveInfo].openData = openModel;
            }
        }];
    }
}



- (void)setBgImage{
    AppVoiceThumbModel *thumbModel = _items[self.selectIndex];
    [_bgImageV sd_setImageWithURL:[NSURL URLWithString:thumbModel.thumb]];
}



@end
