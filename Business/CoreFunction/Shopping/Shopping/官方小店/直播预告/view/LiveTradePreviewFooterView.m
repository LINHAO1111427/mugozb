//
//  LiveTradePreviewFooterView.m
//  Shopping
//
//  Created by yww on 2020/8/10.
//  Copyright © 2020 klc. All rights reserved.
//

#import "LiveTradePreviewFooterView.h"
#import "BRPickerView.h"
#import <LibProjView/SkyDriveTool.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjModel/HttpApiShopBusiness.h>

 
@interface LiveTradePreviewFooterView()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong)UITextField *previewTitleTF;
@property (nonatomic, strong)UITextField *previewTimeTxF;
@property (nonatomic, strong)NSDate *selectedDate;
@property (nonatomic, assign)BOOL isUploading;
@property (nonatomic, strong)UIButton *posterBtn;
@property (nonatomic, copy)NSString *posterImage;
@end
@implementation LiveTradePreviewFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    UIView *headLine =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headLine.backgroundColor = kRGB_COLOR(@"#F5F5F5");
    [self addSubview:headLine];
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(12, headLine.maxY+5, kScreenWidth-24, 20)];
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.text = kLocalizationMsg(@"添加直播预告");
    titleL.textColor = kRGB_COLOR(@"#333333");
    [self addSubview:titleL];
    
    // 预告标题
    UILabel *previewTitleL = [[UILabel alloc]initWithFrame:CGRectMake(12, titleL.maxY+5+15, 60, 20)];
    previewTitleL.textColor = kRGB_COLOR(@"#555555");
    previewTitleL.font = [UIFont systemFontOfSize:14];
    previewTitleL.textAlignment = NSTextAlignmentLeft;
    previewTitleL.text = kLocalizationMsg(@"预告标题");
    [self addSubview:previewTitleL];
    UITextField *previewTitleTF = [[UITextField alloc]initWithFrame:CGRectMake(previewTitleL.maxX+20, 0, kScreenWidth-24-80, 20)];
    previewTitleTF.textColor = kRGB_COLOR(@"#333333");
    previewTitleTF.font = [UIFont systemFontOfSize:13];
    previewTitleTF.placeholder = kLocalizationMsg(@"请输入标题（最多支持8个字）");
    previewTitleTF.centerY = previewTitleL.centerY;
    previewTitleTF.delegate = self;
    previewTitleTF.textAlignment = NSTextAlignmentLeft;
    self.previewTitleTF = previewTitleTF;
    [self addSubview:self.previewTitleTF];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(12, _previewTitleTF.maxY+9, kScreenWidth-24, 0.5)];
    line1.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self addSubview:line1];
    
    //预告开始时间
    UILabel *previewTimeTitleL = [[UILabel alloc]initWithFrame:CGRectMake(12, line1.maxY+15, 60, 20)];
    previewTimeTitleL.textColor = kRGB_COLOR(@"#555555");
    previewTimeTitleL.font = [UIFont systemFontOfSize:14];
    previewTimeTitleL.textAlignment = NSTextAlignmentLeft;
    previewTimeTitleL.text = kLocalizationMsg(@"开始时间");
    [self addSubview:previewTimeTitleL];
    UITextField *previewTimeTxF = [[UITextField alloc]initWithFrame:CGRectMake(previewTimeTitleL.maxX+20, 0, kScreenWidth-24-80, 20)];
    previewTimeTxF.textColor = kRGB_COLOR(@"#333333");
    previewTimeTxF.font = [UIFont systemFontOfSize:13];
    previewTimeTxF.enabled = NO;
    previewTimeTxF.placeholder = kLocalizationMsg(@"请选择开始时间");
    UIView *rightV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 12)];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:rightV.bounds];
    imageV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
    [rightV addSubview:imageV];
    previewTimeTxF.rightView = rightV;
    previewTimeTxF.rightViewMode = UITextFieldViewModeAlways;
    previewTimeTxF.textAlignment = NSTextAlignmentLeft;
    previewTimeTxF.centerY = previewTimeTitleL.centerY;
    self.previewTimeTxF = previewTimeTxF;
    [self addSubview:self.previewTimeTxF];
    UIButton *pickeBtn = [[UIButton alloc]initWithFrame:CGRectMake(previewTimeTitleL.maxX+20, 0, kScreenWidth-24-80, 50)];
    pickeBtn.centerY = previewTimeTitleL.centerY;
    pickeBtn.backgroundColor = [UIColor clearColor];
    [pickeBtn addTarget:self action:@selector(pickeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pickeBtn];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(12, line1.maxY+50, kScreenWidth-24, 0.5)];
    line2.backgroundColor = kRGB_COLOR(@"#DEDEDE");
    [self addSubview:line2];
    
    //预告海报
    UILabel *previewPosterTitleL = [[UILabel alloc]initWithFrame:CGRectMake(12, line2.maxY+5+15, 60, 20)];
    previewPosterTitleL.textColor = kRGB_COLOR(@"#555555");
    previewPosterTitleL.font = [UIFont systemFontOfSize:14];
    previewPosterTitleL.textAlignment = NSTextAlignmentLeft;
    previewPosterTitleL.text = kLocalizationMsg(@"预告海报");
    [self addSubview:previewPosterTitleL];
    UIButton *posterBtn = [[UIButton alloc]initWithFrame:CGRectMake(previewPosterTitleL.maxX + 20, line2.maxY+5+15, 100, 100)];
    [posterBtn setImage:[UIImage imageNamed:@"shop_preview_update"] forState:UIControlStateNormal];
    [posterBtn addTarget:self action:@selector(posterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.posterBtn = posterBtn;
    [self addSubview:self.posterBtn];
    
    //添加直播预告
    UIButton *addPreviewBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-280)/2.0, posterBtn.maxY+40, 280, 40)];
    addPreviewBtn.backgroundColor = kRGB_COLOR(@"#FF5500");
    [addPreviewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addPreviewBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addPreviewBtn setTitle:kLocalizationMsg(@"添加直播预告") forState:UIControlStateNormal];
    addPreviewBtn.layer.cornerRadius = 20;
    addPreviewBtn.clipsToBounds = YES;
    [addPreviewBtn addTarget:self action:@selector(addPreviewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addPreviewBtn];
}

