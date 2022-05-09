//
//  ViewCodeBuild.swift
//  Music
//
//  Created by Gilmar Junior on 09/05/22.
//

import Foundation


protocol ViewCodeBuild {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}


extension ViewCodeBuild {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
