//
//  OtherChannelView.m
//  Shopping
//
//  Created by kalacheng on 2020/6/29.
//  Copyright © 2020 klc. All rights reserved.
//

#import "OtherChannelView.h"
#import "KeyboardToolBar.h"
#import "GoogsCategoryController.h"
 
#import <LibTools/LibTools.h>
#import <LibProjBase/LibProjBase.h>
#import <LibProjView/SkyDriveTool.h>
#import <LibProjView/ZDropScrollView.h>
 
#import <LibProjModel/HttpApiShopGoods.h>
#import <LibProjModel/ShopGoods_updateGoods.h>
#import <LibProjView/CustomCameraController.h>
#import <TZImagePickerController/TZImagePickerController.h>

@interface OtherChannelView ()<ZDropScrollViewDelegate, UITextFieldDelegate>

@property(nonatomic,weak)UIScrollView *scrol;

@property (nonatomic, weak)UITextField *categoryTextF;//分类
@property (nonatomic, weak)UITextField *urlTextF;//链接
@property (nonatomic, weak)UITextField *nameTextF;//名称
@property (nonatomic, weak)UITextField *priceTextF;//价格
@property (nonatomic, weak)UIButton *addbtn;//添加
 

@property (nonatomic, copy)NSString *categoryName;

@property (nonatomic, assign)int64_t categoryId;

@property (nonatomic, assign)int64_t goodsId;

@property (nonatomic, copy)NSString *imageUrl;

@property (nonatomic, copy)ZDropScrollView *dropScrollV;

@property (nonatomic, copy)NSString *goodsUrl;  ///商品链接

@property (nonatomic, copy)NSString *goodsName;  ///商品名称

@property (nonatomic, copy)NSString *goodsPrice;   ///商品价格

@end

@implementation OtherChannelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}
- (void)modifyGoods{
    ShopGoods_updateGoods *goods = [[ShopGoods_updateGoods alloc]init];
    goods.categoryId = _categoryId;
    goods.channelId = _channelId;
    goods.goodsPicture = _imageUrl;
    goods.goodsName = _goodsName;
    goods.present = @"";
    goods.detailPicture = @"";
    goods.price = [_goodsPrice doubleValue];
    goods.favorablePrice = 0;
    goods.productLinks = _goodsUrl;
    goods.goodsId = _goodsId > 0?_goodsId:0;;
    goods.type = 1;
     kWeakSelf(self);
    [HttpApiShopGoods updateGoods:goods callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            if (weakself.addGoodsSuccess) {
                weakself.addGoodsSuccess();
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}
 
- (void)submitGoods{
    ShopGoods_creatGoods *create = [[ShopGoods_creatGoods alloc] init];
    create.categoryId = _categoryId;
    create.channelId = _channelId;
    create.goodsPicture = _imageUrl;
    create.goodsName = _goodsName;
    create.present = @"";
    create.detailPicture = @"";
    create.price = [_goodsPrice doubleValue];
    create.favorablePrice = 0;
    create.productLinks = _goodsUrl;
    create.goodsId = 0;
    create.type = 1;
    kWeakSelf(self);
    [HttpApiShopGoods creatGoods:create callback:^(int code, NSString *strMsg, HttpNoneModel *model) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:strMsg];
            if (weakself.addGoodsSuccess) {
                weakself.addGoodsSuccess();
            }
        }else{
            [SVProgressHUD showInfoWithStatus:strMsg];
        }
    }];
}

- (void)setModel:(ShopGoodsDTOModel *)model{
    _model = model;
    _goodsId = model.goodsId;
    _channelId = model.channelId;
    //链接
    _urlTextF.text = model.productLinks;
    _goodsUrl = model.productLinks;
    //名称
    _nameTextF.text = model.goodsName;
    _goodsName = model.goodsName;
    //价格
    _goodsPrice = [NSString stringWithFormat:@"%.1f",model.price];
    _priceTextF.text = [NSString stringWithFormat:@"%.1f",model.price];
    //分类
    _categoryId = model.categoryId;
    _categoryName = model.categoryName;
    _categoryTextF.text = model.categoryName;
    //图片
    _imageUrl = model.goodsPicture;
    self.dropScrollV.o_imageDatas = [@[self.imageUrl] mutableCopy];
    [self.dropScrollV reloadData];
    [self.addbtn setTitle:kLocalizationMsg(@"立即修改") forState:UIControlStateNormal];
}

