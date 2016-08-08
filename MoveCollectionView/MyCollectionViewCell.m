//
//  MyCollectionViewCell.m
//  MoveCollectionView
//
//  GitHub:https://github.com/szweee
//  Blog:  http://www.szweee.com
//
//  Created by 索泽文 on 15/12/18.
//  Copyright © 2016年 索泽文. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.centerLabel.textColor = [UIColor purpleColor];
        self.centerLabel.font = [UIFont systemFontOfSize:20];
        self.centerLabel.textAlignment = NSTextAlignmentCenter;
        //[self addSubview:self.centerLabel];
        
        self.imageView = [[UIImageView alloc]init];
        self.imageView.frame = self.centerLabel.frame;
        [self addSubview:self.imageView];
        
    }
    return self;
}

@end
