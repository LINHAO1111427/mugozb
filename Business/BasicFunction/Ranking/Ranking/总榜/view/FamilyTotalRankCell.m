//
//  FamilyTotalRankCell.m
//  Ranking
//
//  Created by ssssssss on 2020/12/24.
//  Copyright © 2020 KLC. All rights reserved.
//

#import "FamilyTotalRankCell.h"
#import <SDWebImage.h>
#import <LibTools/LibTools.h>
#import <LibProjBase/ProjConfig.h>
#import <LibProjBase/LibProjBase.h>

@interface FamilyTotalRankCell()

@property (nonatomic, weak)UIButton *indexBtn;
@property (nonatomic, weak)UIImageView *avaterImageV;
@property (nonatomic, weak)UILabel *nameL;
@property (nonatomic, weak)UILabel *numL;
@end

@implementation FamilyTotalRankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return self;
}
 
- (void)creatUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIButton *indexBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 25, 25, 25)];
    indexBtn.backgroundColor = [UIColor clearColor];
    indexBtn.enabled = NO;
    [indexBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
    indexBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:indexBtn];
    self.indexBtn = indexBtn;
    
    UIImageView *avaterImageV =[[UIImageView alloc]initWithFrame:CGRectMake(indexBtn.maxX+20, 0, 50, 50)];
    avaterImageV.centerY = indexBtn.centerY;
    avaterImageV.clipsToBounds = YES;
    avaterImageV.layer.cornerRadius = 25;
    avaterImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:avaterImageV];
    self.avaterImageV = avaterImageV;

    UILabel *nameL = [[UILabel alloc] init];
    nameL.textAlignment = NSTextAlignmentLeft;
    nameL.font = [UIFont systemFontOfSize:14];
    nameL.textColor = kRGB_COLOR(@"#333333");
    [self addSubview:nameL];
    self.nameL = nameL;
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avaterImageV.mas_right).offset(15);
        make.centerY.equalTo(avaterImageV);
    }];
    
    UIImageView *levelImgV =[[UIImageView alloc]init];
    levelImgV.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:levelImgV];
    self.levelImgV = levelImgV;
    [levelImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameL.mas_right).offset(4);
        make.centerY.equalTo(nameL);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UILabel *numL = [[UILabel alloc]init];
    numL.textAlignment = NSTextAlignmentRight;
    numL.font = [UIFont systemFontOfSize:13];
    numL.textColor = kRGB_COLOR(@"#333333");
    [self addSubview:numL];
    self.numL = numL;
    [numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avaterImageV);
        make.right.equalTo(self).offset(-20);
        make.left.equalTo(levelImgV.mas_right).offset(5);
    }];
    
 
    [numL setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:(UILayoutConstraintAxisHorizontal)];
    [nameL setContentHuggingPriority:UILayoutPriorityRequired forAxis:(UILayoutConstraintAxisHorizontal)];
    
    ///抗压缩
    [numL setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [nameL setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}


- (void)updateData:(int)index avater:(NSString *)avater username:(NSString *)username num:(CGFloat)num introduce:(nonnull NSString *)introduce{
    [self.indexBtn setTitle:@"" forState:UIControlStateNormal];
    if (index == 0) {
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_rank_99"] forState:UIControlStateNormal];
    }else if(index == 1){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank1"] forState:UIControlStateNormal];
    }else if(index == 2){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank2)"] forState:UIControlStateNormal];
    }else if(index == 3){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank3"] forState:UIControlStateNormal];
    }else{
        [self.indexBtn setImage:nil forState:UIControlStateNormal];
        [self.indexBtn setTitle:[NSString stringWithFormat:@"%d",index] forState:UIControlStateNormal];
    }
    
    [self.avaterImageV sd_setImageWithURL:[NSURL URLWithString:avater] placeholderImage:[ProjConfig getAppIcon]];
    self.nameL.text = username;

    NSString *numS = [NSString stringWithFormat:@"%.0f",num];
    self.numL.attributedText = [numS attachmentForImage:[ProjConfig getCoinImage] bounds:CGRectMake(0, -3, 15, 15) before:YES];
    self.levelImgV.image = nil;
    
}


@end
