//
//  MGTeacherAllCategoryCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherAllCategoryCell.h"
/// 列表 cell
@interface MGTeacherAllCategoryColletionViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *categoryLabel;

@end
@implementation MGTeacherAllCategoryColletionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW(20), SW(20))];
        _iconImageView.image = [UIImage imageWithColor:MGThemeYellowColor];
        _iconImageView.transform = CGAffineTransformMakeRotation(M_PI / 4);
        _categoryLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24)];
        
        _categoryLabel.frame = CGRectMake(_iconImageView.right + SW(10), 0, 0, _categoryLabel.fontLineHeight);
        
        _iconImageView.centerY = _categoryLabel.centerY + SH(1);
        [self.contentView sd_addSubviews:@[_iconImageView, _categoryLabel]];

    }
    return self;
}

- (void)setName:(NSString *)name {
    _name = name;
    _categoryLabel.text = name;
    
    _categoryLabel.width = [_categoryLabel.text widthForFont:_categoryLabel.font];
    
}

@end



@interface MGTeacherAllCategoryCell () <UICollectionViewDelegate, UICollectionViewDataSource>
/// 顶部内容
@property (nonatomic, strong) UIView *topBgView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UIView *topLineView;
/// 列表
@property (nonatomic, strong) UICollectionView *colletionView;

@end

@implementation MGTeacherAllCategoryCell

- (void)preapreCellUI {

    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(80))];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SW(30), 0, SW(44), SW(44))];
    _iconImageView.centerY = _topBgView.centerY;

    
    
    _categoryLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Title_Black font:PFSC(30)];
    _categoryLabel.frame = CGRectMake(_iconImageView.right + SW(24), 0, SW(500), _categoryLabel.fontLineHeight);
    _categoryLabel.centerY = _topBgView.centerY;
    
    
    
    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _topBgView.height - MGSepLineHeight, kScreenWidth, MGSepLineHeight)];
    _topLineView.backgroundColor = MGSepColor;

    
    [_topBgView sd_addSubviews:@[_iconImageView, _categoryLabel, _topLineView]];
 
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(SH(30), SW(28), SH(30), SW(28));
    layout.itemSize = CGSizeMake(SW(128), PFSC(24).lineHeight);
    layout.minimumInteritemSpacing = SW(154);
    layout.minimumLineSpacing = SW(50);
    
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _topBgView.bottom, kScreenWidth, SH(100)) collectionViewLayout:layout];
    _colletionView.hidden = YES;
    _colletionView.backgroundColor = [UIColor whiteColor];
    _colletionView.showsVerticalScrollIndicator = NO;
    _colletionView.showsHorizontalScrollIndicator = NO;
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    _colletionView.scrollEnabled = NO;
    _colletionView.pagingEnabled = NO;
    _colletionView.bounces = NO;
    [_colletionView registerClass:[MGTeacherAllCategoryColletionViewCell class] forCellWithReuseIdentifier:@"MGTeacherAllCategoryColletionViewCellID"];

    
    [self.contentView sd_addSubviews:@[_topBgView, _colletionView]];
}

#pragma mark - UIColletionViewDelegare

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataModel.details.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MGTeacherAllCategoryColletionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGTeacherAllCategoryColletionViewCellID" forIndexPath:indexPath];
    MGResClassifyDataModel *model = self.dataModel.details[indexPath.item];
    
    cell.name = model.classify_name;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_categoryDidCellItemBlock) {
        _categoryDidCellItemBlock(self.tableIndexPath.section, indexPath.item);
    }
    
    
}


#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter
- (void)setDataModel:(MGResClassifyDataModel *)dataModel {
    _dataModel = dataModel;
    
    _colletionView.hidden = NO;
    
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.logo_rsurl] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView)];
    self.categoryLabel.text = dataModel.classify_name;
    
    /// 求出 colletionView 的高度
    NSInteger row = ceil(dataModel.details.count / 3.0);
    CGFloat height = SH(60) + (row - 1) * SH(50) + PFSC(24).lineHeight * row;
    
    if (_colletionView.height != height && dataModel.details.count > 0) {
        _colletionView.height = height;
    }
    
    [_colletionView reloadData];

}

@end
