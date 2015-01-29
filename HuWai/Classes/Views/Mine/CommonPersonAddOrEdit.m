//
//  CommonPersonAddOrEdit.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "CommonPersonAddOrEdit.h"

@interface CommonPersonAddOrEdit ()<UIActionSheetDelegate>

@end

@implementation CommonPersonAddOrEdit

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.pageType == AddType) {
        self.title = @"添加";
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitData:)];
        self.navigationItem.rightBarButtonItem = rightItem;

    }else if (self.pageType == EditType){
        self.title = @"编辑";
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(submitData:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    [self.gender addTarget:self action:@selector(changeGender:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submitData:(UIBarButtonItem *)sender
{
    DLog(@"%@",sender.title);
}

-(void)changeGender:(UIButton *)sender
{
    [self dismissKeyBoard];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

-(void)dismissKeyBoard
{
    [self.peopleName resignFirstResponder];
    [self.identityNo resignFirstResponder];
    [self.phoneNo resignFirstResponder];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
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
