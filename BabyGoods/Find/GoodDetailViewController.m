//
//  GoodDetailViewController.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/9.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "GoodDetailViewController.h"
#import <UIImageView+WebCache.h>
#import "UserInfoModel.h"
#import "MyDefine.h"
#import <AVOSCloud.h>

@interface GoodDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *ageRange;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *contact;
@property (nonatomic,strong) UserInfoModel *infoModel;    // 物主信息model
@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.infoModel = [self queryGoodHostModelWithName:self.goodModel.goodUserName];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.goodModel.imagePath] placeholderImage:[UIImage imageNamed:@"imageViewBG"]];
    [self.name setText:self.goodModel.goodName];
    [self.ageRange setText:self.goodModel.goodAges];
    [self.userName setText:self.infoModel.userName];
    [self.contact setText:self.infoModel.userMobile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)callGoodHost {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.infoModel.userMobile]];// 出现是否拨打提示框，结束后弹回app
    [[UIApplication sharedApplication] openURL:url];

}

// 查询物主信息
- (UserInfoModel *)queryGoodHostModelWithName:(NSString *)name
{
    UserInfoModel *model = [[UserInfoModel alloc] init];
    AVQuery *query = [AVQuery queryWithClassName:kUserInfoModel];
    [query whereKey:user_loginName equalTo:name];
    AVObject *object = [query getFirstObject];
    model.userName = [object objectForKey:user_name];
    model.userMobile = [object objectForKey:user_mobile];
    model.userAddr = [object objectForKey:user_address];
    
    return model;
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
