import Foundation
import PDFKit

// Browsers title a PDF tab from its internal Title attribute, not the filename.
// A Google Docs export carries "<docname>.docx - Google Docs", so rewrite it.
let args = CommandLine.arguments
guard args.count >= 4, let doc = PDFDocument(url: URL(fileURLWithPath: args[1])) else {
    fputs("usage: pdf-retitle.swift <in.pdf> <out.pdf> <title> [author]\n", stderr)
    exit(1)
}
var attrs = doc.documentAttributes ?? [:]
attrs[PDFDocumentAttribute.titleAttribute] = args[3]
if args.count > 4 { attrs[PDFDocumentAttribute.authorAttribute] = args[4] }
// Drop the exporting browser's user-agent string; it identifies the machine, not the work.
attrs[PDFDocumentAttribute.creatorAttribute] = args.count > 4 ? args[4] : args[3]
attrs[PDFDocumentAttribute.subjectAttribute] = nil
doc.documentAttributes = attrs
guard doc.write(to: URL(fileURLWithPath: args[2])) else { fputs("write failed\n", stderr); exit(1) }
print("wrote \(args[2])")
