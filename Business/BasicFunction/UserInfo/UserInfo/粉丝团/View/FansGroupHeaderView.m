//
//  FansGroupHeaderView.m
//  Fans
//
//  Created by klc on 2020/3/18.
//

#import "FansGroupHeaderView.h"
#import <LibProjModel/HttpApiAnchorController.h>
#import <LibProjBase/ProjConfig.h>

@interface FansGroupHeaderView ()

@property (nonatomic,strong)UILabel *joinCoinLable;

@property (nonatomic,strong)UIButton *nameBtn;  ///粉丝团名称
@property (nonatomic,strong)UILabel *coinNumLable;//打赏金额
@property (nonatomic,strong)UILabel *fansNumLable;//粉丝人数

@end

@implementation FansGroupHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width * 255/375.0)];
    imageV.userInteractionEnabled = YES;
    imageV.image = [UIImage imageNamed:@"fans_header_bg"];
    [self addSubview:imageV];
    
    kWeakSelf(self);
    UIImageView *userIconV = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-60)/2.0, 70-20+kStatusBarHeight, 60, 60)];
    userIconV.layer.cornerRadius = 30;
    userIconV.layer.masksToBounds = YES;
    userIconV.layer.borderWidth = 1.0;
    userIconV.layer.borderColor = [UIColor whiteColor].CGColor;
    userIconV.userInteractionEnabled = YES;
    [userIconV klc_whenTapped:^{
        if (weakself.delegate) {
            [weakself.delegate setFansGroupIconClick];
        }
    }];
    [imageV addSubview:userIconV];
    _userIconV = userIconV;
    
    UIButton *nameBtn = [UIButton buttonWithType:0];
    [nameBtn addTarget:self action:@selector(nameLableTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [nameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [imageV addSubview:nameBtn];
    _nameBtn = nameBtn;
    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userIconV.mas_bottom).offset(11);
        make.centerX.equalTo(userIconV);
        make.height.mas_equalTo(25);
    }];
    [nameBtn layoutIfNeeded];
    
    ///设置入团金额
    UIView *joinCoinBgView = [[UIView alloc] initWithFrame:CGRectMake(15, imageV.maxY-50, self.width-30, 65)];
    {
        joinCoinBgView.backgroundColor = [UIColor whiteColor];
        joinCoinBgView.alpha = 1;
        // Shadow Code
        joinCoinBgView.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:94/255.0 blue:198/255.0 alpha:0.10].CGColor;
        joinCoinBgView.layer.shadowOffset = CGSizeMake(0,2);
        joinCoinBgView.layer.shadowRadius = 10;
        joinCoinBgView.layer.shadowOpacity = 1;
        // Radius Code
        joinCoinBgView.layer.cornerRadius = 10;
        [self addSubview:joinCoinBgView];
        
        UIView *centerV = [[UIView alloc] init];
        [joinCoinBgView addSubview:centerV];
        [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(joinCoinBgView);
        }];
        UILabel *joinTitleL = [[UILabel alloc] init];
        joinTitleL.text = kLocalizationMsg(@"入团金额");
        joinTitleL.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        joinTitleL.textColor = kRGBA_COLOR(@"#333333", 1.0);
        [centerV addSubview:joinTitleL];
        [joinTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(centerV);
            make.size.mas_equalTo(CGSizeMake(70, 21));
        }];
        UIButton *modifyCoinBtn = [UIButton buttonWithType:0];
        [modifyCoinBtn setTitle:kLocalizationMsg(@"点击修改") forState:UIControlStateNormal];
        [modifyCoinBtn addTarget:self action:@selector(coinLableTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [modifyCoinBtn setTitleColor:kRGB_COLOR(@"#666666") forState:UIControlStateNormal];
        modifyCoinBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [centerV addSubview:modifyCoinBtn];
        [modifyCoinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(centerV);
            make.size.mas_equalTo(CGSizeMake(50, 21));
        }];
        
        UILabel *joinCoinL = [[UILabel alloc] init];
        joinCoinL.textAlignment = NSTextAlignmentCenter;
        joinCoinL.attributedText = [@"0" attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -1, 15, 15) before:NO];
        joinCoinL.font = [UIFont boldSystemFontOfSize:18];
        joinCoinL.textColor = [ProjConfig normalColors];
        [centerV addSubview:joinCoinL];
        _joinCoinLable = joinCoinL;
        [joinCoinL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(joinTitleL.mas_right).offset(5);
            make.right.equalTo(modifyCoinBtn.mas_left).offset(-15);
            make.centerY.equalTo(joinTitleL);
        }];
    }
    
    ///粉丝团人数
    CGFloat viewWidth = (self.width-30-15)/2.0;
    UIView *numV = [self createSubViewForFans:CGRectMake(15, joinCoinBgView.maxY+20, viewWidth, viewWidth*90/165.0) title:kLocalizationMsg(@"粉丝团人数") bgImageStr:@"fans_num_bg" index:0];
    [self addSubview:numV];
    
    ///粉丝团大赏
    UIView *coinV = [self createSubViewForFans:CGRectMake(numV.maxX+15, joinCoinBgView.maxY+20, viewWidth, viewWidth*90/165.0) title:kLocalizationMsg(@"粉丝团打赏") bgImageStr:@"fans_contribution_bg" index:1];
    [self addSubview:coinV];
    
    self.height = coinV.maxY + 20;
}

