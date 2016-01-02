#import "SubtitleWindowController.h"
#import "MYLabel.h"

@interface SubtitleWindowController ()

@end

@implementation SubtitleWindowController

- (id)initWithText:(NSString *)text
{
  self = [self initWithWindow: [[NSWindow alloc] init]];
  self.label = [[MYLabel alloc] init];
  [self.window.contentView addSubview:self.label];
  self.window.allowsToolTipsWhenApplicationIsInactive = NO;
  self.window.autorecalculatesKeyViewLoop = NO;
  [self.window setHasShadow:NO];
  [self.window setOpaque:NO];
  self.window.oneShot = NO;
  [self.window setShowsToolbarButton:NO];
  [self.window setBackgroundColor:[NSColor clearColor]];
  [self.window setLevel:NSFloatingWindowLevel];
  [self.window setMovableByWindowBackground:YES];
  [self.window setIgnoresMouseEvents:NO];
  [self.window setStyleMask:NSBorderlessWindowMask];
  [self loadWindow];

  [self setText: text];

  return self;
}

- (void)windowDidLoad
{
  [super windowDidLoad];
}

- (void)resizeWindow
{
  NSSize size = [self.label getSize];
  if (size.width != 0 && size.height != 0) {
    NSPoint pos = [self window].frame.origin;
    [[self window] setFrame: NSMakeRect(pos.x, pos.y, size.width, size.height) display:YES];
    [self.label setFrameSize: size];
  }
}

- (NSColor*)colorWithHexColorString:(NSString*)inColorString
{
  NSColor* result = nil;
  unsigned colorCode = 0;
  unsigned char redByte, greenByte, blueByte;

  if (nil != inColorString)
  {
    NSScanner* scanner = [NSScanner scannerWithString:inColorString];
    (void) [scanner scanHexInt:&colorCode]; // ignore error
  }
  redByte = (unsigned char)(colorCode >> 16);
  greenByte = (unsigned char)(colorCode >> 8);
  blueByte = (unsigned char)(colorCode); // masks off high bits

  result = [NSColor
    colorWithCalibratedRed:(CGFloat)redByte / 0xff
                     green:(CGFloat)greenByte / 0xff
                      blue:(CGFloat)blueByte / 0xff
                     alpha:1.0];
  return result;
}

- (void)setText:(NSString *)text
{
  self.label.text = text;
  [self preupdate];
}

- (void)setHexColorString:(NSString *)color
{
  self.label.color = [self colorWithHexColorString: color];
  [self preupdate];
}

- (void)setHexEdgeColorString:(NSString *)color
{
  self.label.edge_color = [self colorWithHexColorString: color];
  [self preupdate];
}

- (void)setThickness:(float)thickness
{
  if (thickness < 0.0) {
    thickness = 0.0;
  } else if (thickness > 20.0) {
    thickness = 20.0;
  }

  self.label.thickness = thickness;
  [self preupdate];
}

- (void)setFontWithName:(NSString *)fontName size:(CGFloat)size
{
  NSFont *font = [NSFont fontWithName: fontName size: size];

  if (font) {
    self.label.font = font;
    [self preupdate];
  } else {
    NSLog(@"Unknown font_name: %@", fontName);
  }
}

- (void)preupdate
{
  [self.label updateAttributes];
  [self.label updateLayer];
  [self resizeWindow];
  self.label.needsDisplay = YES;
}

- (NSFont *)font
{
  return self.label.font;
}

- (NSColor *)color
{
  return self.label.color;
}

- (NSColor *)edgeColor
{
  return self.label.edge_color;
}

- (NSString *)text
{
  return self.label.text;
}

- (float)thickness
{
  return self.label.thickness;
}

@end
