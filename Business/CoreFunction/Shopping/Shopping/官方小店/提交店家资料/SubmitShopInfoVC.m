//
//  SubmitShopInfoVC.m
//  Shopping
//
//  Created by kalacheng on 2020/6/23.
//  Copyright © 2020 klc. All rights reserved.
//

#import "SubmitShopInfoVC.h"
#import "KeyboardToolBar.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/SkyDriveTool.h>
#import <LibProjModel/HttpApiShopBusiness.h>

#import <LibProjView/SDPhotoBrowser.h>
#import <LibProjView/ZDropScrollView.h>

#import <SDWebImage/SDWebImage.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjView/CustomCameraController.h>

@interface SubmitShopInfoVC ()<ZDropScrollViewDelegate,UITextViewDelegate,SDPhotoBrowserDelegate>
@property(nonatomic,strong)UIScrollView *scrol;
@property(nonatomic,strong)UIImageView *shopLogoImage;
@property(nonatomic,strong)UILabel *logoLabel;
@property(nonatomic,strong)UILabel *shopNameL;
@property(nonatomic,strong)UITextField *shopNameTF;
@property(nonatomic,strong)UILabel *phoneL;
@property(nonatomic,strong)UITextField *phoneTF;
@property(nonatomic,strong)UILabel *shopIntroL;
@property(nonatomic,strong)UITextView *shopIntroTV;
@property(nonatomic,strong)UILabel   *textNumL;

@property(nonatomic,strong)UILabel *licenseL;

@property(nonatomic,strong)UIButton *submitBtn;

@property(nonatomic,strong)UIView *nameLinkV;
@property(nonatomic,strong)UIView *phoneLinkV;

@property (nonatomic,strong) ZDropScrollView *shopInfoScrol;
@property (nonatomic,strong) NSMutableArray *shopInfoImageDatas;
@property (nonatomic,strong) NSArray *shopImageArr;
@property (nonatomic,strong) ZDropScrollView *licenseInfoScrol;
@property (nonatomic,strong) NSMutableArray *licenseImageDatas;
@property (nonatomic,strong) NSArray *licenseImageArr;

@property (nonatomic,assign) NSInteger addImageType;


@property(nonatomic,copy)NSString *logoImageURL;

@property(nonatomic,assign)int64_t businessId;



@property (nonatomic, strong)UIView *checkingTipView;
@end

@implementation SubmitShopInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLocalizationMsg(@"商家简介");
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.vcType intValue] == 1) {
        [self.submitBtn setTitle:kLocalizationMsg(@"修改资料") forState:UIControlStateNormal];
    }
    [self getInformationData];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditingNow)]];
}

- (void)endEditingNow{
    [self.view endEditing:YES];
}

-(void)creatSubView{
    [self.view addSubview:self.scrol];
    [self.scrol addSubview:self.shopLogoImage];
    [self.scrol addSubview:self.logoLabel];
    [self.scrol addSubview:self.shopNameL];
    [self.scrol addSubview:self.shopNameTF];
    [self.scrol addSubview:self.nameLinkV];
    [self.scrol addSubview:self.phoneL];
    [self.scrol addSubview:self.phoneTF];
    [self.scrol addSubview:self.phoneLinkV];
    [self.scrol addSubview:self.shopIntroL];
    [self.scrol addSubview:self.shopIntroTV];
    [self.scrol addSubview:self.textNumL];
    [self.scrol addSubview:self.shopInfoScrol];
    [self.scrol addSubview:self.licenseL];
    [self.scrol addSubview:self.licenseInfoScrol];
    [self.view addSubview:self.submitBtn];
    [self setColorWithsubmitBtn];
    
    self.shopInfoImageDatas = [NSMutableArray arrayWithArray:self.shopImageArr];
    _shopInfoScrol.o_imageDatas = self.shopInfoImageDatas;
    [self.shopInfoScrol reloadData];
    
    self.licenseImageDatas = [NSMutableArray arrayWithArray:self.licenseImageArr];
    _shopInfoScrol.o_imageDatas = self.licenseImageDatas;
    [self.licenseInfoScrol reloadData];
    
    KeyboardToolBar *toolBar = [[KeyboardToolBar alloc]initWithArray:@[self.shopNameTF,self.phoneTF,self.shopIntroTV]];
    self.shopNameTF.inputAccessoryView = toolBar;
    self.phoneTF.inputAccessoryView = toolBar;
    self.shopIntroTV.inputAccessoryView = toolBar;
}



