//
//  HomeLiveShoppingHeader.m
//  HomePage
//
//  Created by yww on 2020/8/10.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "HomeLiveShoppingHeader.h"
#import <LibProjModel/ShopLiveAnnouncementDetailDTOModel.h>
#import "KLBannerView.h"

@interface HomeLiveShoppingHeader ()<KLBannerViewDelegate>
@property (nonatomic, strong)UIImageView *bgImageView;
@property (nonatomic, strong)KLBannerView *banner;
@end

@implementation HomeLiveShoppingHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}
- (void)createUI{
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.banner];
    self.banner.timeInterval = 3;
}

- (void)setArr:(NSArray<ShopLiveAnnouncementDetailDTOModel *> *)arr {
    _arr = arr;
    self.bgImageView.hidden = !arr.count;
    self.banner.hidden = !arr.count;
    self.banner.models = arr;
}

#pragma mark-  KLBannerViewDelegate
-(void)KLBannerView:(KLBannerView *)bannerView didSelectedAt:(ShopLiveAnnouncementDetailDTOModel *)model{
    if (self.delegate && model && [self.delegate respondsToSelector:@selector(HomeLiveShoppingHeader:itemClick:)]) {
        [self.delegate HomeLiveShoppingHeader:self itemClick:model];
    }
}
 


#pragma mark - lazy load
- (KLBannerView *)banner{
    if (!_banner) {
        KLBannerView *banner = ({
            KLBannerView *banner = [[KLBannerView alloc] initWithFrame:self.bounds];
            banner.delegate = self;
            banner;
        });
        _banner = banner;
    }
    return _banner;
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.image = [UIImage imageNamed:@"shop_home_header_bg"];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}
@end
