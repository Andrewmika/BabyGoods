//
//  MeMainTableViewController.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/4.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "MeMainTableViewController.h"
#import <AVOSCloud.h>
#import "UserInfoInputViewController.h"
#import "UserInfoModel.h"
#import "UnifiedUserInfoManager.h"
#import "MyDefine.h"
#import <SVProgressHUD.h>

@interface MeMainTableViewController ()<UserInfoInputViewControllerDelegate>
@property (nonatomic,strong) NSArray *arrayTitles;    // 标题
@property (nonatomic,strong) NSArray *arrayData;    // 信息
@property (nonatomic) NSInteger currentTag;    // 当前tag
@property (nonatomic,strong) UserInfoModel *userInfoModel;    // 用户信息model
@end

@implementation MeMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.arrayTitles = @[@"姓名",@"手机",@"地址"];
    AVQuery *query = [AVQuery queryWithClassName:kUserInfoModel];
    AVObject *object = [query getFirstObject];
    self.userInfoModel.userName = [object objectForKey:user_name];
    self.userInfoModel.userMobile = [object objectForKey:user_mobile];
    self.userInfoModel.userAddr = [object objectForKey:user_address];
    self.userInfoModel.loginName = [object objectForKey:user_loginName];    
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
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
        [self performSegueWithIdentifier:@"meToLogin" sender:self];
    }
}

- (UserInfoModel *)userInfoModel
{
    if (!_userInfoModel)
    {
        _userInfoModel = [[UserInfoModel alloc] init];
    }
    return _userInfoModel;
}

// 保存数据
- (IBAction)saveData:(UIBarButtonItem *)sender {
    
    AVObject *userInfoModel = [AVObject objectWithClassName:kUserInfoModel];
    [userInfoModel setObject:self.userInfoModel.userName forKey:user_name];
    [userInfoModel setObject:self.userInfoModel.userMobile forKey:user_mobile];
    [userInfoModel setObject:self.userInfoModel.userAddr forKey:user_address];
    [userInfoModel setObject:self.userInfoModel.loginName forKey:user_loginName];

    [userInfoModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.arrayTitles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCell" forIndexPath:indexPath];
    [cell.textLabel setText:self.arrayTitles[indexPath.row]];
    switch (indexPath.row)
    {
        case 0:
            [cell.detailTextLabel setText:self.userInfoModel.userName];
            break;
            
        case 1:
            [cell.detailTextLabel setText:self.userInfoModel.userMobile];
            break;
            
        case 2:
            [cell.detailTextLabel setText:self.userInfoModel.userAddr];
            break;
            
        default:
            break;
    }
    [cell setTag:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentTag = indexPath.row;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    
    if ([segue.identifier isEqualToString:@"inputData"])
    {
        UserInfoInputViewController *userInputVC = [segue destinationViewController];
        // Pass the selected object to the new view controller.
        switch (self.currentTag)
        {
            case 0:
                [userInputVC setValue:self.userInfoModel.userName forKey:@"userData"];
                break;
                
            case 1:
                [userInputVC setValue:self.userInfoModel.userMobile forKey:@"userData"];
                break;
                
            case 2:
                [userInputVC setValue:self.userInfoModel.userAddr forKey:@"userData"];
                break;
                
            default:
                break;
        }

        [userInputVC setDelegate:self];
    }
}

#pragma mark - UserInfoInputViewControllerDelegate
- (void)UserInfoInputViewControllerDelegateCallBack_dataFinishedWithData:(NSString *)data
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentTag inSection:0];
    switch (indexPath.row)
    {
        case 0:
            self.userInfoModel.userName = data;
            break;
            
        case 1:
            self.userInfoModel.userMobile = data;
            break;
            
        case 2:
            self.userInfoModel.userAddr = data;
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}
@end
