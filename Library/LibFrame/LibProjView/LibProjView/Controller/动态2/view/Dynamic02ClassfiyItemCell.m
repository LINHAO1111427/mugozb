//
//  Dynamic02ClassfiyItemCell.m
//  klcLive
//
//  Created by SWH05 on 2022/2/14.
//  Copyright © 2022 KLC. All rights reserved.
//

#import "Dynamic02ClassfiyItemCell.h"
#import <LibProjModel/ApiUserVideoModel.h>
#import <LibProjView/DynamicShowPhotoView.h>

@implementation Dynamic02ClassfiyItemCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setVideoModel:(ApiUserVideoModel *)videoModel{
    _videoModel = videoModel;
    
    _dayL.text = [self getDayStr:videoModel.addtime];
    _monthL.text = [self getMonthStr:videoModel.addtime];
    
    if (videoModel.uid == [ProjConfig userId]) {
        self.moreBtn.hidden = NO;
    }else{
        self.moreBtn.hidden = YES;
    }
    
    ///是否显示评论按钮
    _commitBtn.hidden = ![[ProjConfig shareInstence].baseConfig hasDynamicComment];
    
    if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance] && videoModel.hidePublishingAddress == 0) {
        _addressL.hidden = NO;
        ///显示地址
        if (videoModel.city.length > 0 || videoModel.address.length>0) {
            _addressL.attributedText = [[NSString stringWithFormat:@"%@·%@",videoModel.city,videoModel.address] attachmentForImage:[UIImage imageNamed:@"dynamic_list_mini_position"] bounds:CGRectMake(0, -2, 12, 12) before:YES];
        }else{
            _addressL.attributedText = [@"" attachmentForImage:[UIImage imageNamed:@"dynamic_list_mini_position"] bounds:CGRectMake(0, 0, 12, 12) before:YES];
        }
    }else{
        _addressL.hidden = YES;
    }
    
    _contentW = kScreenWidth-80-10;
    
    NSString *zanImgStr = videoModel.isLike > 0?@"dynamic_list_mini_liked":@"dynamic_list_mini_like";
    [_zanBtn setAttributedTitle:[[NSString stringForCompressNum:videoModel.likes] attachmentForImage:[UIImage imageNamed:zanImgStr] bounds:CGRectMake(0, -3, 15, 15) before:YES textFont:[UIFont systemFontOfSize:12] textColor:kRGBA_COLOR(@"#999999", 1.0)] forState:UIControlStateNormal];
    [_commitBtn setAttributedTitle:[[NSString stringForCompressNum:videoModel.comments] attachmentForImage:[UIImage imageNamed:@"dynamic_list_mini_comment"] bounds:CGRectMake(0, -3, 15, 15) before:YES textFont:[UIFont systemFontOfSize:12] textColor:kRGBA_COLOR(@"#999999", 1.0)] forState:UIControlStateNormal];
    
    ///数据基础
    _textL.text = @"";
    _videoLabBtn.hidden = YES;
    _labH.constant = 0;
    _contentBgVTop.constant = 0.0;
    _contentBgVHeight.constant = 0.0;
    _bottomVTop.constant = 0;
    
    ///有话题
    if (videoModel.topicName.length > 0) {
        _videoLabBtn.hidden = NO;
        [_videoLabBtn setTitle:[NSString stringWithFormat:@"# %@",videoModel.topicName] forState:UIControlStateNormal];
        ///如果有话题，文本内容首先高度等于话题
        _labH.constant = 30;
    }
    ///有标题
    if (_videoModel.title.length > 0) {
        ///如果有话题
        _textL.text = _videoModel.title;
        
        ///多媒体内容只针对文本的距离
        _contentBgVTop.constant = 10.0;
    }
    ///有多媒体内容 ：0:只有文字 1:视频动态 2:图片动态）
    switch (videoModel.type) {
        case 1:
        {
            [self showVideoView:videoModel.href thumb:videoModel.thumb time:videoModel.videoTime];
        }
            break;
        case 2:
        {
            [self showImageView:videoModel.images];
        }
            break;
        default:
        {
            [_contentBgV removeAllSubViews];
        }
            break;
    }
    if ([[ProjConfig shareInstence].baseConfig appAllShowAddressAndDistance] && videoModel.hidePublishingAddress == 0) {
        _bottomVTop.constant = 25;
    }else{
        _bottomVTop.constant = 0;
    }

    
    kWeakSelf(self);
    _contentBgV.userInteractionEnabled = YES;
    [_contentBgV klc_whenTapped:^{
        if (weakself.delegate && [self.delegate respondsToSelector:@selector(dynamicClassfiyItemCell:showDynamicDetail:)]) {
            [weakself.delegate dynamicClassfiyItemCell:weakself showDynamicDetail:weakself.videoModel];
        }
    }];
    
    [_shareBtn klc_whenTapped:^{
        if (weakself.delegate && [self.delegate respondsToSelector:@selector(dynamicClassfiyItemCell:shareBtnClick:)]) {
            [weakself.delegate dynamicClassfiyItemCell:weakself shareBtnClick:weakself.videoModel];
        }
    }];
    
    [_zanBtn klc_whenTapped:^{
        if (weakself.delegate && [self.delegate respondsToSelector:@selector(dynamicClassfiyItemCell:zanBtnClick:)]) {
            [weakself.delegate dynamicClassfiyItemCell:weakself zanBtnClick:weakself.videoModel];
        }
    }];
    [_commitBtn klc_whenTapped:^{
        if (weakself.delegate && [self.delegate respondsToSelector:@selector(dynamicClassfiyItemCell:commitBtnClick:)]) {
            [weakself.delegate dynamicClassfiyItemCell:weakself commitBtnClick:weakself.videoModel];
        }
    }];
}
- (NSString *)getMonthStr:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitMonth  fromDate:date];
    NSInteger month = [components month];
    NSArray *monthes = @[kLocalizationMsg(@"一月"),kLocalizationMsg(@"二月"),kLocalizationMsg(@"三月"),kLocalizationMsg(@"四月"),kLocalizationMsg(@"五月"),kLocalizationMsg(@"六月"),kLocalizationMsg(@"七月"),kLocalizationMsg(@"八月"),kLocalizationMsg(@"九月"),kLocalizationMsg(@"十月"),kLocalizationMsg(@"十一月"),kLocalizationMsg(@"十二月")];
    return monthes[month-1];
}
- (NSString*)getDayStr:(NSDate*)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date];
    NSInteger day = [components day];
    return [NSString stringWithFormat:@"%ld",(long)day];
}
///动态标签按钮
- (IBAction)videoLabBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicClassfiyItemCell:dynamicLabClick:)]) {
        [self.delegate dynamicClassfiyItemCell:self dynamicLabClick:self.videoModel];
    }
}
- (IBAction)moreBtnClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dynamicClassfiyItemCell:moreBtnClick:)]) {
        [self.delegate dynamicClassfiyItemCell:self moreBtnClick:self.videoModel];
    }
}

