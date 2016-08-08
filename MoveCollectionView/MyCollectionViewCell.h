//
//  MyCollectionViewCell.h
//  MoveCollectionView
//
//  GitHub:https://github.com/szweee
//  Blog:  http://www.szweee.com
//
//  Created by 索泽文 on 15/12/18.
//  Copyright © 2016年 索泽文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell<UIGestureRecognizerDelegate>

@property (nonatomic,strong)UILabel *centerLabel;
@property (nonatomic,strong)UIImageView *imageView;

@end
