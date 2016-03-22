//
//  KGLocalMusicSaveListView.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KGLocalMusicSaveListView;
@protocol KGLocalMusicSaveListViewDelegate <NSObject>

@optional
-(void)saveListView:(KGLocalMusicSaveListView*)saveListView didSaveListNameConfirm:(NSString*)saveListName;

@end

@interface KGLocalMusicSaveListView : UIView <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *  saveListName;
@property (weak, nonatomic) UIButton* okButton;
@property (weak, nonatomic) UIButton* cancelButton;

@property (weak, nonatomic) UIView* mengBoard;

@property (weak, nonatomic) id<KGLocalMusicSaveListViewDelegate> delegate;

+(instancetype)saveListView;

-(void)showinView:(UIView *)view;
-(void)hide;

@end
