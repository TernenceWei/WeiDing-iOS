//
//  WLAttachmentCell.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLChargeUpCarObject.h"

@interface WLAttachmentCell : UITableViewCell
+ (WLAttachmentCell *)cellWithTableView:(UITableView*)tableView
                        openAlbumAction:(void(^)(UIImagePickerController * pickerVC))action
                       photoCheckAction:(void(^)(UIImage *image, NSURL *imageUrl))photoCheckAction
                                canEdit:(BOOL)canEdit;

@property (nonatomic, strong) NSMutableArray *imgArray;
- (NSArray *)getUploadImageArray;
- (void)modifyPictureJustDelete:(BOOL)isDelete;
@end
