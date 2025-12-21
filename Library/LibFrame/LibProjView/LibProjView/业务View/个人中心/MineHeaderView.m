//
//  MineHeaderView.m
//  MineCenter
//
//  Created by klc on 2020/5/21.
//

#import "MineHeaderView.h"
#import <LibProjBase/LibProjBase.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjModel/KLCUserInfo.h>
#import <LibProjModel/ApiUserInfoModel.h>
#import <LibProjView/KlcAvatarView.h>
#import <LibProjModel/HttpApiUserController.h>

@interface MineHeaderView ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)KlcAvatarView *avaterBtn;//头像
@property (nonatomic, strong)UIImageView *genderAgeImgV;//年龄性别
@property(nonatomic,strong)UITextView *usernameTextView;//昵称
@property(nonatomic,strong)UILabel *signatureLabel;//签名
@property(nonatomic,strong)UILabel *IDLabel;//ID


@property(nonatomic,strong)UILabel *attentLabel;//关注
@property(nonatomic,strong)UILabel *fansLabel;//粉丝
@property(nonatomic,strong)UILabel *likeLabel;//点赞
@property(nonatomic,strong)UILabel *lookeMeLabel;//谁看过我
@property(nonatomic,strong)UILabel *mineTVLable;//我的剧集
@property(nonatomic,strong)UILabel *unreadLookmeLabel;
@property(nonatomic,weak)UIView *funcBgView;

@end


@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addUserInfoView];
    [self addBtnView];
    
    self.height = self.funcBgView.maxY+20;
}

- (void)addUserInfoView{
    //头像
    KlcAvatarView *avaterBtn = [[KlcAvatarView alloc]initWithFrame:CGRectMake(12, 0, 76, 76)];
    [avaterBtn addTarget:self action:@selector(avaterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.avaterBtn = avaterBtn;
    [self addSubview:self.avaterBtn];
    
    UIImageView *genderAgeImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    genderAgeImgV.centerY = avaterBtn.maxY;
    genderAgeImgV.centerX = avaterBtn.centerX;
    genderAgeImgV.layer.cornerRadius = 10;
    genderAgeImgV.clipsToBounds = YES;
    self.genderAgeImgV = genderAgeImgV;
    [self addSubview:genderAgeImgV];
    
    //昵称
    UITextView *userNameTextView = [[UITextView alloc]initWithFrame:CGRectMake(avaterBtn.maxX + 15, avaterBtn.y+3, self.width-130, 20)];
    userNameTextView.textAlignment = NSTextAlignmentLeft;
    userNameTextView.contentMode = UIViewContentModeLeft;
    userNameTextView.scrollEnabled = NO;
    userNameTextView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    userNameTextView.editable = NO;
    userNameTextView.textColor = kRGB_COLOR(@"#333333");
    userNameTextView.font = [UIFont boldSystemFontOfSize:18];
    self.usernameTextView = userNameTextView;
    [self addSubview:self.usernameTextView];
    
    //签名
    UILabel *signatureLabel = [[UILabel alloc]initWithFrame:CGRectMake(userNameTextView.x, avaterBtn.maxY-15-3, self.width-140, 15)];
    signatureLabel.textColor = kRGB_COLOR(@"#999999");
    signatureLabel.font = [UIFont systemFontOfSize:13];
    signatureLabel.numberOfLines = 0;
    signatureLabel.textAlignment = NSTextAlignmentLeft;
    self.signatureLabel = signatureLabel;
    [self addSubview:self.signatureLabel];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(userNameTextView.x, userNameTextView.maxY, 0.1, signatureLabel.y-userNameTextView.maxY)];
    [self addSubview:lineV];
    
    //ID
    UILabel *IDLabel = [[UILabel alloc]initWithFrame:CGRectMake(lineV.x, 0, 100, 15)];
    IDLabel.centerY = lineV.centerY;
    IDLabel.textColor = kRGB_COLOR(@"#999999");
    IDLabel.font = [UIFont systemFontOfSize:13];
    self.IDLabel = IDLabel;
    [self addSubview:self.IDLabel];
    
    //more
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-12-22, 0, 22, 37)];
    moreBtn.centerY = avaterBtn.centerY;
    [moreBtn setImage:[UIImage imageNamed:@"mineCenter_gray_more"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreBtn];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTap)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
}

