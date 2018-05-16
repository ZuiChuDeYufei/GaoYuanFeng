//
//  GJModifyRealnameVC.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/5/2.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJModifyRealnameVC.h"
#import "GJMineManager.h"

#define Tag_InputField  34623456

@interface GJModifyRealnameVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) GJMineManager *mineManager;

@end

@implementation GJModifyRealnameVC

#pragma mark - View controller life circle
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableview.frame = CGRectMake(0, 0, self.view.width, self.view.height-49);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationData];
    [self initializationSubView];
    [self initializationNetWorking];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showShadorOnNaviBar:YES];
}

#pragma mark - Iniitalization methods
- (void)initializationData {
    
}

- (void)initializationSubView {
    self.title = @"姓名";
    [self allowBack];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, APP_CONFIG.appMainColor,NSForegroundColorAttributeName, nil];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateHighlighted];
    
    [self.view addSubview:self.tableview];
}

- (void)initializationNetWorking {}

#pragma mark - Request Handle
- (void)requestModifyRealName:(NSString *)realName {
    _mineManager = [[GJMineManager alloc] init];
    [_mineManager requestEditUserInfoWithName:realName context:self];
}

#pragma mark - Private methods


#pragma mark - Event response
- (void)rightBarBtnClick {
    @try {
        UITextField *tf = (UITextField *)[self.view viewWithTag:Tag_InputField];
        [tf resignFirstResponder];
        if (tf.text.length >= 2 && tf.text.length <= 16) {
            if ([tf.text isValidNickName]) {
                [self requestModifyRealName:tf.text];
            }
            else ShowWaringAlertHUD(@"姓名格式有误，请重新输入", nil);
        }else {
            if (tf.text.length > 16) {
                tf.text = [tf.text substringToIndex:16];
            }
            ShowWaringAlertHUD(@"姓名长度不正确", nil);
        }
    } @catch (NSException *exception) {}
}

#pragma mark - UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"tableview";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        UITextField *nickNameTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, SCREEN_W-30, 44)];
        nickNameTF.delegate = self;
        nickNameTF.backgroundColor = APP_CONFIG.whiteGrayColor;
        nickNameTF.font = AdapFont([APP_CONFIG appFontOfSize:14]);
        nickNameTF.placeholder = @"未填写";
        nickNameTF.tag = Tag_InputField;
        nickNameTF.text= APP_USER.userInfo.username;
        nickNameTF.tintColor= [UIColor blueColor];
        nickNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        nickNameTF.returnKeyType = UIReturnKeyDone;
        nickNameTF.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        [nickNameTF becomeFirstResponder];
        [nickNameTF setValue:[APP_CONFIG appFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [nickNameTF setValue:[UIColor colorWithHexRGB:@"#aaaaaa"] forKeyPath:@"_placeholderLabel.textColor"];
        [cell.contentView addSubview:nickNameTF];
    }
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *textStr = [textField.text changeCharactersInRange:range replacementString:string];
    if ([string isEqualToString:@""]) {
        return YES;
    }
    // markedTextRange 解决拼音预览输入导致统计字数不正确bug
    if (textStr.length <= 16 || textField.markedTextRange != nil) {
        if (range.length > 0 && [NSString stringWithFormat:@"%@%@", textStr, string].length > 16) {
            ShowWaringAlertHUD(@"昵称为2-16个字符", nil);
            textField.text = [[NSString stringWithFormat:@"%@%@", textStr, string] substringToIndex:16];
            return NO;
        }
        return YES;
    }else {
        ShowWaringAlertHUD(@"昵称为2-16个字符", nil);
        @try {
            textField.text = [textStr substringToIndex:16];
        } @catch (NSException *exception) {}
        return NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Custom delegate


#pragma mark - Getter/Setter
- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.scrollEnabled = NO;
        _tableview.backgroundColor = APP_CONFIG.appBackgroundColor;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.sectionHeaderHeight = 0.1f;
        _tableview.sectionFooterHeight = 0.1f;
        _tableview.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    }
    return _tableview;
}

@end
