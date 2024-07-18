//
//  Models.swift
//  github-bio
//
//  Created by naufal on 18/07/24.
//

import Foundation

struct GitHubUser: Codable {
    let login: String
    let avatar_url: String
    let bio: String
}