- (void)addPreviewBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    if (self.previewTitleTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请填写预告标题")];
        return;
    }
    if (!self.selectedDate || self.previewTimeTxF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择开始时间")];
        return;
    }
    if (!self.posterImage) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请上传预告海报")];
        return;
    }
    NSString *startTimeSp = [NSString stringWithFormat:@"%.0lf", [self.selectedDate timeIntervalSince1970]*1000];
    [HttpApiShopBusiness saveLiveAnnouncement:self.previewTimeTxF.text posterStickers:self.posterImage shopCategory:@"" startTime:startTimeSp title:self.previewTitleTF.text callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(LiveTradePreviewFooterViewAddPreviewBtnClick:)]) {
                [weakself.delegate LiveTradePreviewFooterViewAddPreviewBtnClick:self];
            }
            weakself.previewTitleTF.text = @"";
            weakself.previewTimeTxF.text = @"";
            weakself.selectedDate = nil;
            weakself.posterImage = nil;
            [weakself.posterBtn setImage:[UIImage imageNamed:@"shop_preview_update"] forState:UIControlStateNormal];
            [SVProgressHUD showSuccessWithStatus:strMsg];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
- (void)posterBtnClick:(UIButton *)btn{
    [self showActionSheet];
}
#pragma mark - 图片上传
- (void)showActionSheet{
    kWeakSelf(self);
    UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *picAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself selectThumbWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alertContro addAction:picAction];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"拍照") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself selectThumbWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    [alertContro addAction:photoAction];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertContro addAction:cancleAction];
    
    [self.superVc presentViewController:alertContro animated:YES completion:nil];
}

