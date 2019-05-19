// rgbclocksaver macOS screensaver by: github.com/cttsrk
//
// Inspired by ColorClockSaver by: github.com/edwardloveall
// Based on MinimalClock by: github.com/mattiarossini

import ScreenSaver

final class rgbclocksaver: ScreenSaverView {
    private let timeView: View = {
        let view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init!(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        // FONTSTYLE
        timeView.textLabel.font = NSFont.monospacedDigitSystemFont(
            ofSize: round(bounds.width / 7),
            weight: .thin
        )
        addSubview(timeView)
        addConstraints([
            timeView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: NSRect) {
        // BACKGROUNDCOLOR
        // Pretend the current time is a hexadecimal rgb color and use it for
        // the background fill color. Treating hours/minutes/seconds as hex rgb
        // causes color artifacts in the background color transition that convey
        // information about the passage of time:
        // Every second,        the color turns a smidgeon more blue.
        // Every 10 seconds,    the color turns slightly more blue.
        // Every minute,        the color turns somewhat more green.
        // Every 10 minutes,    the color turns a lot more green.
        // Every hour,          the color turns much more red.
        // Every 10 hours,      the color turns very much more red.
        // At midnight, everything goes black.
        //
        let d = Date()
        let c = Calendar.current
        let h = CGFloat(Int(String(c.component(.hour, from: d)), radix: 16)!)
        let m = CGFloat(Int(String(c.component(.minute, from: d)), radix: 16)!)
        let s = CGFloat(Int(String(c.component(.second, from: d)), radix: 16)!)
        NSColor(
            calibratedRed: h/255, green: m/255, blue: s/255, alpha: 1
        ).setFill()
        
        NSBezierPath.fill(bounds)
    }
    
    override func animateOneFrame() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "#HHmmss"
        let timeString = formatter.string(from: date)

        timeView.textLabel.stringValue = timeString
        draw(bounds)
        setNeedsDisplay(bounds)
    }
    
}

final class View: NSView {
    let textLabel: NSTextField = {
        let label = NSTextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // TEXTCOLOR
        label.textColor = .white
        label.alignment = .center
        label.drawsBackground = false
        label.isBezeled = false
        label.isSelectable = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
}
