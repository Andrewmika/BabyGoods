//
//  UserInfoInputViewController.h
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/3.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//  用户信息填写界面

#import <UIKit/UIKit.h>

@protocol UserInfoInputViewControllerDelegate <NSObject>

- (void)UserInfoInputViewControllerDelegateCallBack_dataFinishedWithData:(NSString *)data;

@end
@interface UserInfoInputViewController : UIViewController
@property (nonatomic,strong) NSString *userData;    // 信息
@property (nonatomic,weak) id <UserInfoInputViewControllerDelegate> delegate;    // 委托
@end