-(void)submitBtnClick:(UIButton *)sender{
    
    if (self.logoImageURL.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请上传商家logo")];
        return;
    }
    
    if (self.shopNameTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入商家名称")];
        return;
    }
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入商家联系电话")];
        return;
    }
    
    //    if (self.shopInfoImageDatas.count == 0) {
    //        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请上传商家介绍")];
    //        return;
    //    }
    
    if ([self.vcType intValue] == 1) {
        [self ModifyInfo];
    }else{
        [self submitInfo];
    }
    
}


-(void)shopLogoImageTap{
    [self addImage:0];
}



-(UIScrollView *)scrol{
    if (!_scrol) {
        _scrol = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 35 - 44 - kSafeAreaBottom -kNavBarHeight)];
        _scrol.contentSize = CGSizeMake(kScreenWidth,500+((kScreenWidth-80)/3)*2 +50);
    }
    return _scrol;
}

- (UIView *)checkingTipView{
    if (!_checkingTipView) {
        _checkingTipView = [[UIView alloc]initWithFrame:self.view.bounds];
        _checkingTipView.backgroundColor = [UIColor clearColor];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 183, 124)];
        imageV.image = [UIImage imageNamed:@"shop_checking_tip"];
        imageV.center = CGPointMake(kScreenWidth/2.0, (kScreenHeight-kNavBarHeight)/2.0-kNavBarHeight-50);
        [_checkingTipView addSubview:imageV];
        UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, imageV.maxY+20, kScreenWidth-30, 20)];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:14];
        tipLabel.textColor = kRGB_COLOR(@"#444444");
        tipLabel.text = kLocalizationMsg(@"资料审核中，请耐心等待!");
        [_checkingTipView addSubview:tipLabel];
    }
    return _checkingTipView;
}
-(UIImageView *)shopLogoImage{
    
    if (!_shopLogoImage) {
        _shopLogoImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth -100)/2, 20, 100, 100)];
        _shopLogoImage.image = [UIImage imageNamed:@"shop_dianjialogo"];
        _shopLogoImage.userInteractionEnabled = YES;
        _shopLogoImage.layer.cornerRadius = 50;
        _shopLogoImage.layer.masksToBounds = YES;
        _shopLogoImage.contentMode = UIViewContentModeScaleAspectFill;
        [_shopLogoImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shopLogoImageTap)] ];
    }
    
    return _shopLogoImage;
}

-(UILabel *)logoLabel{
    
    if (!_logoLabel) {
        _logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, kScreenWidth, 20)];
        _logoLabel.textColor = kRGB_COLOR(@"#9BA2AC");
        _logoLabel.font = [UIFont systemFontOfSize:14];
        _logoLabel.text = kLocalizationMsg(@"上传商家LOGO");
        _logoLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _logoLabel;
}

-(UILabel *)shopNameL{
    
    if (!_shopNameL) {
        _shopNameL = [[UILabel alloc] initWithFrame:CGRectMake(20, self.logoLabel.maxY + 30, 70, 20)];
        _shopNameL.text = kLocalizationMsg(@"商家名称");
        _shopNameL.textColor = kRGB_COLOR(@"#555555");
        _shopNameL.font = [UIFont systemFontOfSize:14];
    }
    
    return _shopNameL;
}

-(UITextField *)shopNameTF{
    
    if (!_shopNameTF) {
        _shopNameTF = [[UITextField alloc] initWithFrame:CGRectMake(self.shopNameL.maxX +12, self.logoLabel.maxY + 30, kScreenWidth - 120, 20)];
        _shopNameTF.placeholder = kLocalizationMsg(@"请输入商家名称");
        _shopNameTF.font = [UIFont systemFontOfSize:13];
        _shopNameTF.textColor = kRGB_COLOR(@"#9BA2AC");
    }
    
    return _shopNameTF;
}


-(UIView *)nameLinkV{
    if (!_nameLinkV) {
        _nameLinkV = [[UIView alloc] initWithFrame:CGRectMake(20, self.shopNameL.maxY + 10, kScreenWidth - 40, 0.5)];
        _nameLinkV.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    }
    return _nameLinkV;
}


