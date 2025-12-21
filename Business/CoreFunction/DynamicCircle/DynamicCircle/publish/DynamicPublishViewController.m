//
//  DynamicPublishViewController.m
//  DynamicCircle
//
//  Created by ssssssss on 2020/8/1.
//  Copyright © 2020 klc. All rights reserved.
//

#import "DynamicPublishViewController.h"
#import "TZImagePickerController.h"

#import <LibProjBase/AppRouteName.h>
#import <LibProjBase/BaseNavBarItem.h>

#import <LibProjModel/HttpApiDynamicController.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/AdminLiveConfigModel.h>

#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjModel/HttpApiAppShortVideo.h>
#import <LibProjModel/AppHotSortModel.h>
  
#import <LibProjView/LocationView.h>
#import <LibProjView/VideoPreviewView.h>
#import <LibProjView/BrowserPhotoView.h>
#import <LibProjView/BtnListLayoutView.h>
#import <LibProjView/KLCUserEULAView.h>
#import <LibProjView/CustomCameraController.h>
#import <LibProjView/SkyDriveTool.h>

@interface DynamicPublishViewController ()<UITextViewDelegate,BtnListLayoutViewDelegate>
 

@property (nonatomic, weak)UITextView *weakTextV;
@property (nonatomic, weak)UIView *contentV;
@property (nonatomic, weak)UIScrollView *bgScrollV;

@property (nonatomic, weak)UILabel *textNumL;
@property (nonatomic, assign)NSInteger textNum;
@property (nonatomic,copy)NSString *thumbStr;
@property (nonatomic,copy)NSString *weakTextVStr;
@property (nonatomic, strong)UILabel *locationLabel;
@property (nonatomic, strong)UIView *locationView;

@property (nonatomic, strong)VideoPreviewView *playerView;
 
@property (nonatomic, strong)UIButton *privateBtn;
@property (nonatomic, strong)UITextField *privatePriceTextField;

@property (nonatomic, strong)BtnListLayoutView *btnListView;
@property (nonatomic, strong)UIView *bottmView;
@property (nonatomic, assign)BOOL isVideo;//当前是video还是photo
@property (nonatomic, strong)NSArray *sortArr;//标签list
@property (nonatomic, strong)NSMutableArray *selecteditemArr;//选择的标签

@property (nonatomic,assign)NSUInteger selectedIndex;

@property (nonatomic, weak) UILabel *titleLabel;

//位置
@property (nonatomic, copy)NSString *city;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, assign)double lat;
@property (nonatomic, assign)double lng;
@property (nonatomic, assign)BOOL isShowAddress;  ///是否显示定位


///显示的所有图片数组
@property (nonatomic, strong)NSMutableArray *showImages;

@end

@implementation DynamicPublishViewController

- (void)dealloc
{
   // NSLog(@"过滤文字%s"),__func__);
}

- (NSMutableArray *)selecteditemArr{
    if (!_selecteditemArr) {
        _selecteditemArr = [NSMutableArray array];
    }
    return _selecteditemArr;;
}

- (NSMutableArray *)showImages{
    if (!_showImages) {
        _showImages = [[NSMutableArray alloc] init];
    }
    return _showImages;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /*
    BOOL agree = [[NSUserDefaults standardUserDefaults] boolForKey:@"agreeEULA"];
    if (!agree) {//用户许可协议
        [KLCUserEULAView  showUserEULAView];
    }
     */
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.playerView reset];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.textNum = 50;
    
    [BaseNavBarItem navbar:self bgImage:[UIImage imageWithColor:[UIColor whiteColor]] foregroundColor:nil];
    
    self.navigationItem.title = kLocalizationMsg(@"发布动态");

    self.city = KLCUserInfo.getCity;
    self.address = KLCUserInfo.getAddress;
    self.lat = KLCUserInfo.getLat;
    self.lng = KLCUserInfo.getLng;
     
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
        /*
        BOOL agree = [[NSUserDefaults standardUserDefaults] boolForKey:@"agreeEULA"];
        if (!agree) {//用户许可协议
            [KLCUserEULAView  showUserEULAView];
        }else{
            [weakself commitInfo];
        }
         */
        
    }]];
    
    [self createUI];
    
    _isVideo = (([self.videoDuration floatValue]>0 && self.videoUrl && self.previewImg)?YES:NO);
    if (_isVideo) {
        [self uploadpreviewImg];//上传视频封面
        [self createVideoShow];
    }else{
        [self.showImages addObjectsFromArray:_imgArr];
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
- (void)getTagsData{
    kWeakSelf(self);
    int page = 0;
    int pageSize = kPageSize;
    [HttpApiDynamicController getTopicList:page pageSize:pageSize callback:^(int code, NSString *strMsg, NSArray<AppVideoTopicModel *> *arr) {
        if (code == 1) {
            weakself.sortArr = arr;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself upDateSorts_UI];
            });
        }
    }];
}

