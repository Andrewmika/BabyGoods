//
//  LoginRegistViewController.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/4/16.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginRegistViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@end
