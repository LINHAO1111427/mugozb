//
//  LiveVideoCollectionViewCell.m
//  LibProjView
//
//  Created by ssssssssssss on 2020/11/2.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "LiveVideoCollectionViewCell.h"
#import <LibProjModel/AppHomeHallDTOModel.h>


@interface LiveVideoCollectionViewCell()
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIButton *leftUpBtn;
@property(nonatomic,strong)UIImageView *leftBottomImage;

@property (nonatomic, strong)UILabel *liveStateL; ///视频直播状态
@property (nonatomic, strong)UIImageView *LiveStateImgV;  ///其他状态图标

@property(nonatomic,strong)UILabel *leftBottomLabel;
@property (nonatomic, strong)UILabel *rightBottmL;

@property (nonatomic, copy)UIImage *voiceChannelTypeBgImg; ///语音频道背景图片

@property (nonatomic, copy)UIImage *videoChannelTypeBgImg; ///视频频道背景图片

@end

@implementation LiveVideoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.LiveStateImgV mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.model.liveType == 1 && !self.model.liveFunction) {
            make.size.mas_equalTo(CGSizeMake(49, 22));
        }else{
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }
    }];
}


- (void)createUI{
    
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.clipsToBounds = YES;
    imgV.layer.masksToBounds = YES;
    imgV.layer.cornerRadius = 4.0;
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:imgV];
    self.bgImageView = imgV;
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    UIButton *leftUpBtn = [[UIButton alloc] init];
    leftUpBtn.layer.cornerRadius = 11;
    leftUpBtn.clipsToBounds = YES;
    leftUpBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    leftUpBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
    [leftUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftUpBtn.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:leftUpBtn];
    self.leftUpBtn = leftUpBtn;
    [leftUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).inset(5);
        make.height.mas_equalTo(22);
    }];
    
    UIImageView *rightUpImgV = [[UIImageView alloc] init];
    rightUpImgV.frame = CGRectMake(self.width-55, 5, 49, 22);
    rightUpImgV.clipsToBounds = YES;
    self.LiveStateImgV = rightUpImgV;
    [self.contentView addSubview:rightUpImgV];
    [rightUpImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(49, 22));
        make.top.right.equalTo(self.contentView).inset(5);
    }];
    
    UIImageView *leftBottomImageV = [[UIImageView alloc] init];
    leftBottomImageV.layer.masksToBounds = YES;
    leftBottomImageV.layer.cornerRadius = 10;
    self.leftBottomImage = leftBottomImageV;
    [self.contentView addSubview:leftBottomImageV];
    [leftBottomImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.left.bottom.equalTo(self.contentView).inset(5);
    }];
    
    UILabel *rightBottmL = [[UILabel alloc] init];
    rightBottmL.font = [UIFont systemFontOfSize:12];
    rightBottmL.textAlignment = NSTextAlignmentRight;
    rightBottmL.textColor = [UIColor whiteColor];
    [rightBottmL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [rightBottmL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:rightBottmL];
    self.rightBottmL = rightBottmL;
    [rightBottmL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(leftBottomImageV.mas_height);
        make.right.bottom.equalTo(self.contentView).inset(5);
    }];
    
    UIView *nameBgV = [[UIView alloc] init];
    nameBgV.backgroundColor =kRGBA_COLOR(@"#000000", 0.5);
    nameBgV.clipsToBounds = YES;
    nameBgV.layer.cornerRadius = 10;
    [self.contentView addSubview:nameBgV];
    [self.contentView insertSubview:nameBgV belowSubview:leftBottomImageV];
    [nameBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBottomImageV.mas_right).inset(-10);
        make.right.mas_lessThanOrEqualTo(rightBottmL.mas_left).inset(5);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(leftBottomImageV);
    }];
    
    UILabel *leftBottomLabel = [[UILabel alloc] init];
    leftBottomLabel.font = [UIFont systemFontOfSize:13];
    [leftBottomLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [leftBottomLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    leftBottomLabel.textColor = [UIColor whiteColor];
    self.leftBottomLabel = leftBottomLabel;
    [nameBgV addSubview:leftBottomLabel];
    [leftBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameBgV).inset(12);
        make.right.equalTo(nameBgV).inset(4);
        make.top.bottom.equalTo(nameBgV);
    }];
}


- (UILabel *)liveStateL{
    if (!_liveStateL) {
        UILabel *liveStateL = [[UILabel alloc] init];
        liveStateL.font = [UIFont systemFontOfSize:12];
        liveStateL.layer.masksToBounds = YES;
        liveStateL.layer.cornerRadius = 11;
        liveStateL.textColor = [UIColor whiteColor];
        liveStateL.textAlignment = NSTextAlignmentCenter;
        [_LiveStateImgV addSubview:liveStateL];
        _liveStateL = liveStateL;
        [liveStateL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_LiveStateImgV);
        }];
    }
    return _liveStateL;
}


