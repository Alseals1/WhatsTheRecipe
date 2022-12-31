//
//  WebViewerController.swift
//  WhatsTheRecipe
//
//  Created by Alandis Seals on 12/30/22.
//

import UIKit
import WebKit

class WebViewerController: UIViewController {
    
    private let webView = WKWebView()
    private let urlString: String
    
    
    
    init(with urlString: String) {
        self.urlString = urlString
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        guard let url = URL(string: urlString) else {
            self.dismiss(animated: true)
            return
        }
        self.webView.load(URLRequest(url: url))
        


    }
    
    private func setupUI() {
        self.view.addSubview(webView)
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
 

}
