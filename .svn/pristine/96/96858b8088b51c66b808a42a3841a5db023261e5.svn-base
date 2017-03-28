//
//  WL_PrivateDetail_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_PrivateDetail_ViewController.h"
#import "WL_PrivateDetail_Model.h"
#import "WLLetterItemCell.h"
#import "WLNetworkMessageHandler.h"
#import "WLLetterDetailCell.h"

@interface WL_PrivateDetail_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property(nonatomic,strong)NSMutableArray *detailArray;
@property(nonatomic,strong)WL_PrivateDetail_Model *detailModel;
@property(nonatomic,strong)UILabel *messageNum;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)XKPEPlaceholderTextView *textView;
@property(nonatomic,strong)UIView *bottomView;

@end

static NSString *cellID = @"cellID";
@implementation WL_PrivateDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.title =@"私信";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setupUI];
    [self loadData];
}

-(void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 60)];
    [self.tableView registerClass:[WLLetterItemCell class] forCellReuseIdentifier:cellID];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];

    self.bottomView =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), ScreenWidth, 60)];
    self.bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.bottomView.userInteractionEnabled =YES;
    [self.view addSubview:self.bottomView];
    
    self.textView = [[XKPEPlaceholderTextView alloc]initWithFrame:CGRectMake(8, 7, ScreenWidth-16-40, 60-14)];
    self.textView.textColor = [WLTools stringToColor:@"#2f2f2f"];
    self.textView.placeholderColor = [WLTools stringToColor:@"#868686"];
    self.textView.font = WLFontSize(18);
    self.textView.layer.cornerRadius =3.0;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.delegate = self;
    self.textView.placeholder = @"输入回复内容...";
    [self.bottomView addSubview:self.textView];
    
    UIButton *sendButton =[[UIButton alloc]initWithFrame:CGRectMake(ViewRight(self.textView)+4, 0, 40, 60)];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitleColor:[WLTools stringToColor:@"#4877e7"] forState:UIControlStateNormal];
    [self.bottomView addSubview:sendButton];
 }


#pragma mark UItableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.detailArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WLLetterDetailCell *cell = [WLLetterDetailCell cellWithTableView: tableView];
        cell.detailModel = self.detailModel;
        return cell;
    }
    WLLetterItemCell  *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell =[[WLLetterItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = self.detailArray[indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        CGFloat messageHeight = [WLUITool sizeWithString:self.detailModel.content font:WLFontSize(12.5)].height;
        return messageHeight + 60;
    }
    WL_authorInfo_Model *model = self.detailArray[indexPath.row];
    return [WLLetterItemCell heightWithModel:model];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *messageView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
        messageView.backgroundColor = [UIColor whiteColor];
  
        UIView *line = [UILabel new];
        line.backgroundColor = bordColor;
        [messageView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(44.5);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 0.5));
            
        }];
        
        UIImageView *message = [UIImageView new];
        message.image =[UIImage imageNamed:@"MessageRead"];
        [messageView addSubview:message];
        [message mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            
        }];
        
        self.messageNum = [UILabel new];
        self.messageNum.textColor = [WLTools stringToColor:@"#6f7378"];
        self.messageNum.font =WLFontSize(12);
        [messageView addSubview:self.messageNum];
        [self.messageNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(message.mas_right).offset(10);
            make.top.mas_equalTo(message.mas_top);
            make.height.mas_equalTo(15);
            
        }];
        self.messageNum.text = [NSString stringWithFormat:@"%lu",self.detailModel.reply.count];
        return messageView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *footer = [[UIView alloc] init];
        footer.backgroundColor = bordColor;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 45;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 0;
}

#pragma mark network
-(void)loadData{
    
    WS(weakSelf);
    [WLNetworkMessageHandler requestPrivateLetterDetailWithLetterID:self.model.letterId
                                                          dataBlock:^(WLResponseType responseType, id data, NSString *message) {
                                                              if (responseType == WLResponseTypeSuccess) {
                                                                  weakSelf.detailModel = (WL_PrivateDetail_Model *)data;
                                                                  weakSelf.detailArray = [weakSelf.detailModel.reply mutableCopy];
                                                                  [weakSelf.tableView reloadData];
                                                                  
                                                              }
                                                              
                                                          }];
    
    
}


-(void)sendButtonClick{
  
    if (self.textView.text.length==0) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入回复信息"];
        return;
    }
    [self.view endEditing:YES];
    WS(weakSelf);
    [WLNetworkMessageHandler postPrivateLetterWithLetterID:self.model.letterId
                                                   content:self.textView.text
                                            operationBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
                                                
                                                if (responseType == WLResponseTypeSuccess && result) {
                                                    [weakSelf loadData];
                                                    
                                                    [[WL_TipAlert_View sharedAlert]createTip:@"发送成功"];
                                                }else{
                                                    [[WL_TipAlert_View sharedAlert]createTip:@"发送失败"];
                                                }
                                            }];
}

#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
    }
    if (self.textView.text.length>=300) {
        return NO;
    }
    return YES;
}

#pragma mark 键盘
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyBoardRect=[aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
           make.bottom.mas_equalTo(-keyBoardRect.size.height);
           make.left.mas_equalTo(0);
           make.size.mas_equalTo(CGSizeMake(ScreenWidth, 60));
    }];
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, keyBoardRect.size.height, 0);
    CGRect lastRect = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:self.detailArray.count - 1 inSection:1]];
    [self.tableView scrollRectToVisible:lastRect animated:YES];
}

- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, 0, 0, 0);
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 60));
    }];

}

-(NSMutableArray *)detailArray
{
    if (_detailArray==nil) {
        _detailArray =[NSMutableArray arrayWithCapacity:0];
    }
    return _detailArray;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