- (void)setModel:(AppHomeHallDTOModel *)model{
    if (![model isKindOfClass:[AppHomeHallDTOModel class]]) {
        return;
    }
    _model = model;
    [self.LiveStateImgV stopAnimating];
    self.liveStateL.text = @"";
    self.liveStateL.backgroundColor = [UIColor clearColor];
    if(model.liveType ==2){ ///语音
        self.LiveStateImgV.layer.cornerRadius = 0.1;
        [self.leftUpBtn setBackgroundImage:self.voiceChannelTypeBgImg forState:UIControlStateNormal];
        
        self.LiveStateImgV.contentMode = UIViewContentModeScaleAspectFit;
        self.LiveStateImgV.image = [UIImage imageNamed:@"message_play_0"];
        self.LiveStateImgV.animationDuration = 0.6;
        self.LiveStateImgV.animationRepeatCount = 0;
        self.LiveStateImgV.animationImages = [self getNoRepeatRandomArrayWithMinNum:0 maxNum:9 count:5];
        
        [self.LiveStateImgV startAnimating];
        self.leftBottomImage.image = [UIImage imageNamed:@"videoLive_voice_leftBottom"];
        
    }else{ ///视频
        self.LiveStateImgV.layer.cornerRadius = 11;
        if (self.model.liveFunction) {
            self.LiveStateImgV.image = [UIImage imageNamed:@"shop_home_flag"];
        }else{
            self.liveStateL.backgroundColor = kRGBA_COLOR(@"#000000", 0.3);
            self.LiveStateImgV.image = nil;
            if (model.sourceState == 6) { ///直播中
                self.liveStateL.attributedText = [kLocalizationMsg(@"直播") attachmentForImage:[UIImage imageNamed:@"videoLive_voice_rightup"] bounds:CGRectMake(0, -1, 10, 10) before:YES];
            }else{
                self.liveStateL.attributedText = [kLocalizationMsg(@"休息") attachmentForImage:[UIImage imageNamed:@"videoLive_voice_rest"] bounds:CGRectMake(0, -1, 10, 10) before:YES];
            }
        }
        [self.leftUpBtn setBackgroundImage:self.videoChannelTypeBgImg forState:UIControlStateNormal];
        if (self.model.liveFunction) {
            if (model.businessLogo.length > 0) {
                [self.leftBottomImage sd_setImageWithURL:[NSURL URLWithString:model.businessLogo] placeholderImage:[ProjConfig getAppIcon]];
            }else{
                self.leftBottomImage.image = [ProjConfig getAppIcon];
            }
        }else{
            self.leftBottomImage.image = [UIImage imageNamed:@"videoLive_live_leftBottom"];
        }
    }
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.sourceCover] placeholderImage:PlaholderImage];
    [self.leftUpBtn setTitle:[NSString stringWithFormat:@"%@",model.tabName] forState:UIControlStateNormal];
    self.leftUpBtn.hidden = model.tabName.length > 0?NO:YES;
    self.leftBottomLabel.text = model.title;
    self.rightBottmL.attributedText = [[NSString stringWithFormat:@"%d",model.nums] attachmentForImage:[UIImage imageNamed:@"videoLive_live_lookNum"] bounds:CGRectMake(0, -3, 14, 14) before:YES];
    [self setNeedsLayout];
}



//随机数组
- (NSMutableArray *)getNoRepeatRandomArrayWithMinNum:(NSInteger)min maxNum:(NSInteger )max count:(NSInteger)count{
    NSMutableSet *set = [NSMutableSet setWithCapacity:count];
    while (set.count < count) {
        NSInteger value = arc4random() % (max-min+1) + min;
        [set addObject:[UIImage imageNamed:[NSString stringWithFormat:@"message_play_%ld",(long)value]]];
    }
    NSMutableArray *arr = [self getRandomArrFrome:set.allObjects];
    return arr;
}


-(NSMutableArray*)getRandomArrFrome:(NSArray*)arr{
    NSMutableArray *newArr = [NSMutableArray new];
    while (newArr.count != arr.count) {
        //生成随机数
        int x =arc4random() % arr.count;
        id obj = arr[x];
        if (![newArr containsObject:obj]) {
            [newArr addObject:obj];
        }
    }
    return newArr;
}


- (UIImage *)voiceChannelTypeBgImg{
    if (!_voiceChannelTypeBgImg) {
        _voiceChannelTypeBgImg = [[UIImage createImageSize:CGSizeMake(40, 20) gradientColors:@[ kRGBA_COLOR(@"#FFA8A8", 0.8), kRGBA_COLOR(@"#FCFF00",0.8)] percentage:@[@0.1,@1.0] gradientType:GradientFromLeftToRight] imageAlpha:0.7];
    }
    return _voiceChannelTypeBgImg;
}

- (UIImage *)videoChannelTypeBgImg{
    if (!_videoChannelTypeBgImg) {
        _videoChannelTypeBgImg = [[UIImage createImageSize:CGSizeMake(40, 20) gradientColors:@[ kRGBA_COLOR(@"#FF479B", 0.8), kRGBA_COLOR(@"#FF6F6F",0.8)] percentage:@[@0.1,@1.0] gradientType:GradientFromLeftToRight] imageAlpha:0.7];
    }
    return _videoChannelTypeBgImg;
}


@end
