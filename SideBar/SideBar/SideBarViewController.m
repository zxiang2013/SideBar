//
//  SideBarViewController.m
//  SideBar
//
//  Created by dbc61 on 2018/9/29.
//  Copyright © 2018年 ZZZ. All rights reserved.
//

#import "SideBarViewController.h"
#import "SideBarCollectionViewCell.h"
#import "SideBarCollectionReusableView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SideBarViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIImageView *maskView;
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *selectedArr;

@end

@implementation SideBarViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:self.backgroundView];

    [self setup];
    
    self.datas = [@[@"微信支付", @"支付宝", @"现金", @"赊账", @"POS机",] copy];
    self.titles = [@[@"选择开始日期", @"选择结束日期"] mutableCopy];

    // 默认都不选中
    for (NSInteger i = 0; i < self.datas.count; i++) {
        [self.selectedArr addObject:@NO];
    }
}

- (void)setup {
    UIImageView *maskView = [UIImageView new];
    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    maskView.frame = self.view.bounds;
    maskView.alpha = 0;
    maskView.userInteractionEnabled = YES;
    [self.view addSubview:maskView];
    self.maskView = maskView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToDismiss)];
    [self.maskView addGestureRecognizer:tap];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth - 60, kScreenHeight);
    [self.view addSubview:rightView];
    self.rightView = rightView;
    
    self.collectionView.frame = rightView.bounds;
    [rightView addSubview:self.collectionView];
    
    [UIView animateWithDuration:0.45 animations:^{
        maskView.alpha = 1;
        CGRect r = rightView.frame;
        r.origin.x = 60;
        rightView.frame = r;
    }];
}

- (void)clickToDismiss {
    [UIView animateWithDuration:0.45 animations:^{
        self.maskView.alpha = 0;
        CGRect r = self.rightView.frame;
        r.origin.x = kScreenWidth;
        self.rightView.frame = r;
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:NO];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return self.titles.count;
    }
    return self.datas.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(90, 35);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SideBarCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(SideBarCollectionReusableView.class) forIndexPath:indexPath];
        header.titleLabel.text = @[@"订单类型", @"日期"][indexPath.section];
       
        return header;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SideBarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SideBarCollectionViewCell.class) forIndexPath:indexPath];
    cell.isSelected = indexPath.section != 0 ? NO : [self.selectedArr[indexPath.row] boolValue];
    cell.titleLabel.text = @[self.datas, self.titles][indexPath.section][indexPath.row];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return;
    }
    
    for (NSInteger i = 0; i < self.selectedArr.count; i++) {
        NSNumber *n = self.selectedArr[i];
        if (i == indexPath.row) {
            n = @YES;
        }else {
            n = @NO;
        }

        [self.selectedArr replaceObjectAtIndex:i withObject:n];
    }
    
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.headerReferenceSize = CGSizeMake(kScreenWidth - 60, 80);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 20, -5, 20);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:SideBarCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(SideBarCollectionViewCell.class)];
        [_collectionView registerClass:SideBarCollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(SideBarCollectionReusableView.class)];
    }
    return _collectionView;
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray new];
    }
    return _titles;
}

- (NSMutableArray *)selectedArr {
    if (!_selectedArr) {
        _selectedArr = [NSMutableArray new];
    }
    return _selectedArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
