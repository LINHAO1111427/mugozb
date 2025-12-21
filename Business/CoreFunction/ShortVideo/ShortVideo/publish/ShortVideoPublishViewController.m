//
//  ShortVideoPublishViewController.m
//  HomePage
//
//  Created by ssssssss on 2020/6/15.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "ShortVideoPublishViewController.h"

#import "TZImagePickerController.h"

#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/AppRouteName.h>
#import <LibProjBase/BaseNavBarItem.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>

#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjModel/HttpApiAppShortVideo.h>

#import <LibProjModel/AppHotSortModel.h>
#import <LibProjModel/ShopGoodsDTOModel.h>
  
#import <LibProjView/LocationView.h>
#import <LibProjView/VideoPreviewView.h>
#import <LibProjView/BrowserPhotoView.h>
#import <LibProjView/BtnListLayoutView.h>
#import <LibProjView/LiveGoodsManagerView.h>

#import <LibProjView/CustomCameraController.h>
#import <LibProjView/SkyDriveTool.h>

#import "CommoditySelectPublishView.h"
 
@interface ShortVideoPublishViewController ()<UITextViewDelegate,BtnListLayoutViewDelegate>

@property (nonatomic, weak)UITextView *weakTextV; ///输入的文字
@property (nonatomic, weak)UIView *contentV;  ///多媒体view
@property (nonatomic, weak)UIScrollView *bgScrollV;

@property (nonatomic, weak)UILabel *textNumL;  ///文字数量
@property (nonatomic, assign)NSInteger textNum; ///文字最大数量
@property (nonatomic,copy)NSString *thumbStr;  ///图片字符串
@property (nonatomic, strong)UILabel *locationLabel;  ///定位的位置

@property (nonatomic, strong)VideoPreviewView *playerView;
 
@property (nonatomic, strong)UIButton *privateBtn;
@property (nonatomic, strong)UITextField *privatePriceTextField;

@property (nonatomic, strong)BtnListLayoutView *btnListView;
@property (nonatomic, strong)UIView *bottmView;

@property (nonatomic, assign)BOOL isVideo;//当前是video还是photo
@property (nonatomic, strong)NSArray *sortArr;//标签list
@property (nonatomic, strong)NSMutableArray<NSNumber *> *selecteditemArr;//选择的

///选择商品
@property (nonatomic, weak)CommoditySelectPublishView *selectCommodityView;

//位置
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,assign)double lat;
@property (nonatomic,assign)double lng;

@end

@implementation ShortVideoPublishViewController

#pragma mark - 懒加载

- (NSMutableArray *)selecteditemArr{
    if (!_selecteditemArr) {
        _selecteditemArr = [NSMutableArray array];
    }
    return _selecteditemArr;;
}

- (NSMutableArray *)imgArr{
    if (_imgArr == nil) {
        _imgArr = [[NSMutableArray alloc] init];
    }
    return _imgArr;
}

#pragma mark - 初始化
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.playerView reset];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.textNum = 50;
    
    [BaseNavBarItem navbar:self bgImage:[UIImage imageWithColor:[UIColor whiteColor]] foregroundColor:nil];
    
    self.navigationItem.title = kLocalizationMsg(@"发布短视频");
    self.view.backgroundColor = [UIColor whiteColor];
    kWeakSelf(self);
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIColor *textColor =[UIColor whiteColor];
    UIColor *titleTextColor = navBar.titleTextAttributes[@"NSColor"];
    if ([self isEqualToColor:titleTextColor anotherColor:kRGB_COLOR(@"#333333")]) {
        textColor = kRGB_COLOR(@"#333333");
    }
     
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemTitle:kLocalizationMsg(@"取消") bgColor:nil textColor:textColor clickHandle:^{
        [weakself dismiss];
    }]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[BaseNavBarItem navItemTitle:kLocalizationMsg(@"发表") bgColor:[ProjConfig normalColors] textColor:[UIColor whiteColor] clickHandle:^{
        [weakself commitInfo];
    }]];
    
    [self createUI];
    
    _isVideo = (([self.videoDuration floatValue]>0 && self.videoUrl && self.previewImg)?YES:NO);
    if (_isVideo) {
        [self uploadpreviewImg:nil];//上传视频封面
        [self createVideoShow];
    }else{
        [self createPhotoShow];
    }
   [self getTagsData];
}
- (BOOL)isEqualToColor:(UIColor*)colorA anotherColor:(UIColor*)colorB{
    if (CGColorEqualToColor(colorA.CGColor, colorB.CGColor)) {
        return YES;
   }else {
        return NO;
   }
}
 
