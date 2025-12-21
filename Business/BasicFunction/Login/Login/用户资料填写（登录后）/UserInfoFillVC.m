//
//  UserInfoFillVC.m
//  Login
//
//  Created by klc on 2020/4/24.
//

#import "UserInfoFillVC.h"

#import "BRPickerView.h"

#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>
#import <TZImagePickerController/TZImagePickerController.h>

#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/TXMapManager.h>

#import <LibProjBase/ProjectCache.h>

#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/APPConfigModel.h>
#import <LibProjModel/HttpApiUserController.h>
#import <LibProjModel/HttpApiAppThree.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjModel/UserController_userUpdate.h>
#import <LibProjModel/AdminLoginSwitchModel.h>

#import <LibProjView/SkyDriveTool.h>
#import <LibProjView/CustomCameraController.h>

@interface UserInfoFillVC ()<UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIButton *userAvaterBtn;
@property (strong, nonatomic) UIImageView *cameraImageV;
@property (strong, nonatomic) UIImageView *rightImageV;
@property (strong, nonatomic) UITextField *userNameTextField;
@property (strong, nonatomic) UITextField *birthTextField;
@property (assign, nonatomic) NSInteger selectedGender;
@property (strong, nonatomic) UIButton *girlGenderBtn;
@property (strong, nonatomic) UIButton *boyGenderBtn;
@property (strong, nonatomic) UIButton *nextBtn;

@property (copy, nonatomic) NSString *avterImage;
@property (copy, nonatomic) NSString *constellation;
@property (strong, nonatomic) UIViewController *superVc;

@property (nonatomic, weak) UITextField *signatureTextField;

@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double lng;
@property (copy, nonatomic) NSString *city;
@property (nonatomic, copy) NSString *address;

@end

@implementation UserInfoFillVC


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI:self.view];
}

