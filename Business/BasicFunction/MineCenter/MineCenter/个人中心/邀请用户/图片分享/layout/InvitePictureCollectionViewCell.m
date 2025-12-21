//
//  InvitePictureCollectionViewCell.m
//  MineCenter
//
//  Created by ssssssss on 2020/12/11.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "InvitePictureCollectionViewCell.h"
#import <LibProjModel/InviteDtoModel.h>
#import <LibProjModel/AppInviteImgModel.h>

@interface InvitePictureCollectionViewCell()
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UIImageView *qrcodeImageV;//二维码
@property (nonatomic, strong)UILabel *codeL;//邀请码
@end

@implementation InvitePictureCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.bounds];
    imageV.layer.cornerRadius = 8;
    imageV.clipsToBounds =YES;
    imageV.layer.borderColor = [UIColor whiteColor].CGColor;
    imageV.layer.borderWidth = 3.0;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    self.imageV = imageV;
    [self.contentView addSubview:imageV];
    
    CGFloat pt = kScreenWidth/375.0;
    UIImageView *qrcodeImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height-80*pt-40, 80*pt, 80*pt)];
    qrcodeImageV.backgroundColor = [UIColor whiteColor];
    qrcodeImageV.contentMode = UIViewContentModeScaleAspectFit;
    qrcodeImageV.backgroundColor = [UIColor clearColor];
    qrcodeImageV.centerX = self.width/2.0;
    self.qrcodeImageV = qrcodeImageV;
    [imageV addSubview:self.qrcodeImageV];
    
    UILabel *codeL = [[UILabel alloc]initWithFrame:CGRectMake(0, qrcodeImageV.maxY+10, 150, 20)];
    codeL.centerX = self.width/2.0;
    codeL.font = [UIFont systemFontOfSize:10];
    codeL.textAlignment = NSTextAlignmentCenter;
    codeL.textColor = [UIColor whiteColor];
    codeL.backgroundColor = kRGBA_COLOR(@"#000000",0.3);
    codeL.layer.cornerRadius = 10;
    codeL.clipsToBounds = YES;
    self.codeL = codeL;
    [imageV addSubview:codeL];
    
}

- (void)setModel:(AppInviteImgModel *)model{
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageWithColor:[UIColor lightGrayColor]]];
    self.codeL.text = [NSString stringWithFormat:kLocalizationMsg(@"邀请码 %@"),self.inviteModel.code];
    if (self.inviteModel.inviteUrl.length > 0) {
        UIImage *qrcodeImg = [self generateQRCode:self.inviteModel.inviteUrl width:100 height:100];
        self.qrcodeImageV.image = qrcodeImg;
    }
     
    
}
//生成条形码以及二维码
- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    // 生成
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width;
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}
@end
