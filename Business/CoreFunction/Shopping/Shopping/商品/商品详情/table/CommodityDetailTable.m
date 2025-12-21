//
//  CommodityDetailTable.m
//  Shopping
//
//  Created by klc on 2020/7/4.
//  Copyright © 2020 klc. All rights reserved.
//

#import "CommodityDetailTable.h"
#import <LibProjModel/ShopGoodsModel.h>
#import <SDWebImage/SDWebImage.h>

@interface CommodityDetailTable ()

@property (nonatomic, weak)UIView *bgView;

@end

@implementation CommodityDetailTable

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}


- (void)createUI{
    UIView *bgView = [[UIView alloc] init];
    [self.contentView addSubview:bgView];
    self.bgView = bgView;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)updateUI{
    [self.bgView removeAllSubViews];
    
    UIView *textBgV = [[UIView alloc] init];
    [self.bgView addSubview:textBgV];
    [textBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView).inset(12);
        make.top.equalTo(self.bgView).inset(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    
    ///文字
    if (self.shopGoods.present.length > 0) {
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.textColor = kRGB_COLOR(@"#666666");
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.text = self.shopGoods.present;
        [textBgV addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(textBgV).inset(15);
            make.bottom.equalTo(textBgV).inset(20);
            make.left.right.equalTo(textBgV);
        }];
    }
    
    UIView *topView = textBgV;
    
    ///判断是否有图片
    BOOL hasImage = NO;
    ///图片
    NSArray *arr = [self.shopGoods.detailPicture componentsSeparatedByString:@","];
    for (int i = 0; i < arr.count; i++) {
        NSString *url = arr[i];
        if (url.length > 0) {
            
            hasImage = YES;
            
            UIImageView *imgV = [[UIImageView alloc] init];
            [imgV sd_setImageWithURL:[NSURL URLWithString:url]];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            imgV.layer.masksToBounds = YES;
            [self.bgView addSubview:imgV];
            [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.bgView);
                make.top.equalTo(topView.mas_bottom);
                make.height.mas_equalTo(0.1);
                if (i == (arr.count-1)) {
                    make.bottom.equalTo(self.bgView);
                }
            }];
            topView = imgV;
            [CommodityDetailTable getWebImageWith:url callBack:^(BOOL success, CGFloat imgHeight) {
                if (success) {
                    [imgV mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(imgHeight);
                    }];
                }else{
                    imgV.hidden = YES;
                }
            }];
        }
    }
    
    
    if (!hasImage) {
        [textBgV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView).inset(12);
            make.top.equalTo(self.bgView).inset(0);
            make.bottom.equalTo(self.bgView);
        }];
    }
    
}


//获取图片的尺寸
+ (void)getWebImageWith:(NSString *)url callBack:(void (^)(BOOL, CGFloat))callBack{
    
    if (kStringIsEmpty(url)) {
        callBack?callBack(NO, 0):nil;
        return;
    }
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager loadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //       // NSLog(@"过滤文字receive == %ld targetURL == %@"),(long)receivedSize,targetURL);
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
        CGFloat imageH;
        if (error) {
            imageH = 0.1;
            callBack?callBack(NO,imageH):nil;
        } else {
            imageH = kScreenWidth*image.size.height*1.0/image.size.width;
            callBack?callBack(YES,imageH):nil;
        }
    }];
}


- (void)setShopGoods:(ShopGoodsModel *)shopGoods{
    _shopGoods = shopGoods;
    [self updateUI];
    
}

@end
