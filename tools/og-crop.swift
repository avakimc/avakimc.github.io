import AppKit

// Crop a rect from a screenshot (top-left origin) and letterbox it into a
// 1200x630 OG frame on the site background, so the padding is invisible.
//
//   swift tools/og-crop.swift <in.png> <out.png> <x> <y> <w> <h>

// `swift file.swift ...` sometimes includes the script path as argv[0] and
// sometimes does not, so normalise rather than assume an index.
var a = CommandLine.arguments
if let first = a.first, first.hasSuffix(".swift") { a.removeFirst() }
guard a.count >= 6,
      let img = NSImage(contentsOfFile: a[0]),
      let rep = NSBitmapImageRep(data: img.tiffRepresentation!),
      let x = Double(a[2]), let y = Double(a[3]),
      let w = Double(a[4]), let h = Double(a[5]) else {
    fputs("usage: og-crop.swift <in.png> <out.png> <x> <y> <w> <h>\n", stderr)
    exit(1)
}
guard let cg = rep.cgImage?.cropping(to: CGRect(x: x, y: y, width: w, height: h)) else {
    fputs("crop rect lies outside the image (\(rep.pixelsWide)x\(rep.pixelsHigh))\n", stderr)
    exit(1)
}

let cw = Double(cg.width), ch = Double(cg.height)
let W = 1200.0, H = 630.0
let s = min(W / cw, H / ch), dw = cw * s, dh = ch * s

let out = NSImage(size: NSSize(width: W, height: H))
out.lockFocus()
NSColor(srgbRed: 0.078, green: 0.086, blue: 0.102, alpha: 1).setFill()
NSRect(x: 0, y: 0, width: W, height: H).fill()
NSGraphicsContext.current!.imageInterpolation = .high
NSImage(cgImage: cg, size: NSSize(width: cw, height: ch))
    .draw(in: NSRect(x: (W - dw) / 2, y: (H - dh) / 2, width: dw, height: dh))
out.unlockFocus()

let png = NSBitmapImageRep(data: out.tiffRepresentation!)!.representation(using: .png, properties: [:])!
try png.write(to: URL(fileURLWithPath: a[1]))
print("wrote \(a[1]) from \(Int(cw))x\(Int(ch)) crop")
