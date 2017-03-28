//
//  AKGalleryCustUI.m
//  AKGallery
//
//  Created by ak on 16/11/9.
//  Copyright © 2016年 ak. All rights reserved.
//

#import "AKGalleryCustUI.h"

@implementation AKGalleryCustUI
-(instancetype)init{
    self=[super init];
    //defaults value
    self.spaceBetweenViewer=1;
    self.viewerBarTint=Color1;
    self.viewerBackgroundBlack=NO;
    self.navigationTint=Color1;
    self.listTitle=@"概览";
    self.minZoomScale=0.5;
    self.maxZoomScale=3;
    self.onlyViewer=YES;
    return self;
}
@end