- (void)addBtnView{
    
    UIView *functBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.avaterBtn.maxY+38, self.width, 50)];
    [self addSubview:functBgView];
    _funcBgView = functBgView;
    
    NSArray *showArr = [[ProjConfig shareInstence].businessConfig getMineCenterHeaderShowArray];
    
    CGFloat magin = 10;
    CGFloat width = (kScreenWidth-magin*8 -12*2)/(showArr.count * 1.0);
    for (int i = 0; i < showArr.count; i++) {
        
        NSDictionary *dic = showArr[i];
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(12+magin+i*(width+2*magin), 0, width, 25)];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.textColor = kRGB_COLOR(@"#131313");
        numLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightMedium];
        numLabel.text = @"0";
        [functBgView addSubview:numLabel];
        
        switch ([dic[@"type"] intValue]) {
            case 1:
                self.attentLabel = numLabel;
                break;
            case 2:
                self.fansLabel = numLabel;
                break;
            case 3:
                self.likeLabel = numLabel;
                break;
            case 4:
                self.lookeMeLabel = numLabel;
                break;
            case 6:
                self.mineTVLable = numLabel;
                break;
            default:
                break;
        }
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, numLabel.maxY+7, width, 20)];
        titleLabel.centerX = numLabel.centerX;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = kRGB_COLOR(@"#666666");
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.text = dic[@"title"];
        [functBgView addSubview:titleLabel];
        
        if ([dic[@"type"] intValue] == 4) {
            UILabel *unreadLookmeLabel = [[UILabel alloc]initWithFrame:CGRectMake(12+magin+i*(width+2*magin)+width-25 + 3, numLabel.y-9, 18, 18)];
            unreadLookmeLabel.backgroundColor = [UIColor redColor];
            unreadLookmeLabel.layer.cornerRadius = 9;
            unreadLookmeLabel.clipsToBounds = YES;
            unreadLookmeLabel.font = [UIFont systemFontOfSize:9];
            unreadLookmeLabel.textAlignment= NSTextAlignmentCenter;
            unreadLookmeLabel.textColor = [UIColor whiteColor];
            unreadLookmeLabel.text = @"0";
            unreadLookmeLabel.hidden = YES;
            self.unreadLookmeLabel = unreadLookmeLabel;
            [functBgView addSubview:self.unreadLookmeLabel];
            
        }
        
        if (i != (showArr.count-1)) {
            UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(numLabel.maxX+9, numLabel.y+10, 0.5, 20)];
            lineV.backgroundColor = kRGB_COLOR(@"#D8D8D8");
            [functBgView addSubview:lineV];
        }
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(numLabel.x, numLabel.y, width, functBgView.height)];
        btn.tag = 9891+[dic[@"type"] intValue];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(numDetailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [functBgView addSubview:btn];
    }
    
}

- (void)setVideoNum:(int)videoNum{
    _videoNum = videoNum;
    if ([ProjConfig isContainShortVideo] && [ProjConfig getAppType] != 4) {
        self.likeLabel.text = [NSString stringWithFormat:@"%d",videoNum];
    }
}

