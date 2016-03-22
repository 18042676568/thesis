//
//  SaveList+CoreDataProperties.h
//  KGKuGouPlayer
//
//  Created by wangjing on 16/3/21.
//  Copyright © 2016年 hegf. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SaveList.h"
#import "Music.h"

NS_ASSUME_NONNULL_BEGIN

@interface SaveList (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Music *> *musics;

@end

@interface SaveList (CoreDataGeneratedAccessors)

- (void)addMusicsObject:(Music *)value;
- (void)removeMusicsObject:(Music *)value;
- (void)addMusics:(NSSet<Music *> *)values;
- (void)removeMusics:(NSSet<Music *> *)values;

@end

NS_ASSUME_NONNULL_END
