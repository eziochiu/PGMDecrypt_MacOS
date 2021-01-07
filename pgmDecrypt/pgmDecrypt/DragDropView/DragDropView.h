//
//  DragDropView.h
//  pgmDecrypt
//
//  Created by admin on 2021/1/7.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DragDropViewDelegate <NSObject>

- (void)dragDropViewFileDidReceiveList:(NSArray <NSURL *>*)fileList;
- (NSDragOperation)quaryDragOperation:(NSArray *)fileList;
@end

@interface DragDropView : NSView
@property (nonatomic ,weak) id<DragDropViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
