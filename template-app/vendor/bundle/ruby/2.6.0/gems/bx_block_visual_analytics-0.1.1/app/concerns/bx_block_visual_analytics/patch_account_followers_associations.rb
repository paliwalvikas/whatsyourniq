# frozen_string_literal: true

module BxBlockVisualAnalytics
  module PatchAccountFollowersAssociations
    extend ActiveSupport::Concern

    included do
      has_many :follows, class_name: 'BxBlockFollowers::Follow', dependent: :destroy
    end
  end
end