-(UILabel *)phoneL{
    
    if (!_phoneL) {
        _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(20, self.shopNameL.maxY + 30, 70, 20)];
        _phoneL.text = kLocalizationMsg(@"联系电话");
        _phoneL.textColor = kRGB_COLOR(@"#555555");
        _phoneL.font = [UIFont systemFontOfSize:14];
    }
    
    return _phoneL;
}

-(UITextField *)phoneTF{
    
    if (!_phoneTF) {
        _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(self.shopNameL.maxX +12, self.shopNameL.maxY + 30, kScreenWidth - 120, 20)];
        _phoneTF.placeholder = kLocalizationMsg(@"请输入商家联系电话");
        _phoneTF.keyboardType = UIKeyboardTypePhonePad;
        _phoneTF.font = [UIFont systemFontOfSize:13];
        _phoneTF.textColor = kRGB_COLOR(@"#9BA2AC");
    }
    
    return _phoneTF;
}

-(UIView *)phoneLinkV{
    if (!_phoneLinkV) {
        _phoneLinkV = [[UIView alloc] initWithFrame:CGRectMake(20, self.phoneL.maxY + 10, kScreenWidth - 40, 0.5)];
        _phoneLinkV.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    }
    return _phoneLinkV;
}



-(UILabel *)shopIntroL{
    
    if (!_shopIntroL) {
        _shopIntroL = [[UILabel alloc] initWithFrame:CGRectMake(20, self.phoneL.maxY + 30, 200, 20)];
        _shopIntroL.text = kLocalizationMsg(@"商家简介（非必填）");
        _shopIntroL.textColor = kRGB_COLOR(@"#555555");
        _shopIntroL.font = [UIFont systemFontOfSize:14];
    }
    
    return _shopIntroL;
}


-(UITextView *)shopIntroTV{
    
    if (!_shopIntroTV) {
        _shopIntroTV = [[UITextView alloc] initWithFrame:CGRectMake(20, self.shopIntroL.maxY + 15, kScreenWidth - 40, 120)];
        _shopIntroTV.font = [UIFont systemFontOfSize:13];
        _shopIntroTV.layer.borderColor = kRGB_COLOR(@"#DEDEDE").CGColor;
        _shopIntroTV.layer.borderWidth = 1;
        _shopIntroTV.layer.cornerRadius = 8;
        _shopIntroTV.layer.masksToBounds = YES;
        _shopIntroTV.placeholder = kLocalizationMsg(@"请输入商家简介");
        _shopIntroTV.placeholderColor = kRGB_COLOR(@"#9BA2AC");
        _shopIntroTV.textColor = kRGB_COLOR(@"#9BA2AC");
        _shopIntroTV.delegate = self;
    }
    
    return _shopIntroTV;
}

-(UILabel *)textNumL{
    
    if (!_textNumL) {
        _textNumL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 130, self.shopIntroTV.maxY - 25, 100, 20)];
        _textNumL.font = [UIFont systemFontOfSize:12];
        _textNumL.font = [UIFont systemFontOfSize:12];
        _textNumL.textAlignment = NSTextAlignmentRight;
        _textNumL.textColor = [UIColor lightGrayColor];
        _textNumL.text = [NSString stringWithFormat:@"0/%i",500];
    }
    
    return _textNumL;
}




-(UILabel *)licenseL{
    
    if (!_licenseL) {
        _licenseL = [[UILabel alloc] initWithFrame:CGRectMake(20, self.shopInfoScrol.maxY + 20, 200, 20)];
        _licenseL.text = kLocalizationMsg(@"营业证照（非必填）");
        _licenseL.textColor = kRGB_COLOR(@"#555555");
        _licenseL.font = [UIFont systemFontOfSize:14];
    }
    
    return _licenseL;
}


-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth -kScreenWidth *0.6)/2 , kScreenHeight -kNavBarHeight- kSafeAreaBottom - 59, kScreenWidth *0.6, 44)];
        [_submitBtn setTitle:kLocalizationMsg(@"提交资料") forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _submitBtn;
    
}

