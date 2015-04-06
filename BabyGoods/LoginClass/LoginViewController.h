//
//  LoginViewController.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/4.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UITextField *txfdID;
@property (strong, nonatomic) IBOutlet UITextField *txfdPSW;
@property (strong, nonatomic) IBOutlet UIButton *btnCancle;

@end
