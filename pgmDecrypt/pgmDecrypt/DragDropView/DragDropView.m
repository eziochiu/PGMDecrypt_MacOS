//
//  DragDropView.m
//  pgmDecrypt
//
//  Created by admin on 2021/1/7.
//

#import "DragDropView.h"

@implementation DragDropView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(macOS 10.13, *)) {
            [self registerForDraggedTypes:[NSArray arrayWithObjects:NSPasteboardTypeFileURL, nil]];
        } else {
            [self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
        }
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (void)dealloc {
    [self unregisterDraggedTypes];
}

//当文件被拖动到界面触发
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    if (@available(macOS 10.13, *)) {
        if ( [[pboard types] containsObject:NSPasteboardTypeFileURL] ) {
            if (sourceDragMask & NSDragOperationLink) {
                NSArray *list = [pboard readObjectsForClasses:@[[NSURL class]] options:nil];
                return [self.delegate quaryDragOperation:list];
            } else if (sourceDragMask & NSDragOperationCopy) {
                return NSDragOperationCopy;//拖动会变成+号
            }
        }
    } else {
        if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
            if (sourceDragMask & NSDragOperationLink) {
                NSArray *list = [pboard propertyListForType:NSFilenamesPboardType];
                return [self.delegate quaryDragOperation:list];
            } else if (sourceDragMask & NSDragOperationCopy) {
                return NSDragOperationCopy;//拖动会变成+号
            }
        }
    }
    return NSDragOperationNone;
}

// 第三步：当在view中松开鼠标键时会触发以下函数
- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    NSPasteboard *zPasteboard = [sender draggingPasteboard];
    NSArray *list;
    if (@available(macOS 10.13, *)) {
        //获取的路径看不懂，需要通过bookmark才能转成能看懂的磁盘路径
        list = [zPasteboard readObjectsForClasses:@[[NSURL class]] options:nil];
    } else {
        list = [zPasteboard propertyListForType:NSFilenamesPboardType];
    }
     
    NSMutableArray *urlList = [NSMutableArray array];
    for (NSObject *obj in list) {
        if ([obj isKindOfClass:[NSURL class]]) {
            [urlList addObject:(NSURL *)obj];
        } else if ([obj isKindOfClass:[NSString class]]) {
            NSURL *url = [NSURL fileURLWithPath:(NSString *)obj];
            [urlList addObject:url];
        }
    }
    if (urlList.count && self.delegate && [self.delegate respondsToSelector:@selector(dragDropViewFileDidReceiveList:)]) {
        [self.delegate dragDropViewFileDidReceiveList:urlList];
    }
    return YES;
}

@end
