//
//  ViewController.m
//  CenterPageCollectionView
//
//  Created by QMP on 2018/7/30.
//  Copyright © 2018年 xiusl. All rights reserved.
//

#import "ViewController.h"
#import "CenterPageCollectionLayout.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface ViewController () <UICollectionViewDataSource>
@property (nonatomic, strong) CenterPageCollectionLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.collectionView];
}
#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"123" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0
                                                       green:(arc4random()%255)/255.0
                                                        blue:(arc4random()%255)/255.0 alpha:1];
    
    UILabel *label = [cell.contentView viewWithTag:102];
    if (!label) {
        label = [[UILabel alloc] init];
        label.tag = 102;
        label.frame = CGRectMake(0, 0, kScreenW-32, 60);
        label.font = [UIFont systemFontOfSize:30];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    
    return cell;
}
#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGRect rect = CGRectMake(0, 100, kScreenW, 180);
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:self.layout];
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"123"];
    }
    return _collectionView;
}

- (CenterPageCollectionLayout *)layout {
    if (!_layout) {
        _layout = [[CenterPageCollectionLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.itemSize = CGSizeMake(kScreenW-32, 60);
        _layout.minimumLineSpacing = 8.f;
        _layout.minimumInteritemSpacing = 0.f;
        _layout.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
    }
    return _layout;
}


@end
