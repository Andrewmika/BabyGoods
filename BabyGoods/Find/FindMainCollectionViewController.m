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
#import <CoreLocation/CoreLocation.h>
#import <SVProgressHUD.h>

@interface FindMainCollectionViewController ()<CLLocationManagerDelegate>

@property (nonatomic,strong) NSMutableArray *arrayModels; // 物品信息
@property (nonatomic,strong) CLLocationManager *locationManager;    // 定位管理

@property (nonatomic) DistanceTag distance;    // 筛选距离
@property (nonatomic,strong) AVGeoPoint *selfGeoPoint;    // 自己的位置
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
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:10];
    [layout setMinimumLineSpacing:10];
    [layout setItemSize:CGSizeMake(130, 160)];
    [layout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.collectionView setCollectionViewLayout:layout];
    self.distance = tag_3km;
    
    [self getLocation];
}

- (NSMutableArray *)arrayModels
{
    if (!_arrayModels)
    {
        _arrayModels = [NSMutableArray array];
    }
    return _arrayModels;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (AVGeoPoint *)selfGeoPoint
{
    if (!_selfGeoPoint)
    {
        _selfGeoPoint = [AVGeoPoint geoPoint];
    }
    return _selfGeoPoint;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getGoodsWithDistance:self.distance];

}

// 定位
- (void)getLocation
{
    if (![CLLocationManager locationServicesEnabled])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"定位服务当前可能尚未打开，请设置打开！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
        {
            //如果没有授权则请求用户授权
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [self.locationManager requestWhenInUseAuthorization];
            }
            else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
            {
                //设置代理
                self.locationManager.delegate = self;
                //设置定位精度
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                //定位频率,每隔多少米定位一次
                CLLocationDistance distance = 100.0;//十米定位一次
                self.locationManager.distanceFilter = distance;
                //启动跟踪定位
                [self.locationManager startUpdatingLocation];
                [SVProgressHUD showWithStatus:@"正在定位。。。"];
            }
            
        }
        else
        {
            //设置代理
            self.locationManager.delegate = self;
            //设置定位精度
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            //定位频率,每隔多少米定位一次
            CLLocationDistance distance = 10.0;//十米定位一次
            self.locationManager.distanceFilter = distance;
            //启动跟踪定位
            [self.locationManager startUpdatingLocation];
            [SVProgressHUD showWithStatus:@"正在定位。。。"];
        }
        
    }

}
- (IBAction)screenOutGoods:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.distance = tag_3km;
            break;
            
        case 1:
            self.distance = tag_7km;
            break;
            
        case 2:
            self.distance = tag_10km;
            break;
            
        case 3:
            self.distance = tag_all;
            break;
            
        default:
            break;
    }
    
    [self getGoodsWithDistance:self.distance];
    
}

- (void)getGoodsWithDistance:(DistanceTag)distance
{
    [SVProgressHUD show];

    AVQuery *query = [AVQuery queryWithClassName:kGoodModel];
    NSString *loginName = [[UnifiedUserInfoManager share] getUserLoginName];
    [query whereKey:good_userName notEqualTo:loginName];
    [query whereKey:good_geoPoint nearGeoPoint:self.selfGeoPoint withinKilometers:distance];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            [self.arrayModels removeAllObjects];
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
            [SVProgressHUD dismiss];
            [self.collectionView reloadData];

        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }

    }];

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
        if ([segue.identifier isEqualToString:@"goodDetail"])
        {
            UIViewController *goodDetailVC = [segue destinationViewController];
            // Pass the selected object to the new view controller.
            [goodDetailVC setValue:model forKey:@"goodModel"];
        }

    }

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
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
//    [cell setBackgroundColor:[UIColor grayColor]];
    [cell setGoodData:self.arrayModels[indexPath.row]];
    return cell;
}


#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    [SVProgressHUD dismiss];
    
    CLLocation *location=[locations firstObject];//取出第一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    self.selfGeoPoint.longitude = coordinate.longitude;
    self.selfGeoPoint.latitude = coordinate.latitude;
    
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    [self.locationManager stopUpdatingLocation];
    
    // 获取数据
    [self getGoodsWithDistance:self.distance];

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
