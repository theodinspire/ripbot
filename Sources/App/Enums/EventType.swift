//
//  EventType.swift
//  App
//
//  Created by Eric Cormack on 6/19/18.
//

import Vapor

enum EventType: String, Content {
	case appMention = "app_mention"
	case appRateLimited = "app_rate_limted"
	case appUninstalled = "app_uninstalled"
	case channelArchived = "channel_archive"
	case channelCreated = "channel_created"
	case channelDeleted = "channel_deleted"
	case channelHistoryChanged = "channel_history_changed"
	case channelLeft = "channel_left"
	case channelRenamed = "channel_rename"
	case channelUnarchived = "channel_unarchive"
	case doNotDisturbUpdatedCurrentUser = "dnd_updated"
	case doNotDisturbUpdatedOtherUser = "dnd_updated_user"
	case emailDomainChanged = "email_domain_changed"
	case emojiChanged = "emoji_changed"
	case fileChanged = "file_change"
	case fileCommentAdded = "file_comment_added"
	case fileCommentDeleted = "file_comment_deleted"
	case fileCommentEdited = "file_comment_edited"
	case fileCreated = "file_created"
	case fileDeleted = "file_deleted"
	case fileMadePublic = "file_public"
	case fileShared = "file_shared"
	case fileUnshared = "file_unshared"
	case gridMigrationComplete = "grid_mirgration_finished"
	case gridMigrationBegan = "grid_migration_began"
	case groupArchived = "group_archive"
	case groupClose = "group_close"
	case groupHistoryChanged = "group_history_changed"
	case groupLeft = "group_left"
	case groupOpen = "group_open"
	case groupRenamed = "group_rename"
	case groupUnarchived = "group_unarchive"
	case imClose = "im_close"
	case imCreated = "im_created"
	case imHistoryChanged = "im_history_changed"
	case imOpen = "im_open"
	case linkShared = "link_shared"
	case memberJoinedChannel = "member_joined_channel"
	case memberLeftChannel = "memeber_left_channel"
	case message = "message"
	case messageAppHome = "message.appHome"
	case messageChannels = "message.channels"
	case messageGroups = "message.groups"
	case messageIm = "message.im"
	case messageMpim = "message.mpim"
	case pinAdded = "pin_added"
	case pinRemoved = "pin_removed"
	case reactionAdded = "reaction_added"
	case reactionRemoved = "reaction_removed"
	case resourcesAdded = "resources_added"
	case resourcesRemoved = "resources_removed"
	case scopeDenied = "scope_denied"
	case scopeGranted = "scope_granted"
	case starAdded = "star_added"
	case starRemoved = "star_removed"
	case subteamCreated = "subteam_created"
	case subteamMembersChanged = "subteam_members_changed"
	case subteamSelfAdded = "subteam_self_added"
	case subteamSelfRemoved = "subteam_self_removed"
	case subteamUpdated = "subteam_updated"
	case teamDomainChange = "team_domain_change"
	case teamJoin = "team_join"
	case teamRename = "team_rename"
	case tokensRevoked = "tokens_revoked"
	case urlVerification = "url_verification"
	case userChange = "user_change"
}
