#import <Cocoa/Cocoa.h>

@class MYLabel;

@interface SubtitleWindowController : NSWindowController

@property (nonatomic, strong) MYLabel *label;

- (id)initWithText:(NSString *)text;// andOwner:(id)myowner;
- (void)resizeWindow;

- (void)setText:(NSString *)text;
- (void)setHexColorString:(NSString *)color;
- (void)setHexEdgeColorString:(NSString *)color;
- (void)setThickness:(float)thickness;
- (void)setFontWithName:(NSString *)fontName size:(CGFloat)size;

- (NSFont *)font;
- (NSColor *)color;
- (NSColor *)edgeColor;
- (NSString *)text;
- (float)thickness;

@end
