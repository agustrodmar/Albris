//
//  KeyHandler.swift
//  Albris
//
//  Created by Agustín Rodríguez Márquez on 26/7/24.
//

#if os(macOS)
import AppKit

class KeyHandler {
    var onLeftArrow: (() -> Void)?
    var onRightArrow: (() -> Void)?
    var onDownArrow: (() -> Void)?
    var onUpArrow: (() -> Void)?
    
    private var monitor: Any?
    
    func start() {
        monitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handle(event: event)
            return event
        }
    }
    
    deinit {
        if let monitor = monitor {
            NSEvent.removeMonitor(monitor)
        }
    }
    
    private func handle(event: NSEvent) {
        switch event.keyCode {
        case 123: // Left arrow
            onLeftArrow?()
        case 124: // Right arrow
            onRightArrow?()
        case 125: // Down arrow
            onDownArrow?()
        case 126: // Up arrow
            onUpArrow?()
        default:
            break
        }
    }
}
#endif