- (void)createUI:(UIView *)superVv{
    
    UIScrollView *bgScrollV = [[UIScrollView alloc] initWithFrame:superVv.bounds];
    [superVv addSubview:bgScrollV];
    
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesture)];
    tap.delegate = self;
    [bgScrollV addGestureRecognizer:tap];
    
    
    UILabel *bigTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, superVv.width, 30)];
    bigTitleL.textAlignment = NSTextAlignmentCenter;
    bigTitleL.text = kLocalizationMsg(@"设置你的形象");
    bigTitleL.font = [UIFont boldSystemFontOfSize:25];
    bigTitleL.textColor = kRGB_COLOR(@"#333333");
    [bgScrollV addSubview:bigTitleL];
    
    UILabel *smallTitleL = [[UILabel alloc]initWithFrame:CGRectMake(0, bigTitleL.maxY, superVv.width, 30)];
    smallTitleL.textAlignment = NSTextAlignmentCenter;
    smallTitleL.text = kLocalizationMsg(@"让大家更好的认识你");
    smallTitleL.font = [UIFont systemFontOfSize:13];
    smallTitleL.textColor = kRGB_COLOR(@"#666666");
    [bgScrollV addSubview:smallTitleL];
    
    
    ApiUserInfoModel *model = KLCUserInfo.getUserInfo;
    //头像
    UIButton *avterBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, smallTitleL.maxY+40, 100, 100)];
    avterBtn.centerX = smallTitleL.centerX;
    avterBtn.layer.cornerRadius = 50;
    avterBtn.clipsToBounds = YES;
    avterBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [avterBtn sd_setImageWithURL:[NSURL URLWithString:model.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"login_userFill_avater"]];
    [avterBtn addTarget:self action:@selector(avterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.userAvaterBtn = avterBtn;
    [bgScrollV addSubview:self.userAvaterBtn];
    
    
    [KLCUserInfo setUserInfo:model];
    self.avterImage = model.avatar;
    [self.userAvaterBtn  sd_setImageWithURL:[NSURL URLWithString:self.avterImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"login_userFill_avater"]];
    self.cameraImageV.hidden = YES;
    [self nextBtnBackgroudChange];
    
    UIImageView *cameraImageV = [[UIImageView alloc]initWithFrame:CGRectMake(avterBtn.x+60, avterBtn.y+60, 40, 40)];
    cameraImageV.image = [UIImage imageNamed:@"login_userFill_camera"];
    self.cameraImageV = cameraImageV;
    cameraImageV.hidden = model.avatar.length;
    [bgScrollV addSubview:cameraImageV];
    
    //昵称
    CGFloat width = 265*kScreenWidth/360.0;
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0, avterBtn.maxY+40, width, 50)];
    nameView.layer.cornerRadius = 25;
    nameView.centerX = bgScrollV.centerX;
    nameView.clipsToBounds = YES;
    nameView.backgroundColor = kRGB_COLOR(@"#F5F5F5");
    [bgScrollV addSubview:nameView];
    
    UITextField *nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 15, width-40, 20)];
    nameTextField.textColor = kRGB_COLOR(@"#333333");
    nameTextField.placeholder = kLocalizationMsg(@"请输入您的昵称");
    nameTextField.textAlignment = NSTextAlignmentLeft;
    nameTextField.delegate = self;
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField.font = [UIFont systemFontOfSize:14];
    nameTextField.text = model.username;
    self.userNameTextField = nameTextField;
    [nameView addSubview:self.userNameTextField];
    
    
    
    //出生日期
    UIView *birthView = [[UIView alloc]initWithFrame:CGRectMake(0, nameView.maxY+20,width, 50)];
    birthView.layer.cornerRadius = 25;
    birthView.clipsToBounds = YES;
    birthView.centerX = bgScrollV.centerX;
    birthView.backgroundColor = kRGB_COLOR(@"#F5F5F5");
    [bgScrollV addSubview:birthView];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageV.image = [UIImage imageNamed:@"login_userFill_down"];
    self.rightImageV = imageV;
    UITextField *birthTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 15,width-40, 20)];
    birthTextField.userInteractionEnabled = YES;
    birthTextField.enabled = NO;
    birthTextField.textAlignment = NSTextAlignmentLeft;
    birthTextField.rightView = self.rightImageV;
    birthTextField.rightViewMode = UITextFieldViewModeAlways;
    birthTextField.textColor =kRGB_COLOR(@"#333333");
    birthTextField.placeholder = kLocalizationMsg(@"选择出生日期");
    birthTextField.font = [UIFont systemFontOfSize:14];
    birthTextField.userInteractionEnabled = YES;
    birthTextField.text = model.birthday;
    birthTextField.backgroundColor = [UIColor clearColor];
    self.birthTextField = birthTextField;
    [birthView addSubview:self.birthTextField];
    self.constellation = model.constellation;
    
    UIButton *birthTap = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,width, 50)];
    birthTap.backgroundColor = [UIColor clearColor];
    birthTap.centerX = bgScrollV.centerX;
    [birthTap addTarget:self action:@selector(birthTap) forControlEvents:UIControlEventTouchUpInside];
    [birthView addSubview:birthTap];
    
    
    //性别
    UIView *genderView = [[UIView alloc]initWithFrame:CGRectMake(0, birthView.maxY+20, width, 50)];
    genderView.backgroundColor = [UIColor whiteColor];
    genderView.centerX = bgScrollV.centerX;
    [bgScrollV addSubview:genderView];
    CGFloat genderW = ( width-15)/2.0;
    for (int i = 0; i < 2; i++) {
        UIButton *genderBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*(genderW+15), 0,genderW, 50)];
        genderBtn.layer.cornerRadius = 25;
        genderBtn.clipsToBounds = YES;
        [genderBtn setBackgroundImage:[UIImage imageWithColor:kRGB_COLOR(@"#F5F5F5")] forState:UIControlStateNormal];
        UIColor *selectedColor ;
        if (i == 1) {
            selectedColor = kRGB_COLOR(@"#FFF1F8");
        }else{
            selectedColor = kRGB_COLOR(@"#DBF4FF");
        }
        [genderBtn setBackgroundImage:[UIImage imageWithColor:selectedColor] forState:UIControlStateSelected];
        [genderBtn addTarget:self action:@selector(genderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString *imageName ;
        if (i == 1) {
            imageName = @"login_userFill_girl";
        }else{
            imageName = @"login_userFill_boy";
        }
        genderBtn.tag = i;
        [genderBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        genderBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [genderBtn setTitle:i == 1 ?kLocalizationMsg(@"女生     "):kLocalizationMsg(@"男生     ") forState:UIControlStateNormal];
        genderBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 8, 0, genderW-58);
        genderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [genderBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
        if (i == 1) {
            [genderBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateSelected];
            self.girlGenderBtn = genderBtn;
        }else{
            [genderBtn setTitleColor:kRGB_COLOR(@"#4BC9FF") forState:UIControlStateSelected];
            self.boyGenderBtn = genderBtn;
        }
        [genderView addSubview: genderBtn];
    }
    
    self.boyGenderBtn.selected = NO;
    self.girlGenderBtn.selected = NO;
    self.selectedGender = 0;

    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(20, genderView.maxY+30, kScreenWidth-40, 20)];
    tipL.textColor = kRGB_COLOR(@"#999999");
    tipL.text = kLocalizationMsg(@"性别确认后不能修改哦～");
    tipL.font = [UIFont systemFontOfSize:12];
    tipL.textAlignment = NSTextAlignmentCenter;
    [bgScrollV addSubview:tipL];
    
    //下一步
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, genderView.maxY + 80, width, 40)];
    nextBtn.layer.cornerRadius = 20;
    nextBtn.clipsToBounds = YES;
    [nextBtn setTitle:kLocalizationMsg(@"下一步") forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    [bgScrollV addSubview:nextBtn];
    self.nextBtn = nextBtn;
    [self nextBtnBackgroudChange];
    
    bgScrollV.contentSize = CGSizeMake(0, nextBtn.maxY+50);
    
    kWeakSelf(self);
    [[TXMapManager shareInstance] startSingleLocation:^(BOOL success, LocationInfoModel * _Nonnull infoModel) {
        NSString *cityStr = infoModel.city;
        if ([cityStr hasSuffix:kLocalizationMsg(@"市")]) {
            cityStr =[cityStr substringToIndex:cityStr.length-1];
        }
        weakself.city = cityStr;
        weakself.lat = infoModel.coordinate.latitude;
        weakself.lng = infoModel.coordinate.longitude;
        weakself.address = infoModel.name;
       // NSLog(@"过滤文字初次定位 *************== *****************%@"),cityStr);
    }];
}