- (void)dismiss{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - 获取数据
///获取话题标签
- (void)getTagsData{
    kWeakSelf(self);
    [HttpApiAppShortVideo getShortVideoClassifyList:^(int code, NSString *strMsg, NSArray<AppHotSortModel *> *arr) {
        if (code == 1) {
            weakself.sortArr = arr;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself upDateSorts_UI];
            });
        }
    }];
}

#pragma mark - 更新UI
- (void)createUI{
    UIScrollView *bgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    [self.view addSubview:bgScroll];
    bgScroll.showsVerticalScrollIndicator = NO;
    bgScroll.scrollEnabled = YES;
    kWeakSelf(self);
    [bgScroll klc_whenTapped:^{
        [weakself.view endEditing:YES];
    }];
    self.bgScrollV = bgScroll;
    
    UITextView *textV = [[UITextView alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth-30, 120)];
    textV.font = [UIFont systemFontOfSize:14];
    textV.delegate = self;
    textV.returnKeyType = UIReturnKeyDone;
    textV.placeholder = kLocalizationMsg(@"说点什么...");
    [bgScroll addSubview:textV];
    self.weakTextV = textV;
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-115, CGRectGetMaxY(textV.frame)-20, 100, 20)];
    numLab.font = [UIFont systemFontOfSize:12];
    numLab.textAlignment = NSTextAlignmentRight;
    numLab.textColor = [UIColor lightGrayColor];
    numLab.text = [NSString stringWithFormat:@"0/%zi",self.textNum];
    [self.bgScrollV addSubview:numLab];
    self.textNumL = numLab;
    
    //内容
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(textV.frame.origin.x, CGRectGetMaxY(textV.frame)+15, textV.frame.size.width, 20)];
    [bgScroll addSubview:contentView];
    self.contentV = contentView;
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(textV.frame.origin.x, contentView.maxY+20, kScreenWidth-2*textV.frame.origin.x, 10)];
    [bgScroll addSubview:bottomView];
    self.bottmView = bottomView;
    
    CGFloat pointY = 0;
    ///定位
    if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance]) {
        UIButton *locateBtn = [UIButton buttonWithType:0];
        locateBtn.frame = CGRectMake(0, pointY, bottomView.width, 40);
        locateBtn.backgroundColor = [UIColor clearColor];
        [locateBtn addTarget:self action:@selector(locateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:locateBtn];
        ///图片
        UIButton *LocationImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(-5, (locateBtn.height-30)/2.0, 30, 30)];
        LocationImageBtn.userInteractionEnabled = NO;
        LocationImageBtn.contentEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [LocationImageBtn setImage:[UIImage imageNamed:@"userInfo_location"] forState:UIControlStateNormal];
        [bottomView addSubview:LocationImageBtn];
        //位置
        NSString *locationStr = [NSString stringWithFormat:@"%@·%@",KLCUserInfo.getCity.length>0?KLCUserInfo.getCity:@"",KLCUserInfo.getAddress.length > 0?KLCUserInfo.getAddress:@""];
        NSString *localNameStr = (KLCUserInfo.getCity.length > 0 && KLCUserInfo.getAddress.length > 0) ? locationStr : kLocalizationMsg(@"未知");
        UILabel *locationLab = [[UILabel alloc]initWithFrame:CGRectMake(LocationImageBtn.maxX, 0, kScreenWidth-2*textV.frame.origin.x-25, locateBtn.height)];
        locationLab.font = [UIFont systemFontOfSize:13];
        locationLab.numberOfLines = 2;
        locationLab.textColor = kRGB_COLOR(@"#2B2C2C");
        locationLab.text = localNameStr;
        self.locationLabel = locationLab;
        [locateBtn addSubview:self.locationLabel];
        
        pointY = (locateBtn.maxY+10);
    }
    
    APPConfigModel *config = KLCAppConfig.appConfig;
    ///私密
    if (!config.adminLiveConfig.isShortVideoFee) {
        
        UIButton *privateBtn = [[UIButton alloc]initWithFrame:CGRectMake(-5, pointY, 30, 30)];
        privateBtn.selected = NO;
        if (self.privateBtn) {
            privateBtn.selected = self.privateBtn.selected;
        }
        privateBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        [privateBtn setImage:[UIImage imageNamed:@"shortVideo_privateBtn_sel"] forState:UIControlStateSelected];
        [privateBtn setImage:[UIImage imageNamed:@"shortVideo_privateBtn_normal"] forState:UIControlStateNormal];
        [privateBtn addTarget:self action:@selector(privateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.privateBtn = privateBtn;
        [bottomView addSubview:self.privateBtn];
        
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(privateBtn.maxX, 0, 60, 20)];
        leftLabel.textColor = kRGB_COLOR(@"#222222");
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.font = [UIFont systemFontOfSize:13];
        leftLabel.text = self.isVideo?kLocalizationMsg(@"私密视频"):kLocalizationMsg(@"私密图片");
        leftLabel.centerY = privateBtn.centerY;
        [bottomView addSubview:leftLabel];
        
        UITextField *privatePriceTextField = [[UITextField alloc]initWithFrame:CGRectMake(leftLabel.maxX+20, 0, 80, 30)];
        privatePriceTextField.backgroundColor = kRGB_COLOR(@"#EBEBEB");
        privatePriceTextField.font = [UIFont systemFontOfSize:13];
        privatePriceTextField.textAlignment = NSTextAlignmentCenter;
        privatePriceTextField.textColor = kRGB_COLOR(@"#222222");
        privatePriceTextField.keyboardType = UIKeyboardTypeNumberPad;
        privatePriceTextField.centerY = privateBtn.centerY;
        self.privatePriceTextField = privatePriceTextField;
        [bottomView addSubview:self.privatePriceTextField];
        
        UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(privatePriceTextField.maxX+3, 0, 40, 20)];
        rightLabel.textColor = kRGB_COLOR(@"#222222");
        rightLabel.textAlignment = NSTextAlignmentLeft;
        rightLabel.font = [UIFont systemFontOfSize:13];
        rightLabel.text = [KLCAppConfig unitStr];
        rightLabel.centerY = privateBtn.centerY;
        [bottomView addSubview:rightLabel];
        
        pointY = privateBtn.maxY+10;
    }
    
    ///选择分类
    {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, pointY+10, bottomView.width, 20)];
        titleLabel.text = kLocalizationMsg(@"#选择分类#");
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = kRGB_COLOR(@"#444444");
        [bottomView addSubview:titleLabel];
         
        BtnListLayoutView *btnListView = [[BtnListLayoutView alloc] initWithFrame:CGRectMake(0, titleLabel.maxY+15, bottomView.width, 0) delegate:self];
        btnListView.marginWidth = 15;
        btnListView.marginHeight = 12;
        btnListView.itemHeight = 30;
        btnListView.maxSelectedNum = 3;
        [bottomView addSubview:btnListView];
        self.btnListView = btnListView;
        
        pointY = self.btnListView.maxY+10;
    }
    
    /// 关联商品
    if ([ProjConfig isContainShopping]) {///包含直播购物
        CommoditySelectPublishView *selectCommodityV = [[CommoditySelectPublishView alloc] initWithFrame:CGRectMake(0, weakself.btnListView.maxY+10, bottomView.width, 130)];
        [bottomView addSubview:selectCommodityV];
        self.selectCommodityView = selectCommodityV;
        
        pointY = selectCommodityV.maxY+10;
    }
    

    self.bottmView.height = pointY;
    self.bgScrollV.contentSize = CGSizeMake(0, bottomView.maxY+20+kSafeAreaBottom);
}
 
 
- (void)upDateSorts_UI{
    
    self.bottmView.y = self.contentV.maxY+20;
    ///底部视图Y点
    CGFloat maxY = 0;
    ///分类
    NSMutableArray *arr = [NSMutableArray array];
    for (AppHotSortModel *model in self.sortArr) {
        NSString *name = [NSString stringWithFormat:@"#%@#",model.name];
        [arr addObject:name];
    }
     
    kWeakSelf(self);
    [self.btnListView showTagsWithTitles:arr selectIndexArr:self.selecteditemArr callBack:^(NSArray<NSNumber *> * _Nullable itemArr) {
        [weakself.selecteditemArr removeAllObjects];
        [weakself.selecteditemArr addObjectsFromArray:itemArr];
    }];

    if (self.btnListView.height >= 0) {
        
        maxY = self.btnListView.maxY+30;
        
        if (self.selectCommodityView) {
            self.selectCommodityView.y = maxY;
            maxY = self.selectCommodityView.maxY+10;
        }
    }
    
    self.bottmView.height = maxY;
    self.bgScrollV.contentSize = CGSizeMake(0, self.bottmView.maxY+20+kSafeAreaBottom);
}

 
#pragma mark - 显示照片
- (void)createPhotoShow{
    [self.contentV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    BrowserPhotoView *photoV = [[BrowserPhotoView alloc] initWithFrame:CGRectMake(0, 0,self.contentV.frame.size.width ,15)];
    photoV.isAdd = YES;
    photoV.imageArr = self.imgArr;
    kWeakSelf(self);
    photoV.selectPhoto = ^(BOOL isAdd, NSInteger index) {
        [weakself.view endEditing:YES];
        if (isAdd) {
            [weakself showActionSheet];
        }
    };
    photoV.deleteBtnClick = ^(int index) {
        [weakself.imgArr removeObjectAtIndex:index];
        [weakself createPhotoShow];
    };
    [self.contentV addSubview:photoV];

    self.contentV.height = photoV.maxY;
    [self upDateSorts_UI];
}
 
#pragma mark - 按钮 手势
- (void)privateBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (void)locateBtnClick:(UIButton *)btn{
    LocationView *locationV = [[LocationView alloc]init];
    kWeakSelf(self);
    self.navigationController.navigationBarHidden = YES;
    [locationV showInView:self.view callBack:^(BOOL cancel, NSString * _Nonnull city, double lat, double lng, NSString * _Nonnull address) {
        self.navigationController.navigationBarHidden = NO;
        weakself.address = address;
        weakself.city = city;
        weakself.lat = lat;
        weakself.lng = lng;
        NSString *locationStr = [NSString stringWithFormat:@"%@·%@",city.length>0?city:@"",address.length > 0?address:@""];
        NSString *localNameStr = (city.length>0 &&address.length > 0)?locationStr:kLocalizationMsg(@"未知");
        weakself.locationLabel.text = localNameStr;
    }];
}

#pragma mark - 显示视频
- (void)createVideoShow{
    
    [self.contentV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat viewW = (self.contentV.frame.size.width-20)/3.0;
    CGFloat scale = 1.0*kScreenHeight/kScreenWidth;
    VideoPreviewView *playerView = [[VideoPreviewView alloc] initWithFrame:CGRectMake(0, 0, viewW , viewW*scale)];
    playerView.videoUrl = self.videoUrl;
    [playerView play];
    playerView.layer.masksToBounds = YES;
    playerView.layer.cornerRadius = 4;
    self.playerView = playerView;
    [self.contentV addSubview:self.playerView];
    self.contentV.height = self.playerView.maxY;

    [self upDateSorts_UI];
    
}

#pragma mark - ActionSheet

- (void)showActionSheet{
    UIAlertController *sheetC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    kWeakSelf(self);
    [sheetC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"拍摄") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [weakself selectThumbWithType:UIImagePickerControllerSourceTypeCamera];
    }]];
    [sheetC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [weakself selectThumbWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [sheetC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:sheetC animated:YES completion:nil];
    
}

- (void)selectThumbWithType:(UIImagePickerControllerSourceType)type{
    kWeakSelf(self);
    if (type == UIImagePickerControllerSourceTypeCamera) {
        CustomCameraController *camera = [[CustomCameraController alloc] init];
        camera.functionType = CameraFunction_onlyCamera;
        camera.showPhotoAlbum = NO;
        [camera selectPhotoDidComplete:^(CustomCameraController *cameraVC, NSArray<UIImage *> *images) {
            if (images.count) {
                if ([weakself.imgArr isKindOfClass:[NSArray class]]) {
                    NSMutableArray *Marray = [NSMutableArray array];
                    [Marray addObjectsFromArray:weakself.imgArr];
                    weakself.imgArr = Marray;
                }
                [weakself.imgArr addObjectsFromArray:images];
                [weakself createPhotoShow];
            }
            [cameraVC dismissViewControllerAnimated:YES completion:nil];
        }];
        [weakself presentViewController:camera animated:YES completion:nil];
        
    }else{
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9-self.imgArr.count delegate:nil];
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.showSelectedIndex = YES;
        imagePickerVc.allowTakeVideo = NO;
        imagePickerVc.allowTakePicture = NO;
        
        imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
        imagePickerVc.naviTitleColor = [ProjConfig projNavTitleColor];
        imagePickerVc.naviBgColor = [UIColor whiteColor];
        [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
            [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
        }];
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
           // NSLog(@"过滤文字photos%@"),photos);
            if ([weakself.imgArr isKindOfClass:[NSArray class]]) {
                NSMutableArray *Marray = [NSMutableArray array];
                [Marray addObjectsFromArray:weakself.imgArr];
                weakself.imgArr = Marray;
            }
            [weakself.imgArr addObjectsFromArray:photos];
            [weakself createPhotoShow];
        }];
        [weakself presentViewController:imagePickerVc animated:YES completion:nil];
    }
}