- (void)selectThumbWithType:(UIImagePickerControllerSourceType)type{
    if (type == UIImagePickerControllerSourceTypeCamera) {
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = type;
        imagePickerController.allowsEditing = NO;
        imagePickerController.showsCameraControls = YES;
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.superVc presentViewController:imagePickerController animated:YES completion:nil];
    }else{
        kWeakSelf(self);
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
        [self.superVc presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

//选择图片完成
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.isUploading = YES;
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"修改中")];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]){
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//原图传送 UIImagePickerControllerOriginalImage（裁剪）
        [self uploadImage:image];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([UIDevice currentDevice].systemVersion.floatValue < 11) {
        return;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")]) {
        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.frame.size.width < 42) {
                [viewController.view sendSubviewToBack:obj];
                *stop = YES;
            }
        }];
    }
}
 
- (void)uploadImage:(UIImage *)image{
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:5 image:image complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        weakself.isUploading = NO;
        if (success) {
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"上传成功")];
            weakself.posterImage = imageUrl;
            [weakself.posterBtn sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"shop_preview_update"]];
        }else{
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"上传失败")];
        }
    }];
}

#pragma mark - 时间选择
- (void)pickeBtnClick:(UIButton *)btn{
    [self endEditing:YES];
    if (!self.selectedDate) {
        self.selectedDate = [NSDate date];
    }
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    datePickerView.pickerMode = BRDatePickerModeMDHM;
    datePickerView.title = kLocalizationMsg(@"开始时间");
//    datePickerView.selectDate = self.selectedDate;
    datePickerView.minDate = [NSDate date];
    datePickerView.maxDate = [[NSDate date] br_getNewDateToDays:12];
    datePickerView.isAutoSelect = NO;
    datePickerView.showToday = YES;
    datePickerView.showWeek = YES;
    
    BRPickerStyle *style = [[BRPickerStyle alloc]init];
    style.pickerTextColor = kRGB_COLOR(@"#999999");
    style.selectRowTextColor = kRGB_COLOR(@"#FF4915");
    datePickerView.pickerStyle = style;
    
    //       datePickerView.showUnitType = BRShowUnitTypeNone;
    kWeakSelf(self);
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakself.selectedDate = selectDate;
            NSString *time = [weakself getShowTime];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakself.previewTimeTxF.text = time;
            });
        });
    };
    [datePickerView show];
}


- (NSString *)getShowTime{

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];//月
    NSInteger selectedMonth=[[formatter stringFromDate:self.selectedDate]integerValue];
    NSString *monthStr = [NSString stringWithFormat:@"%ld",(long)selectedMonth];
    
    [formatter setDateFormat:@"dd"];//日
    NSInteger selectedDay=[[formatter stringFromDate:self.selectedDate] integerValue];
    NSString *dayStr = [NSString stringWithFormat:@"%ld",(long)selectedDay];
    
    [formatter setDateFormat:@"HH"];//时
    NSInteger selectedHour=[[formatter stringFromDate:self.selectedDate] integerValue];
    NSString *hourStr;
    if (selectedHour >= 10) {
        hourStr = [NSString stringWithFormat:@"%ld",(long)selectedHour];
    }else{
        hourStr = [NSString stringWithFormat:@"0%ld",(long)selectedHour];
    }
    
    [formatter setDateFormat:@"mm"];//分钟
    NSInteger selectedMniute=[[formatter stringFromDate:self.selectedDate] integerValue];
    NSString *minuteStr;
    if (selectedMniute >= 10) {
        minuteStr = [NSString stringWithFormat:@"%ld",(long)selectedMniute];
    }else{
        minuteStr = [NSString stringWithFormat:@"0%ld",(long)selectedMniute];
    }
     
    //星期
    NSString *week = [self weekdayStringFromDate:self.selectedDate];
    if ([self isSameDay:[NSDate date] date2:self.selectedDate]) {
        week = kLocalizationMsg(@"今日");
    }
    NSString *timeStr = [NSString stringWithFormat:kLocalizationMsg(@"%@月%@日 %@ %@:%@"),monthStr,dayStr,week,hourStr,minuteStr];
    return timeStr;
}

- (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}
 
- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], kLocalizationMsg(@"周日"), kLocalizationMsg(@"周一"), kLocalizationMsg(@"周二"), kLocalizationMsg(@"周三"), kLocalizationMsg(@"周四"), kLocalizationMsg(@"周五"), kLocalizationMsg(@"周六")];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.previewTitleTF) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 8){
            return NO;
        }
    }

    return YES;
}

@end
