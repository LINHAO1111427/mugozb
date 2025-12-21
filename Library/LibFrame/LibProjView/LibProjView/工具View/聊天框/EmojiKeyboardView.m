//
//  EmojiKeyboardView.m
//  TaiWanEight
//
//  Created by Boom on 2017/11/23.
//  Copyright © 2017年 YangBiao. All rights reserved.
//

#import "EmojiKeyboardView.h"
#import "EmojiCell.h"
#import <LibProjBase/ProjConfig.h>

@interface CollCellWhite : UICollectionViewCell

@end

@implementation CollCellWhite

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
@implementation EmojiKeyboardView{
    UICollectionView *collectionView;
    NSArray *emojiArray;
    UIPageControl *_pageControl;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =kRGB_COLOR(@"#f4f5f6");
        emojiArray = @[kLocalizationMsg(@"[微笑]"),kLocalizationMsg(@"[色]"),kLocalizationMsg(@"[发呆]"),kLocalizationMsg(@"[抽烟]"),kLocalizationMsg(@"[抠鼻]"),kLocalizationMsg(@"[哭]"),kLocalizationMsg(@"[发怒]"),kLocalizationMsg(@"[呲牙]"),kLocalizationMsg(@"[睡]"),kLocalizationMsg(@"[害羞]"),kLocalizationMsg(@"[调皮]"),kLocalizationMsg(@"[晕]"),kLocalizationMsg(@"[衰]"),kLocalizationMsg(@"[闭嘴]"),kLocalizationMsg(@"[指点]"),kLocalizationMsg(@"[关注]"),kLocalizationMsg(@"[搞定]"),kLocalizationMsg(@"[胜利]"),kLocalizationMsg(@"[无奈]"),kLocalizationMsg(@"[打脸]"),@"message_icon_del",kLocalizationMsg(@"[大笑]"),kLocalizationMsg(@"[哈欠]"),kLocalizationMsg(@"[害怕]"),kLocalizationMsg(@"[喜欢]"),kLocalizationMsg(@"[困]"),kLocalizationMsg(@"[疑问]"),kLocalizationMsg(@"[伤心]"),kLocalizationMsg(@"[鼓掌]"),kLocalizationMsg(@"[得意]"),kLocalizationMsg(@"[捂嘴]"),kLocalizationMsg(@"[惊恐]"),kLocalizationMsg(@"[思考]"),kLocalizationMsg(@"[吐血]"),kLocalizationMsg(@"[卖萌]"),kLocalizationMsg(@"[嘘]"),kLocalizationMsg(@"[生气]"),kLocalizationMsg(@"[尴尬]"),kLocalizationMsg(@"[笑哭]"),kLocalizationMsg(@"[口罩]"),kLocalizationMsg(@"[斜眼]"),@"message_icon_del",kLocalizationMsg(@"[酷]"),kLocalizationMsg(@"[脸红]"),kLocalizationMsg(@"[大叫]"),kLocalizationMsg(@"[眼泪]"),kLocalizationMsg(@"[见钱]"),kLocalizationMsg(@"[嘟]"),kLocalizationMsg(@"[吓]"),kLocalizationMsg(@"[开心]"),kLocalizationMsg(@"[想哭]"),kLocalizationMsg(@"[郁闷]"),kLocalizationMsg(@"[互粉]"),kLocalizationMsg(@"[赞]"),kLocalizationMsg(@"[拜托]"),kLocalizationMsg(@"[唇]"),kLocalizationMsg(@"[粉]"),@"[666]",kLocalizationMsg(@"[玫瑰]"),kLocalizationMsg(@"[黄瓜]"),kLocalizationMsg(@"[啤酒]"),kLocalizationMsg(@"[无语]"),@"message_icon_del",kLocalizationMsg(@"[纠结]"),kLocalizationMsg(@"[吐舌]"),kLocalizationMsg(@"[差评]"),kLocalizationMsg(@"[飞吻]"),kLocalizationMsg(@"[再见]"),kLocalizationMsg(@"[拒绝]"),kLocalizationMsg(@"[耳机]"),kLocalizationMsg(@"[抱抱]"),kLocalizationMsg(@"[嘴]"),kLocalizationMsg(@"[露牙]"),kLocalizationMsg(@"[黄狗]"),kLocalizationMsg(@"[灰狗]"),kLocalizationMsg(@"[蓝狗]"),kLocalizationMsg(@"[狗]"),kLocalizationMsg(@"[脸黑]"),kLocalizationMsg(@"[吃瓜]"),kLocalizationMsg(@"[绿帽]"),kLocalizationMsg(@"[汗]"),kLocalizationMsg(@"[摸头]"),kLocalizationMsg(@"[阴险]"),@"message_icon_del",kLocalizationMsg(@"[擦汗]"),kLocalizationMsg(@"[瞪眼]"),kLocalizationMsg(@"[疼]"),kLocalizationMsg(@"[鬼脸]"),kLocalizationMsg(@"[拇指]"),kLocalizationMsg(@"[亲]"),kLocalizationMsg(@"[大吐]"),kLocalizationMsg(@"[高兴]"),kLocalizationMsg(@"[敲打]"),kLocalizationMsg(@"[加油]"),kLocalizationMsg(@"[吐]"),kLocalizationMsg(@"[握手]"),kLocalizationMsg(@"[18禁]"),kLocalizationMsg(@"[菜刀]"),kLocalizationMsg(@"[威武]"),kLocalizationMsg(@"[给力]"),kLocalizationMsg(@"[爱心]"),kLocalizationMsg(@"[心碎]"),kLocalizationMsg(@"[便便]"),kLocalizationMsg(@"[礼物]"),@"message_icon_del",kLocalizationMsg(@"[生日]"),kLocalizationMsg(@"[喝彩]"),kLocalizationMsg(@"[雷]"),@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"345",@"message_icon_del"];
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    CollectionPageFlowLayout *layout =[[CollectionPageFlowLayout alloc]init];
    layout.itemCountPerRow = 7;
    layout.rowCount = 3;
    layout.itemSize = CGSizeMake((kScreenWidth-20)/7, (kScreenWidth-20)/7);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat collectinHeight = (kScreenWidth-20)/7*3;
    collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(10,10, kScreenWidth-20,collectinHeight) collectionViewLayout:layout];
    collectionView.backgroundColor = kRGB_COLOR(@"#f4f5f6");
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    [collectionView registerClass:[CollCellWhite class] forCellWithReuseIdentifier:@"emojiWhiteIdentifier"];
    [collectionView registerClass:[EmojiCell class] forCellWithReuseIdentifier:emojiCellIdentifier];
    [self addSubview:collectionView];
    _pageControl = [[UIPageControl alloc] init];
    
    CGFloat pageSpace = (EmojiHeight - collectinHeight-20-20)/2;
    _pageControl.frame = CGRectMake(collectionView.frame.size.width/2, CGRectGetMaxY(collectionView.frame)+pageSpace, 20, 20);//指定位置大小
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];// 设置非选中页的圆点颜色
    _pageControl.currentPageIndicatorTintColor = [ProjConfig normalColors]; // 设置选中页的圆点颜色
    _pageControl.numberOfPages = (emojiArray.count%21==0)?(emojiArray.count/21):(emojiArray.count/21+1);
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    CGFloat sendSpace = (EmojiHeight - collectinHeight-20-30)/2;
    UIButton *sendEmojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendEmojiBtn.frame = CGRectMake(kScreenWidth-70, CGRectGetMaxY(collectionView.frame)+sendSpace, 60, 24);
    [sendEmojiBtn setTitle:kLocalizationMsg(@"发送") forState:0];
    [sendEmojiBtn setTitleColor:[UIColor whiteColor] forState:0];
    sendEmojiBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    sendEmojiBtn.backgroundColor = [ProjConfig normalColors];
    sendEmojiBtn.layer.masksToBounds = YES;
    sendEmojiBtn.layer.cornerRadius = 12;
    [sendEmojiBtn addTarget:self action:@selector(clickSendBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendEmojiBtn];
    _sendEmojiBtn = sendEmojiBtn;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / collectionView.frame.size.width;
    // 设置页码
    _pageControl.currentPage = page;
}