- (void)tapgesture{
    [self.view endEditing:YES];
}

- (void)genderBtnClick:(UIButton *)btn{
    if (btn.tag == 1) {
        self.selectedGender = 2;
        self.girlGenderBtn.selected = YES;
        self.boyGenderBtn.selected = NO;
    }else{
        self.selectedGender = 1;
        self.girlGenderBtn.selected = NO;
        self.boyGenderBtn.selected = YES;
    }
    [self nextBtnBackgroudChange];
}

- (void)nextBtnClick:(UIButton *)btn{
    if (self.avterImage.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择头像")];
        return;
    }
    if (self.userNameTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写一个昵称")];
        return;
    }
    
    if (self.birthTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择出生日期")];
        return;
    }
    
    if (self.selectedGender == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择性别")];
        return;
    }
    if (self.signatureTextField.text.length > 20) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"签名不能超过20个字")];
        return;
    }
    
    [self updateUserInfo];
}



- (void)updateUserInfo{
    [SVProgressHUD show];
    UserController_userUpdate *update = [[UserController_userUpdate alloc] init];
    update.signature = self.signatureTextField.text.length>0?self.signatureTextField.text:@"";
    update.birthday = self.birthTextField.text;
    update.constellation = self.constellation;
    update.username = self.userNameTextField.text;
    update.sex = (int)self.selectedGender;
    kWeakSelf(self);
    [KLCUserInfo setServiceUserInfo:update complete:^(BOOL success, NSString * _Nonnull msg) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:msg];
            [RouteManager routeForName:RN_login_userInterestLabel currentC:weakself];
        }else{
            [SVProgressHUD showInfoWithStatus:msg];
        }
    }];
}


- (void)avterBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *picAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself selectThumbWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"拍照") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself selectThumbWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    [alertContro addAction:photoAction];
    [alertContro addAction:picAction];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertContro addAction:cancleAction];
    [self presentViewController:alertContro animated:NO completion:nil];
}


- (void)birthTap{
    [self.view endEditing:YES];
    NSDate *date = [NSDate date];
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"yyyy-MM-dd HH"];
    //当前时间
    //100年前
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:-100];
    [adcomps setDay:0];
    NSDate *minDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    kWeakSelf(self);

    NSDate *selectDate = [forMatter dateFromString:KLCUserInfo.getUserInfo.birthday];
    if (KLCUserInfo.getUserInfo.birthday.length == 0) {
        selectDate = [NSDate date];
    }
    
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    datePickerView.pickerMode = BRDatePickerModeYMD;
    datePickerView.title = kLocalizationMsg(@"出生日期");
    datePickerView.selectDate = selectDate;
    datePickerView.minDate = minDate;
    datePickerView.maxDate = [NSDate date];
    datePickerView.isAutoSelect = NO;
    datePickerView.showToday = YES;
    datePickerView.showWeek = NO;
    
    BRPickerStyle *style = [[BRPickerStyle alloc]init];
    style.pickerTextColor = kRGB_COLOR(@"#666666");
    style.selectRowTextColor = [ProjConfig normalColors];
    datePickerView.pickerStyle = style;
    
    //datePickerView.showUnitType = BRShowUnitTypeNone;
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
            [forMatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *selecteDate = [forMatter dateFromString:selectValue];
            NSComparisonResult result1 = [date compare:selecteDate];
            NSComparisonResult result2 = [minDate compare:selecteDate];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (result1 == -1) {
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"日期不能超过当前时间")];
                }else if (result2 == 1) {
                    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"日期选择不当")];
                }else{
                    weakself.birthTextField.text = selectValue;
                    NSArray *dataArr = [selectValue componentsSeparatedByString:@"-"];
                    int mounth = [dataArr[1] intValue];
                    int day = [dataArr[2] intValue];
                    NSString *constellation = [self getAstroWithMonth:mounth day:day];
                    weakself.constellation = constellation;
                    [weakself nextBtnBackgroudChange];
                }
            });
        });
        
    };
    [datePickerView show];
}


