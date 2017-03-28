//
//  JHCusomHistory.m
//  CJPubllicLessons
//
//  Created by cjatech-简豪 on 15/12/2.
//  Copyright (c) 2015年 cjatech-简豪. All rights reserved.
//

#import "JHCusomHistory.h"

@interface JHCusomHistory ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
       //流布局视图
    NSMutableArray      *_dataArr;          //流布局数据源
}

@end

@implementation JHCusomHistory


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
    self.backgroundColor            = [UIColor whiteColor];
    
    /* 自定义布局格式 */
    UICollectionViewFlowLayout *flow              = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing         = 5;
    flow.minimumInteritemSpacing    = 5;
    
    flow.scrollDirection =UICollectionViewScrollDirectionHorizontal;
    
    /* 初始化流布局视图 */
    _collectionView                 = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
    _collectionView.dataSource      = self;
    _collectionView.delegate        = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    /* 提前注册流布局item */
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
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
    return _dataArr.count ;
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
    NSDictionary *dict = @{NSFontAttributeName:WLFontSize(16)};
    CGSize size        = [str boundingRectWithSize:CGSizeMake(self.frame.size.width, 1000) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    size.height        = 55;
    size.width         += 12;
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
    return UIEdgeInsetsMake(3, 0, 3, 3);
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
    UIButton *label                      = [[UIButton alloc] initWithFrame:CGRectMake(3, 0, size.width, 55)];
    
    [label setTitle:str forState:UIControlStateNormal];
    
    label.titleLabel.font =WLFontSize(16);
    
    [label setTitleColor:[WLTools stringToColor:@"#879efa"] forState:UIControlStateNormal];
    
    [label addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];

    label.layer.borderColor             = [UIColor whiteColor].CGColor;
   
    [cell.contentView addSubview:label];
    
    UIImageView *im =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(label.frame)+4, CGRectGetMinY(label.frame)+20, 8, 15)];
    
    im.image =[UIImage imageNamed:@"arrow"];
    
    [cell.contentView addSubview:im];
    
    if (indexPath.row == _dataArr.count-1) {
        
        im.hidden =YES;
        
        [label setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        label.enabled =NO;
    }
    
    return cell;
}

-(void)labelClick:(UIButton *)button

{
    UICollectionViewCell *cell  =(UICollectionViewCell *) [button superview].superview;
    
    NSIndexPath *index =[_collectionView indexPathForCell:cell];
    
    _itemClick(index.row);
}

/**
 *  当前点击的item的响应方法
 *
 *  @param collectionView 当前流布局
 *  @param indexPath      索引
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
}


@end