-(ZDropScrollView *)shopInfoScrol{
    if (!_shopInfoScrol) {
        _shopInfoScrol = [[ZDropScrollView alloc] initWithFrame:CGRectMake(10, self.shopIntroTV.maxY + 5, kScreenWidth -20, (kScreenWidth-80)/3 + 20) ];
        _shopInfoScrol.o_delegate = self;
        _shopInfoScrol.o_regionView = self.scrol;
        _shopInfoScrol.o_maxCount = 3;
        _shopInfoScrol.sDROPVIEW_MARGIN = 20;
        _shopInfoScrol.sDROPVIEW_SIZE = (kScreenWidth-80)/3 ;
        _shopInfoScrol.sDROPVIEW_COUNT = 3;
        _shopInfoScrol.tag = 10001;
        _shopInfoScrol.addImageStr = @"shop_introAdd";
    }
    return _shopInfoScrol;
}

-(NSArray *)shopImageArr{
    if (!_shopImageArr) {
        _shopImageArr = [[NSArray alloc] init];
    }
    return _shopImageArr;
}

-(NSMutableArray *)shopInfoImageDatas{
    if (!_shopInfoImageDatas) {
        
        _shopInfoImageDatas = [NSMutableArray array];
    }
    return _shopInfoImageDatas;
}


-(ZDropScrollView *)licenseInfoScrol{
    if (!_licenseInfoScrol) {
        _licenseInfoScrol = [[ZDropScrollView alloc] initWithFrame:CGRectMake(10, self.licenseL.maxY + 5, kScreenWidth -20, (kScreenWidth-80)/3 + 20 ) ];
        _licenseInfoScrol.o_delegate = self;
        _licenseInfoScrol.o_regionView = self.scrol;
        _licenseInfoScrol.o_maxCount = 3;
        _licenseInfoScrol.sDROPVIEW_MARGIN = 20;
        _licenseInfoScrol.sDROPVIEW_SIZE = (kScreenWidth-80)/3;
        _licenseInfoScrol.sDROPVIEW_COUNT = 3;
        _licenseInfoScrol.tag = 10002;
        _licenseInfoScrol.addImageStr = @"shop_licenseAdd";
    }
    return _licenseInfoScrol;
}

-(NSArray *)licenseImageArr{
    if (!_licenseImageArr) {
        _licenseImageArr = [[NSArray alloc] init];
    }
    return _licenseImageArr;
}

-(NSMutableArray *)licenseImageDatas{
    if (!_licenseImageDatas) {
        _licenseImageDatas = [NSMutableArray array];
    }
    return _licenseImageDatas;
}


-(void)setColorWithsubmitBtn{
    CGFloat coinBtnW = kScreenWidth*0.6;
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 22;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors     = @[(__bridge id) kRGB_COLOR(@"#FB72E2").CGColor, (__bridge id) kRGB_COLOR(@"#9C58FE").CGColor];
    gradientLayer.locations  = @[@0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(1.0, 0);
    gradientLayer.frame      = CGRectMake(0, 0, coinBtnW, 44);
    gradientLayer.cornerRadius = 22;
    [self.submitBtn.layer addSublayer:gradientLayer];
    [self.submitBtn.layer insertSublayer:gradientLayer atIndex:0];
}



#pragma mark- PreDroScrollViewDelegate
-(void) addNewView:(ZDropScrollView *)scrollView{
   // NSLog(@"过滤文字scrollView==%@"),scrollView);
    
    self.addImageType = scrollView.tag - 10000;
    kWeakSelf(self);
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];;
    [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"相机") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself photoShoot:self.addImageType];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself addImage:self.addImageType];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void) exchangeIndex:(NSInteger)index otherIndex:(NSInteger)otherIndex andView:(ZDropScrollView *)scrollView
{
   // NSLog(@"过滤文字交换 原始数据 %ld <--> %ld"),index,otherIndex);
    self.addImageType = scrollView.tag - 10000;
    switch (self.addImageType) {
        case 1:
            [self.shopInfoImageDatas exchangeObjectAtIndex:index withObjectAtIndex:otherIndex];
            break;
        case 2:
            [self.licenseImageDatas exchangeObjectAtIndex:index withObjectAtIndex:otherIndex];
            break;
        default:
            break;
    }
    
}


-(void)removeIndex:(NSInteger)index andView:(ZDropScrollView *)scrollView{
   // NSLog(@"过滤文字删除 原始数据 %ld"),index);
    self.addImageType = scrollView.tag - 10000;
    switch (self.addImageType) {
        case 1:
            [self.shopInfoImageDatas removeObjectAtIndex:index];
            break;
        case 2:
            [self.licenseImageDatas removeObjectAtIndex:index];
            break;
        default:
            break;
    }
}