-(void)creatSubView{
    
    ///type : 1:输入文字。  2 点击事件。  3 照片
    NSArray *itemArr = @[@{@"name":kLocalizationMsg(@"商品链接"),@"placeholder":kLocalizationMsg(@"请输入商品链接/口令/ID"),@"type":@"1"},
                         @{@"name":kLocalizationMsg(@"商品名称"),@"placeholder":kLocalizationMsg(@"请输入商品名称"),@"type":@"2"},
                         @{@"name":kLocalizationMsg(@"商品价格"),@"placeholder":@"0.00",@"type":@"3"},
                         @{@"name":kLocalizationMsg(@"商品分类"),@"placeholder":@"",@"type":@"4"},
                         @{@"name":kLocalizationMsg(@"商品图片"),@"placeholder":@"",@"type":@"5"},];
    
    
    CGFloat maxY = 0;
    for (NSDictionary *item in itemArr) {
        
        ///背景视图的高度
        CGFloat viewHeight = [item[@"type"] intValue] == 5? ((kScreenWidth-80)/4 + 30 + 50) : 50;
        CGFloat top = 10;
        
        UIView *bgV = [[UIView alloc] initWithFrame:CGRectMake(20, maxY, self.scrol.width-40, viewHeight)];
        [self.scrol addSubview:bgV];
        maxY += viewHeight;

        UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 100, 40)];
        nameL.text = item[@"name"];
        nameL.textColor = kRGB_COLOR(@"#555555");
        nameL.font = [UIFont systemFontOfSize:14];
        [bgV addSubview:nameL];
        
        int type = [item[@"type"] intValue];
        switch (type) {
            case 1:
            case 2:
            case 3:
            {
                UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(80, top, kScreenWidth - 100 -20, nameL.height)];
                textF.centerY = nameL.centerY;
                textF.font = [UIFont systemFontOfSize:13];
                textF.userInteractionEnabled = YES;
                textF.tag = 99567+[item[@"type"] intValue];
                [textF addTarget:self action:@selector(textValueChange:) forControlEvents:UIControlEventEditingChanged];
                textF.placeholder = item[@"placeholder"];
                [bgV addSubview:textF];
                textF.keyboardType = UIKeyboardTypeDefault;
                if (type == 1) {
                    self.urlTextF = textF;
                }else if(type == 2){
                    self.nameTextF = textF;
                }else if (type == 3) {
                    textF.keyboardType = UIKeyboardTypeDecimalPad;
                    self.priceTextF = textF;
                    self.priceTextF.delegate = self;
                }
                
                UIView *linkV = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight-0.5, bgV.width, 0.5)];
                linkV.backgroundColor = kRGB_COLOR(@"#DEDEDE");
                [bgV addSubview:linkV];
            }
                break;
            case 4:
            {
                UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(80, top, kScreenWidth - 100 -20, nameL.height)];
                textF.centerY = nameL.centerY;
                textF.font = [UIFont systemFontOfSize:13];
                textF.userInteractionEnabled = NO;
                textF.placeholder = kLocalizationMsg(@"请选择商品分类");
                [bgV addSubview:textF];
                _categoryTextF = textF;
                
                UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(bgV.width - 10, 0, 10 , 12)];
                imageV.centerY = nameL.centerY;
                imageV.image = [UIImage imageNamed:@"mineCenter_gray_more"];
                imageV.contentMode = UIViewContentModeScaleAspectFit;
                [bgV addSubview:imageV];
                
                UIButton *selectBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
                selectBtn.frame = CGRectMake(textF.x, textF.y, imageV.maxX-textF.x, nameL.height);
                selectBtn.centerY = imageV.centerY;
                [selectBtn addTarget:self action:@selector(selectCategory) forControlEvents:UIControlEventTouchUpInside];
                [bgV addSubview:selectBtn];
                
                UIView *linkV = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight-0.5, bgV.width, 0.5)];
                linkV.backgroundColor = kRGB_COLOR(@"#DEDEDE");
                [bgV addSubview:linkV];
            }
                break;
            case 5:
            {
                viewHeight -= (nameL.maxY + top);
                ZDropScrollView *dropScrollV = [[ZDropScrollView alloc] initWithFrame:CGRectMake(nameL.x-10, nameL.maxY-10, (kScreenWidth-80)/4.0 +20, (kScreenWidth-80)/4 + 20)];
                dropScrollV.o_delegate = self;
                dropScrollV.o_regionView = self.scrol;
                dropScrollV.o_maxCount = 1;
                dropScrollV.sDROPVIEW_MARGIN = 0;
                dropScrollV.sDROPVIEW_SIZE = (kScreenWidth-80)/4.0 ;
                dropScrollV.sDROPVIEW_COUNT = 1;
                dropScrollV.addImageStr = @"shop_addGoods";
                dropScrollV.o_imageDatas = [[NSMutableArray alloc] init];
                [bgV addSubview:dropScrollV];
                _dropScrollV = dropScrollV;
                [dropScrollV reloadData];
            }
                
                break;
            default:
                break;
        }
        
        
        
    }
    self.scrol.contentSize = CGSizeMake(0, maxY);
    
    {
        
        UIButton *previewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height-44, self.width/2.0, 44)];
        previewBtn.backgroundColor = kRGB_COLOR(@"#FF8548");
        [previewBtn setTitle:kLocalizationMsg(@"预览商品") forState:UIControlStateNormal];
        previewBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [previewBtn addTarget:self action:@selector(previewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:previewBtn];
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2.0, self.height-44, self.width/2.0, 44)];
        addBtn.backgroundColor = kRGB_COLOR(@"#FF5500");
        [addBtn setTitle:kLocalizationMsg(@"立即添加") forState:UIControlStateNormal];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.addbtn = addBtn;
        [self addSubview:self.addbtn];
    }
}

