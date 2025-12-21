//
//  userInfoEidteTableHeader.m
//  UserInfo
//
//  Created by ssssssss on 2020/12/17.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "UserInfoEditTableHeader.h"
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/HttpApiUserController.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjView/SendIMMessageObj.h>
#import "UserInfoGroupDetailView.h"


@interface UserPicItemView : UIControl

@property (nonatomic, weak)UIImageView *userPicV;
@property (nonatomic, weak)UIView *coverV;

@property (nonatomic, strong)AppUserDataReviewVOModel *userPicM;

@end


@implementation UserPicItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        
        [self createView];
    }
    return self;
}

- (void)createView{
    UIImageView *userIconV = [[UIImageView alloc] initWithFrame:self.bounds];
    userIconV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:userIconV];
    self.userPicV = userIconV;
    
    UIView *coverV = [[UIView alloc] initWithFrame:self.bounds];
    coverV.userInteractionEnabled = NO;
    [self addSubview:coverV];
    self.coverV = coverV;
    {
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        effectView.alpha = 0.3;
        effectView.frame = coverV.bounds;
        [coverV addSubview:effectView];
        UILabel *titleL = [[UILabel alloc] initWithFrame:coverV.bounds];
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.text = kLocalizationMsg(@"审核中");
        titleL.textColor = [UIColor redColor];
        [coverV addSubview:titleL];
    }
}

- (void)setUserPicM:(AppUserDataReviewVOModel *)userPicM{
    _userPicM = userPicM;
    if (userPicM.approvalStatus == 0) {
        [self.userPicV sd_setImageWithURL:[NSURL URLWithString:userPicM.upUserContent] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
        self.coverV.hidden = NO;
    }else{
        self.coverV.hidden = YES;
        [self.userPicV sd_setImageWithURL:[NSURL URLWithString:userPicM.oldUserContent] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    }
}


@end




@interface UserInfoEditTableHeader()<TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

///用户头像
@property (nonatomic, weak)UserPicItemView *userIconV;
@property (nonatomic, strong)AppUserDataReviewVOModel *userIconM;

///个人主页
@property (nonatomic, strong)UIScrollView *picScrollV;
@property (nonatomic, strong)NSMutableArray<AppUserDataReviewVOModel *> *imageUrls;

///是否为修改用户头像
@property (nonatomic, assign)BOOL isModifyUserIcon;
///选择第几张个人主页图片
@property (nonatomic, assign)NSInteger selectIndex;
///当前操作是添加还是修改图片
@property (nonatomic, assign)BOOL modifyPic;
///个人主页最大图片数
@property (nonatomic, assign)int maxNum;


@end


@implementation UserInfoEditTableHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.maxNum = 8;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.selectIndex = -1;
    self.backgroundColor = [UIColor whiteColor];
    
    kWeakSelf(self);
    ///用户头像
    UserInfoGroupTitleView *userIconTitleBgV = [[UserInfoGroupTitleView alloc] initWithFrame:CGRectMake(0, 0, self.width, [UserInfoGroupTitleView viewHeight])];
    [self addSubview:userIconTitleBgV];
    userIconTitleBgV.sectionL.text = kLocalizationMsg(@"用户头像");
    
    UserPicItemView *userPicV = [[UserPicItemView alloc] initWithFrame:CGRectMake(15, userIconTitleBgV.maxY+15, 110, 110)];
    [self addSubview:userPicV];
    self.userIconV = userPicV;
    [userPicV klc_whenTapped:^{
        [weakself choosePictureOrTakePhotoOrDeletePic:YES isModify:YES];
    }];

    ///个人主页图片
    UserInfoGroupTitleView *userMainTitleBgV = [[UserInfoGroupTitleView alloc] initWithFrame:CGRectMake(0, userPicV.maxY+15, self.width, [UserInfoGroupTitleView viewHeight])];
    [self addSubview:userMainTitleBgV];
    userMainTitleBgV.sectionL.text = kLocalizationMsg(@"个人主页图片");

    self.picScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, userMainTitleBgV.maxY+15, kScreenWidth, 110)];
    self.picScrollV.backgroundColor = [UIColor whiteColor];
    self.picScrollV.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.picScrollV];
    
    UIView *botV = [[UIView alloc] initWithFrame:CGRectMake(15, self.picScrollV.maxY+5, self.width-30, 40)];
    [self addSubview:botV];
    {
        UILabel *addTl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, botV.height)];
        addTl.textColor = kRGB_COLOR(@"#666666");
        addTl.font = [UIFont systemFontOfSize:15];
        addTl.text = kLocalizationMsg(@"上传照片");
        [botV addSubview:addTl];
        
        UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(botV.width-120, 0, 120, botV.height)];
        tipL.textAlignment = NSTextAlignmentRight;
        tipL.textColor = kRGB_COLOR(@"#666666");
        tipL.font = [UIFont systemFontOfSize:14];
        tipL.text = kStringFormat(kLocalizationMsg(@"最多上传%d张"),self.maxNum);
        [botV addSubview:tipL];
    }
    
    self.height = botV.maxY;
    
    //初始化图片
    [self getUserAvatarAndPortrait];
}