-(void) didSelectWithIndex:(NSInteger)index userInfo:(id)userInfo andView:(ZDropScrollView *)scrollView
{
    self.addImageType = scrollView.tag - 10000;
   // NSLog(@"过滤文字select index=%ld,userInfo=%@"),(long)index,userInfo);
    switch (self.addImageType) {
        case 1:
            [self clickImageView:index];
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
}

//可以在此动态修改 ZDropScrollView的高度
-(void) contentSizeDidChange:(CGSize)contenSize
{
   // NSLog(@"过滤文字content size:%@"),NSStringFromCGSize(contenSize));
    
    
}


- (void)photoShoot:(NSInteger)type{
    kWeakSelf(self);
    CustomCameraController *camera = [[CustomCameraController alloc] init] ;
    camera.showPhotoAlbum = NO;
    camera.functionType = CameraFunction_onlyCamera;
    camera.isFront = NO;
    [camera selectPhotoDidComplete:^(CustomCameraController *cameraVC, NSArray<UIImage *> *images) {
        [cameraVC dismissViewControllerAnimated:NO completion:nil];
        ///上传
        [weakself uploadImage:images.firstObject andType:type];
    }];
    [self presentViewController:camera animated:YES completion:nil];
}


-(void)addImage:(NSInteger)type{
    kWeakSelf(self);
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.maxImagesCount = 1;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.showSelectedIndex = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.showSelectBtn = YES;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
    
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
        [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
    }];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        switch (type) {
            case 0:
                weakself.shopLogoImage.image = photos.firstObject;
                break;
            case 1:
                //                    [weakself.shopInfoImageDatas addObjectsFromArray:photos];
                //                    weakself.shopInfoScrol.o_imageDatas = self.shopInfoImageDatas;
                //                    [weakself.shopInfoScrol reloadData];
                break;
            case 2:
                //                    [weakself.licenseImageDatas addObjectsFromArray:photos];
                //                    weakself.licenseInfoScrol.o_imageDatas = self.licenseImageDatas;
                //                    [weakself.licenseInfoScrol reloadData];
                break;
            default:
                break;
        }
        ///上传
        [weakself uploadImage:photos.firstObject andType:type];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


- (void)uploadImage:(UIImage *)image andType:(NSInteger)type{
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"上传中")];
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:5 image:image complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            switch (type) {
                case 0:
                    self.logoImageURL = imageUrl;
                    break;
                case 1:
                    [weakself.shopInfoImageDatas addObject:imageUrl];
                    weakself.shopInfoScrol.o_imageDatas = self.shopInfoImageDatas;
                    [weakself.shopInfoScrol reloadData];
                    break;
                case 2:
                    [weakself.licenseImageDatas addObject:imageUrl];
                    weakself.licenseInfoScrol.o_imageDatas = self.licenseImageDatas;
                    [weakself.licenseInfoScrol reloadData];
                    break;
                default:
                    break;
            }
           // NSLog(@"过滤文字imageUrl=%@"),imageUrl);
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传成功")];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"发送图片失败！")];
        }
    }];
}

//提交资料
-(void)submitInfo{
    NSString *businessLicense = [self.licenseImageDatas componentsJoinedByString:@","];
    NSString *logo = self.logoImageURL;
    NSString *mobile = self.phoneTF.text;
    NSString *name = self.shopNameTF.text;
    NSString *present = self.shopIntroTV.text;
    NSString *presentPicture =  [self.shopInfoImageDatas componentsJoinedByString:@","];
    kWeakSelf(self);
    [HttpApiShopBusiness applicationForResidence:businessLicense logo:logo mobile:mobile name:name present:present presentPicture:presentPicture callback:^(int code, NSString *strMsg, AppMerchantAgreementDTOModel *model) {
        if (code == 1) {
            [RouteManager routeForName:RN_Shopping_ShopContentVC  currentC:weakself parameters:@{@"status":@(model.status),@"remake":model.remake}];
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"提交成功")];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}



//修改资料
-(void)ModifyInfo{
    kWeakSelf(self);
    NSString *businessLicense = [self.licenseImageDatas componentsJoinedByString:@","];
    NSString *logo = self.logoImageURL;
    NSString *mobile = self.phoneTF.text;
    NSString *name = self.shopNameTF.text;
    NSString *present = self.shopIntroTV.text;
    NSString *presentPicture =  [self.shopInfoImageDatas componentsJoinedByString:@","];
    int64_t businessId = self.businessId;
    [HttpApiShopBusiness updateBusiness:businessId businessLicense:businessLicense logo:logo mobile:mobile name:name present:present presentPicture:presentPicture callback:^(int code, NSString *strMsg, AppMerchantAgreementDTOModel *model) {
        if (code == 1) {
            [RouteManager routeForName:RN_Shopping_ShopContentVC  currentC:weakself parameters:@{@"status":@(model.status),@"remake":model.remake}];
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"修改成功")];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}



//获取资料
-(void)getInformationData{
    kWeakSelf(self);
    [HttpApiShopBusiness getOne:^(int code, NSString *strMsg, ShopBusinessModel *model) {
        if (code == 1) {
            if (model.status != 1) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself creatSubView];
                    [weakself updataUI:model];
                });
            }else{//审核中
                [weakself.view addSubview:self.checkingTipView];
            }
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself creatSubView];
                [weakself updataUI:model];
            });
        }
    }];
}

