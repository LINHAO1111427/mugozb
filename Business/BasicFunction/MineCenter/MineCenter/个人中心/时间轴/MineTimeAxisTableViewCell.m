//
//  MineTimeAxisTableViewCell.m
//  MineCenter
//
//  Created by ssssssss on 2019/12/23.
//

#import "MineTimeAxisTableViewCell.h"

@interface MineTimeAxisTableViewCell ()


@end
@implementation MineTimeAxisTableViewCell
- (instancetype)initWithIndexpath:(NSIndexPath *)indexPath timeAxisType:(TimeAxisType)type{
    self = [super init];
    if (self) {
        self.type = type;
        self.indexpath = indexPath;
        
    }
    return self;
}

- (void)setUserModel:(ApiUserInfoModel *)userModel{
    _userModel = userModel;
}

- (void)setTrendsRecordModel:(AppTrendsRecordModel *)trendsRecordModel{
    _trendsRecordModel = trendsRecordModel;
    [self updateUI];
}

- (NSString *)getYearBy:(AppTrendsRecordModel *)model{
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dataFormatter setTimeZone:tz];
    return [dataFormatter stringFromDate:model.createTime];
}

- (void)updateUI{
    [self.contentView removeAllSubViews];
    BOOL isAvater = NO;
    switch (self.trendsRecordModel.type) {
        case 1://新生啦
        case 2://发布第1条动态
        case 6://发布第1条短视频
        case 7://发起第1次视频直播
        case 8://发起第1次语音直播
        case 21://第1次发布私密动态
        case 23://第1次提现
            break;
        case 3://和TA第1次打招呼
        case 4://和TA聊天亲密值达到100
        case 5://第1次守护TA
        case 9://和TA第1次语音通话
        case 10://和TA第1次视频通话
        case 20://第1次认证成主播
        case 22://第1次被守护
            isAvater = YES;
            break;
        default:
            break;
    }
    CGFloat y = 10;
    if (self.isShowYear) {//年份
        UILabel *yearL = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+y, kScreenWidth-30, 20)];
        yearL.textAlignment = NSTextAlignmentLeft;
        yearL.font = [UIFont boldSystemFontOfSize:18];
        yearL.textColor = kRGB_COLOR(@"#333333");
        yearL.text = [self getYearBy:self.trendsRecordModel];
        [self.contentView addSubview:yearL];
        y += 70;
    }
    UIImageView *point = [[UIImageView alloc]initWithFrame:CGRectMake(15, y, 10, 10)];
    point.image = [UIImage imageNamed:@"icon_mine_time_axis_point"];
    [self.contentView addSubview:point];
    
    //时间
    UILabel *timeL = [[UILabel alloc]initWithFrame:CGRectMake(point.maxX+10, 0, 80, 20)];
    timeL.centerY = point.centerY;
    timeL.textAlignment = NSTextAlignmentLeft;
    timeL.font = [UIFont boldSystemFontOfSize:14];
    timeL.textColor = [ProjConfig normalColors];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"MM/dd"];
    NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dataFormatter setTimeZone:tz];
    timeL.text = [dataFormatter stringFromDate:self.trendsRecordModel.createTime];
    [self.contentView addSubview:timeL];
    y += 30;
    
    //标题
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(point.maxX+10, timeL.maxY, kScreenWidth-150, 40)];
    titleL.textColor = kRGB_COLOR(@"#333333");
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textAlignment = NSTextAlignmentLeft;
    titleL.numberOfLines = 0;
    titleL.text = self.trendsRecordModel.title;
    [self.contentView addSubview:titleL];
    y += 40;
    
    //右边图片
    UIImageView *showImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-75, 0, 60, 60)];
    showImageV.centerY = titleL.centerY;
    showImageV.contentMode = UIViewContentModeScaleAspectFill;
    showImageV.layer.cornerRadius = 8;
    showImageV.clipsToBounds = YES;
    showImageV.userInteractionEnabled = YES;
    NSString *imageUrl = self.trendsRecordModel.source;
    if (self.trendsRecordModel.type == 2 || self.trendsRecordModel.type == 21) {//头像
        imageUrl = [imageUrl componentsSeparatedByString:@","].firstObject;
    }
    [showImageV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[ProjConfig getDefaultImage]];
    [self.contentView addSubview:showImageV];

    if (self.trendsRecordModel.type == 7 || self.trendsRecordModel.type == 8) {//第一次直播
        UIImageView *liveImagev = [[UIImageView alloc]initWithFrame:CGRectMake(5, 40, 15, 15)];
        liveImagev.image = [UIImage imageNamed:@"icon_mine_time_axis_live"];
        liveImagev.contentMode = UIViewContentModeScaleAspectFit;
        [showImageV addSubview:liveImagev];
    }
    if (isAvater) {
        UIButton *avaterBtn = [[UIButton alloc]initWithFrame:showImageV.bounds];
        avaterBtn.backgroundColor = [UIColor clearColor];
        [avaterBtn addTarget:self action:@selector(avaterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [showImageV addSubview:avaterBtn];
    }
    
    //内容
    if (self.trendsRecordModel.reserve1.length > 0) {
        CGFloat height = 0;
        CGSize size = [self.trendsRecordModel.reserve1 boundingRectWithSize:CGSizeMake(kScreenWidth-150, MAXFLOAT) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
        if (size.height+8 < 40) {
            height = 40;
        }else{
            height = size.height+8;
        }
        UILabel *contentL = [[UILabel alloc]initWithFrame:CGRectMake(point.maxX+10, titleL.maxY, kScreenWidth-150, height)];
        contentL.textAlignment = NSTextAlignmentLeft;
        contentL.font = [UIFont systemFontOfSize:12];
        contentL.numberOfLines = 0;
        contentL.textColor = kRGB_COLOR(@"#999999");
        contentL.text = self.trendsRecordModel.reserve1;
        [self.contentView addSubview:contentL];
    }
    
    //聊天按钮
    if (self.trendsRecordModel.type == 3 || self.trendsRecordModel.type == 4 || self.trendsRecordModel.type == 5) {
        NSString *str = @"";
        CGFloat width = 110;
        if (self.trendsRecordModel.type == 3) {//和TA第1次打招呼
            str = kLocalizationMsg(@"远离默默守护的好人卡 >");
            width = 150;
        }else if(self.trendsRecordModel.type == 4){//和TA聊天亲密值达到100
            str = kLocalizationMsg(@"问问Ta的近况 >");
            width = 110;
        }else if(self.trendsRecordModel.type == 5){//第1次守护TA
            str = kLocalizationMsg(@"聊聊共同兴趣 >");
            width = 110;
        }
        
        UIButton *actionBtn = [[UIButton alloc]initWithFrame:CGRectMake(point.maxX+10, y, width, 30)];
        actionBtn.backgroundColor = kRGB_COLOR(@"#FFF1F8");
        actionBtn.layer.cornerRadius = 15;
        actionBtn.clipsToBounds = YES;
        actionBtn.layer.borderWidth = 1.0;
        actionBtn.layer.borderColor = [ProjConfig normalColors].CGColor;
        actionBtn.tag = self.trendsRecordModel.type;
        [actionBtn setTitleColor:[ProjConfig normalColors] forState:UIControlStateNormal];
        [actionBtn addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        actionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [actionBtn setTitle:str forState:UIControlStateNormal];
        [self.contentView addSubview:actionBtn];
    }
     
    // 竖线
    UIView *lineDown = [[UIView alloc]initWithFrame:CGRectMake(20, point.maxY, 0.3, self.cell_height-point.maxY-20)];
    lineDown.backgroundColor = kRGB_COLOR(@"#EEEEEE");
    [self.contentView addSubview:lineDown];
    
}
- (void)avaterBtnClick:(UIButton *)btn{
   // NSLog(@"过滤文字点击了头像"));
    if (self.delegate && [self.delegate respondsToSelector:@selector(MineTimeAxisTableViewCellAvaterBtnClick:)]) {
        [self.delegate MineTimeAxisTableViewCellAvaterBtnClick:self.trendsRecordModel];
    }
}
- (void)actionBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MineTimeAxisTableViewCellActionBtnClick:index:)]) {
        [self.delegate MineTimeAxisTableViewCellActionBtnClick:self.trendsRecordModel index:btn.tag];
    }
}
@end