///获取用户头像和设置的形象
- (void)getUserAvatarAndPortrait{
    kWeakSelf(self);
    [HttpApiUserController getAppUserDataImg:^(int code, NSString *strMsg, AppUserDataImgModel *model) {
        if (code == 1) {
            [weakself.imageUrls removeAllObjects];
            weakself.userIconM = model.appUserAvatar;
            [weakself.imageUrls addObjectsFromArray:model.appUserPortrait];
            [weakself updateHeaderImages];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


///更新用户头像和形象设置的图片显示
- (void)updateHeaderImages{
    ///头像
    self.userIconV.userPicM = self.userIconM;
    
    ///个人主页信息
    [self.picScrollV removeAllSubViews];
    CGFloat viewH = self.picScrollV.height;
    
    UIButton *addPicBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, viewH, viewH)];
    [addPicBtn setBackgroundImage:[UIImage imageNamed:@"icon_authority_upload"] forState:UIControlStateNormal];
    [addPicBtn addTarget:self action:@selector(addPicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.picScrollV addSubview:addPicBtn];

    CGFloat contentWidth = addPicBtn.maxX;
    
    for (int i = 0; i < self.imageUrls.count; i++) {
        AppUserDataReviewVOModel *picModel = self.imageUrls[i];
        UserPicItemView *userPicV = [[UserPicItemView alloc] initWithFrame:CGRectMake(addPicBtn.maxX+10+(viewH+10)*i, 0, viewH, viewH)];
        userPicV.tag = i+9970;
        contentWidth += (viewH+10);
        userPicV.userPicM = picModel;
        [userPicV addTarget:self action:@selector(picBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.picScrollV addSubview:userPicV];
    }
    self.picScrollV.contentSize = CGSizeMake(contentWidth+15, 0);
}

///点击某一个图片
- (void)picBtnClick:(UserPicItemView*)picView{
    self.selectIndex = picView.tag-9970;
    [self choosePictureOrTakePhotoOrDeletePic:NO isModify:YES];
}

///点击添加图片
- (void)addPicBtnClick:(UIButton *)btn{
   // NSLog(@"过滤文字添加图片"));
    self.selectIndex = -1;
    [self choosePictureOrTakePhotoOrDeletePic:NO isModify:NO];
}

///选择某一张图片
- (void)choosePictureOrTakePhotoOrDeletePic:(BOOL)isUserIcon isModify:(BOOL)isModify{
    self.isModifyUserIcon = isUserIcon;
    self.modifyPic = isModify;
    if (isModify && !isUserIcon) {
        if (self.imageUrls.count >  self.maxNum) {
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"不能再添加了")];
            return;
        }
    }
    UIAlertController *alertContro = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *picAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectThumbWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alertContro addAction:picAction];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"拍照") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectThumbWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    
    [alertContro addAction:photoAction];
    ///选择图片位置 > 0
    if (isModify && !isUserIcon) {
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"删除") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self delegateUserPic:self.selectIndex];
        }];
        [deleteAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
        [alertContro addAction:deleteAction];
    }
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertContro addAction:cancleAction];
    
    [self.superVc presentViewController:alertContro animated:YES completion:nil];
}


