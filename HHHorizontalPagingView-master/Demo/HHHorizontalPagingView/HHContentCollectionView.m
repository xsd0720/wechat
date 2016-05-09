//
//  HHContentCollectionView.m
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import "HHContentCollectionView.h"

@interface HHContentCollectionView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HHContentCollectionView

static NSString *collectionViewCellIdentifier = @"collectionViewCell";

//+ (HHContentCollectionView *)contentCollectionView {
//    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.minimumLineSpacing = 5;
//    layout.minimumInteritemSpacing = 5;
//    layout.itemSize = CGSizeMake(100, 100);
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    
//    HHContentCollectionView *collectionView = [[HHContentCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    collectionView.backgroundColor = [UIColor clearColor];
//    collectionView.dataSource = collectionView;
//    collectionView.delegate = collectionView;
//    
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
//    
//    return collectionView;
//}
//
//#pragma mark - UICollectionViewDataSource
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 20;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor lightGrayColor];
//    
//    return cell;
//    
//}
//
//#pragma mark - UICollectionViewDelegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

+ (HHContentCollectionView *)contentCollectionView{
    HHContentCollectionView *contentTV = [[HHContentCollectionView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    contentTV.backgroundColor = [UIColor clearColor];
    contentTV.dataSource = contentTV;
    contentTV.delegate = contentTV;
    contentTV.contentInset = UIEdgeInsetsMake(0, 0, 568-5*44-44-44-44, 0);
    contentTV.tableFooterView = [UIView new];
    return contentTV;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
