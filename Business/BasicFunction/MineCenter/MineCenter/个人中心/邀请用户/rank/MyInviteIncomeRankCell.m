//
//  MyInviteIncomeRankCell.m
//  MineCenter
//
//  Created by klc on 2020/7/31.
//

#import "MyInviteIncomeRankCell.h"
#import <LibProjModel/AppUserIncomeRankingDtoModel.h>

@interface MyInviteIncomeRankCell ()
@property (nonatomic, strong)UIButton *indexBtn;
@property (nonatomic, strong)UIImageView *avaterImageV;
@property (nonatomic, strong)UILabel *nameL;
@property (nonatomic, strong)UILabel *numL;
@property (nonatomic, strong)UILabel *moneyL;
@end

@implementation MyInviteIncomeRankCell
 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    
    UIButton *indexBtn = [[UIButton alloc]init];
    indexBtn.backgroundColor = [UIColor clearColor];
    indexBtn.enabled = NO;
    [indexBtn setTitleColor:kRGB_COLOR(@"#333333") forState:UIControlStateNormal];
    indexBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.indexBtn = indexBtn;
    [self.contentView addSubview:indexBtn];
    [indexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).inset(20);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    UIImageView *avaterImageV =[[UIImageView alloc]init];
    avaterImageV.centerY = indexBtn.centerY;
    avaterImageV.clipsToBounds = YES;
    avaterImageV.layer.cornerRadius = 25;
    avaterImageV.contentMode = UIViewContentModeScaleAspectFill;
    self.avaterImageV = avaterImageV;
    [self.contentView addSubview:avaterImageV];
    [avaterImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(indexBtn.mas_right).inset(20);
        make.centerY.equalTo(indexBtn);
    }];
    
    
    UILabel *nameL = [[UILabel alloc] init];
    nameL.textAlignment = NSTextAlignmentLeft;
    nameL.font = [UIFont systemFontOfSize:14];
    nameL.textColor = kRGB_COLOR(@"#333333");
    nameL.centerY =avaterImageV.centerY;
    [nameL setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [nameL setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    self.nameL = nameL;
    [self.contentView addSubview:nameL];
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avaterImageV.mas_right).inset(20);
        make.centerY.equalTo(avaterImageV);
    }];
    
    UIView *centerV = [[UIView alloc] init];
    [self.contentView addSubview:centerV];
    [centerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameL.mas_right).inset(5);
        make.right.equalTo(self.contentView).inset(20);
        make.centerY.equalTo(avaterImageV);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *numL = [[UILabel alloc]init];
    numL.textAlignment = NSTextAlignmentRight;
    [numL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [numL setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    numL.font = [UIFont systemFontOfSize:13];
    numL.textColor = kRGB_COLOR(@"#333333");
    self.numL = numL;
    [centerV addSubview:numL];
    [numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(centerV);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *moneyL = [[UILabel alloc]init];
    moneyL.textAlignment = NSTextAlignmentRight;
    moneyL.font = [UIFont systemFontOfSize:13];
    [moneyL setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [moneyL setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    moneyL.textColor = kRGB_COLOR(@"#999999");
    self.moneyL = moneyL;
    [centerV addSubview:moneyL];
    [moneyL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(centerV);
        make.height.mas_equalTo(20);
    }];
     
}
- (void)setModel:(AppUserIncomeRankingDtoModel *)model{
    _model = model;
    if (model.serialNumber < 1|| model.serialNumber >= 99) {
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_rank_99"] forState:UIControlStateNormal];
    }else if(model.serialNumber == 1){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank1"] forState:UIControlStateNormal];
    }else if(model.serialNumber == 2){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank2"] forState:UIControlStateNormal];
    }else if(model.serialNumber == 3){
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_invite_rank3"] forState:UIControlStateNormal];
    }else{
        [self.indexBtn setTitle:[NSString stringWithFormat:@"%d",model.serialNumber] forState:UIControlStateNormal];
    }
    
    [self.avaterImageV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[ProjConfig getAppIcon]];
    self.nameL.text = model.username;
    self.moneyL.text = [NSString stringWithFormat:kLocalizationMsg(@"获得%.2f元"),model.totalAmount];
    
    NSString *numS = [NSString stringWithFormat:@"%d",model.numberOfInvitations];
    NSString *numStr = [NSString stringWithFormat:kLocalizationMsg(@"邀请%@人"),numS];
    NSMutableAttributedString *numAtt = [[NSMutableAttributedString alloc]initWithString:numStr];
    [numAtt addAttributes:@{NSForegroundColorAttributeName:[ProjConfig normalColors],NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} range:[numStr rangeOfString:numS]];
    self.numL.attributedText = numAtt;
}
 
@end
