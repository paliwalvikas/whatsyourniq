BxBlockVisualAnalytics::Engine.routes.draw do
  get 'user_statistic' => 'statistics#users'
  get 'audience_followers' => 'audiences#audience_followers'
end
