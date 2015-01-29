//
//  AvatarObject.h
//  PSCollectionViewDemo
//
//  头像选择修改类
//
//  Created by WmVenusMac on 14-7-30.
//
//

#import <Foundation/Foundation.h>

@protocol ImagePickerDelegate <NSObject>

@required
/**
 *  pickerView 需要显示的UIImagePickerController控制器
 */
-(void)presentImagePickerView:(UIImagePickerController *)pickerView;
/**
 *  imageData 图片数据
 *  ext     图片格式：png、jpg
 */
@optional
-(void)endPickerImageWithData:(NSData *)imageData;
-(void)endPickerImageWithImage:(UIImage *)image;

@end

@interface AvatarObject : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) id<ImagePickerDelegate> pickDelegate;

+(instancetype)shareImagePicker;
-(void)steupWithView:(UIView *)view;
@end