#pragma mark - textView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (text.length == 0) {
        return YES;
    }
   // NSLog(@"过滤文字-----%@--%zi---"),text,text.length);
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    self.textNumL.text = [NSString stringWithFormat:@"%zi/%zi",textView.text.length,self.textNum];
    if (textView.text.length>50) {
        textView.text = [textView.text substringToIndex:self.textNum];
    }
}

- (NSString *)stringToimageArr:(NSArray *)imageArr{
    NSString *images = @"";
    for (int i = 0; i < imageArr.count; i++) {
        NSString *imgS = imageArr[i];
        if (i == imageArr.count-1) {
            images = [images stringByAppendingFormat:@"%@",imgS];
        }else{
            images = [images stringByAppendingFormat:@"%@,",imgS];
        }
    }
    return images;
}

#pragma mark - 发布
- (void)commitInfo{
    [self.view endEditing:YES];
    if (!_isVideo && self.imgArr.count == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择至少一张照片")];
        return;
    }
    if (self.privateBtn.selected) {
        if (self.privatePriceTextField.text.length == 0) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入视频价格")];
            return;
        }
    }
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"发布中，请稍后")];
    if (_isVideo) {
        if (self.thumbStr.length > 0) {
            [self uploadVideoWithFile:self.videoUrl.path];
        }else{
            kWeakSelf(self);
            [self uploadpreviewImg:^(BOOL success) {
                [weakself uploadVideoWithFile:self.videoUrl.path];
            }];
        }
    }else{
        [self upDataMoreImage];
    }
}