-(void)clickSendBtn {
    if (self.clickHandle) {
        self.clickHandle(EmojiKeyboardForSend,@"");
    }
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return emojiArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.item >= emojiArray.count) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"emojiWhiteIdentifier" forIndexPath:indexPath];
        return cell;
        
    } else {
        EmojiCell *cell = (EmojiCell *)[collectionView dequeueReusableCellWithReuseIdentifier:emojiCellIdentifier forIndexPath:indexPath];
        NSString *imgPath= [[[NSBundle mainBundle] pathForResource:@"customEmoji" ofType:@"bundle"] stringByAppendingPathComponent:emojiArray[indexPath.row]];
        if ([emojiArray[indexPath.row] isEqual:@"message_icon_del"]) {
            cell.emojiImgView.image = [UIImage imageNamed:@"message_icon_del"];;
        }else{
            cell.emojiImgView.image = [UIImage imageWithContentsOfFile:imgPath];;
        }
        return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([emojiArray[indexPath.row] isEqualToString:@"345"]) {
        return;
    }
    if (self.clickHandle) {
        if ([emojiArray[indexPath.row] isEqual:@"message_icon_del"]) {
               self.clickHandle(EmojiKeyboardForDelete, emojiArray[indexPath.row]);
           }else {
               self.clickHandle(EmojiKeyboardForStr, emojiArray[indexPath.row]);
           }
    }
}

@end
