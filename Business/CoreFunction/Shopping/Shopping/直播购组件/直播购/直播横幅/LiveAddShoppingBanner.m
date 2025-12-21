//
//  LiveAddShoppingBanner.m
//  LiveCommon
//
//  Created by klc_sl on 2020/8/4.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LiveAddShoppingBanner.h"
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/FunctionSheetBaseView.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjView/SkyDriveTool.h>
#import <LibProjModel/HttpApiHttpLive.h>
#import <LiveCommon/LiveManager.h>
#import <SDWebImage.h>

@interface LiveAddShoppingBanner ()

@property (nonatomic, weak)UIButton *bannerImgV;
@property (nonatomic, weak)UIButton *removeBtn;

@end

@implementation LiveAddShoppingBanner

+ (void)addShoppingBanner{
    LiveAddShoppingBanner *addBanner = [[LiveAddShoppingBanner alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200+kSafeAreaBottom)];
    [addBanner createUI];
    [FunctionSheetBaseView showView:addBanner cover:NO];
}


- (void)createUI{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
    [self addSubview:headerV];
    
    ///商店名称
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textColor = [UIColor blackColor];
    titleL.text = kLocalizationMsg(@"上传活动横幅");
    [headerV addSubview:titleL];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerV);
        make.left.equalTo(headerV).mas_offset(12);
    }];
    
    //右侧关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:0];
    closeBtn.frame = CGRectMake(kScreenWidth-headerV.height, 0, headerV.height, headerV.height);
    [closeBtn setImage:[UIImage imageNamed:@"live_guanbi_gray"] forState:UIControlStateNormal];
    [closeBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [closeBtn addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:closeBtn];
    

    ///上传图片UI
    UIButton *banner = [UIButton buttonWithType:0];
    [banner setImage:[UIImage imageNamed:@"live_goods_add"] forState:UIControlStateNormal];
    banner.frame = CGRectMake(24, (self.height-kSafeAreaBottom-50-100)/2.0+50, 100, 100);
    banner.imageView.contentMode = UIViewContentModeScaleAspectFill;
    banner.layer.masksToBounds = YES;
    banner.layer.cornerRadius = 5;
    [banner addTarget:self action:@selector(selectBannerView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:banner];
    _bannerImgV = banner;

    
    UIButton *removeBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 36, 28, 28)];
    removeBtn.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
    removeBtn.layer.cornerRadius = 14;
    removeBtn.clipsToBounds = YES;
    [removeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [removeBtn setTitle:@"-" forState:UIControlStateNormal];
    removeBtn.titleLabel.font = [UIFont systemFontOfSize:28];
    [removeBtn addTarget:self action:@selector(removeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:removeBtn];
    self.removeBtn = removeBtn;
    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.top.right.equalTo(banner);
    }];
    
    
    UILabel *contentL = [[UILabel alloc] init];
    contentL.textAlignment = NSTextAlignmentLeft;
    contentL.frame = CGRectMake(banner.maxX+20, 60, kScreenWidth-168, 80);
    contentL.font = [UIFont systemFontOfSize:12];
    contentL.centerY = banner.centerY;
    contentL.numberOfLines = 0;
    contentL.textColor = kRGB_COLOR(@"#333333");
    NSString *showStr = kLocalizationMsg(@"图片建议尺寸：\n宽度为270px, 高度不得超过540px;\n仅支持1张活动横幅");
    [self addSubview:contentL];
    contentL.attributedText = [showStr lineSpace:10];
    
    [self setBannerShow];
}


- (void)dealloc{
   // NSLog(@"过滤文字delloc"));
}


- (void)removeBtnClick:(UIButton *)btn{
    [self removeLiveBanner];
    [FunctionSheetBaseView deletePopView:self];
}


- (void)selectBannerView:(UIButton *)btn{
    [self endEditing:YES];
    BOOL isVideo = NO;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:isVideo?1:9 delegate:nil];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.maxImagesCount = 1;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
    imagePickerVc.naviTitleColor = [ProjConfig projNavTitleColor];
    imagePickerVc.naviBgColor = [UIColor whiteColor];
//    CGFloat viewWidth = 180;
//    CGFloat viewHeight = 360;
    
    
    CGFloat viewHeight = kScreenHeight-kNavBarHeight-kSafeAreaBottom-100;
    CGFloat viewWidth = viewHeight/2.0;
    if (viewWidth > kScreenWidth-60) {
        viewWidth = kScreenWidth-60;
        viewHeight = viewWidth * 2;
    }
    
    imagePickerVc.cropRect = CGRectMake((kScreenWidth-viewWidth)/2.0, (kScreenHeight - viewHeight)/2.0, viewWidth, viewHeight);
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
        [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
    }];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self uploadUserIcon:photos.firstObject];
    }];
    [[ProjConfig currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (void)uploadUserIcon:(UIImage *)image{
    ///上传
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"上传中")];
    __block UIImage *uploadImage = [UIImage imageWithData:[image compressWithMaxLength:1024*200]];
    [SkyDriveTool uploadImageFormScene:5 image:uploadImage complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setLiveThumb:uploadImage imagePath:imageUrl success:success];
            });
        }else{
            [SVProgressHUD dismiss];
        }
    }];
}

- (void)setLiveThumb:(UIImage *)image imagePath:(NSString *)imagePath success:(BOOL)success{
    if (success && imagePath.length>0) {
        kWeakSelf(self);
        [HttpApiHttpLive setShopLiveBanner:[LiveManager liveInfo].roomId shopLiveBanner:imagePath callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            [SVProgressHUD dismiss];
            if (code == 1) {
                [LiveManager liveInfo].roomModel.shopLiveBanner = imagePath;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself setBannerShow];
                });
            }else{
                 [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
        
    }else{
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传失败")];
        
    }
}
- (void)removeLiveBanner{
    kWeakSelf(self);
    [HttpApiHttpLive setShopLiveBanner:[LiveManager liveInfo].roomId shopLiveBanner:@"" callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        [SVProgressHUD dismiss];
        if (code == 1) {
            [LiveManager liveInfo].roomModel.shopLiveBanner = @"";
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself setBannerShow];
            });
        }else{
             [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)setBannerShow{
    NSString *bannerStr = [LiveManager liveInfo].roomModel.shopLiveBanner;
    [LiveManager liveInfo].roomModel.shopLiveBanner = bannerStr;
    self.removeBtn.hidden = bannerStr.length?NO:YES;;
    [self.bannerImgV sd_setImageWithURL:[NSURL URLWithString:bannerStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"live_goods_add"]];
}


- (void)dismissView:(UIButton *)btn{
    [FunctionSheetBaseView deletePopView:self];
}


@end
