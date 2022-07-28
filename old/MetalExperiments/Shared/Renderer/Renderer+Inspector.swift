//
//  Renderer+Inspector.swift
//  MetalExperiments (macOS)
//
//  Created by Felix Akira Green on 2/11/21.
//

import Satin
import Youi

extension Renderer {
	#if os(macOS)
	func setupInspector() {
		var panelOpenStates: [String: Bool] = [:]
		if let inspectorWindow = self.inspectorWindow, let inspector = inspectorWindow.inspectorViewController {
			let panels = inspector.getPanels()
			for panel in panels {
				if let label = panel.parameters?.label {
					panelOpenStates[label] = panel.state
				}
			}
		}
		
		if inspectorWindow == nil {
			inspectorWindow = InspectorWindow("Inspector")
			inspectorWindow?.setIsVisible(true)
		}
		
		if let inspectorWindow = self.inspectorWindow, let inspectorViewController = inspectorWindow.inspectorViewController {
			if inspectorViewController.getPanels().count > 0 {
				inspectorViewController.removeAllPanels()
			}
			
			// add params here
			// inspectorViewController.addPanel(PanelViewController(params.label, parameters: params))
			inspectorViewController.addPanel(PanelViewController(instanceMaterial.label + " Material", parameters: instanceMaterial.parameters))
			
			let panels = inspectorViewController.getPanels()
			for panel in panels {
				if let label = panel.parameters?.label {
					if let open = panelOpenStates[label] {
						panel.state = open
					}
				}
			}
		}
	}
	
	func updateInspector() {
		if _updateInspector {
			DispatchQueue.main.async { [unowned self] in
				self.setupInspector()
			}
			_updateInspector = false
		}
	}
	#endif
}
