//
//  MessageTool.m
//  MessageInfo
//
//  Created by shirley on 2022/2/9.
//

#import "MessageTool.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <LibProjView/SkyDriveTool.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import "MessageTakePhotoPreview.h"

@interface MessageTool ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign)ConversationChatForType chatType;

@property (nonatomic, copy)SelectPhotoBlock photoBlock;

@property (nonatomic, assign)BOOL picSelectShowOnce;


@end


@implementation MessageTool
 
- (instancetype)initWithChatType:(ConversationChatForType)chatType{
    self = [super init];
    if (self) {
        _chatType = chatType;
    }
    return self;
}

- (void)selectPhoto:(SelectPhotoBlock)selectBlock {
    self.photoBlock = selectBlock;
    self.picSelectShowOnce = NO;
    [self doUploadPicture];
}

#pragma mark - 选择相册 -
- (void)doUploadPicture{
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
    [[ProjConfig currentVC] presentViewController:alertContro animated:NO completion:nil];
    
}
- (void)selectThumbWithType:(UIImagePickerControllerSourceType)type{
    kWeakSelf(self);
    if (type == UIImagePickerControllerSourceTypeCamera) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        picker.allowsEditing = NO;
        [[ProjConfig currentVC] presentViewController:picker animated:YES completion:nil];
    }else{
         
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.showSelectedIndex = NO;
        imagePickerVc.allowTakeVideo = NO;
        imagePickerVc.allowTakePicture = NO;
        imagePickerVc.showSelectBtn = YES;
        imagePickerVc.allowCrop = NO;
        imagePickerVc.barItemTextColor = [ProjConfig projNavTitleColor];
        imagePickerVc.naviTitleColor = [ProjConfig projNavTitleColor];
        imagePickerVc.naviBgColor = [UIColor whiteColor];
        [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
            [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
        }];
         
        imagePickerVc.photoPickerPageUIConfigBlock = ^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
            ///单聊+阅后即焚
            if (weakself.chatType == 0) {
                UIButton *allowBtn = [UIButton buttonWithType:0];
                [allowBtn setImage:[UIImage imageNamed:@"launch_agree_normal"] forState:UIControlStateNormal];
                [allowBtn setImage:[UIImage imageNamed:@"launch_agree_selected"] forState:UIControlStateSelected];
                [allowBtn setTitle:kLocalizationMsg(@" 阅后即焚") forState:UIControlStateNormal];
                [allowBtn addTarget:self action:@selector(OnceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                allowBtn.titleLabel.font = previewButton.titleLabel.font;
                [allowBtn setTitleColor:kRGBA_COLOR(@"#666666", 1.0) forState:UIControlStateNormal];
                [bottomToolBar addSubview:allowBtn];
                [allowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(100, kTabBarHeight-kSafeAreaBottom));
                    make.top.equalTo(bottomToolBar);
                    make.left.equalTo(previewButton.mas_right).inset(15);
                }];
                
            }
        };
       
         
        
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            ///上传
            [weakself uploadPhoto:photos.firstObject];
             
        }];
        
        [[ProjConfig currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
    }
}
- (void)uploadPhoto:(UIImage *)image{
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"发送中")];
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:4 image:image complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        [SVProgressHUD dismiss];
        if (success) {
            weakself.photoBlock?weakself.photoBlock(imageUrl, weakself.picSelectShowOnce):nil;
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"发送图片失败！")];
        }
    }];
}


- (void)OnceBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    
    self.picSelectShowOnce = btn.selected;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:NO completion:^{
        __block UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (image) {
            kWeakSelf(self);
            [MessageTakePhotoPreview showImageWith:image callBack:^(MessageTakePhotoPreview * _Nonnull view, BOOL isBronDownAfterRead, UIImage * _Nonnull returnImage, BOOL isSend) {
                if (view) {
                    [view removeFromSuperview];
                    view = nil;
                }
                if (isSend) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        weakself.picSelectShowOnce = isBronDownAfterRead;
                        [weakself uploadPhoto:image];
                    });
                }
            }];
            
        }
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
