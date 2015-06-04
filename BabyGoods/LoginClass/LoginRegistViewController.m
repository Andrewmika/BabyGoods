//
//  LoginRegistViewController.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/16.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "LoginRegistViewController.h"
#import <AVOSCloud.h>
#import <SVProgressHUD.h>
#import "UnifiedUserInfoManager.h"

@interface LoginRegistViewController ()

@end

@implementation LoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userRegist {
    
    AVUser *user = [AVUser user];
    user.username = self.phoneNum.text;
    user.password = self.password.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [[UnifiedUserInfoManager share] saveUserLoginName:self.phoneNum.text];

            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
        }
    }];
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