#pragma mark - 创建UI -
- (void)createUI{
    UIScrollView *bgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
    [self.view addSubview:bgScroll];
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
    
    if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance]) {
        ///定位
        UIView *locationView = [[UIView alloc]initWithFrame:CGRectMake(textV.frame.origin.x, CGRectGetMaxY(contentView.frame)+5, kScreenWidth-2*textV.frame.origin.x,  40)];
        locationView.backgroundColor = [UIColor clearColor];
        self.locationView = locationView;
        [bgScroll addSubview:self.locationView];
        
        UIImageView *LocationImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
        LocationImageV.image = [UIImage imageNamed:@"userInfo_location"];
        LocationImageV.userInteractionEnabled = YES;
        [locationView addSubview:LocationImageV];
        
        NSString *localNameStr = [self localNameWithCity:KLCUserInfo.getCity address:KLCUserInfo.getAddress];
        UILabel *locationLab = [[UILabel alloc]initWithFrame:CGRectMake(LocationImageV.maxX+3, 0, locationView.width-25-60, 40)];
        locationLab.font = [UIFont systemFontOfSize:12];
        locationLab.numberOfLines = 2;
        locationLab.textColor = kRGB_COLOR(@"#2B2C2C");
        locationLab.text = localNameStr;
        locationLab.centerY = LocationImageV.centerY;
        self.locationLabel = locationLab;
        [locationView addSubview:self.locationLabel];
        
        UIButton *locateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, locationLab.maxX, locationView.height)];
        locateBtn.backgroundColor = [UIColor clearColor];
        [locateBtn addTarget:self action:@selector(locateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [locationView addSubview:locateBtn];
        
        __block UIButton *privateBtn = [[UIButton alloc]initWithFrame:CGRectMake(locationView.width-40, 0, 40, 40)];
        [privateBtn setImage:[UIImage imageNamed:@"shortVideo_privateBtn_sel"] forState:UIControlStateSelected];
        [privateBtn setImage:[UIImage imageNamed:@"shortVideo_privateBtn_normal"] forState:UIControlStateNormal];
        [privateBtn addTarget:self action:@selector(privateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        privateBtn.selected = NO;
        self.isShowAddress = NO;
        [locationView addSubview:privateBtn];
    }
}

- (void)privateBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.isShowAddress = btn.selected;
}


- (NSString *)localNameWithCity:(NSString *)city address:(NSString *)address {
    NSString *locationStr = [NSString stringWithFormat:@"%@·%@", city.length > 0 ? city : @"", address.length > 0 ? address : @""];
    NSString *localNameStr = (city.length > 0 && address.length > 0) ? locationStr : kLocalizationMsg(@"武汉");
    return localNameStr;
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
        NSString *localNameStr = [weakself localNameWithCity:city address:address];
        weakself.locationLabel.text = localNameStr;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)upDateSorts_UI{
    __block CGFloat h = 0;
    [self.bottmView  removeAllSubViews];
    [self.bottmView removeFromSuperview];
    self.bottmView  = nil;
    [self.titleLabel removeFromSuperview];
    self.titleLabel  = nil;
    
    CGFloat y = self.contentV.maxY+15;
    if (self.locationView) {
        y = self.locationView.maxY+15;
    }
    UIView *bottmView = [[UIView alloc]initWithFrame:CGRectMake(0, y,kScreenWidth, h)];
    self.bottmView = bottmView;
    [self.bgScrollV addSubview:self.bottmView];
     
    
    {
        //选择话题
        h += 30;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 20)];
        titleLabel.text = kLocalizationMsg(@"#选择话题#");
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = kRGB_COLOR(@"#444444");
        [bottmView addSubview:titleLabel];
        self.titleLabel = titleLabel;
         
        BtnListLayoutView *btnListView = [[BtnListLayoutView alloc] initWithFrame:CGRectMake(15, titleLabel.maxY+10, kScreenWidth-30, 0) delegate:self];
        btnListView.itemHeight = 30;
        btnListView.marginWidth = 15;
        btnListView.marginHeight = 12;
        btnListView.maxSelectedNum = 1;
        [bottmView addSubview:btnListView];
        self.btnListView = btnListView;
    }

    NSMutableArray *arr = [NSMutableArray array];
    for (AppVideoTopicModel *model in self.sortArr) {
        NSString *name = [NSString stringWithFormat:@"#%@#",model.name];
        [arr addObject:name];
    }
     
    if (arr.count > 0) {
        kWeakSelf(self);
        [self.btnListView showTagsWithTitles:arr selectIndexArr:self.selecteditemArr callBack:nil];
        h += self.btnListView.height+40;
        
        weakself.bottmView.height = h;
        weakself.bgScrollV.contentSize = CGSizeMake(0,CGRectGetMaxY(weakself.contentV.frame)+20+40+h);
    }
     self.bottmView.height = h;
}
#pragma mark - 显示照片 -
- (void)createPhotoShow{
    
    [self.contentV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    BrowserPhotoView *photoV = [[BrowserPhotoView alloc] initWithFrame:CGRectMake(0, 0,self.contentV.frame.size.width ,15)];
    photoV.isAdd = YES;
    photoV.imageArr = self.showImages;
    kWeakSelf(self);
    photoV.selectPhoto = ^(BOOL isAdd, NSInteger index) {
        [weakself.view endEditing:YES];
        if (isAdd) {
            [weakself showActionSheet];
        }
    };
    photoV.deleteBtnClick = ^(int index) {
        [weakself.showImages removeObjectAtIndex:index];
        [weakself createPhotoShow];
    };
    [self.contentV addSubview:photoV];
    
    [self setContentFrame:photoV];
    [self upDateSorts_UI];
    
}

#pragma mark - 显示视频 -
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
    [self setContentFrame:self.playerView];
    
}
///设置图片背景尺寸
- (void)setContentFrame:(UIView *)lastView{
    CGRect rc = self.contentV.frame;
    rc.size.height = CGRectGetMaxY(lastView.frame);
    self.contentV.frame = rc;
    self.locationView.y = self.contentV.maxY+5;
    self.bgScrollV.contentSize = CGSizeMake(0, CGRectGetMaxY(self.contentV.frame)+20);
}

