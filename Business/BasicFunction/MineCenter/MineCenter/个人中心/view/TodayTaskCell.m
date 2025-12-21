//
//  TodayTaskCell.m
//  MineCenter
//
//  Created by klc on 2020/7/29.
//

#import "TodayTaskCell.h"

@interface TodayTaskCell ()

kStrong(UIImageView, imv)
kStrong(UILabel, titleLab)
kStrong(UIButton, btn)
@end

@implementation TodayTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupSubviews];
    }
    return self;
}
-(void)setupSubviews{
    
    _imv = [Maker Imv:nil layerCorner:20 superView:self.contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.size.mas_equalTo(SIZE(40, 40));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(12);
    }];
    
    _btn = [Maker BtnWithShadow:NO backColor:nil text:kLocalizationMsg(@"签到") textColor:[UIColor whiteColor] font:kFont(14) superView:self.contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(64, 28));
        make.right.equalTo(self.contentView).inset(12);
    }];
    _btn.colors = @[kRGB_COLOR(@"#7CD2FF"),kRGB_COLOR(@"#CF6DFF")];
    _btn.layer.cornerRadius = 14;
    [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLab = [Maker labelWithShadow:NO alignment:NSTextAlignmentLeft backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:kFont(14) superView:self.contentView constraints:^(MASConstraintMaker * _Nonnull make) {
       
        make.top.bottom.equalTo(_imv);
        make.left.equalTo(_imv.mas_right).offset(14);
        make.right.equalTo(_btn.mas_left).inset(20);
    }];
}
-(void)setModel:(TaskDtoModel *)model{
    
    _model = model;
    [_imv sd_setImageWithURL:[NSURL URLWithString:model.image]];
    _titleLab.attributedText = [self attStringBystrings:@[kStringFormat(@"%@\n",model.name),kStringFormat(kLocalizationMsg(@"经验+%d"),model.point)] attributes:@[@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:kFont(14)},@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:kFont(12)}]];
    if (model.status==0) {
        
        NSString *title = [model.typeCode  isEqual:@"1001"]?kLocalizationMsg(@"签到"):kLocalizationMsg(@"未完成");
        [_btn setTitle:title forState:0];
        _btn.colors =  @[kRGB_COLOR(@"#7CD2FF"),kRGB_COLOR(@"#CF6DFF")];
        [_btn setTitleColor:[UIColor whiteColor] forState:0];
    }else{
        
        NSString *title = [model.typeCode  isEqual:@"1001"]?kLocalizationMsg(@"已签到"):kLocalizationMsg(@"已完成");
        [_btn setTitle:title forState:0];
        _btn.colors = nil;
        _btn.backgroundColor = [UIColor lightGrayColor];
        [_btn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] forState:0];
    }
    
}
-(NSAttributedString *)attStringBystrings:(NSArray <NSString*>*)strs attributes:(NSArray <NSDictionary *>*)attributes{
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] init];
    int start = 0;
    for (int i = 0; i<strs.count; i++) {
        
        NSString * str = strs[i];
        NSDictionary *attribute = attributes[i];
        if (!str) {
            str = @"";
        }
        [muStr appendAttributedString:[[NSAttributedString alloc] initWithString:str]];
        [muStr addAttributes:attribute range:NSMakeRange(start, str.length)];
        start+= str.length;
    }
    return muStr;
}

-(void)btnAction:(UIButton *)sender{
    if (self.btnActionBlock) {
        self.btnActionBlock(sender.currentTitle);
    }
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
