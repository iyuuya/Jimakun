#import "MYLabel.h"

@interface MYLabel ()

@property (nonatomic, strong) NSMutableDictionary *attributes;

@end

@implementation MYLabel

#pragma mark - Initialize

- (id)initWithFrame:(NSRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setDefault];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self setFrameOrigin: NSMakePoint(0.0, 0.0)];
    [self setFrameSize:   NSMakeSize(448.0, 223.0)];
  }

  return self;
}

#pragma mark -

- (void)setDefault
{
  self.thickness = 0.25;
  self.font = [NSFont fontWithName:@"HiraKakuStd-W8" size:36];
  self.color = [NSColor whiteColor];
  self.edge_color = [NSColor colorWithSRGBRed:0 green:0 blue:0.5 alpha:1];
  self.attributes = [NSMutableDictionary dictionary];
  [self updateAttributes];
}

- (void)updateAttributes
{
  [self.attributes setObject: self.font forKey:NSFontAttributeName];
  [self.attributes setObject: self.color forKey:NSForegroundColorAttributeName];
  [self.attributes setObject: self.edge_color forKey:NSStrokeColorAttributeName];
  [self.attributes setObject: [NSNumber numberWithFloat: -0.5*self.thickness*self.font.pointSize] forKey:NSStrokeWidthAttributeName];
  self.needsDisplay = YES;
}

- (NSSize)getSize
{
  return [self.text sizeWithAttributes:self.attributes];
}

#pragma mark - Draw

- (void)drawRect:(NSRect)dirtyRect
{
  [self.text drawAtPoint:NSMakePoint(0, 0) withAttributes:self.attributes];
}

#pragma mark - Menu and Action

+ (NSMenu *)defaultMenu
{
  NSMenu *menu = [[[NSMenu alloc] initWithTitle: @"MYLabelMenu"] autorelease];
  [menu addItemWithTitle: @"字幕を変更" action: @selector(showTextDialog:) keyEquivalent: @"m"];
  [menu addItemWithTitle: @"文字の色を変更" action: @selector(showColorDialog:) keyEquivalent: @"c"];
  [menu addItemWithTitle: @"文字の縁の色を変更" action: @selector(showEdgeColorDialog:) keyEquivalent: @"e"];
  [menu addItemWithTitle: @"フォントを変更" action: @selector(showFontDialog:) keyEquivalent: @"f"];
  [menu addItem: [NSMenuItem separatorItem]];
  [menu addItemWithTitle: @"終了" action: @selector(terminate:) keyEquivalent: @"q"];
  return menu;
}

- (void)showTextDialog:(id)sender
{
  NSLog(@"TODO: show text dialog");
}

- (void)showColorDialog:(id)sender
{
  NSLog(@"TODO: show color dialog");
}

- (void)showEdgeColorDialog:(id)sender
{
  NSLog(@"TODO: show edge color dialog");
}

- (void)showFontDialog:(id)sender
{
  NSLog(@"TODO: show font dialog");
}

@end
