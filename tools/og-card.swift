import AppKit

let W = 1200.0, H = 630.0
let bg     = NSColor(srgbRed: 0.078, green: 0.086, blue: 0.102, alpha: 1) // #14161a
let ink    = NSColor(srgbRed: 0.925, green: 0.918, blue: 0.894, alpha: 1) // #eceae4
let muted  = NSColor(srgbRed: 0.647, green: 0.643, blue: 0.612, alpha: 1) // #a5a49c
let accent = NSColor(srgbRed: 0.475, green: 0.753, blue: 0.831, alpha: 1) // #79c0d4
let rule   = NSColor(srgbRed: 0.173, green: 0.188, blue: 0.216, alpha: 1) // #2c3037

let img = NSImage(size: NSSize(width: W, height: H))
img.lockFocus()
bg.setFill(); NSRect(x: 0, y: 0, width: W, height: H).fill()

let x = 96.0
func draw(_ s: String, _ font: NSFont, _ color: NSColor, y: Double) {
    let a: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
    s.draw(at: NSPoint(x: x, y: y), withAttributes: a)
}

let serif = NSFont(name: "Georgia-Bold", size: 92) ?? NSFont.boldSystemFont(ofSize: 92)
let sans  = NSFont(name: "HelveticaNeue", size: 34) ?? NSFont.systemFont(ofSize: 34)
let sans2 = NSFont(name: "HelveticaNeue", size: 27) ?? NSFont.systemFont(ofSize: 27)
let mono  = NSFont(name: "Menlo", size: 22) ?? NSFont.monospacedSystemFont(ofSize: 22, weight: .regular)

draw("Ava Kim Cohen", serif, ink, y: 372)
draw("Applied Math @ Columbia University", sans, muted, y: 316)

rule.setFill(); NSRect(x: x, y: 268, width: 340, height: 1).fill()

draw("Software engineering · research engineering", sans2, muted, y: 200)
draw("AI and LLM systems · quantitative research · HCI · robotics", sans2, muted, y: 158)
draw("avakimc.github.io", mono, accent, y: 84)

img.unlockFocus()

let tiff = img.tiffRepresentation!
let rep = NSBitmapImageRep(data: tiff)!
let png = rep.representation(using: .png, properties: [:])!
try! png.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
print("wrote \(CommandLine.arguments[1])")
