//
//  Enroll.m
//  HuWai
//
//  Created by WmVenusMac on 15-2-27.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "Enroll.h"
#import "EnrollMembers.h"

@interface Enroll ()
{
    NSString *orderPerson;
    NSString *orderPersonPhone;
    NSString *emergencyPerson;
    NSString *emergencyPersonPhone;
}

@end

@implementation Enroll

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"enrollMember"]) {
        EnrollMembers *enMemberController = segue.destinationViewController;
        enMemberController.realname = orderPerson;
        enMemberController.phone = orderPersonPhone;
        enMemberController.o_realname = emergencyPerson;
        enMemberController.o_phone = emergencyPersonPhone;
        enMemberController.activityID = self.activityID;
    }
}


- (IBAction)orderCheckAction:(id)sender {
    orderPerson = [CommonFoundation trimString:self.orderPersonField.text];
    orderPersonPhone = [CommonFoundation trimString:self.orderPersonPhoneField.text];
    emergencyPerson = [CommonFoundation trimString:self.emergencyPersonField.text];
    emergencyPersonPhone = [CommonFoundation trimString:self.emergencyPersonPhoneField.text];
    if ([CommonFoundation isEmptyString:orderPerson] || [CommonFoundation isEmptyString:orderPersonPhone] || [CommonFoundation isEmptyString:emergencyPerson] || [CommonFoundation isEmptyString:emergencyPersonPhone]) {
        [self showMessageWithThreeSecondAtCenter:@"信息填写不完整"];
        return;
    }
    
    [self postAction:OrderPersonCheckAction params:@"realname",orderPerson,@"phone",orderPersonPhone,@"o_realname",emergencyPerson,@"o_phone",emergencyPersonPhone,nil];
}

-(void)onRequestFinished:(HttpRequestAction)tag response:(Response *)response
{
    [self performSegueWithIdentifier:@"enrollMember" sender:self];
}
@end
