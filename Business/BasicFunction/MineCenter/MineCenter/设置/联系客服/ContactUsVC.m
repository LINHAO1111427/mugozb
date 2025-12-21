//
//  ContactUsVC.m
//  MineCenter
//
//  Created by klc on 2020/8/14.
//

#import "ContactUsVC.h"
#import <LibProjModel/KLCAppConfig.h>
#import <LibProjModel/CustomerServiceSettingModel.h>
#import <LibProjModel/APPConfigModel.h>
#import <SDWebImage/SDWebImage.h>

@interface ContactItem : UIView

kStrong(UIImageView, iconImv)
kStrong(UILabel, titleLab)

@end


@implementation ContactItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        _iconImv = [Maker Imv:nil layerCorner:22 superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
            
            make.left.top.equalTo(self).offset(21);
            make.size.mas_equalTo(SIZE(44, 44));
        }];
        
        
        _titleLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:@"" textColor:[UIColor clearColor] font:kFont(14) superView:self constraints:^(MASConstraintMaker * _Nonnull make) {
           
            make.centerY.equalTo(_iconImv);
            make.left.equalTo(_iconImv.mas_right).offset(18);
        }];
    
    }
    return self;
}


@end


@interface ContactUsVC ()

@end

@implementation ContactUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

-(void)createUI{
    
    self.navigationItem.title = kLocalizationMsg(@"联系客服");
    self.view.backgroundColor = kRGB_COLOR(@"#F4F4F4");
    
    ContactItem *phoneItem = [[ContactItem alloc] initWithFrame:CGRectZero];
    [self.view addSubview:phoneItem];
    [phoneItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.zh_safe_top).offset(16);
        make.left.equalTo(self.view).offset(12);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(86);
    }];
    phoneItem.iconImv.image = ImgNamed(@"contact_phone");
    
    CustomerServiceSettingModel *model = [KLCAppConfig appConfig].customerServiceSetting;
    
    NSAttributedString * phoneStr = [self attributePreString:kLocalizationMsg(@"联系电话") subString:[NSString stringWithFormat:@"\n\n%@",model.consumerHotline] attributes:@[@{NSFontAttributeName:kFont(15),NSForegroundColorAttributeName:[UIColor blackColor]},@{NSFontAttributeName:kFont(14),NSForegroundColorAttributeName:kRGB_COLOR(@"#73798D")}]];
    phoneItem.titleLab.attributedText = phoneStr;
    
    if (model.consumerHotline.length > 0) {
        
        UIButton *phoneCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [phoneCheckBtn setImage:ImgNamed(@"contact_check") forState:0];
        [phoneItem addSubview:phoneCheckBtn];
        [phoneCheckBtn klc_whenTapped:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",model.consumerHotline]]];
        }];
        [phoneCheckBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(phoneItem).inset(18);
            make.centerY.equalTo(phoneItem);
        }];
        
    }

    
    ContactItem *qqItem = [[ContactItem alloc] initWithFrame:CGRectZero];
    [self.view addSubview:qqItem];
    [qqItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneItem.mas_bottom).offset(16);
        make.left.right.height.equalTo(phoneItem);
    }];
    qqItem.iconImv.image =  ImgNamed(@"contact_qq");
    NSAttributedString * qqStr = [self attributePreString:kLocalizationMsg(@"QQ客服") subString:[NSString stringWithFormat:@"\n\n%@",model.qq] attributes:@[@{NSFontAttributeName:kFont(15),NSForegroundColorAttributeName:[UIColor blackColor]},@{NSFontAttributeName:kFont(14),NSForegroundColorAttributeName:kRGB_COLOR(@"#73798D")}]];
    qqItem.titleLab.attributedText = qqStr;
    
    ContactItem *wechatItem = [[ContactItem alloc] initWithFrame:CGRectZero];
    [self.view addSubview:wechatItem];
    [wechatItem mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(qqItem.mas_bottom).offset(16);
        make.left.right.equalTo(qqItem);
        make.height.mas_equalTo(280);
    }];
    
    wechatItem.iconImv.image =  ImgNamed(@"contact_wechat");
    NSAttributedString * wechatStr = [self attributePreString:kLocalizationMsg(@"微信客服") subString:[NSString stringWithFormat:@"\n\n%@",model.wechat] attributes:@[@{NSFontAttributeName:kFont(15),NSForegroundColorAttributeName:[UIColor blackColor]},@{NSFontAttributeName:kFont(14),NSForegroundColorAttributeName:kRGB_COLOR(@"#73798D")}]];
    wechatItem.titleLab.attributedText = wechatStr;
    
    UIImageView *qrCodeImv = [Maker Imv:nil layerCorner:0 superView:wechatItem constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.size.mas_equalTo(SIZE(160, 160));
        make.centerX.equalTo(wechatItem);
        make.top.equalTo(wechatItem).offset(80);
    }];
    
    [qrCodeImv sd_setImageWithURL:[NSURL URLWithString:model.wechatCode]];

    if (model.wechatCode.length > 0) {
        kWeakSelf(self);
        qrCodeImv.userInteractionEnabled = YES;
        [qrCodeImv klc_whenTapped:^{
            [weakself saveCodeImage];
        }];
    }
}

- (void)saveCodeImage{
    CustomerServiceSettingModel *model = [KLCAppConfig appConfig].customerServiceSetting;
    UIImage *codeImage = [model.wechatCode getImageFromURLStr];
    UIImageWriteToSavedPhotosAlbum(codeImage, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = kLocalizationMsg(@"保存图片失败") ;
    }else{
        msg = kLocalizationMsg(@"保存图片成功") ;
    }
    [SVProgressHUD showInfoWithStatus:msg];
}


-(NSAttributedString *)attributePreString:(NSString *)preString subString:(NSString *)subString attributes:(NSArray<NSDictionary*>*)attributes{
    
    NSMutableAttributedString *mustr = [[NSMutableAttributedString alloc] initWithString:kStringFormat(@"%@%@",preString,subString)];
    [mustr addAttributes:attributes.firstObject range:NSMakeRange(0, preString.length)];
    [mustr addAttributes:attributes.lastObject range:NSMakeRange(preString.length, subString.length)];
    return mustr;
}


@end