- (void)commitServerShortVideoURL:(NSString *)videoUrl videoThumb:(NSString *)videoThumb imageArr:(NSString *)imageArr isVideoInfo:(BOOL)isVideoInfo{
   
    NSString *tabStr = @"";
    if (isVideoInfo) {
        
    }else{
        for (NSNumber *num in self.selecteditemArr) {
            AppHotSortModel *mo = self.sortArr[[num intValue]];
            if (tabStr.length == 0) {
                tabStr = [NSString stringWithFormat:@"%lld",mo.id_field];
            }else{
                tabStr = [NSString stringWithFormat:@"%@,%lld",tabStr,mo.id_field];
            }
        }
    }

    NSString *content = self.weakTextV.text;
    NSString *href = videoUrl.length?videoUrl:@"";
    NSString *images = imageArr.length?imageArr:@"";
    int type = _isVideo?1:(images.length>0?2:0);
    int videoTime = [self.videoDuration floatValue];
    NSString *city = self.city.length > 0?self.city:@"";
    double lng = self.lng;
    double lat = self.lat;
    NSString *address = self.address.length > 0?self.address:@"";
    NSString *thumb = videoThumb.length?videoThumb:@"";
    NSString *classifyId = tabStr.length > 0 ?tabStr:@"";
    int64_t productId = 0;
    int width = -1;
    int height = -1;
    double coin = 0;
    int isPrivate= 0;
    
    if (self.selectCommodityView.selectGoods && self.selectCommodityView.goodsModel) {
        productId = self.selectCommodityView.goodsModel.goodsId;
    }

    if (self.previewImg) {
        width = _isVideo?self.previewImg.size.width:-1;
        height = _isVideo?self.previewImg.size.height:-1;
    }

    if (self.privateBtn.selected && [self.privatePriceTextField.text doubleValue] > 0) {
        isPrivate = self.privateBtn.selected;
        coin = [self.privatePriceTextField.text doubleValue];
    }
    
    kWeakSelf(self);
    [HttpApiAppShortVideo setShortVideo:address city:city classifyId:classifyId coin:coin content:content height:height href:href images:images isPrivate:isPrivate lat:lat lng:lng productId:productId thumb:thumb type:type videoTime:videoTime width:width callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            //保存位置
            if (weakself.address.length > 0 && weakself.city.length > 0 && weakself.lat > 0 && weakself.lng > 0) {
                ApiUserInfoModel *userInfoSave  =  KLCUserInfo.getUserInfo;
                userInfoSave.address = weakself.address;
                userInfoSave.city =  weakself.city;
                userInfoSave.lat = weakself.lat;
                userInfoSave.lng = weakself.lng;
                [KLCUserInfo setUserInfo:userInfoSave];
            }
            [SVProgressHUD showInfoWithStatus:strMsg];
            [weakself clearVideo:weakself.videoUrl.path];
            [weakself dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
    
}



#pragma mark - 上传
 
// 视频上传
- (void)uploadVideoWithFile:(NSString*)fileUrlStr{
    kWeakSelf(self);
    [SkyDriveTool uploadFileFromScene:3 filePath:fileUrlStr complete:^(BOOL success, NSString * _Nonnull url) {
         [SVProgressHUD dismiss];
         if (success && url.length) {
            [weakself commitServerShortVideoURL:url videoThumb:self.thumbStr imageArr:@"" isVideoInfo:YES];
         }else{
             [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传失败")];
         }
    } progress:^(CGFloat uploadProgress) {
         [SVProgressHUD showProgress:uploadProgress];
    }];
}

- (void)clearVideo:(NSString *)urlStr{
    if ( [[NSFileManager defaultManager] fileExistsAtPath:urlStr]) {
        BOOL success =  [[NSFileManager defaultManager]removeItemAtPath:urlStr error:nil];
        if (success) {
           // NSLog(@"过滤文字删除成功"));
        }else{
           // NSLog(@"过滤文字删除失败"));
        }
    }
}

//上传预览图
-(void)uploadpreviewImg:(void(^_Nullable)(BOOL success))uploadBlock{
    //上传图片
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:3 image:self.previewImg complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            weakself.thumbStr = imageUrl;
        }
        uploadBlock?uploadBlock(success):nil;
    }];
}


-(void)upDataMoreImage{
    kWeakSelf(self);
    [SkyDriveTool uploadImageArrayFormScene:3 images:self.imgArr complete:^(BOOL success, NSArray<NSString *> * _Nonnull urlArr) {
        if (success) {
            NSString *imgStr = [urlArr componentsJoinedByString:@","];
            if (![imgStr isEmpty]) {
               [weakself commitServerShortVideoURL:@"" videoThumb:@"" imageArr:imgStr isVideoInfo:NO];
            }else{
                [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传失败")];
            }
         }else{
             [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传失败")];
         }
    }];
}


#pragma mark - BtnListLayoutViewDelegate
- (UIButton *)listLayoutView:(BtnListLayoutView *)listView btnForItemAtIndex:(NSInteger)index {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:kRGB_COLOR(@"#999999") forState:UIControlStateNormal];
    [btn setTitleColor:kRGB_COLOR(@"#FFFFFF") forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#EBEBEB")] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#DD85FD")] forState:UIControlStateSelected];
    btn.layer.cornerRadius = 15;
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.clipsToBounds = YES;
    return btn;
}



- (UIView *)showShopSelectView{
    return nil;
}

@end
