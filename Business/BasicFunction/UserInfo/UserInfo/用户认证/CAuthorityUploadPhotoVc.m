//
//  CAuthorityUploadPhotoVc.m
//  MineCenter
//
//  Created by ssssssss on 2020/11/28.
//  Copyright © 2020 KLC. All rights reserved.
// 上传证件

#import "CAuthorityUploadPhotoVc.h"
#import <TZImagePickerController/TZImagePickerController.h>

#import <LibProjModel/HttpApiAnchorAuthenticationController.h>
#import <LibProjModel/AnchorAuthVOModel.h>
#import <LibProjView/CustomCameraController.h>

@interface CAuthorityUploadPhotoVc ()<TZImagePickerControllerDelegate>
@property (nonatomic, strong)UIScrollView *scrollV;
@property (nonatomic, assign)NSInteger selectedIndex;
@property (nonatomic, assign)BOOL isUploading;
@property (nonatomic, strong)AnchorAuthVOModel *authModel;
 
@property (nonatomic, strong)UIButton *frontImageBtn;//正面
@property (nonatomic, strong)UIButton *backImageBtn;//反面
@property (nonatomic, strong)UIButton *hostImageBtn;//手持
 
@end

@implementation CAuthorityUploadPhotoVc
- (instancetype)initWith:(AnchorAuthVOModel *)authModel{
    self = [super init];
    if (self) {
        self.authModel = authModel;
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.completeCallBack(self.authModel);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleStr;
    [self.view addSubview:self.scrollV];
    [self createUI];
}
- (void)createUI{
    CGFloat width = kScreenWidth*150.0/375;
    CGFloat height = width*95/150.0;
    CGFloat margin = kScreenWidth-30-2*width;
    for (int i = 0; i < 3; i++) {
        UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0,(height+100)*i, kScreenWidth, height+100)];
        backV.backgroundColor = [UIColor whiteColor];
        [self.scrollV addSubview:backV];
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, kScreenWidth-30, 20)];
        titleL.textColor =  kRGB_COLOR(@"#333333");
        titleL.font = [UIFont systemFontOfSize:13];
        titleL.textAlignment = NSTextAlignmentLeft;
        if (i == 0) {
            titleL.text = kLocalizationMsg(@"身份证正面");
        }else if(i == 1){
            titleL.text = kLocalizationMsg(@"身份证背面");
        }else if(i == 2){
            titleL.text = kLocalizationMsg(@"手持身份证");
        }
        [backV addSubview:titleL];
        
        UIImageView *leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, titleL.maxY+10, width, height)];
        if (i == 0) {
            leftImageV.image = [UIImage imageNamed:@"icon_authority_idcard_front"];
        }else if(i == 1){
            leftImageV.image = [UIImage imageNamed:@"icon_authority_idcard_back"];
        }else if(i == 2){
            leftImageV.image = [UIImage imageNamed:@"icon_authority_idcard_host"];
        }
        leftImageV.contentMode = UIViewContentModeScaleAspectFill;
        leftImageV.layer.cornerRadius = 8;
        leftImageV.clipsToBounds = YES;
        [backV addSubview:leftImageV];
        
        UILabel *exmpleL = [[UILabel alloc]initWithFrame:CGRectMake(0, leftImageV.maxY+10, width, 20)];
        exmpleL.textColor = kRGB_COLOR(@"#666666");
        exmpleL.text = kLocalizationMsg(@"示例");
        exmpleL.centerX = leftImageV.centerX;
        exmpleL.font = [UIFont systemFontOfSize:13];
        exmpleL.textAlignment = NSTextAlignmentCenter;
        [backV addSubview:exmpleL];
        
         
        UIImageView *toImageV = [[UIImageView alloc]initWithFrame:CGRectMake(leftImageV.maxX+(margin-15)/2.0, 0, 15, 20)];
        toImageV.image = [UIImage imageNamed:@"icon_authority_idcard_arrow"];
        toImageV.centerY = leftImageV.centerY;
        [backV addSubview:toImageV];
        
        UIButton *cardBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-15-width, titleL.maxY+10, width, height)];
        cardBtn.layer.cornerRadius = 8;
        cardBtn.tag = i;
        if (i == 0) {
            self.frontImageBtn = cardBtn;
            [cardBtn sd_setImageWithURL:[NSURL URLWithString:self.authModel.idCardFrontView] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_authority_idcard_front_placeholder"]];
        }else if(i == 1){
            self.backImageBtn = cardBtn;
            [cardBtn sd_setImageWithURL:[NSURL URLWithString:self.authModel.idCardBackView] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_authority_idcard_back_placeholder"]];
        }else if(i == 2){
            self.hostImageBtn = cardBtn;
            [cardBtn sd_setImageWithURL:[NSURL URLWithString:self.authModel.idCardHandView] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_authority_idcard_host_placeholder"]];
        }
        cardBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cardBtn.clipsToBounds = YES;
        [cardBtn addTarget:self action:@selector(cardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [backV addSubview:cardBtn];
        UILabel *uploadTipL = [[UILabel alloc]initWithFrame:CGRectMake(0, cardBtn.maxY+10, width, 20)];
        uploadTipL.textColor = kRGB_COLOR(@"#666666");
        uploadTipL.text = kLocalizationMsg(@"上传照片");
        uploadTipL.centerX = cardBtn.centerX;
        uploadTipL.font = [UIFont systemFontOfSize:13];
        uploadTipL.textAlignment = NSTextAlignmentCenter;
        [backV addSubview:uploadTipL];
    }
    self.scrollV.contentSize = CGSizeMake(kScreenWidth, (height+100)*3+kSafeAreaBottom);
}
- (void)cardBtnClick:(UIButton *)btn{
    if (self.isUploading) {
        return;
    }
    self.selectedIndex = btn.tag;
    [self ChoosePictureOrTakePhoto];
}

- (void)ChoosePictureOrTakePhoto{
    UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *picAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectThumbWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alertContro addAction:picAction];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"拍照") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectThumbWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    [alertContro addAction:photoAction];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertContro addAction:cancleAction];
    
    [self presentViewController:alertContro animated:YES completion:nil];
}
 
