//
//  KGLocalMusicSaveListView.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGLocalMusicSaveListView.h"
#import "UIView+Extension.h"
#import "CoreDataMngTool.h"


#define Margin 20.f
#define MidMargin 8.f
@interface KGLocalMusicSaveListView()
@property(strong,nonatomic)NSArray * saveNameList;
@property(copy,nonatomic) NSString * saveName;
@end

@implementation KGLocalMusicSaveListView
-(NSArray *)saveNameList{
    if (_saveNameList == nil) {
        _saveNameList = [CoreDataMngTool sharedCoredataMngTool].saveNameList;
    }
    return  _saveNameList;
}

+(instancetype)saveListView{
    KGLocalMusicSaveListView* saveListView = [[KGLocalMusicSaveListView alloc]init];
    
    saveListView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.6, 198.f);
    saveListView.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.5);
    saveListView.backgroundColor = [UIColor lightGrayColor];
    return saveListView;
}

//添加子控件
-(instancetype)init{
    self = [super init];
    if (self) {
        
        //view的四个边是圆弧状
        self.layer.cornerRadius = 20.f;
        
        UITableView* saveListName = [[UITableView alloc]init];
        
        saveListName.dataSource =self;
        saveListName.delegate =self;
        
        _saveListName = saveListName;
        [self addSubview:saveListName];
        
        
        UIButton* okButton = [[UIButton alloc]init];
        _okButton = okButton;
        
        okButton.layer.borderColor = [[UIColor yellowColor] CGColor];
        okButton.layer.borderWidth = 2.0;
        okButton.layer.cornerRadius = 15.f;
        
        okButton.backgroundColor = [UIColor blueColor];
        [self addSubview:okButton];
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        [okButton addTarget:self action:@selector(okButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* cancelButton = [[UIButton alloc]init];
        _cancelButton = cancelButton;
        cancelButton.backgroundColor = [UIColor redColor];
        [self addSubview:cancelButton];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cacelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

//定义子控件的位置
-(void)layoutSubviews{
    [super layoutSubviews];
    _saveListName.frame = CGRectMake(Margin, Margin, self.frame.size.width-2*Margin, 120.f);
    
    _cancelButton.frame = CGRectMake(_saveListName.left, _saveListName.bottom+MidMargin, (_saveListName.width-MidMargin)*0.5, 30.f);
    
    _okButton.frame = CGRectMake(_cancelButton.right+MidMargin, _cancelButton.top, _cancelButton.width, _cancelButton.height);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.saveNameList.count;

}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

static NSString * ID =@"localMusicCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell ==nil) {
        cell = [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    SaveList * saveList=self.saveNameList[indexPath.row];
    cell.textLabel.text = saveList.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SaveList * saveList = self.saveNameList[indexPath.row];
    NSString * saveListName = saveList.name;
    _saveName = saveListName;
    
}
#pragma mark 确定添加
-(void)okButtonClicked:(UIButton*)sender{
    if (_saveName.length == 0) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择收藏列表" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if ([_delegate respondsToSelector:@selector(saveListView:didSaveListNameConfirm:)]) {
        [_delegate saveListView:self didSaveListNameConfirm:_saveName];
    }
    
    
    
    
    
    
}

#pragma mark 取消添加
-(void)cacelButtonClicked:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(saveListView:didSaveListNameConfirm:)]) {
        [_delegate saveListView:self didSaveListNameConfirm:nil];
    }
    
    
}

-(void)showinView:(UIView *)view{
    UIView* mengBorad = [[UIView alloc]init];
    _mengBoard = mengBorad;
    mengBorad.frame = [UIScreen mainScreen].bounds;
    mengBorad.backgroundColor = [UIColor yellowColor];
    mengBorad.alpha = 0.3;
    [view addSubview:mengBorad];
    [view addSubview:self];
}

-(void)hide{
    [_mengBoard removeFromSuperview];
    [self removeFromSuperview];
}

@end
