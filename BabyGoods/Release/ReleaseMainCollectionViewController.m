//
//  ReleaseMainCollectionViewController.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/4.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "ReleaseMainCollectionViewController.h"
#import "UnifiedUserInfoManager.h"
#import "LoginViewController.h"
#import <AVOSCloud.h>
#import "ReleaseCollectionViewCell.h"
#import "MyDefine.h"

@interface ReleaseMainCollectionViewController ()
@property (nonatomic,strong) NSMutableArray *arrayModels; // 物品信息
@property (nonatomic,strong) NSMutableArray *arrayObjects;    // 所有的对象
@end

@implementation ReleaseMainCollectionViewController

static NSString * const reuseIdentifier = @"releaseCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[ReleaseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:10];
    [layout setMinimumLineSpacing:10];
    [layout setItemSize:CGSizeMake(120, 160)];
    [layout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.collectionView setCollectionViewLayout:layout];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 允许用户使用应用
        [self getReleaseGoods];
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
        [self performSegueWithIdentifier:@"findToLogin" sender:self.navigationController];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UICollectionViewCell class]])
    {
        UICollectionViewCell *cell = (UICollectionViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        goodModel *model = self.arrayModels[indexPath.row];
        AVObject *object = self.arrayObjects[indexPath.row];
        if ([segue.identifier isEqualToString:@"editGood"])
        {
            UIViewController *editGoodVC = [segue destinationViewController];
            // Pass the selected object to the new view controller.
            [editGoodVC setValue:model forKey:@"model"];
            [editGoodVC setValue:object forKey:@"object"];
        }
        
    }


}


// 获取物品信息
- (void)getReleaseGoods
{
    [self.arrayModels removeAllObjects];
    AVQuery *query = [AVQuery queryWithClassName:kGoodModel];
    NSString *loginName = [[UnifiedUserInfoManager share] getUserLoginName];
    [query whereKey:good_userName equalTo:loginName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.arrayObjects removeAllObjects];
        [self.arrayObjects addObjectsFromArray:objects];
        for (AVObject *object in objects)
        {
            goodModel *model = [[goodModel alloc] init];
            model.goodName = [object objectForKey:good_name];
            model.goodAges = [object objectForKey:good_ages];
            model.goodUserName = [object objectForKey:good_userName];
            model.geoPoint = [object objectForKey:good_geoPoint];
            AVFile *file = [object objectForKey:good_image];
            model.imagePath = file.url;
            [self.arrayModels addObject:model];
        }
        
        [self.collectionView reloadData];

    }];

}
- (IBAction)addGoods:(UIBarButtonItem *)sender {

}
- (NSMutableArray *)arrayObjects
{
    if (!_arrayObjects)
    {
        _arrayObjects = [NSMutableArray array];
    }
    return _arrayObjects;
}
- (NSMutableArray *)arrayModels
{
    if (!_arrayModels)
    {
        _arrayModels = [NSMutableArray array];
    }
    return _arrayModels;
}

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
    ReleaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
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
