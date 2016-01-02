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
  self.thickness = 5.0;
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
  [self.attributes setObject: [NSNumber numberWithFloat: -1*self.thickness] forKey:NSStrokeWidthAttributeName];
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

@end
