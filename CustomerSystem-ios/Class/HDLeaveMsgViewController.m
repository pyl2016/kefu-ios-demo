//
//  SCLeaveMsgViewController.m
//  CustomerSystem-ios
//
//  Created by afanda on 16/11/24.
//  Copyright © 2016年 easemob. All rights reserved.
//

#import "HDLeaveMsgViewController.h"
#import "CustomButton.h"
#import "FLTextView.h"
#import "HLeaveMessageSucceedViewController.h"
typedef NS_ENUM(NSUInteger, NSTextFieldTag) {
    NSTextFieldTagName=342,
    NSTextFieldTagTel,
    NSTextFieldTagMail,
    NSTextFieldTagContent
};



@interface HDLeaveMsgViewController ()<UITextFieldDelegate>

{
    UIView *_bottomView;
}

@property (nonatomic, strong) FLTextView *textView;

@end

@implementation HDLeaveMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBarButtonItem];
    [self.view addSubview:self.textView];
    NSArray *placeholders = @[@"姓名",@"电话",@"邮箱",@"主题"];
    for (int i=0; i<4; i++) {
        [self createTextfieldWithY:CGRectGetMaxY(self.textView.frame) +60*i placeholder:placeholders[i] tag:i+NSTextFieldTagName];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}


- (FLTextView *)textView
{
    if (_textView == nil) {
        _textView = [[FLTextView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight * 0.4)];
        [_textView setPlaceholderText:[NSString stringWithFormat:@"%@%@",@"输入留言",@"..."]];
        _textView.fontSize = 16.0;
        _textView.font = [UIFont systemFontOfSize:18];
        _textView.layer.borderColor = [UIColor clearColor].CGColor;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textView.frame), kScreenWidth, 0.5f)];
        //        line.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:line];
    }
    return _textView;
}

- (void)createTextfieldWithY:(CGFloat)y placeholder:(NSString *)placeholder tag:(NSTextFieldTag)tag
{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, y, kScreenWidth-140, 40)];
    textField.font = [UIFont systemFontOfSize:15];
    UILabel *beforeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, y + 4, 40, 30)];
    beforeLabel.text = [NSString stringWithFormat:@"%@:", placeholder];
    beforeLabel.font = [UIFont systemFontOfSize:15];
    
    UILabel *lateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame) + 10, y + 4, 40, 30)];
    lateLabel.text = @"必填";
    lateLabel.textColor = [UIColor grayColor];
    lateLabel.font = [UIFont systemFontOfSize:15];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, y + 42, kScreenWidth - 40, 1.f)];
    line.backgroundColor = [UIColor blackColor];
    
    if (tag == NSTextFieldTagTel) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    textField.tag = tag;
    textField.delegate = self;
    [self.view addSubview:beforeLabel];
    [self.view addSubview:lateLabel];
    [self.view addSubview:line];
    [self.view addSubview:textField];
}

- (void)leaveMessage {
    [self.view endEditing:YES];
    NSString *name = ((UITextField *)[self.view viewWithTag:NSTextFieldTagName]).text;
    NSString *tel = ((UITextField *)[self.view viewWithTag:NSTextFieldTagTel]).text;
    NSString *mail = ((UITextField *)[self.view viewWithTag:NSTextFieldTagMail]).text;
    NSString *subject = ((UITextField *)[self.view viewWithTag:NSTextFieldTagContent]).text;
    NSString *content = _textView.text;
    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    NSString *subject = content.length >=10 ? [content substringToIndex:10] : content;
//    [parameters setValue:subject forKey:@"subject"];
//    [parameters setObject:content.length>0 ? content:@"" forKey:@"content"];
    
    Creator *creator = [Creator new];
    creator.name = name;
    creator.email = mail;
    creator.phone = tel;
    creator.qq = @"123456";
    creator.desc = @"我是一只丑小鸭";
    creator.companyName = @"环信客服";
    LeaveMsgRequestBody *body = [LeaveMsgRequestBody new];
    body.creator = creator;
    body.content = content;
    body.subject = subject;
    SCLoginManager *logM = [SCLoginManager shareLoginManager];
    [self showHudInView:self.view hint:@"发送中..."];
    [[HLeaveMsgManager shareInstance] asyncCreateMessageWithTenantId:logM.tenantId projectId:logM.projectId cname:logM.cname requestBody:body completion:^(id responseObject, NSError *error) {
        if (error == nil) {
            NSLog(@"发送留言成功");
            [self hideHud];
            [self showHudInView:self.view hint:@"留言发送中"];
            
            HLeaveMessageSucceedViewController *lmsvc = [[HLeaveMessageSucceedViewController alloc] init];
            NSMutableArray *array = [NSMutableArray array];
            [array addObject:name];
            [array addObject:tel];
            [array addObject:mail];
            [array addObject:subject];
            [array addObject:content];
            NSArray *arr = [NSArray arrayWithArray:array];
            lmsvc.leaveMessageArray = arr;
            [self.navigationController pushViewController:lmsvc animated:YES];

        } else {
            NSLog(@"发送留言失败");
            [self hideHud];
            [self showHudInView:self.view hint:@"发送失败，请稍后重试"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self hideHud];
                    [self.navigationController popViewControllerAnimated:YES];
            });
        }

    }];
    
 
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_ADDMSG_TO_LIST object:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == NSTextFieldTagTel && ![string isEqualToString:@""]) {
        if (textField.text.length >=20) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"长度受限" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

- (void)setupBarButtonItem
{
    CustomButton * backButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
    [backButton setTitle:@"留言" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:22];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitleColor:RGBACOLOR(184, 22, 22, 1) forState:UIControlStateHighlighted];
    backButton.imageRect = CGRectMake(10, 10, 20, 18);
    backButton.titleRect = CGRectMake(45, 10, 120, 18);
    [self.view addSubview:backButton];
    backButton.frame = CGRectMake(self.view.width * 0.5 - 80, 250, 160, 40);
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    _bottomView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_bottomView];
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 0, 50, 50)];
    [sendButton setTitle:NSLocalizedString(@"send", @"Send") forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(leaveMessage) forControlEvents:UIControlEventTouchUpInside];
    

    [_bottomView addSubview:sendButton];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
