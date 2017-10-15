//
//  MGSchedulePeopleView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGSchedulePeopleCollectionView.h"

@interface MGSchedulePeopleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *centerLineView;

@property (nonatomic, strong) UILabel *peopleLabel;

@end

@implementation MGSchedulePeopleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 3;
        
        _timeLabel = [MGUITool labelWithText:@"11点" textColor:colorHex(@"#252525") font:MGThemeFont_30 textAlignment:NSTextAlignmentRight];
        
        _centerLineView = [[UIView alloc] init];
        _centerLineView.backgroundColor = MGSepColor;
        
        _peopleLabel = [MGUITool labelWithText:@"0人" textColor:colorHex(@"#bfbfbf") font:MGThemeFont_30 textAlignment:NSTextAlignmentRight];
        _peopleLabel.adjustsFontSizeToFitWidth = YES;
        [_bgView sd_addSubviews:@[_timeLabel, _centerLineView, _peopleLabel]];
        
        [self.contentView sd_addSubviews:@[_bgView]];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _bgView.frame = CGRectInset(self.contentView.bounds, 1, 1);
    
    _centerLineView.width = MGSepLineHeight;
    _centerLineView.height = _bgView.height - SH(20);
    _centerLineView.center  = _bgView.center;
    
    
    [_timeLabel sizeToFit];
    _timeLabel.right = _centerLineView.left - SW(20);
    _timeLabel.centerY = _centerLineView.centerY;
    
    [_peopleLabel sizeToFit];
    _peopleLabel.left = _centerLineView.right + SW(20);
    _peopleLabel.width = _bgView.width - _peopleLabel.left - SW(10);
    _peopleLabel.centerY = _centerLineView.centerY;
    
    
}

@end

@interface MGSchedulePeopleCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation MGSchedulePeopleCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    CGFloat itemWidth = (frame.size.width - SW(24) * 2 - 2 * SW(10)) / 3;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(itemWidth, SH(58));
    layout.sectionInset = UIEdgeInsetsMake(0, SW(24), 0, SW(24));
    layout.minimumLineSpacing = SW(10);
    layout.minimumInteritemSpacing = SW(10);
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = NO;
        [self registerClass:[MGSchedulePeopleCollectionViewCell class] forCellWithReuseIdentifier:@"MGSchedulePeopleCollectionViewCellID"];
    }
    return self;
}

#pragma mark - Event Response

#pragma mark - --Notification Event Response

#pragma mark - --Button Event Response

#pragma mark - --Gesture Event Response

#pragma mark - System Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
    return self.collectionDataArrayM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGSchedulePeopleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGSchedulePeopleCollectionViewCellID" forIndexPath:indexPath];
    return cell;
}



#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter




@end
