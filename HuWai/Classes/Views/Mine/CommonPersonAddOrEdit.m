//
//  CommonPersonAddOrEdit.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "CommonPersonAddOrEdit.h"
#import "CommonPersonModel.h"
#import "EnrollMembers.h"

@interface CommonPersonAddOrEdit ()<UIActionSheetDelegate>
{
    CommonPersonInfo *_info;
    
    NSString *genderStr;
    NSString *pName;
    NSString *idNo;
    NSString *phone;
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
        if (self.pid) {
            NSArray *person = [[DatabaseUtil shareDatabase] selectFromTable:COMMON_PERSON_TABLE conditions:@{@"id":self.pid,@"ownerid":[APPInfo shareInit].uid}];
            _info = [[CommonPersonInfo alloc] initWithJsonDict:person[0]];
            self.peopleName.text = _info.name;
            [self.gender setTitle:[self genderToString:[_info.gender intValue]] forState:UIControlStateNormal];
            self.identityNo.text = _info.identity;
            self.phoneNo.text = _info.phone;
            genderStr = _info.gender;
        }
    }
    
    [self.gender addTarget:self action:@selector(changeGender:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

-(void)submitData:(UIBarButtonItem *)sender
{
    pName = [CommonFoundation trimString:self.peopleName.text];
    idNo = [CommonFoundation trimString:self.identityNo.text];
    phone = [CommonFoundation trimString:self.phoneNo.text];
    if ([CommonFoundation isEmptyString:pName] || [CommonFoundation isEmptyString:idNo] || [CommonFoundation isEmptyString:phone] || !genderStr) {
        [self showMessageWithThreeSecondAtCenter:@"请填写完整信息"];
        return;
    }
    
    if (self.pageType == AddType) {
        //添加
        [self postActionWithHUD:CommonPersonAddAction params:@"name",pName,@"gender",genderStr,@"identity",idNo,@"phone",phone,nil];
    }else{
        //编辑常用联系人
        [self postActionWithHUD:CommonPersonAddAction params:@"id",_info.pid,@"name",pName,@"gender",genderStr,@"identity",idNo,@"phone",phone,nil];
    }
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    NSString *successID = response.data[@"id"];
    if (self.pageType == AddType) {
        [[DatabaseUtil shareDatabase] insertTableName:COMMON_PERSON_TABLE keyArray:@[@"id",@"name",@"gender",@"identity",@"phone",@"ownerid"] valueArrary:@[successID,pName,genderStr,idNo,phone,[APPInfo shareInit].uid]];
        if (self.isFromEnroll) {
            [[NSNotificationCenter defaultCenter] postNotificationName:EnrollMembersAddNewNotification object:successID];
        }
    }else{
        [[DatabaseUtil shareDatabase] updateToTableName:COMMON_PERSON_TABLE kValues:@{@"name":pName,@"gender":genderStr,@"identity":idNo,@"phone":phone} condition:@{@"id":successID,@"ownerid":[APPInfo shareInit].uid}];
    }
    
}

-(void)changeGender:(UIButton *)sender
{
    [self dismissKeyBoard];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"女",@"男", nil];
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
    NSString *sexString = [self genderToString:buttonIndex];
    if (sexString) {
        genderStr = [NSString stringWithInteger:buttonIndex];
        [self.gender setTitle:sexString forState:UIControlStateNormal];
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
