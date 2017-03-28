//
//  WL_PrivateDetail_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/10.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_PrivateDetail_ViewController.h"

#import "WL_PrivateDetail_Model.h"

#import "WL_PrivateDetail_Cell.h"


@interface WL_PrivateDetail_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>


@property(nonatomic,strong)NSMutableArray *detailArray;

@property(nonatomic,strong)WL_PrivateDetail_Model *baseModel;

@property(nonatomic,strong)UIImageView *portrait;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)UILabel *messageNum;

@property(nonatomic,strong)UILabel *line;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)XKPEPlaceholderTextView *textView;

@property(nonatomic,strong)UIView *bottomView;

@end


static NSString *cellID = @"cellID";

@implementation WL_PrivateDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =BgViewColor;
    
    self.navigationItem.title =@"私信";
    
    ////增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    

    [self initHeaderView];
    
    [self loadPrivatePetterDetailData];
}

-(NSMutableArray *)detailArray
{
    if (_detailArray==nil) {
        
        _detailArray =[NSMutableArray arrayWithCapacity:0];
    }
    
    return _detailArray;
}



-(void)initHeaderView
{
    
    UIView *topView =[UIView new];
    
    topView.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.left.mas_equalTo(0);
        
        make.width.mas_equalTo(ScreenWidth);
    }];
    
    self.portrait = [UIImageView new];
    
    //self.portrait.backgroundColor = [UIColor redColor];
    
    [topView addSubview:self.portrait];
    
    [self.portrait mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.size.mas_equalTo(CGSizeMake(45, 45));
        
    }];
    
    self.portrait.layer.cornerRadius = 22.5;
    
    self.portrait.layer.masksToBounds = YES;
    
    //[self.portrait sd_setImageWithURL:[NSURL URLWithString:self.model.UserPhoto] placeholderImage:nil];
    
    self.nameLabel =[UILabel new];
    
    self.nameLabel.font =WLFontSize(15);
    
    self.nameLabel.textColor = BlackColor;
    
    //self.nameLabel.text = self.model.realName;
    
    [topView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.portrait.mas_right).mas_offset(10);
        
        make.top.mas_equalTo(self.portrait.mas_top).offset(2);
        
        make.height.mas_equalTo(20);
        
    }];
    
    self.dateLabel = [UILabel new];
    
    self.dateLabel.textColor = [WLTools stringToColor:@"#6f7378"];
    
    self.dateLabel.textAlignment = NSTextAlignmentRight;

    
    self.dateLabel.font = WLFontSize(14);
    
    [topView addSubview:self.dateLabel];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(topView.mas_right).offset(-15);
        
        make.top.mas_equalTo(self.nameLabel.mas_top);
        
    }];
    
    self.detailLabel = [UILabel new];
    
    self.detailLabel.numberOfLines= 0;
    
    self.detailLabel.textColor =[WLTools stringToColor:@"#6f7378"];
    
    self.detailLabel.font =WLFontSize(12.5);
    
    //detailLabel.text = self.model.letterContent;
    
    [topView addSubview:self.detailLabel];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.nameLabel.mas_left);
        
        make.width.mas_equalTo(ScreenWidth-85);
        
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        
        make.bottom.mas_equalTo(topView.mas_bottom).offset(-15);
        
    }];
    
    UIView *messageView =[UIView new];
    
    messageView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:messageView];
    
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(topView.mas_bottom).offset(15);
        
        make.left.mas_equalTo(0);
        
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 45));
        
    }];
    
    
    self.line = [UILabel new];
    
    self.line.backgroundColor =bordColor;
    
    [messageView addSubview:self.line];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
      
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
    
    //messageNum.text = self.model.noReadCount;
    
    [messageView addSubview:self.messageNum];
    
    [self.messageNum mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(message.mas_right).offset(10);
        
        make.top.mas_equalTo(message.mas_top);
        
        make.height.mas_equalTo(15);
        
    }];
    WlLog(@"%f",ViewBelow(topView));
    
    self.tableView =[[UITableView alloc]init];
    
    [self.tableView registerClass:[WL_PrivateDetail_Cell class] forCellReuseIdentifier:cellID];
    
    self.tableView.dataSource =self;
    
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView =[UIView new];
    
    [self.view addSubview:self.tableView];
    
   [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      
       make.top.mas_equalTo(messageView.mas_bottom);
       
       make.left.mas_equalTo(0);
       
       make.width.mas_equalTo(ScreenWidth);
       
       make.bottom.mas_equalTo(self.view.mas_bottom).offset(-60);
       
   }];
    
    self.bottomView =[UIView new];
    
    self.bottomView.backgroundColor = WLColor(75, 75, 75, 1);
    
    self.bottomView.userInteractionEnabled =YES;
    
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(0);
        
        make.top.mas_equalTo(self.tableView.mas_bottom);
        
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 60));
        
    }];
    
    
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
-(void)loadPrivatePetterDetailData
{
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"letterId":self.model.letterId};
    
    WS(weakSelf);
    
    [self showHud];
    
    [[WLHttpManager shareManager]requestWithURL:LetterDetailUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        WlLog(@"%@",responseObject);
        
        [weakSelf hidHud];
        
        WL_Network_Model *net_model =[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        //[QXBModelTool createJsonModelWithDictionary:net_model.data[0] modelName:@"12"];
        
        if ([net_model.result integerValue]==1) {
            
            self.baseModel = [WL_PrivateDetail_Model mj_objectWithKeyValues:net_model.data];
            
            for (NSDictionary *dic in self.baseModel.reply) {
                
                WL_authorInfo_Model *model = [WL_authorInfo_Model mj_objectWithKeyValues:dic];
                
                [self.detailArray addObject:model];
                
            }
 
        }

        [self.portrait sd_setImageWithURL:[NSURL URLWithString:self.baseModel.userInfo.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
     
        self.nameLabel.text = self.baseModel.userInfo.user_name;
        
        self.dateLabel.text = self.baseModel.create_date;
      
        self.detailLabel.text = self.baseModel.content;
        
        self.messageNum.text = [NSString stringWithFormat:@"%lu",self.baseModel.reply.count];
        
        [self.view updateConstraints];
        
        [self.view updateConstraintsIfNeeded];
  
        [self.view layoutIfNeeded];
   
        [self.tableView reloadData];
        
    } Failure:^(NSError *error) {
       
         [weakSelf hidHud];
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WL_authorInfo_Model *model = self.detailArray[indexPath.row];
    

   return [WL_PrivateDetail_Cell heightWithModel:model];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WL_PrivateDetail_Cell  *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[WL_PrivateDetail_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.model = self.detailArray[indexPath.row];
    
    return cell;
}

-(void)sendButtonClick
{
  
    if (self.textView.text.length==0) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入回复信息"];
        
        return;
    }
    
    [self.view endEditing:YES];
    
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"letterId":self.model.letterId,@"content":self.textView.text};
    
    WS(weakSelf);
    
    [self.detailArray removeAllObjects];
    
    //[self showHud];
    
    [[WLHttpManager shareManager]requestWithURL:LetterAddReplyUrl RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        //[weakSelf hidHud];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if ([netModel.result integerValue]==1) {
            
            [weakSelf loadPrivatePetterDetailData];
            
            [[WL_TipAlert_View sharedAlert]createTip:@"发送成功"];
            
        }else
        {
            [[WL_TipAlert_View sharedAlert]createTip:@"发送失败"];
        }
        
       
        
    } Failure:^(NSError *error) {
       
       
        
        [[WL_TipAlert_View sharedAlert]createTip:@"发送失败"];
        
    }];
}

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
#pragma mark 键盘出现
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyBoardRect=[aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
           
           make.bottom.mas_equalTo(-keyBoardRect.size.height);
           
           make.left.mas_equalTo(0);
           
           make.size.mas_equalTo(CGSizeMake(ScreenWidth, 60));
    }];

    [self.view updateConstraints];
    
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}
#pragma mark 键盘消失
- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.tableView.mas_bottom);
        
        make.left.mas_equalTo(0);
        
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, 60));
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