- (void)setUserModel:(ApiUserInfoMyHeadModel *)userModel {
    _userModel = userModel;
    
    ApiUserInfoModel *userInfo = userModel.userInfo;
    
    [self.avaterBtn showUserIconUrl:userInfo.avatar vipBorderUrl:userInfo.nobleAvatarFrame];
    
    //username
    //id 等级
    NSString *user_level = userInfo.userGradeImg;
    NSString *anchor_level = userInfo.anchorGradeImg;
    NSString *levelUrl = user_level;
    if (userInfo.role > 0) {
        levelUrl = anchor_level;
    }
    NSMutableAttributedString *nameAttri = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ ",userInfo.username]];
    

    //用户/主播等级
    if ([[ProjConfig shareInstence].baseConfig showUserLevelImage] && userInfo.userGradeImg.length > 0) {
        [nameAttri appendAttributedString:[self parserImgContext:levelUrl]];
    }
    ///财富等级
    if ([[ProjConfig shareInstence].baseConfig showWeathLevelImage] && userInfo.wealthGradeImg.length > 0) {
        [nameAttri appendAttributedString:[self parserImgContext:userInfo.wealthGradeImg]];
    }
    
    //贵族等级
    if (userInfo.nobleGradeImg.length > 0) {
        [nameAttri appendAttributedString:[self parserImgContext:userInfo.nobleGradeImg]];
    }
    
    
    ///设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;// 字体的行间距
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
        NSForegroundColorAttributeName:kRGB_COLOR(@"#333333"),
        NSParagraphStyleAttributeName:paragraphStyle
    };
    [nameAttri addAttributes:attributes range:NSMakeRange(0, nameAttri.length)];
    self.usernameTextView.attributedText = nameAttri;
    
    ///性别年龄
    self.genderAgeImgV.image = [[ProjConfig shareInstence].baseConfig imageGender:userInfo.sex age:userInfo.age role:-1];
    
    ///ID
    NSString *userId = [NSString stringWithFormat:@"ID:%lld ",userInfo.userId];
    if (userInfo.goodnum.length > 0 && userInfo.goodnum != nil && userInfo.goodnum != NULL ) {
        userId = [NSString stringWithFormat:kLocalizationMsg(@"靓号:%@"),userInfo.goodnum];
        self.IDLabel.textColor = kRGB_COLOR(@"#F6B86A");
    }else{
        self.IDLabel.textColor = kRGB_COLOR(@"#999999");
    }
    self.IDLabel.text = userId;
    
    ///签名
    if (userInfo.signature.length > 0) {
        self.signatureLabel.text = [NSString stringWithFormat:@"%@",userInfo.signature];
    }else{
        self.signatureLabel.text = [NSString stringWithFormat:kLocalizationMsg(@"这个家伙很懒，什么也没说...")];
    }
    
    self.attentLabel.text = [NSString stringWithFormat:@"%d",userModel.followNum];
    self.fansLabel.text = [NSString stringWithFormat:@"%d",userModel.fansNum];
    self.likeLabel.text = [NSString stringWithFormat:@"%d",userModel.likeNum];
    self.lookeMeLabel.text = [NSString stringWithFormat:@"%d",userModel.readMeUsersNumber];
    self.mineTVLable.text = [NSString stringWithFormat:@"%d",userModel.televisionNum];
}


- (NSMutableAttributedString *)parserImgContext:(NSString *)url{
    NSMutableAttributedString *itemAttrM = [[NSMutableAttributedString alloc] initWithString:@" "];
    __block NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    kWeakSelf(self);
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            attach.image = image;
            NSRange range = [weakself rangeOfAttachment:attach];
            if (range.location < weakself.usernameTextView.attributedText.length) {
                [weakself.usernameTextView.layoutManager invalidateLayoutForCharacterRange:range actualCharacterRange:NULL];
            }
        });
    }];
    attach.bounds = CGRectMake(3, -3, 36,18);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    
    //将图片插入到合适的位置
    [itemAttrM insertAttributedString:attachString atIndex:1];
    return itemAttrM;
}
- (NSRange)rangeOfAttachment:(NSTextAttachment *)attachment {
    __block NSRange ret;
    kWeakSelf(self);
    [self.usernameTextView.attributedText enumerateAttribute:NSAttachmentAttributeName
                                                     inRange:NSMakeRange(0, weakself.usernameTextView.attributedText.length)
                                                     options:0
                                                  usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (attachment == value) {
            ret = range;
            *stop = YES;
        }
    }];
    return ret;
}

- (void)setShow_lookRedPoint:(NSString *)show_lookRedPoint{
    _show_lookRedPoint = show_lookRedPoint;
    
    int64_t unlookNum = [show_lookRedPoint longLongValue];
    self.unreadLookmeLabel.hidden = !unlookNum;
    
    NSString *showStr = kStringFormat(@"%lld",unlookNum);
    if (unlookNum > 99) {
        showStr = @"99+";
    }
    self.unreadLookmeLabel.text = showStr;
}

#pragma mark - 按钮 手势
- (void)avaterBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MineHeaderView:userModel:)]) {
        [self.delegate MineHeaderView:self userModel:self.userModel.userInfo];
    }
}
- (void)moreBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MineHeaderView:userModel:)]) {
        [self.delegate MineHeaderView:self userModel:self.userModel.userInfo];
    }
}

- (void)headerTap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MineHeaderView:userModel:)]) {
        [self.delegate MineHeaderView:self userModel:self.userModel.userInfo];
    }
}

- (void)numDetailBtnClick:(UIButton *)btn{
    NSInteger type = (btn.tag-9891);
    if (self.delegate && [self.delegate respondsToSelector:@selector(MineHeaderView:funcType:userModel:)]) {
        [self.delegate MineHeaderView:self funcType:type userModel:self.userModel.userInfo];
    }
}
#pragma mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    
    return YES;
}



@end
