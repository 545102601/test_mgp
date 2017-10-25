//
//  MGTeacherFunctionCell.m
//  MangGuoPai
//
//  Created by ZYN on 2017/7/18.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGTeacherFunctionCell.h"


/// cell
@interface MGTeacherFunctionColletionViewCell ()
/// 图标
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MGTeacherFunctionColletionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW(44), SW(44))];
        _iconImageView.centerX = frame.size.width * 0.5;
        _titleLabel = [MGUITool labelWithText:nil textColor:MGThemeColor_Common_Black font:PFSC(24) textAlignment:NSTextAlignmentCenter];
        _titleLabel.frame = CGRectMake(0, _iconImageView.bottom + SH(12), SW(130), _titleLabel.fontLineHeight);
        
        [self.contentView sd_addSubviews:@[_iconImageView, _titleLabel]];
        
    }
    return self;
}

- (void)setModel:(MGResClassifyDataModel *)model {
    _model = model;
    
    if (model.id == -1000) { /// 全部
        self.iconImageView.image = [UIImage imageNamed:@"teacher_func_all"];
        self.titleLabel.text = @"全部";
    } else {
        
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.logo_rsurl scaleWidth:self.iconImageView.width] placeholderImage:SDWEB_PLACEHODER_IMAGE(_iconImageView)];
        self.titleLabel.text = model.classify_name;
    }
}


@end



@interface MGTeacherFunctionCell () <UICollectionViewDelegate, UICollectionViewDataSource>

/// 列表
@property (nonatomic, strong) UICollectionView *colletionView;


@end

@implementation MGTeacherFunctionCell

- (void)preapreCellUI {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(SH(30), SW(30), SH(30), SW(30));
    layout.itemSize = CGSizeMake(SW(130), SH(90));
    layout.minimumInteritemSpacing = SH(40);
    layout.minimumLineSpacing = SW(40);
    
    _colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SH(280)) collectionViewLayout:layout];
    _colletionView.hidden = YES;
    _colletionView.backgroundColor = [UIColor whiteColor];
    _colletionView.showsVerticalScrollIndicator = NO;
    _colletionView.showsHorizontalScrollIndicator = NO;
    _colletionView.delegate = self;
    _colletionView.dataSource = self;
    _colletionView.pagingEnabled = NO;
    _colletionView.bounces = NO;
    _colletionView.scrollEnabled = NO;
    [_colletionView registerClass:[MGTeacherFunctionColletionViewCell class] forCellWithReuseIdentifier:@"MGTeacherFunctionColletionViewCellID"];
    
    
    [self.contentView sd_addSubviews:@[_colletionView]];
}
#pragma mark - UIColletionViewDelegare

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataArray.count > 7) {
        return 8;
    }
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MGTeacherFunctionColletionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGTeacherFunctionColletionViewCellID" forIndexPath:indexPath];
    MGResClassifyDataModel *model = self.dataArray[indexPath.item];
    cell.model = model;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self callBackBlockWithIndex:indexPath.item];
}

- (void)callBackBlockWithIndex:(NSInteger)index {
    if (_didCellItemBlock) {
        _didCellItemBlock(index);
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

- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = [dataArray copy];
    
    if (_dataArray.count > 4) {
        _colletionView.height = SH(280);
    } else {
        _colletionView.height = SH(150);
    }
    _colletionView.hidden = NO;
    
    
    [_colletionView reloadData];
}

@end
