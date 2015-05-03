//
//  LoginViewController.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/4.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "LoginViewController.h"
#import <AVOSCloud.h>
#import "UnifiedUserInfoManager.h"
#import <SVProgressHUD.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login {
    [AVUser logInWithUsernameInBackground:self.txfdID.text password:self.txfdPSW.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [[UnifiedUserInfoManager share] saveUserPhoneNum:self.txfdID.text];
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
