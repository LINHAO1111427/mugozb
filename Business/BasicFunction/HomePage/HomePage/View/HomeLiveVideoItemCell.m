//
//  HomeLiveVideoItemCell.m
//  LibProjView
//
//  Created by ssssssssssss on 2020/11/2.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "HomeLiveVideoItemCell.h"
#import <LibProjModel/AppHomeHallDTOModel.h>
#import <Masonry/Masonry.h>

@interface HomeLiveVideoItemCell()

@property(nonatomic, weak)UIImageView *stateImgV; ///直播状态图标
@property(nonatomic, weak)UILabel *stateLab; ///直播状态


@property(nonatomic, weak)UIImageView *bgImageView;  ///主播图片
@property(nonatomic, weak)UILabel *lookNumL;   ///观看人数

@property(nonatomic, weak)UILabel *liveTitleL;   ///直播主题名
@property (nonatomic, weak)UILabel *categoryL; ///分类名称

@end


@implementation HomeLiveVideoItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)createUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    ///用户封面图
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.clipsToBounds = YES;
    imgV.layer.masksToBounds = YES;
    imgV.layer.cornerRadius = 10;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImageView = imgV;
    [self.contentView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    ///直播状态
    UIView *stateBgV = [[UIView alloc] init];
    stateBgV.backgroundColor = kRGBA_COLOR(@"#000000", 0.3);
    [self.contentView addSubview:stateBgV];
    stateBgV.layer.masksToBounds = YES;
    stateBgV.layer.cornerRadius = 10;
    [stateBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.right.equalTo(self.contentView).mas_offset(-5);
        make.top.equalTo(self.contentView).mas_offset(5);
    }];
    
    ///状态图标
    UIImageView *stateImgV = [[UIImageView alloc]init];
    [stateBgV addSubview:stateImgV];
    self.stateImgV = stateImgV;
    [stateImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 10));
        make.centerY.equalTo(stateBgV);
        make.left.equalTo(stateBgV).offset(6);
    }];
    
    ///状态名字
    UILabel *stateLab = [[UILabel alloc] initWithFrame:CGRectMake(12, self.height-24, 60, 18)];
    stateLab.font = [UIFont systemFontOfSize:12];
    stateLab.textAlignment = NSTextAlignmentRight;
    stateLab.text = kLocalizationMsg(@"休息");
    stateLab.textColor = [UIColor whiteColor];
    [stateBgV addSubview:stateLab];
    _stateLab = stateLab;
    [stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(stateBgV).offset(-6);
        make.centerY.equalTo(stateImgV);
    }];
    
    ///观看人数按钮
    UILabel *lookNumL =[[UILabel alloc]init];
    lookNumL.font = [UIFont systemFontOfSize:14];
    lookNumL.textAlignment = NSTextAlignmentRight;
    lookNumL.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    lookNumL.textColor = [UIColor whiteColor];
    [self.contentView addSubview:lookNumL];
    self.lookNumL = lookNumL;
    [lookNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(17);
    }];
    
    ///主播名称
    UILabel *liveTitleL =[[UILabel alloc]init];
    liveTitleL.font = [UIFont systemFontOfSize:14];
    liveTitleL.textColor = [UIColor whiteColor];
    [self.contentView addSubview:liveTitleL];
    self.liveTitleL = liveTitleL;
    [liveTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(lookNumL.mas_bottom);
        make.right.equalTo(lookNumL.mas_left).offset(-28);
        make.height.mas_equalTo(20);
    }];

    ///分类名称
    UILabel *categoryL =[[UILabel alloc]init];
    categoryL.font = [UIFont systemFontOfSize:12];
    categoryL.textColor = [UIColor whiteColor];
    [self.contentView addSubview:categoryL];
    self.categoryL = categoryL;
    [categoryL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(liveTitleL.mas_top).offset(-8);
        make.left.equalTo(liveTitleL);
        make.right.equalTo(lookNumL.mas_right);
    }];
}

- (void)setModel:(AppHomeHallDTOModel *)model{
    if (![model isKindOfClass:[AppHomeHallDTOModel class]]) {
        return;
    }
    _model = model;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.sourceCover] placeholderImage:PlaholderImage];
    self.categoryL.text = model.tabName;
    self.liveTitleL.text = model.title.length?model.title:@" ";
    
    NSString *lookNum = [NSString stringWithFormat:@"%d",model.nums];
    self.lookNumL.text = lookNum;
    CGSize size = [lookNum sizeWithAttributes:@{NSFontAttributeName:self.lookNumL.font}];
    [self.lookNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width+5);
    }];
    [self.lookNumL layoutIfNeeded];
    
    if (model.sourceState == 6) { ///直播中
        self.stateLab.text = kLocalizationMsg(@"直播");
        self.stateImgV.image = [UIImage imageNamed:@"videoLive_voice_rightup"];
    }else{
        self.stateLab.text = kLocalizationMsg(@"休息");
        self.stateImgV.image = [UIImage imageNamed:@"videoLive_voice_rest"];
    }
    [self setNeedsLayout];
}

@end
