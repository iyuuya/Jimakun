#import <Cocoa/Cocoa.h>

@class SubtitleWindowController;

@interface MYLabel : NSView
{
  SubtitleWindowController *parentWindowController;
}

@property (nonatomic, strong) NSFont *font;
@property (nonatomic, assign) CGFloat thickness;
@property (nonatomic, strong) NSColor *color;
@property (nonatomic, strong) NSColor *edge_color;
@property (nonatomic, strong) NSString *text;

- (void)updateAttributes;
- (NSSize)getSize;
- (void)setParentWindowController:(SubtitleWindowController *)wc;

@end