- (void)textValueChange:(UITextField *)textF{
    switch (textF.tag-99567) {
        case 1: ///连接
        {
            _goodsUrl = textF.text;
        }
            break;
        case 2: ///名称
        {
            _goodsName = textF.text;
        }
            break;
        case 3: ///价格
        {
            _goodsPrice = textF.text;
        }
            break;
        default:
            break;
    }
}

 

//预览
-(void)previewBtnClick:(UIButton *)sender{
    if (_goodsUrl.length > 0) {
        [RouteManager routeForName:RN_general_webView currentC:[ProjConfig currentVC] parameters:@{@"url":_goodsUrl}];
    }else{
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入商品链接")];
    }
}

//添加
-(void)addBtnClick:(UIButton *)sender{
    if (![_goodsUrl.lowercaseString hasPrefix:@"https://"] && ![_goodsUrl.lowercaseString hasPrefix:@"http://"]) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入正确的商品链接")];
        return;
    }
    if (_goodsUrl.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入商品链接")];
        return;
    }
    if (_goodsName.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入商品名称")];
        return;
    }
    if (_goodsPrice.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请输入商品价格")];
        return;
    }
    if (_categoryId == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请选择商品分类")];
        return;
    }
    if (_imageUrl.length == 0) {
        [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"请上传商品图片")];
        return;
    }
    if (self.isModify) {
         [self modifyGoods];
    }else{
         [self submitGoods];
    }
    
}

#pragma mark - ZDropScrollViewDelegate -
//添加按钮 时间
- (void)addNewView:(ZDropScrollView*)scrollView{

    kWeakSelf(self);
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];;
    [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"相机") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself photoShoot];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself addImage];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:kLocalizationMsg(@"取消") style:UIAlertActionStyleCancel handler:nil]];
    [[ProjConfig currentVC] presentViewController:alertVC animated:YES completion:nil];

}


- (void)photoShoot{
    kWeakSelf(self);
    CustomCameraController *camera = [[CustomCameraController alloc] init] ;
    camera.showPhotoAlbum = NO;
    camera.functionType = CameraFunction_onlyCamera;
    camera.isFront = NO;
    [camera selectPhotoDidComplete:^(CustomCameraController *cameraVC, NSArray<UIImage *> *images) {
        [cameraVC dismissViewControllerAnimated:NO completion:nil];
        ///上传
        [weakself uploadImage:images.firstObject];
    }];
    [[ProjConfig currentVC] presentViewController:camera animated:YES completion:nil];
}


-(void)addImage{
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
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;

    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton) {
        [leftButton setTitle:kLocalizationMsg(@"返回") forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftButton setTitleColor:[ProjConfig projNavTitleColor] forState:UIControlStateNormal];
    }];

    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        ///上传
        [weakself uploadImage:photos.firstObject];
    }];

    [[ProjConfig currentVC] presentViewController:imagePickerVc animated:YES completion:nil];
}



- (void)uploadImage:(UIImage *)image{
    [SVProgressHUD showWithStatus:kLocalizationMsg(@"上传中")];
    kWeakSelf(self);
    [SkyDriveTool uploadImageFormScene:5 image:image complete:^(BOOL success, NSString * _Nonnull imageUrl) {
        if (success) {
            
            weakself.dropScrollV.o_imageDatas =[@[imageUrl] mutableCopy];
            [weakself.dropScrollV reloadData];
            weakself.imageUrl = imageUrl;
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"上传成功")];
        }else{
            [SVProgressHUD showInfoWithStatus:kLocalizationMsg(@"发送图片失败！")];
        }
    }];
}


- (void)selectCategory{
    GoogsCategoryController *categoryVC = [[GoogsCategoryController alloc] init];
    [[ProjConfig currentVC].navigationController pushViewController:categoryVC animated:YES];
    
    kWeakSelf(self);
    categoryVC.selectCategory = ^(int64_t categoryId, NSString * _Nonnull categoryName) {
        weakself.categoryId = categoryId;
        weakself.categoryName = categoryName;
        weakself.categoryTextF.text = categoryName;
    };
}


-(UIScrollView *)scrol{
    if (!_scrol) {
        UIScrollView *scrol = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-44)];
        scrol.contentSize = self.frame.size;
        [self addSubview:scrol];
        _scrol = scrol;
    }
    return _scrol;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitV = [super hitTest:point withEvent:event];
    if (hitV == _scrol || [hitV isMemberOfClass:[UIView class]]) {
        return nil;
    }
    return hitV;
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

      NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];

      if (toString.length > 0) {

          //NSString *stringRegex = @"(\\+|\\-)?(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?";//(带正负号的)

          NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,20}(([.]\\d{0,2})?)))?";//一般格式 d{0,8} 控制位数

          NSPredicate *money = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];

          BOOL flag = [money evaluateWithObject:toString];

          if (!flag) return NO;
      }
      return YES;
}

@end
