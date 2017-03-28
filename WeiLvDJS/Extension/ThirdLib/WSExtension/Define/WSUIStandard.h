//
//  WSUIStandard.h
//  Tools
//
//  Created by ternence on 16/11/20.
//  Copyright © 2016年 ternence. All rights reserved.
//

#ifndef WSUIStandard_h
#define WSUIStandard_h

#define WSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define WSAlphaColor(color, alpha) [color colorWithAlphaComponent:alpha]

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//#define C0   WSColor(0xff,0xff,0xff)
//#define C1   WSColor(0xd1,0xd1,0xd1)
//#define C2   WSColor(0xfc,0x67,0x66)
//#define C3   WSColor(0x08,0xcb,0xf9)
//#define C4   WSColor(0x14,0xd4,0xb8)
//#define C5   WSColor(0xfb,0xd4,0x4f)
//#define C6   WSColor(0xa1,0xc9,0x40)
//#define C7   WSColor(0xd7,0x5c,0x8b)
//#define C8   WSColor(0xee,0x00,0x34)
//#define C9   WSColor(0x89,0x89,0x89)
//#define C10  WSColor(0xad,0xad,0xad)
//#define C11  WSColor(0xeb,0xec,0xe8)
//#define C12  WSColor(0x44,0x44,0x44)
//#define C13  WSColor(0xc6,0xc6,0xc6)
//#define C14  WSColor(0xfd,0x9a,0x08)
//#define C15  WSColor(0x33,0x33,0x33)
//#define C16  WSColor(0x00,0x00,0x00)
//#define C17  WSColor(0xfd,0x4f,0x00)
//#define C18  WSColor(0x66,0x66,0x66)
//#define C19  WSColor(0x77,0x77,0x77)
//#define C20  WSColor(0xe6,0xe6,0xe6)
//#define C21  WSColor(0x88,0x88,0x88)
//#define C22  WSColor(0x34,0xa8,0xb8)
//#define C23  WSColor(0x3c,0x5b,0x9b)
//#define C24  WSColor(0x6a,0xc4,0x55)
//#define C25  WSColor(0xff,0xf8,0xf8)
//#define C26  WSColor(0x01,0x9b,0xff)
//#define C27  WSColor(0xfe,0x9b,0x08)
//#define C28  WSColor(0x38,0xa1,0xf3)
//#define C29  WSColor(0x49,0x65,0xa1)
//#define C30  WSColor(0x72,0xc1,0x60)
//#define C31  WSColor(0xef,0x69,0x55)


//字体大小

#define T1 [UIFont WSFontOfSize:21.0]
#define T2 [UIFont WSFontOfSize:18.0]
#define T3 [UIFont WSFontOfSize:15.0]
#define T4 [UIFont WSFontOfSize:14.0]
#define T5 [UIFont WSFontOfSize:13.0]
#define T6 [UIFont WSFontOfSize:12.0]
#define T7 [UIFont WSFontOfSize:11.0]
#define T8 [UIFont WSFontOfSize:10.0]


#define T1_Bold [UIFont WSBoldSystemFontOfSize:21.0]
#define T2_Bold [UIFont WSBoldSystemFontOfSize:18.0]
#define T3_Bold [UIFont WSBoldSystemFontOfSize:15.0]
#define T4_Bold [UIFont WSBoldSystemFontOfSize:14.0]
#define T5_Bold [UIFont WSBoldSystemFontOfSize:13.0]
#define T6_Bold [UIFont WSBoldSystemFontOfSize:12.0]
#define T7_Bold [UIFont WSBoldSystemFontOfSize:11.0]
#define T8_Bold [UIFont WSBoldSystemFontOfSize:10.0]

#endif /* WSUIStandard_h */
