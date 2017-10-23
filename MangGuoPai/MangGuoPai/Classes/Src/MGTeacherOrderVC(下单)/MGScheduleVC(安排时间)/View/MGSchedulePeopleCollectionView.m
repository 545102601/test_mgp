//
//  MGSchedulePeopleView.m
//  MangGuoPai
//
//  Created by ZYN on 2017/9/29.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "MGSchedulePeopleCollectionView.h"
#import "MGSchedulePeopleModel.h"

@interface MGSchedulePeopleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *centerLineView;

@property (nonatomic, strong) UILabel *peopleLabel;

@property (nonatomic, strong) MGSchedulePeopleModel *peopleModel;

@end

@implementation MGSchedulePeopleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 3;
        _bgView.layer.borderWidth = 1;
        _bgView.frame = CGRectInset(self.contentView.frame, 1, 1);
        
        _timeLabel = [MGUITool labelWithText:nil textColor:colorHex(@"#252525") font:MGThemeFont_30 textAlignment:NSTextAlignmentCenter];
        _timeLabel.frame = CGRectMake(SW(10), 0, SW(100), _timeLabel.fontLineHeight);
        _timeLabel.centerY = self.contentView.height * 0.5;
        
        
        _centerLineView = [[UIView alloc] initWithFrame:CGRectMake(0, SH(10), MGSepLineHeight, self.contentView.height - SH(20))];
        _centerLineView.centerX = self.contentView.centerX;
        _centerLineView.backgroundColor = MGSepColor;
        
        _peopleLabel = [MGUITool labelWithText:nil textColor:colorHex(@"#bfbfbf") font:MGThemeFont_30 textAlignment:NSTextAlignmentRight];
        _peopleLabel.frame = CGRectMake(self.contentView.width - SW(100) - SW(10), 0, SW(90), _peopleLabel.fontLineHeight);
        _peopleLabel.centerY = self.contentView.height * 0.5;
        _peopleLabel.adjustsFontSizeToFitWidth = YES;
        [_bgView sd_addSubviews:@[_timeLabel, _centerLineView, _peopleLabel]];
        
        [self.contentView sd_addSubviews:@[_bgView]];
        
    }
    return self;
}

- (void)setPeopleModel:(MGSchedulePeopleModel *)peopleModel {
    _peopleModel = peopleModel;
    
    _timeLabel.text = [NSString stringWithFormat:@"%@", peopleModel.time];
    _peopleLabel.text = [NSString stringWithFormat:@"%zd人", peopleModel.count];
    
    if (peopleModel.isSelected) {
        _bgView.layer.borderColor = MGThemeShenYellowColor.CGColor;
    } else {
        if (peopleModel.count > 0) { /// 有人数
            _bgView.layer.borderColor = MGThemeColor_QianYellowColor.CGColor;
        } else {
            _bgView.layer.borderColor = [UIColor clearColor].CGColor;
        }
    }
}

+ (CGFloat)getCellWidth {
    return (kScreenWidth - SW(24) * 2 - 2 * SW(10)) / 3;;
}

@end

@interface MGSchedulePeopleCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation MGSchedulePeopleCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    CGFloat itemWidth = [MGSchedulePeopleCollectionViewCell getCellWidth];
    
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

    return self.collectionDataArrayM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGSchedulePeopleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGSchedulePeopleCollectionViewCellID" forIndexPath:indexPath];
    cell.peopleModel = self.collectionDataArrayM[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    MGSchedulePeopleModel *peopleModel = self.collectionDataArrayM[indexPath.item];
    MGSchedulePeopleModel *selectModel = nil;
    for (MGSchedulePeopleModel *tempModel in self.collectionDataArrayM) {
        tempModel.isSelected = NO;
        if (tempModel.id == peopleModel.id) {
            tempModel.isSelected = YES;
            selectModel = tempModel;
        }
    }
    [collectionView reloadData];
    
    if (_didSelectItemBlock) {
        _didSelectItemBlock(selectModel);
    }
    
}

#pragma mark - Custom Delegate

#pragma mark - Public Function

#pragma mark - Private Function

#pragma mark - Getter and Setter




@end
