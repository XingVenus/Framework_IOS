//
//  profile.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Profile.h"
#import "AvatarObject.h"

@interface Profile ()<ImagePickerDelegate>
- (IBAction)avatarChange:(id)sender;

//- (IBAction)passwordChange:(id)sender;
@end

@implementation Profile

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:[APPInfo shareInit].avatar] placeholderImage:[UIImage imageNamed:@"avatar"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  pickerView 需要显示的UIImagePickerController控制器
 */
-(void)presentImagePickerView:(UIImagePickerController *)pickerView
{
    [self presentViewController:pickerView animated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)avatarChange:(id)sender {
    AvatarObject *aobj = [AvatarObject shareImagePicker];
    aobj.pickDelegate = self;
    [aobj steupWithView:self.view];
}

//- (IBAction)passwordChange:(id)sender {
//    
//}
@end
