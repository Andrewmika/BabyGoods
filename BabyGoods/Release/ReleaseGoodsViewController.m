//
//  ReleaseGoodsViewController.m
//  BabyGoods
//
//  Created by Andrew Shen on 15/5/3.
//  Copyright (c) 2015年 Andrew Shen. All rights reserved.
//

#import "ReleaseGoodsViewController.h"
#import <SVProgressHUD.h>
#import "goodModel.h"
#import <AVOSCloud.h>
#import "MyDefine.h"
#import "UnifiedUserInfoManager.h"

@interface ReleaseGoodsViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic,strong) goodModel *model;    // 物品model

@end

@implementation ReleaseGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage)];
    [self.imageView addGestureRecognizer:gest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (goodModel *)model
{
    if (!_model)
    {
        _model = [[goodModel alloc] init];
    }
    return _model;
}
- (void)addImage
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"图片选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)releaseGood:(UIBarButtonItem *)sender {
    NSData *data = UIImagePNGRepresentation(self.model.image);
    AVFile *file = [AVFile fileWithName:@"goodName.png" data:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            // 上传数据
            [self uploadGoodDataWithImage:file];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
    }];
}

- (void)uploadGoodDataWithImage:(AVFile *)file
{
    AVObject *object = [AVObject objectWithClassName:kGoodModel];
    [object setObject:self.goodTitle.text forKey:good_name];
    [object setObject:self.ageRange.text forKey:good_ages];
    [object setObject:file forKey:good_image];
    [object setObject:[[UnifiedUserInfoManager share] getUnserPhoneNum] forKey:good_userName];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            [SVProgressHUD showSuccessWithStatus:@"发布成功"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
    }];
}

// 设置头像
- (void)pickImageisFromCamera:(BOOL)isFromCamera
{
    NSInteger sourceType;
    // 拍照
    if (isFromCamera)
    {
        // 判断是否有摄像头
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        { sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"无法打开相机"];
            return;
        }
    }
    // 相册
    else
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self; imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}
#pragma mark - image picker delegte 
// 选择后返回
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil)
    {
        // 设置头像
        [self.imageView setImage:image];
        self.model.image = image;
    }
    // 销毁照片选择器
    [self dismissViewControllerAnimated:NO completion:nil];
}
// 取消返回
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self pickImageisFromCamera:NO];
            break;
            
            
        case 1:
            [self pickImageisFromCamera:YES];
            break;
        default:
            break;
    }
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