- (UIView *)createSubViewForFans:(CGRect)frame title:(NSString *)title bgImageStr:(NSString *)bgImageStr index:(int)index{
    
    UIImageView *fansBgImgV = [[UIImageView alloc] initWithFrame:frame];
    fansBgImgV.image = [UIImage imageNamed:bgImageStr];
    [self addSubview:fansBgImgV];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, frame.size.width-30, 20)];
    titleLable.textColor = kRGB_COLOR(@"#333333");
    titleLable.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    titleLable.text = title;
    [fansBgImgV addSubview:titleLable];
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(15, titleLable.maxY+10, titleLable.width, 20)];
    numLab.textColor = [ProjConfig normalColors];
    numLab.font = [UIFont boldSystemFontOfSize:18];
    [fansBgImgV addSubview:numLab];
    
    if (index) {
        ///打赏金额
        _coinNumLable = numLab;
    }else{
        ///粉丝人数
        _fansNumLable = numLab;
    }
    return fansBgImgV;
}


- (void)setFansInfoModel:(FansInfoDtoModel *)fansInfoModel{
    _fansInfoModel = fansInfoModel;
    
    [_userIconV sd_setImageWithURL:[NSURL URLWithString:fansInfoModel.fansTeamAvatar] placeholderImage:[ProjConfig getDefaultImage]];
    [_nameBtn setAttributedTitle:[fansInfoModel.fansTeamName attachmentForImage:[UIImage imageNamed:@"userInfo_edite_btn"] bounds:CGRectMake(0, 0, 12, 12) before:NO textFont:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium] textColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    _fansNumLable.text = [NSString stringWithFormat:@"%d",fansInfoModel.fansNum];
    _coinNumLable.attributedText = [[NSString stringWithFormat:@"%0.0lf",fansInfoModel.totalCoin] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -1, 15, 15) before:NO];
    
    _joinCoinLable.attributedText = [[NSString stringWithFormat:@"%.0lf",fansInfoModel.coin] attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -1, 15, 15) before:NO];
}







- (void)nameLableTouchUpInside:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(setFansGroupNameClick:)]) {
        [self.delegate setFansGroupNameClick:self.fansInfoModel.fansTeamName];
    }
    
}

- (void)coinLableTouchUpInside:(UIButton *)btn{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(setFansGroupCoinClick:)]) {
        [self.delegate setFansGroupCoinClick:[NSString stringWithFormat:@"%.0f",self.fansInfoModel.coin]];
    }
    
}

@end