//获取星座
- (NSString *)getAstroWithMonth:(int)m day:(int)d{
    NSString *astroString = kLocalizationMsg(@"摩羯座水瓶座双鱼座白羊座金牛座双子座巨蟹座狮子座处女座天秤座天蝎座射手座摩羯座");
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){
        return kLocalizationMsg(@"错误日期格式!");
    }
    if(m==2 && d>29){
        return kLocalizationMsg(@"错误日期格式!!");
    }else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return kLocalizationMsg(@"错误日期格式!!!");
        }
    }
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*3-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*3,3)]];
    return result;
}
#pragma mark- nameTextField

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self nextBtnBackgroudChange];
    return ((textField.text.length + string.length) < 15);
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self nextBtnBackgroudChange];
}
#pragma  mark - 选择
- (void)selectThumbWithType:(UIImagePickerControllerSourceType)type{
    
    kWeakSelf(self);
    if (type == UIImagePickerControllerSourceTypeCamera) {
        
        CustomCameraController *camera = [[CustomCameraController alloc] init] ;
        camera.showPhotoAlbum = NO;
        camera.functionType = CameraFunction_onlyCamera;
        [camera selectPhotoDidComplete:^(CustomCameraController *cameraVC, NSArray<UIImage *> *images) {
            [cameraVC dismissViewControllerAnimated:NO completion:nil];
            [weakself uploadImage:images.firstObject];
        }];
        [self presentViewController:camera animated:YES completion:nil];
    
    }else{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.maxImagesCount = 1;
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.showSelectedIndex = YES;
        imagePickerVc.allowTakeVideo = NO;
        imagePickerVc.allowTakePicture = NO;
        imagePickerVc.showSelectBtn = NO;
        imagePickerVc.allowCrop = YES;
        imagePickerVc.cropRect = CGRectMake(10, (kScreenHeight- kScreenWidth-20)/2.0, kScreenWidth-20, kScreenWidth-20);
        
        imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
        imagePickerVc.naviTitleColor = [ProjConfig projNavTitleColor];
        imagePickerVc.naviBgColor = [UIColor whiteColor];
        [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
            [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
        }];
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            UIImage* image = photos.firstObject;
            [weakself uploadImage:image];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
    
}

#pragma mark - 图片上传
- (void)uploadImage:(UIImage *)image{
    kWeakSelf(self);
    __block UIImage *uploadImage = [UIImage imageWithData:[image compressWithMaxLength:1024*100]];
    [SkyDriveTool uploadImageFormScene:1 image:uploadImage complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            [weakself lastUpdateUserAvater:imageUrl];
        }else{
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"上传失败")];
        }
    }];
}



- (void)lastUpdateUserAvater:(NSString *)imageUrl{
    kWeakSelf(self);
    [HttpApiUserController updateUserDataReview:[KLCUserInfo userAvatarId] dataType:1 reviewContent:imageUrl callback:^(int code, NSString *strMsg, AppUserDataImgModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"上传成功")];
            
            ApiUserInfoModel *model = KLCUserInfo.getUserInfo;
            model.avatar = imageUrl;
            [KLCUserInfo setUserInfo:model];
            
            weakself.avterImage = imageUrl;
            [weakself.userAvaterBtn  sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"login_userFill_avater"]];
            weakself.cameraImageV.hidden = YES;
            [weakself nextBtnBackgroudChange];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}



- (void)nextBtnBackgroudChange{
    
    BOOL canNext = YES;
    if (self.selectedGender == 0) {
        canNext = NO;
    }
    if (self.avterImage.length == 0) {
        canNext = NO;
    }
    if (self.userNameTextField.text.length == 0) {
        canNext = NO;
    }
    if (self.birthTextField.text.length == 0) {
        canNext = NO;
    }
    
    self.nextBtn.selected = canNext;
    if (canNext) {
        if (self.selectedGender == 1) {//男
            [self.nextBtn setBackgroundImage:[UIImage createImageSize:self.nextBtn.bounds.size gradientColors:@[kRGB_COLOR(@"4BC9FF"),kRGB_COLOR(@"00FFF4")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateSelected];
        }else{
            [self.nextBtn setBackgroundImage:[UIImage createImageSize:self.nextBtn.bounds.size gradientColors:@[kRGB_COLOR(@"#FF54A0"), kRGB_COLOR(@"#FF6CF6")] percentage:@[@0.3,@1.0] gradientType:GradientFromTopToBottom] forState:UIControlStateSelected];
        }
    }
    
}


@end

