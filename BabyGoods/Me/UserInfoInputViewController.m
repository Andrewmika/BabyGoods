//
//  UserInfoInputViewController.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/3.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "UserInfoInputViewController.h"

@interface UserInfoInputViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txfd;
@end

@implementation UserInfoInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.txfd setText:self.userData];
    [self.txfd setClearButtonMode:UITextFieldViewModeWhileEditing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SaveData:(UIBarButtonItem *)sender {
    
    if ([self.delegate respondsToSelector:@selector(UserInfoInputViewControllerDelegateCallBack_dataFinishedWithData:)])
    {
        [self.delegate UserInfoInputViewControllerDelegateCallBack_dataFinishedWithData:self.txfd.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