-(void)updataUI:(ShopBusinessModel *)model{
    
    self.logoImageURL = model.logo;
    [self.shopLogoImage sd_setImageWithURL:[NSURL URLWithString:self.logoImageURL] placeholderImage:[UIImage imageNamed:@"shop_dianjialogo"]];
    if (model.logo.length > 0) {
        self.logoLabel.text = kLocalizationMsg(@"商家LOGO");
    }
    self.shopNameTF.text = model.name;
    self.phoneTF.text = model.mobile;
    self.shopIntroTV.text = model.present;
    
    self.textNumL.text = [NSString stringWithFormat:@"%zi/%d",self.shopIntroTV.text.length,500];
    
    if (model.presentPicture.length) {
        self.shopImageArr = [model.presentPicture componentsSeparatedByString:@","];
        self.shopInfoImageDatas = [NSMutableArray arrayWithArray:self.shopImageArr];
        _shopInfoScrol.o_imageDatas = self.shopInfoImageDatas;
        [self.shopInfoScrol reloadData];
    }
    
    if (model.businessLicense.length) {
        self.licenseImageArr = [model.businessLicense componentsSeparatedByString:@","];
        self.licenseImageDatas = [NSMutableArray arrayWithArray:self.licenseImageArr];
        _licenseInfoScrol.o_imageDatas = self.licenseImageDatas;
        [self.licenseInfoScrol reloadData];
    }
    
    self.businessId = model.id_field;
}


#pragma mark - textView delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if (kScreenWidth <= 375) {
        [self.scrol setContentOffset:CGPointMake(0, 160) animated:YES];
    }
    
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView{
    
    UITextInputMode *currentInputMode = textView.textInputMode;
    NSString *lang = [currentInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            if (textView.text.length > 500) {
                textView.text = [textView.text substringToIndex:500];
                
            }
            
        } else{
        }
        
    }else{
        if (textView.text.length > 500){
            textView.text = [textView.text substringToIndex:500];
        }
    }
    self.textNumL.text = [NSString stringWithFormat:@"%zi/%d",textView.text.length,500];
    
}

- (void)clickImageView:(NSInteger)imageTag{
    
    if (self.addImageType == 1) {
        if (self.shopInfoImageDatas.count>imageTag) {
            SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
            browser.currentImageIndex = imageTag;
            browser.sourceImagesContainerView = self.shopInfoScrol;
            browser.imageCount = self.shopInfoImageDatas.count;
            browser.delegate = self;
            [browser show];
        }
    }else{
        if (self.licenseImageDatas.count>imageTag) {
            SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
            browser.currentImageIndex = imageTag;
            browser.sourceImagesContainerView = self.licenseInfoScrol;
            browser.imageCount = self.licenseImageDatas.count;
            browser.delegate = self;
            [browser show];
        }
    }
    
}

#pragma mark - SDPhotoBrowserDelegate -
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = @"";
    
    if (self.addImageType == 1) {
        urlStr = [self.shopInfoImageDatas[index] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else{
        urlStr = [self.licenseImageDatas[index] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
    return [NSURL URLWithString:urlStr];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    //    UIImageView *img = self.shopInfoScrol.subviews[index];
    //    return img.image;
    
    if (self.addImageType == 1) {
        return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.shopInfoImageDatas[index]]]];
    }else{
        return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.licenseImageDatas[index]]]];
    }
    
}


@end