#pragma mark - ActionSheet -
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
    if (type == UIImagePickerControllerSourceTypeCamera) {
        
        CustomCameraController *camera = [[CustomCameraController alloc] init];
        camera.functionType = CameraFunction_onlyCamera;
        [camera selectPhotoDidComplete:^(CustomCameraController *cameraVC, NSArray<UIImage *> *images) {
            if (images.count > 0) {
                [self.showImages addObjectsFromArray:images];
                [self createPhotoShow];
            }
            [cameraVC dismissViewControllerAnimated:YES completion:nil];
        }];
        [self presentViewController:camera animated:YES completion:nil];
        
    }else{
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9-self.showImages.count delegate:nil];
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
            if (photos.count > 0) {
                [self.showImages addObjectsFromArray:photos];
            }
            [self createPhotoShow];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

#pragma mark - textView delegate -
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

#pragma mark - 发布 -
- (void)commitInfo{
    [self.view endEditing:YES];
    if (!_isVideo && self.showImages.count == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择至少一张照片")];
        return;
    }
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"发布中，请稍后")];
    self.weakTextVStr = self.weakTextV.text;
    if (_isVideo) {
        [self uploadVideoWithFile:self.videoUrl.path];
    }else{
        [self upDataMoreImage];
    }
}

- (void)commitServerDynamicVideoURL:(NSString *)videoUrl videoThumb:(NSString *)thumb images:(NSString *)images{
      
    DynamicController_publishDynamic *dynamic = [[DynamicController_publishDynamic alloc] init];
    dynamic.title = self.weakTextVStr;
    dynamic.href = videoUrl.length?videoUrl:@"";
    dynamic.images = images.length?images:@"";
    /** 类型（0只有文字1视频动态2图片动态） */
    dynamic.type = _isVideo?1:(images.length>0?2:0);
    dynamic.videoTime = [NSString stringWithFormat:@"%0.0f",[self.videoDuration floatValue]];
    dynamic.city = self.city.length > 0?self.city:@"";
    dynamic.lng = self.lng;
    dynamic.lat = self.lat;
    dynamic.address = self.address.length > 0?self.address:@"";
    dynamic.musicId = 0;
    dynamic.thumb = thumb.length?thumb:@"";
    dynamic.coin = 0;
    dynamic.hidePublishingAddress = self.isShowAddress?0:1;
    if (self.previewImg) {
        dynamic.width = _isVideo?self.previewImg.size.width:-1;
        dynamic.height = _isVideo?self.previewImg.size.height:-1;
    }else{
        dynamic.width = -1;
        dynamic.height = -1;
    }
    if (self.selecteditemArr.count>0) {
        AppVideoTopicModel *model = _sortArr[[self.selecteditemArr.firstObject intValue]];
        if (model) {
            dynamic.topicId = model.id_field;
        }
    }
    {
        ///没用上的参数
        dynamic.channelId = 0;
        dynamic.content = @"";
        dynamic.isPrivate = 0;
        dynamic.sourceFrom = 0;
    }
    kWeakSelf(self);
    [HttpApiDynamicController publishDynamic:dynamic callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            //保存位置
            if (weakself.address.length > 0 && weakself.city.length > 0 && weakself.lat > 0 && weakself.lng > 0) {
                ApiUserInfoModel *userInfoSave  = KLCUserInfo.getUserInfo;
                userInfoSave.address = weakself.address;
                userInfoSave.city =  weakself.city;
                userInfoSave.lat = weakself.lat;
                userInfoSave.lng = weakself.lng;
                [KLCUserInfo setUserInfo:userInfoSave];
            }
            [SVProgressHUD showSuccessWithStatus:strMsg];
            [weakself dismiss];
        }else if (code == 3){
            [SVProgressHUD showInfoWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


#pragma mark - 视频上传
- (void)uploadVideoWithFile:(NSString*)fileUrlStr{
    kWeakSelf(self);
    [SkyDriveTool uploadFileFromScene:2 filePath:fileUrlStr complete:^(BOOL success, NSString * _Nonnull url) {
         [SVProgressHUD dismiss];
         if (success && url.length) {
            [weakself commitServerDynamicVideoURL:url videoThumb:self.thumbStr images:@""];
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
-(void)uploadpreviewImg{
    //上传图片
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:2 image:self.previewImg complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            weakself.thumbStr = imageUrl;
        }else{
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"上传失败")];
        }
    }];
}


-(void)upDataMoreImage{
    kWeakSelf(self);
    [SkyDriveTool uploadImageArrayFormScene:2 images:self.showImages complete:^(BOOL success, NSArray<NSString *> * _Nonnull urlArr) {
        if (success) {
            NSString *imgStr = [urlArr componentsJoinedByString:@","];
            if (![imgStr isEmpty]) {
                [weakself commitServerDynamicVideoURL:@"" videoThumb:@"" images:imgStr];
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
    [btn setBackgroundImage:[UIImage imageWithColor:[ProjConfig normalColors]] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    return btn;
}

- (void)list:(BtnListLayoutView *)listView selecteIndex:(NSUInteger)index isSlected:(BOOL)isSelected {
    
    _selectedIndex = index;
    [self.selecteditemArr removeAllObjects];
    if (isSelected) [self.selecteditemArr addObject:@(index)];

}

@end
