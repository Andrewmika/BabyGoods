//
//  FindMainCollectionViewController.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/4.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "FindMainCollectionViewController.h"
#import "FindCollectionViewCell.h"
#import "UnifiedUserInfoManager.h"
#import "LoginViewController.h"
#import <AVOSCloud.h>
#import "goodModel.h"
#import "MyDefine.h"

@interface FindMainCollectionViewController ()

@property (nonatomic,strong) NSMutableArray *arrayModels; // 物品信息

@end

@implementation FindMainCollectionViewController

static NSString * const reuseIdentifier = @"findCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[FindCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
//    [self.collectionView setBackgroundColor:[UIColor cyanColor]];
    // Do any additional setup after loading the view.
    
    AVQuery *query = [AVQuery queryWithClassName:kGoodModel];
    NSArray *arrTemp = [query findObjects];
    for (AVObject *object in arrTemp)
    {
        goodModel *model = [[goodModel alloc] init];
        model.goodName = [object objectForKey:good_name];
        model.goodAges = [object objectForKey:good_ages];
        AVFile *file = [object objectForKey:good_image];
        model.imagePath = file.url;
        [self.arrayModels addObject:model];
    }

}

- (NSMutableArray *)arrayModels
{
    if (!_arrayModels)
    {
        _arrayModels = [NSMutableArray array];
    }
    return _arrayModels;
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return self.arrayModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
//    [cell setBackgroundColor:[UIColor grayColor]];
    [cell setGoodData:self.arrayModels[indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
