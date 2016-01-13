#import <Cocoa/Cocoa.h>

@interface MYLabel : NSView

@property (nonatomic, strong) NSFont *font;
@property (nonatomic, assign) float thickness;
@property (nonatomic, strong) NSColor *color;
@property (nonatomic, strong) NSColor *edge_color;
@property (nonatomic, strong) NSString *text;

- (void)updateAttributes;
- (NSSize)getSize;

@end
