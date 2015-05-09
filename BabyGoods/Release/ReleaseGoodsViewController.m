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


    } progressBlock:^(NSInteger percentDone) {
        [SVProgressHUD showProgress:(percentDone * 0.01) status:@"正在上传"];
    }];
}

- (void)uploadGoodDataWithImage:(AVFile *)file
{
    AVObject *object = [AVObject objectWithClassName:kGoodModel];
    [object setObject:self.goodTitle.text forKey:good_name];
    [object setObject:self.ageRange.text forKey:good_ages];
    [object setObject:file forKey:good_image];
    [object setObject:[[UnifiedUserInfoManager share] getUserLoginName] forKey:good_userName];
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

// 设置图片
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

//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
#pragma mark - image picker delegte 
// 选择后返回
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil)
    {
        UIImage *newImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(200, 200)];
        // 设置图片
        [self.imageView setImage:newImage];
        self.model.image = newImage;
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
