//
//  CommonPersonAddOrEdit.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "CommonPersonAddOrEdit.h"

@interface CommonPersonAddOrEdit ()<UIActionSheetDelegate>
{
    NSString *genderStr;
}

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
        if (_info) {
            self.peopleName.text = _info.name;
            [self.gender setTitle:_info.gender forState:UIControlStateNormal];
            self.identityNo.text = _info.identity;
            self.phoneNo.text = _info.phone;
        }
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
    if (self.pageType == AddType) {
        if ([CommonFoundation isEmptyString:self.peopleName.text] || [CommonFoundation isEmptyString:self.identityNo.text] || [CommonFoundation isEmptyString:self.phoneNo.text] || !genderStr) {
            [self showMessageWithThreeSecondAtCenter:@"请填写完整信息"];
            return;
        }
        [self postActionWithHUD:CommonPersonAddAction params:@"name",self.peopleName.text,@"gender",genderStr,@"identity",self.identityNo.text,@"phone",self.phoneNo.text,nil];
    }
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    if (response.code == 20000) {
        
    }
    [self showMessageWithThreeSecondAtCenter:response.message];
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
    genderStr = self.gender.titleLabel.text;
    if (buttonIndex == 0) {
        genderStr = @"男";
    }else if (buttonIndex == 1){
        genderStr = @"女";
    }
    [self.gender setTitle:genderStr forState:UIControlStateNormal];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