#pragma mark - 显示图片 -
- (void)showImageView:(NSString *)images{
    
    [_contentBgV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSArray *imgArr = [images componentsSeparatedByString:@","];
    NSString *lastUrl = imgArr.lastObject;
    if([lastUrl isEmpty]){
        imgArr = [imgArr subarrayWithRange:NSMakeRange(0, imgArr.count-1)];
    }
    
    if (imgArr.count > 0) {
        DynamicShowPhotoView *showPhotoV = [[DynamicShowPhotoView alloc] initWithFrame:CGRectMake(0, 0, _contentW, 100)];
        showPhotoV.imageArr = imgArr;
        showPhotoV.userInteractionEnabled = NO;
        [_contentBgV addSubview:showPhotoV];
        _contentBgVHeight.constant = showPhotoV.height;
    }
}

#pragma mark - 显示视频 -
- (void)showVideoView:(NSString *)videoUrl thumb:(NSString *)thumb time:(NSString *)time{
    
    [_contentBgV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *videoBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 175, 233)];
    videoBgView.layer.masksToBounds = YES;
    videoBgView.layer.cornerRadius = 4;
    videoBgView.userInteractionEnabled = NO;
    [_contentBgV addSubview:videoBgView];
    
    //图片
    UIImageView *preview = [[UIImageView alloc] initWithFrame:videoBgView.bounds];
    [preview sd_setImageWithURL:[NSURL URLWithString:thumb]];
    preview.userInteractionEnabled = YES;
    preview.layer.cornerRadius = 4;
    preview.contentMode = UIViewContentModeScaleAspectFill;
    [videoBgView addSubview:preview];
    
    UIImageView *playV = [[UIImageView alloc] initWithFrame:CGRectMake(videoBgView.frame.size.width/2 - 20,videoBgView.frame.size.height/2 - 20, 40, 40)];
    playV.image = [UIImage imageNamed:@"dynamic_video_play"];
    [videoBgView addSubview:playV];
    
    _contentBgVHeight.constant = 233.0;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
