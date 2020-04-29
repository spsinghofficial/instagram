//
//  Protocols.swift
//  instagram
//
//  Created by surinder pal singh sidhu on 2020-03-26.
//  Copyright © 2020 surinder. All rights reserved.
//

import Foundation

protocol FeedCellDelegate {
    func handleUsernameTapped(for cell: FeedCell)
    func handleOptionsTapped(for cell: FeedCell)
    func handleLikeTapped(for cell: FeedCell, isDoubleTap: Bool)
    func handleCommentTapped(for cell: FeedCell)
    func handleConfigureLikeButton(for cell: FeedCell)
    func handleShowLikes(for cell: FeedCell)
    func configureCommentIndicatorView(for cell: FeedCell)
}

protocol UserProfileHeaderDelegate {
    func handleEditFollowTapped(for header: UserProfileHeader)
    func setUserStats(for header: UserProfileHeader)
    func handleFollowersTapped(for header: UserProfileHeader)
    func handleFollowingTapped(for header: UserProfileHeader)
}

//protocol NotificationCellDelegate {
//    func handleFollowTapped(for cell: NotificationCell)
//    func handlePostTapped(for cell: NotificationCell)
//}

protocol CommentInputAccesoryViewDelegate {
    func didSubmit(forComment comment: String)
}

protocol MessageInputAccesoryViewDelegate {
    func handleUploadMessage(message: String)
    func handleSelectImage()
}

protocol FollowCellDelegate {
    func handleFollowTapped(for cell: FollowLikeCell)
}
//
//protocol ChatCellDelegate {
//    func handlePlayVideo(for cell: ChatCell)
//}

//protocol MessageCellDelegate {
//    func configureUserData(for cell: MessageCell)
//}
//
//protocol Printable {
//    var description: String { get }