- (void)selectThumbWithType:(UIImagePickerControllerSourceType)type{
    kWeakSelf(self);
    if (type == UIImagePickerControllerSourceTypeCamera) {
        
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = type;
        imagePickerController.allowsEditing = self.isModifyUserIcon?YES:NO; ///如果是添加头像就可编辑，不是不编辑
        imagePickerController.showsCameraControls = YES;
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.superVc presentViewController:imagePickerController animated:YES completion:nil];
        
    }else{
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerVc.pickerDelegate = self;
        if (self.isModifyUserIcon) { ///添加头像
            imagePickerVc.maxImagesCount = 1;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.allowPickingOriginalPhoto = NO;
        }else{ ///其他图片
            imagePickerVc.allowCrop = NO;
            imagePickerVc.maxImagesCount = self.modifyPic?1:(self.maxNum-self.imageUrls.count);
            imagePickerVc.allowPickingOriginalPhoto = YES;
        }
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
            [weakself updateImages:photos];
        }];
        [self.superVc presentViewController:imagePickerVc animated:YES completion:nil];
        
    }
}

#pragma mark - 上传
- (void)updateImages:(NSArray<UIImage *> *)photos{
    [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传中...")];
    kWeakSelf(self);
    [SkyDriveTool uploadImageArrayFormScene:1 images:photos complete:^(BOOL success, NSArray<NSString *> * _Nonnull urlArr) {
        if (success && urlArr.count > 0) {
            [SVProgressHUD showSuccessWithStatus:kLocalizationMsg(@"上传完成")];
            [weakself userPicHandle:[urlArr componentsJoinedByString:@","]];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传失败")];
        }
    }];
}

- (void)deleteUserInfo{
    [IMInfoManager deleteUserExtraInfo:[ProjConfig userId]];
}

///删除操作
- (void)delegateUserPic:(NSInteger)delIndex{
    if (self.imageUrls.count > delIndex) {
        AppUserDataReviewVOModel *picModel = self.imageUrls[delIndex];
        kWeakSelf(self);
        [HttpApiUserController delUserDataReview:picModel.id_field callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
            if (code == 1) {
                [weakself.imageUrls enumerateObjectsUsingBlock:^(AppUserDataReviewVOModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (picModel.id_field == obj.id_field) {
                        [weakself.imageUrls removeObjectAtIndex:idx];
                        [weakself updateHeaderImages];
                        *stop = YES;
                    }
                }];
            }else{
                [SVProgressHUD showInfoWithStatus:strMsg];
            }
        }];
    }
}

///处理用户图片
-(void)userPicHandle:(NSString *)images{
    if (self.isModifyUserIcon) {
        ///修改用户头像
        [self addAndUpdateUserPic:images dataType:1 oldId:self.userIconM.id_field];
    }else{
        if (self.modifyPic) {
            if (self.imageUrls.count > self.selectIndex) {
                AppUserDataReviewVOModel *picModel = self.imageUrls[self.selectIndex];
                [self addAndUpdateUserPic:images dataType:2 oldId:picModel.id_field];
            }
        }else{
            [self addAndUpdateUserPic:images dataType:2 oldId:0];
        }
    }
}

/// 修改用户头像
/// pic 多张图片字符串
/// oldId 资料id(新增的情况下为0)
/// dataType 资料类型 1:用户头像 2:用户资料图片(个人中心)
- (void)addAndUpdateUserPic:(NSString *)pic dataType:(int)dataType oldId:(int64_t)oldId{
    kWeakSelf(self);
    [HttpApiUserController updateUserDataReview:oldId dataType:dataType reviewContent:pic callback:^(int code, NSString *strMsg, AppUserDataImgModel *model) {
        if (code == 1) {
            [weakself.imageUrls removeAllObjects];
            weakself.userIconM = model.appUserAvatar;
            [weakself.imageUrls addObjectsFromArray:model.appUserPortrait];
            [weakself updateHeaderImages];
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}


#pragma mark - UINavigationControllerDelegate,UIImagePickerControllerDelegate>
//选择图片完成
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //    NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]){
        NSString *typeEdite ;
        if (self.selectIndex == 0) {
            typeEdite = @"UIImagePickerControllerEditedImage";
        }else{
            typeEdite = @"UIImagePickerControllerOriginalImage";
        }
        UIImage* image = [info objectForKey:typeEdite];
        [self updateImages:@[image]];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//解决触碰难点到的问题
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

#pragma mark - lazy

- (NSMutableArray *)imageUrls{
    if (!_imageUrls) {
        _imageUrls = [NSMutableArray array];
    }
    return _imageUrls;
}

@end
