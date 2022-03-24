Rails.application.reloader.to_prepare do
  AccountBlock::Account.include(
    BxBlockVisualAnalytics::PatchAccountFollowersAssociations
  )
end