- (void)selectThumbWithType:(UIImagePickerControllerSourceType)type{
    kWeakSelf(self);
    if (type == UIImagePickerControllerSourceTypeCamera) {

        CustomCameraController *camera = [[CustomCameraController alloc] init] ;
        camera.showPhotoAlbum = NO;
        camera.functionType = CameraFunction_onlyCamera;
        [camera selectPhotoDidComplete:^(CustomCameraController *cameraVC, NSArray<UIImage *> *images) {
            [SVProgressHUD showWithStatus:kLocalizationMsg(@"上传中")];
            weakself.isUploading = YES;
            [weakself updateImage:images.firstObject];
            [cameraVC dismissViewControllerAnimated:YES completion:nil];
        }];
        [self presentViewController:camera animated:YES completion:nil];
        
    }else{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerVc.pickerDelegate = self;
        imagePickerVc.maxImagesCount = 1;
        imagePickerVc.allowCrop = NO;
        imagePickerVc.allowPickingOriginalPhoto = YES;
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.showSelectedIndex = YES;
        imagePickerVc.allowTakeVideo = NO;
        imagePickerVc.allowTakePicture = NO;
        imagePickerVc.showSelectBtn = NO;
         
        imagePickerVc.cropRect = CGRectMake(10, (kScreenHeight- kScreenWidth-20)/2.0, kScreenWidth-20, kScreenWidth-20);
        
        imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
        imagePickerVc.naviTitleColor = [ProjConfig projNavTitleColor];
        imagePickerVc.naviBgColor = [UIColor whiteColor];
        [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
            [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
        }];
        [imagePickerVc setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSArray<NSDictionary *> *infos) {
            weakself.isUploading = YES;
            [weakself updateImage:photos.firstObject];
        }];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

- (void)updateImage:(UIImage *)image{
    kWeakSelf(self);
    CGFloat sizeImage = 200;
    __block UIImage *uploadImage = [UIImage imageWithData:[image compressWithMaxLength:1024*sizeImage]];
    [SkyDriveTool uploadImageFormScene:1 image:uploadImage complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"上传成功")];
            [weakself savePhoto:imageUrl];
        }else{
            weakself.isUploading = NO;
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"上传失败")];
        }
    }];
}
 
- (void)savePhoto:(NSString *)url{
    kWeakSelf(self);
    if (self.selectedIndex == 0) {
        self.authModel.idCardFrontView = url;
        [self.frontImageBtn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_authority_idcard_front_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            weakself.isUploading = NO;
        }];
    }else if(self.selectedIndex == 1){
        self.authModel.idCardBackView = url;
        [self.backImageBtn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_authority_idcard_back_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            weakself.isUploading = NO;
        }];
    }else if(self.selectedIndex == 2){
        self.authModel.idCardHandView = url;
        [self.hostImageBtn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_authority_idcard_host_placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            weakself.isUploading = NO;
        }];
    }
    [self updateInfo];
}
- (void)updateInfo{
    if (self.authModel) {
        [HttpApiAnchorAuthenticationController authUpdate:self.authModel callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [SVProgressHUD showSuccessWithStatus:strMsg];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}

#pragma mark - lazy
- (UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollV.backgroundColor = [UIColor whiteColor];
    }
    return _scrollV;
}
@end
