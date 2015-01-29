//
//  AvatarObject.m
//  PSCollectionViewDemo
//
//  Created by WmVenusMac on 14-7-30.
//
//

#import "AvatarObject.h"

@implementation AvatarObject

+(instancetype)shareImagePicker
{
    static AvatarObject *pickerManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pickerManager = [[self alloc] init];
    });
    return pickerManager;
}

-(void)steupWithView:(UIView *)view {
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]
                                    initWithTitle:@"更换头像"
                                    delegate:self
                                    cancelButtonTitle:@"取消"
                                    destructiveButtonTitle:nil
                                    otherButtonTitles: @"相册", @"拍照",nil];
    [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //从相册选择
            [self LocalPhoto];
            break;
        case 1:
            //拍照
            [self takePhoto];
            break;
        default:
            break;
    }
}
//从相册选择
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    if (_pickDelegate && [_pickDelegate respondsToSelector:@selector(presentImagePickerView:)]) {
        [_pickDelegate presentImagePickerView:picker];
    }
//    [self presentViewController:picker animated:YES completion:nil];
}

//拍照
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        //        [self presentModalViewController:picker animated:YES];
//        [self presentViewController:picker animated:YES completion:nil];
        if (_pickDelegate && [_pickDelegate respondsToSelector:@selector(presentImagePickerView:)]) {
            [_pickDelegate presentImagePickerView:picker];
        }
    }else {
        NSLog(@"该设备无摄像头");
    }
}
#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        
        if (_pickDelegate && [_pickDelegate respondsToSelector:@selector(endPickerImageWithImage:)]) {
            [_pickDelegate endPickerImageWithImage:image];
        }
        
        //以下是保存文件到沙盒路径下
        //把图片转成NSData类型的数据来保存文件
        NSData *data;
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            data = UIImagePNGRepresentation(image);
        }else {
            //返回为JPEG图像。
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        //保存
//        [[NSFileManager defaultManager] createFileAtPath:self.imageStoragePath contents:data attributes:nil];
        if (_pickDelegate && [_pickDelegate respondsToSelector:@selector(endPickerImageWithData:)]) {
            [_pickDelegate endPickerImageWithData:data];
        }
    }
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
