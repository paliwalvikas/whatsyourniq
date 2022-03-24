# frozen_string_literal: true

module BxBlockFollowers
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockFollowers
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_followers.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockFollowers::Engine => base + '/followers'
      end
    end
  end
end
