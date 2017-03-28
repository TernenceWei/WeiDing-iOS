//
//  JHCusomHistory.m
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/2.
//  Copyright (c) 2015年 cjatech-简豪. All rights reserved.
//

#import "SearchCusomHistory.h"
#import "JHCustomFlow.h"
@interface SearchCusomHistory ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
      //流布局视图
    NSMutableArray      *_dataArr;          //流布局数据源
}

@end

@implementation SearchCusomHistory


/**
 *  初始化方法
 *
 *  @param frame 流布局frame
 *  @param items 外部导入的数据源
 *  @param click item点击响应回调block
 *
 *  @return 自定义流布局对象
 */
-(id)initWithFrame:(CGRect)frame andItems:(NSArray *)items andItemClickBlock:(itemClickBlock)click{
    
    if (self == [super initWithFrame:frame]) {
        _dataArr                    = [NSMutableArray arrayWithArray:items];
        _itemClick                  = click;
        self.userInteractionEnabled = YES;
        [self configBaseView];
    }
    return self;
}


/**
 *  搭建基本视图
 */
- (void)configBaseView{
    self.backgroundColor            = BgViewColor;
    
    /* 自定义布局格式 */
    JHCustomFlow *flow              = [[JHCustomFlow alloc] init];
    flow.minimumLineSpacing         = 5;
    flow.minimumInteritemSpacing    = 5;
    
    /* 初始化流布局视图 */
    _collectionView                 = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
    _collectionView.dataSource      = self;
    _collectionView.delegate        = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    /* 提前注册流布局item */
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"kheaderIdentifier"];
    
}


#pragma mark -------------> UICollectionView协议方法
/**
 *  自定义流布局item个数 要比数据源的个数多1 需要一个作为清除历史记录的行
 *
 *  @param collectionView 当前流布局视图
 *  @param section        nil
 *
 *  @return 自定义流布局item的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}


/**
 *  第index项的item的size大小
 *
 *  @param collectionView       当前流布局视图
 *  @param collectionViewLayout nil
 *  @param indexPath            item索引
 *
 *  @return size大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str      = _dataArr[indexPath.row];    
    /* 根据每一项的字符串确定每一项的size */
    NSDictionary *dict = @{NSFontAttributeName:WLFontSize(15)};
    CGSize size        = [str boundingRectWithSize:CGSizeMake(self.frame.size.width, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    size.height        = 35;
    size.width         += 10;
    
//    if (size.width>110) {
//        
//        size.width=110;
//    }
    

    return size;
    
}

/**
 *  流布局的边界距离 上下左右
 *
 *
 *
 *  @return 边界距离值
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(3, 5, 3, 3);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{

    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"kheaderIdentifier" forIndexPath:indexPath];
    
    view.backgroundColor = BgViewColor;
    
    UILabel *left =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 45)];
    
    left.textColor = [UIColor grayColor];
    
    left.font = WLFontSize(16);
    
    left.text = @"最近搜索";
    
    [view addSubview:left];
    
    
    UIButton *deleteButton =[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth-14-10, 15, 15, 15)];
    
    [deleteButton addTarget:self action:@selector(deleteTipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    
    [view addSubview:deleteButton];
    
    return view;
    
   
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={ScreenWidth,45};
    return size;
}
/**
 *  第index项的item视图
 *
 *  @param collectionView 当前流布局
 *  @param indexPath      索引
 *
 *  @return               item视图
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *vie in cell.contentView.subviews) {
        [vie removeFromSuperview];
    }


    NSString *str                       = _dataArr[indexPath.row];
    NSDictionary *dict                  = @{NSFontAttributeName:WLFontSize(16)};
    CGSize size                         = [str boundingRectWithSize:CGSizeMake(self.frame.size.width, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
//    if (size.width>100) {
//       
//        size.width =100;
//    }
    
    UILabel *label                      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 35)];
    label.text                          = str;
    label.font                          = WLFontSize(16);
    
    label.textColor = [WLTools stringToColor:@"#4877e7"];
    
    [cell.contentView addSubview:label];
    
    return cell;
}



/**
 *  当前点击的item的响应方法
 *
 *  @param collectionView 当前流布局
 *  @param indexPath      索引
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    /* 响应回调block */
    _itemClick(indexPath.row);
}


-(void)deleteTipButtonClicked:(UIButton *)button

{
    if (self.deleteButtonClick) {
        
        self.deleteButtonClick();
    }
}
@end
