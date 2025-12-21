//
//  MessageShowOncePicView.m
//  MessageInfo
//
//  Created by shirley on 2022/2/9.
//

#import "MessageShowOncePicView.h"
#import <Masonry/Masonry.h>
#import <LibTools/LibTools.h>
#import <SDWebImage/SDWebImage.h>

@implementation MessageShowOncePicView
{
    BOOL _isCanLook;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setClipsToBounds:YES];
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imgV];
    _pic = imgV;
    
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont systemFontOfSize:13];
    titleL.textColor = [UIColor blackColor];
    [self addSubview:titleL];
    _titleL = titleL;
    
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).inset(15);
        make.height.mas_equalTo(16);
        make.centerX.equalTo(self);
    }];
    
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).inset(15);
        make.bottom.equalTo(self.titleL.mas_top).inset(5);
        make.width.equalTo(imgV.mas_height);
        make.centerX.equalTo(self);
    }];
}

//切圆角
- (void)cornerRadiiView:(UIView *)view isOnwer:(BOOL)isOnwer{
    UIRectCorner corner = (UIRectCornerBottomLeft|UIRectCornerBottomRight|UIRectCornerTopRight);
    if (isOnwer) {
        corner = (UIRectCornerBottomLeft|UIRectCornerBottomRight|UIRectCornerTopLeft);
    }
    [view cornerRadii:CGSizeMake(8, 8) byRoundingCorners:corner];
}

///显示图片
- (void)showPic:(MessageShowOncePicModel *)picModel isOwner:(BOOL)isOwner{
    [self cornerRadiiView:self isOnwer:isOwner];
    
    if (isOwner || picModel.readStatus == 0) {
        self.pic.image = [UIImage imageNamed:@"message_oncepic_look"];
        self.titleL.text = kLocalizationMsg(@"点击查看");
        _isCanLook = YES;
    }else{
        self.pic.image = [UIImage imageNamed:@"message_oncepic_unlook"];
        self.titleL.text = kLocalizationMsg(@"已销毁");
        _isCanLook = NO;
    }
}


@end
